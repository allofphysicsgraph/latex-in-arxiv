echo ok to run 6
ssdeep  -rcd  . -t 10 > file_similarity_scores_"$(date +%s)"
