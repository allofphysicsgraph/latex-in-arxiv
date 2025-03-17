gcc strip_non_ascii.c -o strip_non_ascii.out
sudo cp strip_non_ascii.out /usr/bin/


screen -d -m -S file_similarity ssdeep  -rcd  . -t 20 > file_similarity_scores_"$(date +%s)"

mkdir 2003_errors
while read f ;
    do strip_non_ascii.out  "$f" > "$f"_cleaned ;
done < <(find . -type f|grep -E './*.tex$|grep -v clean')
