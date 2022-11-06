==1072171== Memcheck, a memory error detector
==1072171== Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward et al.
==1072171== Using Valgrind-3.19.0 and LibVEX; rerun with -h for copyright info
==1072171== Command: ./author.out ../sound1.tex
==1072171== 
\author{K. Trachenko}
\author{B. Monserrat}
\author{C. J. Pickard}
\author{V. V. Brazhkin}

==1072171== 
==1072171== HEAP SUMMARY:
==1072171==     in use at exit: 0 bytes in 0 blocks
==1072171==   total heap usage: 1 allocs, 1 frees, 1,024 bytes allocated
==1072171== 
==1072171== All heap blocks were freed -- no leaks are possible
==1072171== 
==1072171== For lists of detected and suppressed errors, rerun with: -s
==1072171== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)


time ./author.out ../sound1.tex
\author{K. Trachenko}
\author{B. Monserrat}
\author{C. J. Pickard}
\author{V. V. Brazhkin}


real	0m0.006s
user	0m0.001s
sys	0m0.006s

