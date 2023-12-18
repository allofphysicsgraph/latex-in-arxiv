#include <dirent.h>
#include <err.h>
#include <errno.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#define MAX_FILE_COUNT 50000

enum {
  LOOKUP = 0, /* default - looking rather than defining. */
  WALK_OK = 0,
  WALK_BADPATTERN,
  WALK_NAMETOOLONG,
  WALK_BADIO,
};

#define WS_NONE 0
#define WS_RECURSIVE (1 << 0)
#define WS_DEFAULT WS_RECURSIVE
//#define WS_FOLLOWLINK (1 << 1) /* follow symlinks */
#define WS_DOTFILES (1 << 2)   /* per unix convention, .file is hidden */
#define WS_MATCHDIRS (1 << 3)  /* if pattern is used on dir names too */

/* https://rosettacode.org/wiki/Walk_a_directory/Recursively#C */
int walk_recur(char *dname, regex_t *reg, int spec, char *array[],
               int array_index) {
  struct dirent *dent;
  DIR *dir;
  struct stat st;
  char fn[FILENAME_MAX];
  int res = WALK_OK;
  int len = strlen(dname);
  if (len >= FILENAME_MAX - 1)
    return WALK_NAMETOOLONG;

  strcpy(fn, dname);
  fn[len++] = '/';

  if (!(dir = opendir(dname))) {
    warn("can't open %s", dname);
    return WALK_BADIO;
  }

  errno = 0;
  while ((dent = readdir(dir))) {
    if (!(spec & WS_DOTFILES) && dent->d_name[0] == '.')
      continue;
    if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
      continue;

    strncpy(fn + len, dent->d_name, FILENAME_MAX - len);
    if (lstat(fn, &st) == -1) {
      warn("Can't stat %s", fn);
      res = WALK_BADIO;
      continue;
    }

    /* don't follow symlink unless told so */
    //if (S_ISLNK(st.st_mode) && !(spec & WS_FOLLOWLINK))
      //continue;

    /* will be false for symlinked dirs */
    if (S_ISDIR(st.st_mode)) {
      /* recursively follow dirs */
      if ((spec & WS_RECURSIVE))
        walk_recur(fn, reg, spec, array, array_index);

      if (!(spec & WS_MATCHDIRS))
        continue;
    }

    /* pattern match */
    if (!regexec(reg, fn, 0, 0, 0)) {
      array[array_index] = strdup(fn);
      array_index++;
    }
  }

  if (dir)
    closedir(dir);
  return res ? res : errno ? WALK_BADIO : WALK_OK;
}

int walk_dir(char *dname, char *pattern, int spec, char *array[],
             int array_index) {
  regex_t r;
  int res;
  if (regcomp(&r, pattern, REG_EXTENDED | REG_NOSUB))
    return WALK_BADPATTERN;
  res = walk_recur(dname, &r, spec, array, array_index);
  regfree(&r);
  return res;
}
