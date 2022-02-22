// https://github.com/wkoszek/ncurses_guide.git

#include "bloom.h"
#include <assert.h>
#include <errno.h>
#include <ncurses.h>
#include <stdlib.h>
#include <string.h>

#define MENUMAX 9
#define MAX_LEN 1024

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

  int key, menuitem;
  enum {
    INSTALL,
    WORKING_DIR,
    FIND,
    INIT,
    INDEX,
    LEXER,
    SENT_TOKENIZE,
    EXPAND_TEX_MACROS,
    COMPILE_TEX_TO_PDF,
    EXIT
  };
  char working_dir[256];
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
    INSTALL_PTR = popen("sudo apt install -y git vim flex texinfo virtualenv", "r");
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
  return 0;
}
