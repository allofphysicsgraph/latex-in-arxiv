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
./lexer 2003/0301215 array

```

## using the Docker container
on Mac,
```bash
make docmac
make lexer
```
