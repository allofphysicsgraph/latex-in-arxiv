from ctypes import *
t = CDLL('./test.so')
char_ptr = c_char_p(str.encode('./sound1.tex'))
t.author(char_ptr)


