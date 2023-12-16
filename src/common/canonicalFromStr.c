#include "xxhash.h"
#include <stdio.h>
#include <stdlib.h>

/*
 * Converts one hexadecimal character to integer.
 * Returns -1 if the given character is not hexadecimal.
 * cli/xxhsum.c is the original source
 */
static int charToHex(char c) {
  int result = -1;
  if (c >= '0' && c <= '9') {
    result = (int)(c - '0');
  } else if (c >= 'A' && c <= 'F') {
    result = (int)(c - 'A') + 0x0a;
  } else if (c >= 'a' && c <= 'f') {
    result = (int)(c - 'a') + 0x0a;
  }
  return result;
}

/* CanonicalFromString in cli/xxhsum.c */
int cmp_Canonical_XXH64(const char *hashStr, XXH64_hash_t hash) {
  unsigned char dst[16];
  size_t dstSize = 8;
  int h0, h1;
  size_t i = 0;
  for (i = 0; i < dstSize; ++i) {
    h0 = charToHex(hashStr[i * 2 + 0]);
    /* printf("<h0>%x\n",h0); */
    h1 = charToHex(hashStr[i * 2 + 1]);
    dst[i] = (unsigned char)((h0 << 4) | h1);
  }
  XXH64_hash_t hashFromStr = XXH64_hashFromCanonical((XXH64_canonical_t *)dst);
  if (hashFromStr == hash) {
    return 0;
  }
  return -1;
}

/*
int main() {
  for (int i = 0; i < 9; i++) {
    cmp_Canonical_XXH64("a09b6b18bebe9610", XXH3_64bits("physics", 7));
  }
  return 0;
}
*/
