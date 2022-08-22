install_flex:
	sudo apt install libtool
	sudo apt install texinfo
	sudo apt install help2man
	git clone https://github.com/westes/flex
	cd flex && bash autogen.sh && ./configure && make && sudo make install && sudo cp src/flex /usr/bin/

install_sds:
	git clone https://github.com/antirez/sds
	cp sds/sds* .

base:
	flex -CFa frac.l
	flex -CFa abstract.l
	flex -CFa equation.l
	flex -CFa author.l
	flex -CFa cite.l
	flex -CFa bibitem.l
	flex -CFa bibliography.l
	flex -CFa center.l
	flex -CFa cite.l
	flex -CFa date.l
	flex -CFa description.l
	flex -CFa displaymath.l
	flex -CFa enumerate.l
	flex -CFa eqnarray.l
	flex -CFa equation.l
	flex -CFa figure.l
	flex -CFa footnote.l
	flex -CFa itemize.l
	flex -CFa keywords.l
	flex -CFa label.l
	flex -CFa list.l
	flex -CFa minipage.l
	flex -CFa pacs.l
	flex -CFa picture.l
	flex -CFa quotation.l
	flex -CFa quote.l
	flex -CFa ref.l
	flex -CFa section.l
	flex -CFa setcounter.l
	flex -CFa sqrt.l
	flex -CFa tabbing.l
	flex -CFa table.l
	flex -CFa tabular.l
	flex -CFa thanks.l
	flex -CFa theorem.l
	flex -CFa title.l
	flex -CFa titlepage.l
	flex -CFa usepackage.l
	flex -CFa verbatim.l
	flex -CFa verse.l
	gcc -g -O3 lex.Cite_.c lex.Frac_.c lex.Abstract_.c  lex.Author_.c lex.Center_.c lex.Date_.c lex.Description_.c lex.Displaymath_.c lex.Enumerate_.c lex.Eqnarray_.c lex.Equation_.c lex.Figure_.c lex.Footnote_.c  lex.Itemize_.c lex.Keywords_.c lex.Label_.c lex.List_.c lex.Minipage_.c lex.Pacs_.c lex.Picture_.c lex.Quotation_.c lex.Quote_.c lex.Ref_.c lex.Section_.c lex.Setcounter_.c lex.Sqrt_.c lex.Tabbing_.c lex.Table_.c lex.Tabular_.c lex.Thanks_.c lex.Theorem_.c lex.Title_.c lex.Titlepage_.c lex.Usepackage_.c lex.Verbatim_.c lex.Verse_.c resub.c main.c -o main.out



