git clone https://github.com/jvirkki/libbloom.git
cd libbloom
make
cp misc/test/test.c .
cp murmur2/murmurhash2.h .
gcc test.c bloom.c  -Lbuild/libbloom.so murmur2/MurmurHash2.c -lm
./a.out
