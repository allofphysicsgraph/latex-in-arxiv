//gcc levenshtein.c $(pkg-config --libs --cflags  igraph) -lm

#include <igraph.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/param.h>

int get_min(int a, int b, int c) { return (MIN(MIN(a, b), c)); }

int sub_cost(char s, char t) {
  if (s == t) {
    return 0;
  }
  return 2;
}

int main() {
  char str1[10];
  char str2[10];
  memset(str1, '\0', 10);
  strncpy(str1, "attention", 10);
  memset(str2, '\0', 10);
  strncpy(str2, "intention", 10);
  int n = strlen(str1);
  int m = strlen(str2);
  igraph_matrix_t mat;
  igraph_matrix_init(&mat, n + 1, m + 1);
  MATRIX(mat, 0, 0) = 0;
  for (size_t i = 1; i <= n; i++) {
    MATRIX(mat, i, 0) = MATRIX(mat, i - 1, 0) + 1;
  }
  for (size_t j = 1; j <= m; j++) {
    MATRIX(mat, 0, j) = MATRIX(mat, 0, j - 1) + 1;
  }

  for (size_t i = 1; i <= n; i++) {
    for (size_t j = 1; j <= m; j++) {
      MATRIX(mat, i, j) = get_min(MATRIX(mat, i - 1, j) + 1,
                                  MATRIX(mat, i - 1, j - 1) +
                                      sub_cost(str1[i - 1], str2[j - 1]),
                                  MATRIX(mat, i, j - 1) + 1);
    }
  }
  // igraph_matrix_print(&mat);
  int dist = MATRIX(mat, n, m);
  printf("\ndist = %d\n", dist);
  igraph_matrix_destroy(&mat);
  return 0;
}
