while read f ;
    do strip_non_ascii.out  "$f" > "$f"_cleaned ;
done < <(find . -type f|grep -E './[a-f0-9]+.tex')
