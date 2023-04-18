ragel bibliography.rl
gcc -fPIC -shared -o bibliography.so bibliography.c

ragel title.rl
gcc -fPIC -shared -o title.so title.c

ragel author.rl
gcc -fPIC -shared -o author.so author.c

ragel abstract.rl
gcc -fPIC -shared -o abstract.so abstract.c

ragel equation.rl
gcc -fPIC -shared -o equation.so equation.c

ragel affiliation.rl
gcc -fPIC -shared -o affiliation.so affiliation.c
