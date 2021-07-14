# latex-in-arxiv
extract math latex from content in arxiv

## get data
for details, see https://arxiv.org/help/bulk_data_s3  
```bash
# s3cmd get s3://arxiv/src/arXiv_src_manifest.xml . --requester-pays  
# s3cmd get s3://arxiv/src/arXiv_src_9912_001.tar . --requester-pays  
```


## build the parser
```
make openssl
make sampledata
make lexer

example useage  
./a.out WORDS/crib209.tex zeta  

file_match:./WORDS/crib209.tex  
zeta:line_no:1540:offset:8  
zeta:line_no:1540:offset:19  
```

## using the Docker container
on Mac,
```bash
make docmac
make parser
```
