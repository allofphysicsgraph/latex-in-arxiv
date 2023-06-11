
gcc bloom_filter_test.c bloom.c  -Lbuild/libbloom.so murmur2/MurmurHash2.c -lm
cp ../english.vocab .
echo './a.out search_term'
