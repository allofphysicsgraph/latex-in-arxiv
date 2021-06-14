/*
 * =====================================================================================
 *
 *       Filename:  postgres_connection_test.c
 *
 *    Description:  test connection with postgres using libpq
 *    		    https://www.postgresql.org/docs/9.1/libpq-example.html
 *		    gcc postgres_connection_test -I/usr/include/postgresql -lpq
 *
 *        Version:  1.0
 *        Created:  01/30/2020 01:49:14 AM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  YOUR NAME (),
 *   Organization:
 *
 * =====================================================================================
 */
/*
 * testlibpq.c
 *
 *      Test the C version of libpq, the PostgreSQL frontend library.
 */
#include <libpq-fe.h>
#include <stdio.h>
#include <stdlib.h>

static void exit_nicely(PGconn *conn) {
  PQfinish(conn);
  exit(1);
}

int main(int argc, char **argv) {
  const char *conninfo;
  PGconn *conn;
  PGresult *res;
  int nFields;
  int i, j;

  /*
   * If the user supplies a parameter on the command line, use it as the
   * conninfo string; otherwise default to setting dbname=postgres and using
   * environment variables or defaults for all other connection parameters.
   */
  if (argc > 1)
    conninfo = argv[1];
  else
    conninfo = "dbname=arxiv password=arxiv user=arxiv host=127.0.0.1";

  /* Make a connection to the database */
  conn = PQconnectdb(conninfo);

  /* Check to see that the backend connection was successfully made */
  if (PQstatus(conn) != CONNECTION_OK) {
    fprintf(stderr, "Connection to database failed: %s", PQerrorMessage(conn));
    exit_nicely(conn);
  }

  /*
   * Our test case here involves using a cursor, for which we must be inside
   * a transaction block.  We could do the whole thing with a single
   * PQexec() of "select * from pg_database", but that's too trivial to make
   * a good example.
   */

  /* Start a transaction block */
  res = PQexec(conn, "BEGIN");
  if (PQresultStatus(res) != PGRES_COMMAND_OK) {
    fprintf(stderr, "BEGIN command failed: %s", PQerrorMessage(conn));
    PQclear(res);
    exit_nicely(conn);
  }

  /*
   * Should PQclear PGresult whenever it is no longer needed to avoid memory
   * leaks
   */
  PQclear(res);

  /*
   * Fetch rows from pg_database, the system catalog of databases
   */
  res = PQexec(conn, "DECLARE myportal CURSOR FOR select * from pg_database");
  if (PQresultStatus(res) != PGRES_COMMAND_OK) {
    fprintf(stderr, "DECLARE CURSOR failed: %s", PQerrorMessage(conn));
    PQclear(res);
    exit_nicely(conn);
  }
  PQclear(res);

  res = PQexec(conn, "FETCH ALL in myportal");
  if (PQresultStatus(res) != PGRES_TUPLES_OK) {
    fprintf(stderr, "FETCH ALL failed: %s", PQerrorMessage(conn));
    PQclear(res);
    exit_nicely(conn);
  }

  /* first, print out the attribute names */
  nFields = PQnfields(res);
  for (i = 0; i < nFields; i++)
    printf("%-15s", PQfname(res, i));
  printf("\n\n");

  /* next, print out the rows */
  for (i = 0; i < PQntuples(res); i++) {
    for (j = 0; j < nFields; j++)
      printf("%-15s", PQgetvalue(res, i, j));
    printf("\n");
  }

  PQclear(res);

  /* close the portal ... we don't bother to check for errors ... */
  res = PQexec(conn, "CLOSE myportal");
  PQclear(res);

  /* end the transaction */
  res = PQexec(conn, "END");
  PQclear(res);

  /* close the connection to the database and cleanup */
  PQfinish(conn);

  return 0;
}
