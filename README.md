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

# build the webapp 
```
bash build.sh
open a browser and go to http://localhost:8888  


api:    https://postgrest.org/en/stable/api.html

    Currently there is a limit of 1000 results per query due to resource limitations
    http://159.223.177.134:3000/equation?equation=like.*frac{1}{2}*

    current tables availble for queries  
        title  
        author  
        cite  
        section  
        equation  
    

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
