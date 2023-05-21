# latex-in-arxiv
extract math latex from content in arxiv

## get data

### one option is the full arxiv data available from an S3 bucket
for details, see <https://arxiv.org/help/bulk_data_s3>
```bash
# s3cmd get s3://arxiv/src/arXiv_src_manifest.xml . --requester-pays  
# s3cmd get s3://arxiv/src/arXiv_src_9912_001.tar . --requester-pays  
```

### another option (that's free) is a few years of arxiv
<https://www.cs.cornell.edu/projects/kddcup/datasets.html>

cd /latex-in-arxiv/ragel_files/python 
make

source venv/bin/activate 
python call_ragel.py TEX_file
    the output is a dictionary of lists that includes 
        abstract
        affiliation
        algorithm
        author
        bibitem
        center
        cite
        definition
        email
        emph
        eqnarray
        equation
        figure
        itemize
        keywords
        label
        paragraphs
        ref
        section
        sents
        slm
        textbf
        textit
        thebibliography
        title
        url
        usepackage

    and some variable definitions: 
        on average will match between 10-30% of variable definitions in the tex file

```

## using the Docker container
on Mac,
```bash
make docmac
```

Run commands using the container 
```bash
docker run --rm -v `pwd`:/scratch latexinarxiv python3 /scratch/old/lexer_20220528.py /scratch/notebooks/hep-th/2003/0303118
```
