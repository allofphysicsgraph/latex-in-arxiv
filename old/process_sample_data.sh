#a basic overview of the process to verify the pdfs are essentially the same
if [ ! -d 2003 ];
then
	make sampledata

fi

flex newcommand_testing.l 
gcc -lfl lex.yy.c 
cp a.out 2003/
make newcommand
sudo cp newcommand /usr/bin/
cd 2003/
while read f;do ./a.out $f;done < <(ls|grep 03)
while read f;do cat $f|newcommand > "$f"_newcmd_expanded;done < <(ls|grep ^03|grep -v '\.'|grep -v newcmd)

#may consume all free memory 
	#ls|grep ^03|grep -v a.out|grep -v '\.' |xargs -i -P0 pdflatex "{}" 
	#cat newcommand_expansion_verified |xargs -i echo 2003/"{}" |xargs -i cp "{}" SAMPLE_DATA/

#modify path in sed accordingly to cleanup the output
#ls|grep pdf|xargs -i ssdeep "{}" |sed -r 's/\/home\/user\/latex-in-arxiv\/2003\///g'|tee ../output

#adjust the notebook to match your envrionment
#verify_newcommand_expansion_results.ipynb
