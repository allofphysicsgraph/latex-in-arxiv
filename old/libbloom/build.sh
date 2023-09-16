ragel -G2 keyword_search.rl
gcc -O3 keyword_search.c bloom.c  -Lbuild/libbloom.so murmur2/MurmurHash2.c -lm
#cp ../../src/english.vocab .
echo './a.out document'
