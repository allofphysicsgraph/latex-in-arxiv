import rpyc
from os import remove
from redis import Redis
import yaml
with open('config.yaml','r') as f:
          config = yaml.safe_load(f)

client = Redis(decode_responses=True)
c = rpyc.connect("127.0.0.1", 18861)
c.root.exposed_process_data_set()
# c.root.paragraphs()
# c.root.sentences()
# c.root.get_abstract(print_results=True)


exit(0)
c.root.read_file("sound1.tex", "file_data")
c.root.symbol_concordance()
# c.root.resolved_symbols()
# c.root.get_results()
# c.root.bag_of_words()
# c.root.preprocessing()
c.root.build_word_tokenizers()
c.root.print_tokenized_sentences()

c.root.get_affiliation(print_results=True)
c.root.get_algorithm(print_results=True)
c.root.get_author(print_results=True)
# c.root.get_bibitem(print_results=True)
# c.root.get_bibliography(print_results=True)
# c.root.get_center(print_results=True)
c.root.get_cite(print_results=True)
# c.root.get_definition(print_results=True)
c.root.get_emph(print_results=True)
# c.root.get_eqnarray(print_results=True)
# c.root.get_figure(print_results=True)
# c.root.get_itemize(print_results=True)
# c.root.get_keywords(print_results=True)
c.root.get_label(print_results=True)
c.root.get_ref(print_results=True)
c.root.get_section(print_results=True)
c.root.get_slm(print_results=True)
c.root.get_title(print_results=True)
c.root.get_url(print_results=True)


# depends on english_word_tokenizer
# depends on sentences
c.root.rank_bm25()
c.root.query_rank_bm25("fundamental constants")
"0301079.tex",
