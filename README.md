# Overview
_Goal_: extract math Latex from `.tex` content available from arXiv. 

_Caveat when cloning this repo_: Total download size is 640 MB. 

## get started

Read `latex-in-arxiv/postings_list/README.md`

Everything is containerized, so in this repo (`latex-in-arxiv/`) use
either `make docker` (for linux) or `make docmac` (for Mac). 

To run the application, within the Docker image run `/opt/scanner.out .`

To recompile the scanner, within the Docker image run
```bash
cd latex-in-arxiv/postings_list/
make scanner
```

## get data

### an option that's free is a few years of arxiv data
<https://www.cs.cornell.edu/projects/kddcup/datasets.html>

In the directory `latex-in-arxiv/get_sample_data` use
```bash
make get_sample_data
```

### another option is the full arxiv data available from an S3 bucket
for details, see <https://arxiv.org/help/bulk_data_s3>
```bash
# s3cmd get s3://arxiv/src/arXiv_src_manifest.xml . --requester-pays  
# s3cmd get s3://arxiv/src/arXiv_src_9912_001.tar . --requester-pays  
```


