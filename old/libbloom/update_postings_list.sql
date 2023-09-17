update postings_list
set cnt = x.count
from (select count(word),word from postings_list  group by word ) x
where postings_list.word =x.word;

