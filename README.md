# Overview
_Goal_: extract math Latex from `.tex` content available from arXiv. 

_Caveat when cloning this repo_: Total download size is 640 MB. 

## quick start

Read `latex-in-arxiv/src/postings_list/query/README.md`

Everything is containerized, so in this repo (`latex-in-arxiv/`) use
either `make docker` (for linux) or `make docmac` (for Mac). 

To run the application, within the Docker image run `/opt/scanner.out .`

To recompile the scanner, within the Docker image run
```bash
cd latex-in-arxiv/src/postings_list/query
make scanner 
./scanner.out path_to_tex_files tex$
```

## so what?

Suppose you have a `.tex` file that contains math, like
```latex
\documentclass{article}
\title{test}
\begin{document}
\maketitle
\section{Introduction}
This is a great paper.
\begin{equation}
    a+b = c
\end{equation}
Where $c$ is some variable.
\end{document}
```
There's an expression, `a+b=c` and an in-line variable `c`. 
How can the expression and the variables be extracted? 

There are a few options for parsing Latex; see <https://github.com/allofphysicsgraph/latex-in-arxiv/issues/14>
The options that are decent in terms of quality of results are also slow.

This repo uses [`ragel`](https://www.colm.net/open-source/ragel/) to quickly parse Latex and find math. 

## get data

### an option that's free is a few years of arxiv data
<https://www.cs.cornell.edu/projects/kddcup/datasets.html>

In the directory `latex-in-arxiv/get_sample_data` use
```bash
make get_sample_data
```
### ArXiV API calls
```
# curl http://export.arxiv.org/api/query?search_query=all:rigorous%20derivation  
```

### bulk processing: another option is the full arxiv data available from an S3 bucket
for details, see <https://arxiv.org/help/bulk_data_s3>
```bash
# s3cmd get s3://arxiv/src/arXiv_src_manifest.xml . --requester-pays  
# s3cmd get s3://arxiv/src/arXiv_src_9912_001.tar . --requester-pays  
```


