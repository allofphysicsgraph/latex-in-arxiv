// https://github.com/wkoszek/ncurses_guide.git

#include "bloom.h"
#include <assert.h>
#include <cdk_test.h>
#include <errno.h>
#include <fcntl.h>
#include <ncurses.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#define MENUMAX 10
#define MAX_LEN 1024
#define MAX_NUMBER_OF_FILES_SELECTED 10
#define MAX_FILE_SIZE 1048576

int balanced_parens(const char *data, char *start_pattern, char *l_delimiter,
                    char *r_delimiter, int start_position);

int file_path_len = 0;
void drawmenu(int item) {
  int c;
  char mainmenu[] = "Main Menu";
  char menu[MENUMAX][90] = {
      /* items for MENUMAX */
      "install dependencies", // texlive, codesearch+golang, python3, nltk,
                              // flex, re2 for fast regex matching
      "working directory",    // set current working directory
      "find files",           // find . -type f
      "init",                 // read vocab files, setup bloom filters
      "index files",          // codesearch
      "choose lexer",         // mix and match lexers for parsing data
      "read file",            //
      "sentence tokenizer",   // nltk for sent_tokenize
      "expand TeX Macros",    // expand newcommands in latex files
      "compile latex file"};

  clear();
  addstr(mainmenu);
  for (c = 0; c < MENUMAX; c++) {
    if (c == item)
      attron(A_REVERSE); /* highlight selection */
    mvaddstr(3 + (c * 2), 20, menu[c]);
    attroff(A_REVERSE); /* remove highlight */
  }
  mvaddstr(24, 25, "Use arrow keys to move; Enter to select:");
  refresh();
}

int main(void) {
  FILE *FIND_PTR, *INSTALL_PTR, *FILE_PTR, *LEXER_PTR;

  FILE *english_vocab;                             /* input-file pointer */
  char *english_vocab_file_name = "english_vocab"; /* input-file name    */
  struct bloom eng_bloom; // bloom filter for english vocab to verify words

  FILE *latex_vocab;                           /* input-file pointer */
  char *latex_vocab_file_name = "latex_vocab"; /* input-file name    */
  struct bloom latex_bloom; // bloom filter for latex vocab to verify tokens

  char latex_tmp_buffer[100000];
  char tmp_buffer[100000];
  char working_dir[256];

  char *file_buffer;

  char *file_name_tmp;
  char *token;

  int fd;
  char current_file[256];
  char fileList[MAX_NUMBER_OF_FILES_SELECTED][256];
  int fd_array[MAX_NUMBER_OF_FILES_SELECTED];
  char fileData[MAX_NUMBER_OF_FILES_SELECTED][MAX_FILE_SIZE];
  struct stat file_stat_array[MAX_NUMBER_OF_FILES_SELECTED];
  struct stat file_s;

  int mapped_files_count = 0;

  int key, menuitem;
  enum {
    INSTALL,
    WORKING_DIR,
    FIND,
    INIT,
    INDEX,
    LEXER,
    READ_FILE,
    SENT_TOKENIZE,
    EXPAND_TEX_MACROS,
    COMPILE_TEX_TO_PDF,
    EXIT
  };
  menuitem = 0;
  initscr();

  drawmenu(menuitem);
  keypad(stdscr, TRUE);
  noecho(); /* Disable echo */
  do {
    key = getch();
    switch (key) {
    case KEY_DOWN:
      menuitem++;
      if (menuitem > MENUMAX - 1)
        menuitem = 0;
      break;
    case KEY_UP:
      menuitem--;
      if (menuitem < 0)
        menuitem = MENUMAX - 1;
      break;
    default:
      break;
    }
    drawmenu(menuitem);
  } while (key != '\n');

  echo(); /* re-enable echo */

  switch (menuitem) {

  case INSTALL:
    INSTALL_PTR =
        popen("sudo apt install -y git vim flex texinfo virtualenv", "r");
    pclose(INSTALL_PTR);
    INSTALL_PTR = popen("/bin/bash libbloom.sh", "r");
    pclose(INSTALL_PTR);
    break;

  case WORKING_DIR:
    printw("\ninput working dir:\tmax chars 256:\n");
    scanw("%s", &working_dir);
    printw("%s", working_dir);
    getch();
    break;

  case FIND:
    FIND_PTR = popen("find . -type f > /dev/shm/current_file_list", "r");
    printf("file list in /dev/shm/current_file_list");
    pclose(FIND_PTR);
    break;

  case INIT:
    assert(bloom_init(&eng_bloom, 100000, 0.00001) == 0);
    assert(bloom_init(&latex_bloom, 100000, 0.00001) == 0);

    english_vocab = fopen(english_vocab_file_name, "r");
    if (english_vocab == NULL) {
      fprintf(stderr, "couldn't open file '%s'; %s\n", english_vocab_file_name,
              strerror(errno));
      exit(EXIT_FAILURE);
    }

    while (fgets(tmp_buffer, MAX_LEN - 1, english_vocab)) {
      // Remove trailing newline
      tmp_buffer[strcspn(tmp_buffer, "\n")] = 0;
      bloom_add(&eng_bloom, tmp_buffer, strlen(tmp_buffer));
    }

    if (fclose(english_vocab) == EOF) { /* close input file   */
      fprintf(stderr, "couldn't close file '%s'; %s\n", english_vocab_file_name,
              strerror(errno));
      exit(EXIT_FAILURE);
    }

    latex_vocab = fopen(latex_vocab_file_name, "r");
    if (latex_vocab == NULL) {
      fprintf(stderr, "couldn't open file '%s'; %s\n", latex_vocab_file_name,
              strerror(errno));
      exit(EXIT_FAILURE);
    }
    while (fgets(latex_tmp_buffer, MAX_LEN - 1, latex_vocab)) {
      // Remove trailing newline
      latex_tmp_buffer[strcspn(latex_tmp_buffer, "\n")] = 0;
      bloom_add(&latex_bloom, latex_tmp_buffer, strlen(latex_tmp_buffer));
    }

    if (fclose(latex_vocab) == EOF) { /* close input file   */
      fprintf(stderr, "couldn't close file '%s'; %s\n", latex_vocab_file_name,
              strerror(errno));
      exit(EXIT_FAILURE);
    }

    printw("\n\nOK:\tpress any key to continue.\n");
    getch();
    break;

  case INDEX:
    break;

  case LEXER:
    break;

  case READ_FILE:

#ifdef HAVE_XCURSES
    char *XCursesProgramName = "menubar";
#endif

    /*
     * This program demonstrates the Cdk selection widget.
     *
     * Options (in addition to normal CLI parameters):
     *	-c	create the data after the widget
     *	-f TEXT title for a footer label
     *	-h TEXT title for a header label
     *	-s SPOS	location for the scrollbar
     *	-t TEXT	title for the widget
     *
     */
    {
      static const char *choices[] = {"   ", "-->"};
      /* *INDENT-EQLS* */
      CDKSCREEN *cdkscreen = 0;
      CDKSELECTION *selection = 0;
      const char *title = "<C></5>Pick one or more File.";
      char *title_string = 0;
      char **item = 0;
      char temp[256];
      const char *mesg[200];
#if defined(HAVE_PWD_H)
      struct passwd *ent;
#endif
      unsigned x, y;
      unsigned used = 0;
      unsigned count = 0;

      CDK_PARAMS params;
      char **arr;
      CDKparseParams(1, arr, &params, "cf:h:s:t:" CDK_CLI_PARAMS);

      /* Use the account names to create a list. */
      FILE *stream;
      char *line = NULL;
      ssize_t nread;
      size_t len = 0;

      stream = popen("find /home/user/latex-in-arxiv -type f -exec file '{}' "
                     "\\; | grep -i ': LaTeX' |cut -d ':' -f1",
                     "r");

      count = 0;
#if defined(HAVE_PWD_H)
      while ((nread = getline(&line, &len, stream) != -1)) {
        used = CDKallocStrings(&item, line, count++, used);
      }
      free(line);
      pclose(stream);
#endif
      count--;

      cdkscreen = initCDKScreen(NULL);

      /* Set up CDK Colors. */
      initCDKColor();

      if ((title_string = CDKparamString2(&params, 'h', 0)) != 0) {
        const char *list[2];
        CDKLABEL *header;

        list[0] = title_string;
        list[1] = 0;
        header =
            newCDKLabel(cdkscreen, CDKparamValue(&params, 'X', CENTER),
                        CDKparamValue(&params, 'Y', TOP), (CDK_CSTRING2)list, 1,
                        CDKparamValue(&params, 'N', TRUE),
                        CDKparamValue(&params, 'S', TRUE));
        if (header != 0)
          activateCDKLabel(header, 0);
      }

      if ((title_string = CDKparamString2(&params, 'f', 0)) != 0) {
        const char *list[2];
        CDKLABEL *footer;

        list[0] = title_string;
        list[1] = 0;
        footer =
            newCDKLabel(cdkscreen, CDKparamValue(&params, 'X', CENTER),
                        CDKparamValue(&params, 'Y', BOTTOM), (CDK_CSTRING2)list,
                        1, CDKparamValue(&params, 'N', TRUE),
                        CDKparamValue(&params, 'S', TRUE));
        if (footer != 0)
          activateCDKLabel(footer, 0);
      }
      /* Create the selection list. */
      selection = newCDKSelection(
          cdkscreen, CDKparamValue(&params, 'X', CENTER),
          CDKparamValue(&params, 'Y', CENTER),
          CDKparsePosition(CDKparamString2(&params, 's', "RIGHT")),
          CDKparamValue(&params, 'H', 10), CDKparamValue(&params, 'W', 50),
          CDKparamString2(&params, 't', title),
          (CDKparamNumber(&params, 'c') ? 0 : (CDK_CSTRING2)item),
          (CDKparamNumber(&params, 'c') ? 0 : (int)count),
          (CDK_CSTRING2)choices, 2, A_REVERSE,
          CDKparamValue(&params, 'N', TRUE),
          CDKparamValue(&params, 'S', FALSE));

      /* Is the selection list null? */
      if (selection == 0) {
        /* Exit CDK. */
        destroyCDKScreen(cdkscreen);
        endCDK();

        printf("Cannot to create the selection list.\n");
        printf("Is the window too small?\n");
        ExitProgram(EXIT_FAILURE);
      }

      if (CDKparamNumber(&params, 'c')) {
        setCDKSelectionItems(selection, (CDK_CSTRING2)item, (int)count);
      }

      /* Activate the selection list. */
      activateCDKSelection(selection, 0);

      /* Check the exit status of the widget. */
      if (selection->exitType == vESCAPE_HIT) {
        mesg[0] = "<C>You hit escape. No items selected.";
        mesg[1] = "";
        mesg[2] = "<C>Press any key to continue.";
        popupLabel(cdkscreen, (CDK_CSTRING2)mesg, 3);
      } else if (selection->exitType == vNORMAL) {
        mesg[0] = "<C>Here are the files you selected.";
        y = 1;
        for (x = 0; x < count; x++) {
          if (selection->selections[x] == 1) {
            sprintf(temp, "<C></5>%.*s", (int)(sizeof(temp) - 20), item[x]);
            // strncpy(fileList[x],item[x]);
            file_name_tmp = strdup(item[x]);
            token = strsep(&file_name_tmp, "\n"); /*  strip newline */
            strcpy(fileList[x], token);

            mesg[y++] = copyChar(temp);
          }
        }
        popupLabel(cdkscreen, (CDK_CSTRING2)mesg, (int)y);
        //
      }

      /* Clean up. */
      CDKfreeStrings(item);
      destroyCDKSelection(selection);
      destroyCDKScreen(cdkscreen);
      endCDK();
      // ExitProgram (EXIT_SUCCESS);
    }
    printw("%s", fileList[0]);
    getch();
    ///  scanw("%s",&current_file);

    char *buffer[2];
    struct stat s[2];
    int fd[2];
    fd[0] = open(fileList[0], O_RDONLY);
    // if (fd[0] < 0 ) return EXIT_FAILURE;
    fstat(fd[0], &s[0]);
    /* PROT_READ disallows writing to buffer: will segv */
    buffer[0] = mmap(0, s[0].st_size, PROT_READ, MAP_PRIVATE, fd[0], 0);
    printw("%d", 5);
    if (buffer[0] != (void *)-1) {
      printw("%d", 5);
      printw("%s", buffer[0]);
      getch();
      // printw(buffer[0], s[0].st_size, 1, stdout);
      munmap(buffer[0], s[0].st_size);
    }
    close(fd[0]);

    getch();
    break;

  case SENT_TOKENIZE:
    break;

  case EXPAND_TEX_MACROS:
    break;

  case COMPILE_TEX_TO_PDF:
    break;

  default:
    break;
  } /* -----  end switch  ----- */

  endwin();
  exit_curses(EXIT_SUCCESS);
  bloom_free(&eng_bloom);
  bloom_free(&latex_bloom);
  int i = 0;
  for (i = 0; i < mapped_files_count; i++) {
    // munmap(fileData[i], file_stat_array[i].st_size);
  }
  ExitProgram(EXIT_SUCCESS);
  return 0;
}

int balanced_parens(const char *data, char *start_pattern, char *l_delimiter,
                    char *r_delimiter, int start_position) {
  size_t data_sz = strlen(data);
  int start_index = 0;
  int i = start_position;
  int balanced = 0;
  char tmp_data[data_sz];
  char result_data[data_sz];

  memset(tmp_data, '\0', data_sz);
  memset(result_data, '\0', data_sz);

  if (strcmp(start_pattern, l_delimiter) == 0) {
    balanced = -1;

    // printf("balanced:%d",balanced);
  }

  for (i; i < (int)data_sz; i++) {
    strncpy(tmp_data, &data[i], strlen(start_pattern));

    if (strcmp(tmp_data, start_pattern) == 0) {
      start_index = i;
      strncpy(result_data, &data[start_index], strlen(start_pattern));
      break;
    }
  }

  for (i = start_index; i < (int)data_sz; i++) {
    memset(tmp_data, '\0', data_sz);
    strncpy(tmp_data, &data[i], strlen(r_delimiter));

    if (strcmp(tmp_data, r_delimiter) == 0) {
      balanced++;

      // printf("%d\n",balanced);
      if (balanced == 0) {
        strncpy(result_data, &data[start_index], (size_t)(i - start_index + 1));

        // printf("%s",result_data);
        if (strcmp(start_pattern, l_delimiter) == 0) {
          if (r_delimiter[0] == '\\') {
            strcat(result_data, &r_delimiter[1]);
          } else {
            strcat(result_data, r_delimiter);
          }
        }

        attron(COLOR_PAIR(4));
        printw("(%d,%d):%s\n", start_index, i, result_data);
        attroff(COLOR_PAIR(4));
        break;
      }
    }

    if (strcmp(tmp_data, l_delimiter) == 0) {
      // printf("--");
      balanced--;
      strcat(result_data, tmp_data);

      // printf("%s",result_data);
    }
  }

  return 1;
}
