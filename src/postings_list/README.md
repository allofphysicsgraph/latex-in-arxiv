Generates a Postings List with a fixed vocabulary of words or phrases. 
A posting list is a list of terms, along with their positions in the document. The postings list is used to efficiently retrieve documents that contain specific terms or phrases.

See Docker instructions in the section below.


Demo of scanning 1,019 files in 2.5 seconds: 
```bash
ls 2003|wc -l
1019

make scanner    # (using word delimiter '▁')

time ./scanner.out 2003
real	0m2.407s
user	0m1.407s
sys	0m0.855s

```

And how much memory was that? 
```
==43506== HEAP SUMMARY:
==43506==     in use at exit: 0 bytes in 0 blocks
==43506==   total heap usage: 1,087 allocs, 1,087 frees, 89,289 bytes allocated
==43506==
==43506== All heap blocks were freed -- no leaks are possible
==43506==
==43506== For lists of detected and suppressed errors, rerun with: -s
==43506== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
```

# (OPTIONAL) download .tex data to parse

You may already have `.tex` files to parse, in which case this step can be skipped.

If you do want a bunch of `.tex` files, 
```bash
cd postings_list
make get_sample_data
```


# Docker instructions 

Start by running either `make docker` (for linux) or `make docmac` (for Mac) in the latex-in-arxiv directory.


Then, inside the container, run `scanner.out .`
where `.`  can be any directory with `.tex` files.


Should take roughly 3 seconds to process the 1019 files from the 2003 sample dataset.
The file name should be printed before the tokens from the file. 

This process takes ~11 minutes for TexSoup and TexSoup has far more errors related to matching groups of text like equations, fractions, abstract etc.

## other things you can do

If you are interested in the offsets and lengths instead of the 
string uncomment  `//	printf("%zd %zd\n", offsets->offset[i],  offsets->length[i]);`
in the `reader.rl` file, 
and comment `printf("%s▁ ",output);` a few lines below.

To add regex or new latex strings edit `latex.rl`

To add new vocabulary such as new words or phrases edit `vocab.rl`

It's ideal to keep the files around 10k or fewer lines. 
If you need more, add a new vocab file and include it in the `scanner.rl`

MAX_TOKEN_COUNT is defined in globals.h
it is currently set to 10000 which is likely small for a large TeX file 




