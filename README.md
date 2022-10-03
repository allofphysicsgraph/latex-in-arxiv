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

# build the parser
```
make openssl
make curl
make kore

The parser is long overdue, but in progress. 
The scripts in flex_files work pretty well. 

hashmap.h was borrowed from 
https://github.com/sheredom/hashmap.h
it is required for bloom_filter_test.l 

I am interested in showing the important parts of a document by highlighting special words, or word phrases.
Currently using ncurses for this task.

Currently exploring various options for word tokenization/segmentation 
	(which is not trivial or a solved problem as far as I can tell).
Many tokenizers default to splitting on white spaces often introducing errors.
Seems like building a word list is reasonable for this task.
PunktTrainer from NLTK works well for building a tokenizer.

Many word lists I have seen have words for (such as peoples names, locations, abbreviations ...) 
I would like to not include them in the english.vocab but match them in their own classes of tokens. 



make openssl  
make curl  
make postgres  
make Kore  
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
