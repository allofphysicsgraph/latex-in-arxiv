git clone https://github.com/igraph/igraph
cd igraph/
mkdir build
cd build/
cmake ..
make
sudo make install
cd ..
cd examples/
cd simple/
gcc igraph_strvector.c  $(pkg-config --libs --cflags igraph) -lm
