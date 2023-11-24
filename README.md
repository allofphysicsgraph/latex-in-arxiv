# latex-in-arxiv
extract math latex from content in arxiv

_Caveat when cloning this repo_: Total download size is 640 MB. 

## get data

### one option is the full arxiv data available from an S3 bucket
for details, see <https://arxiv.org/help/bulk_data_s3>
```bash
# s3cmd get s3://arxiv/src/arXiv_src_manifest.xml . --requester-pays  
# s3cmd get s3://arxiv/src/arXiv_src_9912_001.tar . --requester-pays  
```

### another option (that's free) is a few years of arxiv
<https://www.cs.cornell.edu/projects/kddcup/datasets.html>

