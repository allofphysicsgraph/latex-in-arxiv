update cite 
 set cite = regexp_replace(cite,'}.*','}','g'),
 len = length(regexp_replace(cite,'}.*','}','g'));

