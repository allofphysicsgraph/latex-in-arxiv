#include <ctype.h>
#include <err.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>

#include "abstract.h"
#include "author.h"
#include "bibitem.h"
#include "center.h"
#include "cite.h"
#include "date.h"
#include "description.h"
#include "displaymath.h"
#include "enumerate.h"
#include "eqnarray.h"
#include "equation.h"
#include "figure.h"
#include "footnote.h"
#include "frac.h"
#include "globals.h"
#include "itemize.h"
#include "keywords.h"
#include "label.h"
#include "list.h"
#include "minipage.h"
#include "pacs.h"
#include "picture.h"
#include "quotation.h"
#include "quote.h"
#include "ref.h"
#include "section.h"
#include "setcounter.h"
#include "sqrt.h"
#include "tabbing.h"
#include "table.h"
#include "tabular.h"
#include "thanks.h"
#include "theorem.h"
#include "title.h"
#include "titlepage.h"
#include "usepackage.h"
#include "verbatim.h"
#include "verse.h"

#include "globals.h"

int main(int argc, char **argv) {
struct stat s;
char *buffer;
int fd;
fd = open(argv[1], O_RDONLY);
if (fd < 0)
  return EXIT_FAILURE;
strcpy(filename,argv[1]);
strncpy(results_filename,argv[0],strlen(argv[0])-3);
strcat(results_filename,"csv");
fstat(fd, &s);
/* PROT_READ disallows writing to buffer: will segv */
buffer = mmap(0, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
// read file ok -> then process with flex
if (buffer != (void *)-1) {
  yybuffer buff1; // create a new buffer
  
  buff1 = Frac__scan_string(buffer); // read string into buff1
  Frac__switch_to_buffer(buff1);     // switch to the new buffer
  Frac_out=fopen(results_filename,"a+");
  Frac_lex();                        // run the lexer defined in scanner.l
  Frac__delete_buffer(buff1);        // delete the buffer


buff1 = Abstract__scan_string(buffer);
Abstract__switch_to_buffer(buff1);
Abstract_out = fopen("abstract.csv", "a+");
Abstract_lex();
Abstract__delete_buffer(buff1);

buff1 = Author__scan_string(buffer);
Author__switch_to_buffer(buff1);
Author_out = fopen("author.csv", "a+");
Author_lex();
Author__delete_buffer(buff1);


buff1 = Center__scan_string(buffer);
Center__switch_to_buffer(buff1);
Center_out = fopen("center.csv", "a+");
Center_lex();
Center__delete_buffer(buff1);

buff1 = Cite__scan_string(buffer);
Cite__switch_to_buffer(buff1);
Cite_out = fopen("cite.csv", "a+");
Cite_lex();
Cite__delete_buffer(buff1);

//buff1 = Comments__scan_string(buffer);
//Comments__switch_to_buffer(buff1);
//Comments_out = fopen("comments.csv", "a+");
//Comments_lex();
//Comments__delete_buffer(buff1);

buff1 = Date__scan_string(buffer);
Date__switch_to_buffer(buff1);
Date_out = fopen("date.csv", "a+");
Date_lex();
Date__delete_buffer(buff1);

buff1 = Description__scan_string(buffer);
Description__switch_to_buffer(buff1);
Description_out = fopen("description.csv", "a+");
Description_lex();
Description__delete_buffer(buff1);

buff1 = Displaymath__scan_string(buffer);
Displaymath__switch_to_buffer(buff1);
Displaymath_out = fopen("displaymath.csv", "a+");
Displaymath_lex();
Displaymath__delete_buffer(buff1);

buff1 = Enumerate__scan_string(buffer);
Enumerate__switch_to_buffer(buff1);
Enumerate_out = fopen("enumerate.csv", "a+");
Enumerate_lex();
Enumerate__delete_buffer(buff1);

buff1 = Eqnarray__scan_string(buffer);
Eqnarray__switch_to_buffer(buff1);
Eqnarray_out = fopen("eqnarray.csv", "a+");
Eqnarray_lex();
Eqnarray__delete_buffer(buff1);

buff1 = Equation__scan_string(buffer);
Equation__switch_to_buffer(buff1);
Equation_out = fopen("equation.csv", "a+");
Equation_lex();
Equation__delete_buffer(buff1);

buff1 = Figure__scan_string(buffer);
Figure__switch_to_buffer(buff1);
Figure_out = fopen("figure.csv", "a+");
Figure_lex();
Figure__delete_buffer(buff1);

buff1 = Footnote__scan_string(buffer);
Footnote__switch_to_buffer(buff1);
Footnote_out = fopen("footnote.csv", "a+");
Footnote_lex();
Footnote__delete_buffer(buff1);

buff1 = Frac__scan_string(buffer);
Frac__switch_to_buffer(buff1);
Frac_out = fopen("frac.csv", "a+");
Frac_lex();
Frac__delete_buffer(buff1);

buff1 = Itemize__scan_string(buffer);
Itemize__switch_to_buffer(buff1);
Itemize_out = fopen("itemize.csv", "a+");
Itemize_lex();
Itemize__delete_buffer(buff1);

buff1 = Keywords__scan_string(buffer);
Keywords__switch_to_buffer(buff1);
Keywords_out = fopen("keywords.csv", "a+");
Keywords_lex();
Keywords__delete_buffer(buff1);

buff1 = Label__scan_string(buffer);
Label__switch_to_buffer(buff1);
Label_out = fopen("label.csv", "a+");
Label_lex();
Label__delete_buffer(buff1);

buff1 = List__scan_string(buffer);
List__switch_to_buffer(buff1);
List_out = fopen("list.csv", "a+");
List_lex();
List__delete_buffer(buff1);

buff1 = Minipage__scan_string(buffer);
Minipage__switch_to_buffer(buff1);
Minipage_out = fopen("minipage.csv", "a+");
Minipage_lex();
Minipage__delete_buffer(buff1);


buff1 = Pacs__scan_string(buffer);
Pacs__switch_to_buffer(buff1);
Pacs_out = fopen("pacs.csv", "a+");
Pacs_lex();
Pacs__delete_buffer(buff1);

buff1 = Picture__scan_string(buffer);
Picture__switch_to_buffer(buff1);
Picture_out = fopen("picture.csv", "a+");
Picture_lex();
Picture__delete_buffer(buff1);

buff1 = Quotation__scan_string(buffer);
Quotation__switch_to_buffer(buff1);
Quotation_out = fopen("quotation.csv", "a+");
Quotation_lex();
Quotation__delete_buffer(buff1);

buff1 = Quote__scan_string(buffer);
Quote__switch_to_buffer(buff1);
Quote_out = fopen("quote.csv", "a+");
Quote_lex();
Quote__delete_buffer(buff1);

buff1 = Ref__scan_string(buffer);
Ref__switch_to_buffer(buff1);
Ref_out = fopen("ref.csv", "a+");
Ref_lex();
Ref__delete_buffer(buff1);

buff1 = Section__scan_string(buffer);
Section__switch_to_buffer(buff1);
Section_out = fopen("section.csv", "a+");
Section_lex();
Section__delete_buffer(buff1);

buff1 = Setcounter__scan_string(buffer);
Setcounter__switch_to_buffer(buff1);
Setcounter_out = fopen("setcounter.csv", "a+");
Setcounter_lex();
Setcounter__delete_buffer(buff1);

buff1 = Sqrt__scan_string(buffer);
Sqrt__switch_to_buffer(buff1);
Sqrt_out = fopen("sqrt.csv", "a+");
Sqrt_lex();
Sqrt__delete_buffer(buff1);

buff1 = Tabbing__scan_string(buffer);
Tabbing__switch_to_buffer(buff1);
Tabbing_out = fopen("tabbing.csv", "a+");
Tabbing_lex();
Tabbing__delete_buffer(buff1);

buff1 = Table__scan_string(buffer);
Table__switch_to_buffer(buff1);
Table_out = fopen("table.csv", "a+");
Table_lex();
Table__delete_buffer(buff1);

buff1 = Tabular__scan_string(buffer);
Tabular__switch_to_buffer(buff1);
Tabular_out = fopen("tabular.csv", "a+");
Tabular_lex();
Tabular__delete_buffer(buff1);

buff1 = Thanks__scan_string(buffer);
Thanks__switch_to_buffer(buff1);
Thanks_out = fopen("thanks.csv", "a+");
Thanks_lex();
Thanks__delete_buffer(buff1);

buff1 = Theorem__scan_string(buffer);
Theorem__switch_to_buffer(buff1);
Theorem_out = fopen("theorem.csv", "a+");
Theorem_lex();
Theorem__delete_buffer(buff1);

buff1 = Title__scan_string(buffer);
Title__switch_to_buffer(buff1);
Title_out = fopen("title.csv", "a+");
Title_lex();
Title__delete_buffer(buff1);

buff1 = Titlepage__scan_string(buffer);
Titlepage__switch_to_buffer(buff1);
Titlepage_out = fopen("titlepage.csv", "a+");
Titlepage_lex();
Titlepage__delete_buffer(buff1);

buff1 = Usepackage__scan_string(buffer);
Usepackage__switch_to_buffer(buff1);
Usepackage_out = fopen("usepackage.csv", "a+");
Usepackage_lex();
Usepackage__delete_buffer(buff1);

buff1 = Verbatim__scan_string(buffer);
Verbatim__switch_to_buffer(buff1);
Verbatim_out = fopen("verbatim.csv", "a+");
Verbatim_lex();
Verbatim__delete_buffer(buff1);

buff1 = Verse__scan_string(buffer);
Verse__switch_to_buffer(buff1);
Verse_out = fopen("verse.csv", "a+");
Verse_lex();
Verse__delete_buffer(buff1);

munmap(buffer, s.st_size);       // unmap the file from memory
}

close(fd); // close file descriptor.
return 0;
}

