copy postings_list (filename,offset_idx,len,word) from '/dev/shm/postings.csv' CSV;

update postings_list
set cnt = x.count
from (select count(word),filename,word from postings_list  group by filename,word ) x
where postings_list.word =x.word
and postings_list.filename = x.filename;

