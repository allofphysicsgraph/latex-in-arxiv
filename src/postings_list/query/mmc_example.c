/*  minor example usage of mmc.c
    Copyright (C) Yann Collet 2018-present

    GPL v2 License
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
    You can contact the author at :
    - public issue list : https://github.com/Cyan4973/mmc/issues
    - website : http://fastcompression.blogspot.com/
*/

#include <assert.h>
#include <stdio.h>  /* fopen, fread, fclose */
#include <stdlib.h> /* malloc, free */

#include "mmc.h"

#define KB *(1 << 10)

/* --- safe variants --- */
static void *MALLOC(size_t s) {
  void *const buf = calloc(1, s);
  assert(buf != NULL);
  return buf;
}
#define FREE free /* cannot fail */

static FILE *FOPEN(const char *name, const char *mode) {
  FILE *f = fopen(name, mode);
  assert(f != NULL);
  return f;
}

static size_t FREAD(void *buf, size_t s, size_t n, FILE *f) {
  size_t const read = fread(buf, s, n, f);
  assert(ferror(f) == 0);
  assert(read <= s * n);
  return read;
}

static void FCLOSE(FILE *f) { assert(fclose(f) == 0); }

/* --- example --- */

char printableChar(char c) {
  if (32 <= c && c <= 126)
    return c;
  return '.';
}

/* this function displays printable characters
 * and replaces all other ones by `.` */
void printContent(const void *p, size_t l) {
#define PRINT_CONTENT_LENGTH_MAX 160
  const char *b = p;
  size_t u;
  if (l > PRINT_CONTENT_LENGTH_MAX)
    l = PRINT_CONTENT_LENGTH_MAX;
  for (u = 0; u < l; u++) {
    printf("%c", printableChar(b[u]));
  }
}

static void printMatches(const void *buffer, size_t size) {
  MMC_ctx *const mmc = MMC_create();
  const char *const buf = (const char *)buffer;
  size_t pos = 0;

  MMC_init(mmc, buf);
  for (pos = 0; pos < size; pos++) {
    const void *match;
    size_t const length =
        MMC_insertAndFindBestMatch(mmc, buf + pos, size - pos, &match);
    if (length > 0) {
      assert(match >= buffer);
      printf("%6zu: %3zu pos%6zi ( ", pos, length, (const char *)match - buf);
      printContent(buf + pos, length);
      printf(" ) \n");
    }
  }

  MMC_free(mmc);
}
