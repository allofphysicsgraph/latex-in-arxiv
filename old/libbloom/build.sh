ragel -G2 postings_list.rl
gcc -O3 postings_list.c bloom.c  -Lbuild/libbloom.so murmur2/MurmurHash2.c -lm
cp ../../src/english.vocab .
echo './a.out document'
echo make sampledata in latex-in-arxiv directory

echo "while read f;do echo $f;./a.out "$f" >> /dev/shm/postings.csv ;sleep 1;done < <(find ../../latex-in-arxiv/2003 -type f)"

