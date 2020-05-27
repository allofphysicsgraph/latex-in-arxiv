# latex-in-arxiv
extract math latex from content in arxiv

## get data
for details, see https://arxiv.org/help/bulk_data_s3  
```
# s3cmd get s3://arxiv/src/arXiv_src_manifest.xml  .	--requester-pays  
# s3cmd get s3://arxiv/src/arXiv_src_9912_001.tar .	--requester-pays  
```

## Extract .tex files
```
# tar -xf arXiv_src_9912_001.tar  
# cd 9912  
# mkdir process_hep  
# mv hep*.gz process_hep/  
# cd process_hep  
# gunzip *.gz  
# find . -type f -exec file {} \;|grep "POSIX tar archive"|cut -d ':' -f1|xargs -i tar -xf {}  
# mkdir TEX  
# mv *.tex TEX/  
```
