// FOR DOCUMENTATION, SEE MY BLOG POST:
//    http://techennui.blogspot.com/2007/11/quick-hack-17-in-series-of-42-inlining.html

// Expands LaTeX \newcommand macros to allow submission of documents
// to print services which do not allow user-defined macros.

// Valid input formats are:
// \newcommand{\whatever}{Replacement text}
// \newcommand{\whatever}[2]{Expand #1 and #2 but not \#1 or even $\#1$}
// - anything else ought to be passed through verbatim; if an inurmountable
// error is detected, the program exits with a non-0 return code.

// The purpose of this utility is similar to:
//    http://winedt.org/Macros/LaTeX/uncommand.php
// which I wasn't aware of when I wrote it.  Though I would like to see how
// well that program handles the test input file, to see if it does the
// right thing with some of the more complex definitions :-)
//
// See also http://texcatalogue.sarovar.org/entries/de-macro.html
// and http://www.mackichan.com/index.html?techtalk/685.htm~mainFrame

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h> /* exit() */
#include <string.h> /* strcpy(), strcmp() */

#define TRUE (0 == 0)
#define FALSE (0 != 0)

// Sorry, only 8-bit char sets supported.

#define NEWCOMMANDLEN 14 /* strlen("\\renewcommand")+1 */

/* Will later make these dynamic - quick hack for now */
#define MAXMACRONAMELEN 80
#define MAXMACROBODYLEN 1024
#define MAXARGLEN 1024
#define MAXCOMMANDS 1024
#define MAX_MACRO_EXPANSION (32 * 1024)
#define _PROTECTED_ 256
#define _PARAMETER_ 512

static int NEXTFREEMACRO = 0;
static int THIS_COMMAND = MAXCOMMANDS - 1;
static char macro[MAXMACRONAMELEN][MAXCOMMANDS];
static int body[MAXMACROBODYLEN][MAXCOMMANDS];
static int args[MAXCOMMANDS];

char actual[MAXARGLEN][10]; // used at point of macro call.

char curcommand[NEWCOMMANDLEN] = {'\0'};

static int in_comment = FALSE;

void intcpy(int *dest, int *source) {
  while ((*dest++ = *source++) != 0)
    ;
}

#ifndef BITS
#define BITS 15
#endif
#define BUFFERSIZE (1 << BITS)
#define CIRCULAR (BUFFERSIZE - 1)
static int buffer[BUFFERSIZE]; // deliberately int, not char, for _protected_
static int get_index = 0, put_index = 0;

// nasty pushback buffer because we always insert text *before* the current
// 'get' pointer and step the get pointer backwards.  This is OK if we insert a
// whole string at a time but if we push back two strings in a row, they can be
// inserted out of order unless we're very careful!  I.e. not as simple as the
// usual put/get from a cyclic buffer :-(

int get_next_char(void) {
  int c;

  if (get_index == put_index)
    return (fgetc(stdin));
  c = buffer[get_index];
  get_index = (get_index + 1) & CIRCULAR;
  return c;
}

int locate_macro_name(char *def) {
  int i = 0;
  for (;;) {
    if (i == NEXTFREEMACRO)
      break;
    if (strcmp(def, macro[i]) == 0)
      break;
    i += 1;
    if (i == MAXCOMMANDS) {
      fprintf(stdout, "Coding error #1.  Aborted.\n");
      exit(1);
    }
  }
  return i;
}

void reinsert_char(int c) {
  buffer[put_index] = c;
  put_index = (put_index + 1) & CIRCULAR;
  if (put_index == get_index) {
    fprintf(stdout,
            "Sorry, a large expansion ran me out of space. Please recompile "
            "with -DBITS=%d\n",
            BITS + 1);
    exit(1);
  }
}

void unread_char(
    int c) // PUT AT *HEAD* OF RE-READ BUFFER.  JUST LIKE ungetc(stdin, c)
{
  get_index = (get_index - 1) & CIRCULAR;
  buffer[get_index] = c;
  if (put_index == get_index) {
    fprintf(stdout,
            "Sorry, a large expansion ran me out of space. Please recompile "
            "with -DBITS=%d\n",
            BITS + 1);
    exit(1);
  }
}

void unread_string(char *s) {
  char *start = s;
  while (*s != '\0')
    s += 1;
  for (;;) {
    s -= 1;
    unread_char(*s);
    if (s == start)
      break;
  }
}

char *get_command(int c) {
  static char w[MAXMACRONAMELEN];
  char *wp = w;
  for (;;) {
    *wp++ = c;
    c = get_next_char();
    if (!isalpha(c))
      break;
  }
  unread_char(c);
  *wp = '\0';
  return w;
}

int next_non_comment_char(void) {
  int c;

  for (;;) {
    c = get_next_char();
    if (c == '%') {
      for (;;) {
        if (c == '\n')
          break;
        c = get_next_char();
      }
      continue; // try again
    } else {
      break;
    }
  }
  return c;
}

int next_non_comment_non_space_char(void) {
  int c;
  for (;;) {
    c = next_non_comment_char();
    if (!isspace(c))
      return (c);
  }
}

void learn_body(void) {
  int c;
  c = next_non_comment_non_space_char();
  if (c != '{') {
    // single token.  Not yet handled.
  } else {
    // READ BODY UP TO AND INCLUDING FINAL '}' BUT NOT BEYOND
    static int expansion[MAXMACROBODYLEN];
    int *ep = expansion;
    int c, depth = 0;

    for (;;) {
      c = get_next_char(); // We'll include comments in the macro expansion
                           // *but* must be careful not to count braces within
                           // comments
      if (c == '\\') {
        *ep++ = c;
        c = get_next_char();
        *ep++ = c;
      } else if (c == '%') {
        // Copy rest of comment
        for (;;) {
          *ep++ = c;
          if (c == '\n')
            break;
          c = get_next_char();
        }
      } else {
        // regular character - proess it normally:
        if (c == '{')
          depth += 1;
        if ((c == '}') && (depth == 0))
          break;
        if (c == '}')
          depth -= 1;
        if (c == '#') {
          c = get_next_char();           // '1' .. '9'
          *ep++ = c - '1' + _PARAMETER_; // INTERNAL CODE FOR #1, #2, ... #9
        } else
          *ep++ = c;
      }
    }
    *ep = '\0';

    intcpy(body[NEXTFREEMACRO], expansion);
    NEXTFREEMACRO = NEXTFREEMACRO + 1; // We now have all the pieces.
    // Need to add check to see if we've busted the array bounds.
  }
}

int learn_argcount(void) {
  int c, argcount;

  c = get_next_char();
  argcount = c - '0'; // eg "[3]" -> 3
  // VERIFY THAT isdigit(c)
  c = get_next_char(); // ']'
  // VERIFY THAT c == ']'
  return argcount;
}

void learn_keyword(void) {
  static char name[MAXMACRONAMELEN];
  char *cp = name;
  int c, argcount;

  c = next_non_comment_non_space_char();
  if (c != '\\') {
    fprintf(stdout,
            "Problem at \"\\%s{%c\"  <-- last char should be a '\\' (was ascii "
            "%d)\n",
            curcommand, c, c);
    exit(1);
  }
  for (;;) {
    c = next_non_comment_non_space_char();
    if (!isalpha(c))
      break; // or isalnum?  Are numbers allowed in TeX words?  Probably not.
    *cp++ = c;
  }
  *cp = '\0';
  if (c != '}') {
    fprintf(stdout,
            "Problem at \"\\%s{\\%s%c\"  <-- last char should be a '}' (was "
            "ascii %d)\n",
            curcommand, name, c, c);
    exit(1);
  }
  strcpy(macro[NEXTFREEMACRO], name);

  // NOW READ ARG COUNT IF PRESENT FOLLOWED BY BODY
  c = next_non_comment_non_space_char();
  if (c == '[') {
    argcount = learn_argcount(); // reads n and the final ']'
  } else {
    reinsert_char(c);
    argcount = 0;
  }
  args[NEXTFREEMACRO] = argcount;
  learn_body();
}

void learn_macro(void) {
  int c;

  c = next_non_comment_non_space_char();
  if (c == '{') {
    learn_keyword(); // reads \word and the final '}'
  } else {
    // badly formatted definition
    fprintf(stdout, "\\%s", curcommand);
    unread_char(c);
  }
}

void expand_macro(void) {
  // READ ARGS IF NEEDED, THEN EXPAND.
  static char temp_buffer[MAX_MACRO_EXPANSION];
  char *pp;
  int *fp;
  char *ap; // put pointer, fetch pointer, arg pointer
  int c, param, i, argcount = args[THIS_COMMAND];

  // following text should be args between {}s... (or nothing, if argcount is 0)

  // fprintf(stdout, "%% COMPLEX EXPANSION OF \\%s WITH %d ARGS\n",
  // macro[THIS_COMMAND], args[THIS_COMMAND]); // add %c? - do tests and check
  for (i = 0; i < argcount; i++) {
    c = get_next_char();
    if (c == '{') {
      // READ PARAM INTO actual[i]
      char *ap = actual[i];
      for (;;) {
        c = get_next_char(); // IS THIS A BUG?  DO I NEED TO HANDLE \} OR
                             // MULTI-LINE ?  % COMMENTS?
        if (c == '}')
          break;
        *ap++ = c;
      }
      *ap = '\0';
      // fprintf(stdout, "%% Got actual parameter #%d: %s\n", i+1, actual[i]);
    } else {
      // parameter is a single atom - not handled!
      fprintf(
          stdout,
          "Sorry - I expected a {} parameter (#%d) to \\%s but found '%c'\n",
          i + 1, macro[THIS_COMMAND], c);
      fprintf(stdout, "This is either a program bug or you need to edit the "
                      "source text to add {}'s\n");
      exit(1);
    }
  }
  // NOW EXPAND THE BODY, SUBSTITUTING ARGS 1..n AS NECESSARY
  // THIS IS WHERE WE NEED TO BE EXTRA CAREFUL ABOUT PUSHBACK ORDER!!!!
  // THE EXPANDED BODY MAY CONTAIN MORE TEXT TO BE EXPANDED.
  fp = body[THIS_COMMAND];
  pp = temp_buffer;
  for (;;) {
    c = *fp++;
    if (c == '\0')
      break;
    if ((c & _PARAMETER_) != 0) {
      param = (c & 255); // 1..9  - TeX counts from 1 up I think. Pre-processed
                         // at defn time to 0..n-1
      // NEED RANGE CHECK, IF INVALID #n GIVEN - BETTER TO CHECK AT DEFN TIME
      // THOUGH!
      ap = actual[param];
      for (;;) {
        if (*ap == '\0')
          break;
        *pp++ = *ap++;
      }
    } else
      *pp++ = c;
  }
  *pp = '\0';
  unread_string(temp_buffer);
  // there is a pending char (whatever followed the \word) at getptr.
  // we have to put our expansion *before* getptr
}

void handle_word(char *s) {
  if ((strcmp(s, "newcommand") == 0) || (strcmp(s, "renewcommand") == 0)) {
    strcpy(curcommand, s);
    learn_macro();
  } else if ((THIS_COMMAND = locate_macro_name(s)) < NEXTFREEMACRO) {
    expand_macro();
  } else {
    // IGNORE UNKNOWN
    fprintf(stdout, "\\%s", s);
  }
}

int main(int argc, char **argv) {
  char *command;
  int i, c;

  for (i = 0; i < MAXCOMMANDS; i++)
    macro[0][i] = '\0';

  for (;;) {
    c = get_next_char();
    if (c == EOF)
      break;
    if (in_comment) {
      fputc(c, stdout);
      if (c == '\n') {
        in_comment = FALSE;
      }
    } else if (c == '\\') {
      c = get_next_char();
      if (isalpha(c)) {
        // Handle TeX word
        command = get_command(c);
        handle_word(command);
      } else {
        fprintf(stdout, "\\%c", c);
      }
    } else if (c == '%') {
      fputc(c, stdout);
      in_comment = TRUE;
    } else {
      fputc(c, stdout);
    }
  }
  // clean up
  exit(0);
  return (1);
}
