ragel -G2 postings_list.rl
gcc -O3 postings_list.c bloom.c  -Lbuild/libbloom.so murmur2/MurmurHash2.c -lm
cp ../../src/english.vocab .
echo './a.out document'
