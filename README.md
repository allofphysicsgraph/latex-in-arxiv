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

## build the parser
```
make openssl
make sampledata

```

## using the Docker container
on Mac,
```bash
make docmac
make lexer
```

Run commands using the container 
```bash
docker run --rm -v `pwd`:/scratch latexinarxiv python3 /scratch/old/lexer_20220528.py /scratch/notebooks/hep-th/2003/0303118
```
