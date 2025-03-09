gcc strip_non_ascii.c -o strip_non_ascii.out
sudo cp strip_non_ascii.out /usr/bin/
mkdir 2003_errors
while read f ;
    do strip_non_ascii.out  "$f" > "$f"_cleaned ;
done < <(find . -type f|grep -E './*.tex$|grep -v clean')
