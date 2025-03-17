import rpyc
from os import remove
import yaml
from sys import argv
from os import listdir

c = rpyc.connect("127.0.0.1", "18863")
# listdir('/mnt/x/100k')
file_data = c.root.exposed_read_file(argv[1])
sentences = c.root.exposed_get_sentences(file_data)
print(sentences)
