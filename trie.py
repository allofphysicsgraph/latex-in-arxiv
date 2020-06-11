class Trie(dict):
    #https://github.com/nltk/nltk/blob/develop/nltk/collections.py
    """A Trie implementation for strings"""

    LEAF = True

    def __init__(self, strings=None):
        """Builds a Trie object, which is built around a ``dict``

        If ``strings`` is provided, it will add the ``strings``, which
        consist of a ``list`` of ``strings``, to the Trie.
        Otherwise, it'll construct an empty Trie.

        :param strings: List of strings to insert into the trie
            (Default is ``None``)
        :type strings: list(str)

        """
        super(Trie, self).__init__()
        if strings:
            for string in strings:
                self.insert(string)

    def insert(self, string):
        """Inserts ``string`` into the Trie

        :param string: String to insert into the trie
        :type string: str

        :Example:

        >>> from nltk.collections import Trie
        >>> trie = Trie(["abc", "def"])
        >>> expected = {'a': {'b': {'c': {True: None}}}, \
                        'd': {'e': {'f': {True: None}}}}
        >>> trie == expected
        True

        """
        if len(string):
            self[string[0]].insert(string[1:])
        else:
            # mark the string is complete
            self[Trie.LEAF] = None

    def __missing__(self, key):
        self[key] = Trie()
        return self[key]

    def trie_query(self,search_string):
        resp = trie.get(search_string[0])
        for letter in search_string[1:]:
            resp = resp.get(letter)
        return resp
    
    def get_trie_query_values(self,search_string):
        lst = []
        seen = set()
        seen.add(search_string)
        dct= self.trie_query(search_string)
        results = []
        if isinstance(dct,dict):
            for k,v in dct.items():
                if k !='value':
                    lst.append(search_string+k)
                else:
                    lst.append(v)
                    seen.add(v)

            for search_string in lst:
                for k,v in self.trie_query(search_string).items():
                    if k !='value':
                        if isinstance(k,str):
                            new_string = search_string+k
                            if new_string not in lst:
                                lst.append(search_string+k)
                        else:
                            results.append(search_string)
                    else:
                        if v not in lst:
                            lst.append(v)
                        seen.add(v)
            return results
