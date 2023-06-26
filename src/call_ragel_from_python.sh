if [[ ! -f Punkt_LaTeX_SENT_Tokenizer.pickle ]];
then 
        xz -d Punkt_LaTeX_SENT_Tokenizer.pickle.xz	
fi



ragel author.rl
gcc -fPIC -shared -o author.so author.c

ragel usepackage.rl
gcc -fPIC -shared -o usepackage.so usepackage.c

ragel caption.rl
gcc -fPIC -shared -o caption.so caption.c

ragel abstract.rl
gcc -fPIC -shared -o abstract.so abstract.c

ragel equation.rl
gcc -fPIC -shared -o equation.so equation.c

ragel definition.rl
gcc -fPIC -shared -o definition.so definition.c

ragel algorithm.rl
gcc -fPIC -shared -o algorithm.so algorithm.c

ragel slm.rl
gcc -fPIC -shared -o slm.so slm.c

ragel affiliation.rl
gcc -fPIC -shared -o affiliation.so affiliation.c

ragel ref.rl
gcc -fPIC -shared -o ref.so ref.c

ragel title.rl
gcc -fPIC -shared -o title.so title.c

ragel section.rl
gcc -fPIC -shared -o section.so section.c

ragel bibitem.rl
gcc -fPIC -shared -o bibitem.so bibitem.c

ragel url.rl
gcc -fPIC -shared -o url.so url.c

#ragel email.rl
#gcc -fPIC -shared -o email.so email.c

ragel textit.rl
gcc -fPIC -shared -o textit.so textit.c

ragel label.rl
gcc -fPIC -shared -o label.so label.c

ragel figure.rl
gcc -fPIC -shared -o figure.so figure.c

ragel cite.rl
gcc -fPIC -shared -o cite.so cite.c

ragel emph.rl
gcc -fPIC -shared -o emph.so emph.c
ragel emph.rl
gcc -fPIC -shared -o emph.so emph.c
ragel emph.rl
gcc -fPIC -shared -o emph.so emph.c

ragel itemize.rl
gcc -fPIC -shared -o itemize.so itemize.c

ragel textbf.rl
gcc -fPIC -shared -o textbf.so textbf.c

ragel eqnarray.rl
gcc -fPIC -shared -o eqnarray.so eqnarray.c

ragel keywords.rl
gcc -fPIC -shared -o keywords.so keywords.c

ragel center.rl
gcc -fPIC -shared -o center.so center.c

ragel align.rl
gcc -fPIC -shared -o align.so align.c

ragel aligned.rl
gcc -fPIC -shared -o aligned.so aligned.c

ragel cases.rl
gcc -fPIC -shared -o cases.so cases.c

ragel description.rl
gcc -fPIC -shared -o description.so description.c

ragel displaymath.rl
gcc -fPIC -shared -o displaymath.so displaymath.c

ragel enumerate.rl
gcc -fPIC -shared -o enumerate.so enumerate.c

ragel flushleft.rl
gcc -fPIC -shared -o flushleft.so flushleft.c

ragel flushright.rl
gcc -fPIC -shared -o flushright.so flushright.c

ragel fmfgraph.rl
gcc -fPIC -shared -o fmfgraph.so fmfgraph.c

ragel gather.rl
gcc -fPIC -shared -o gather.so gather.c

ragel lemma.rl
gcc -fPIC -shared -o lemma.so lemma.c

ragel list.rl
gcc -fPIC -shared -o list.so list.c

ragel lstcode.rl
gcc -fPIC -shared -o lstcode.so lstcode.c

ragel lstlisting.rl
gcc -fPIC -shared -o lstlisting.so lstlisting.c

ragel mathletters.rl
gcc -fPIC -shared -o mathletters.so mathletters.c

ragel matrix.rl
gcc -fPIC -shared -o matrix.so matrix.c

ragel minipage.rl
gcc -fPIC -shared -o minipage.so minipage.c

ragel minted.rl
gcc -fPIC -shared -o minted.so minted.c

ragel multline.rl
gcc -fPIC -shared -o multline.so multline.c

ragel picture.rl
gcc -fPIC -shared -o picture.so picture.c

ragel pmatrix.rl
gcc -fPIC -shared -o pmatrix.so pmatrix.c

ragel proof.rl
gcc -fPIC -shared -o proof.so proof.c

ragel prop.rl
gcc -fPIC -shared -o prop.so prop.c

ragel proposition.rl
gcc -fPIC -shared -o proposition.so proposition.c

ragel quotation.rl
gcc -fPIC -shared -o quotation.so quotation.c

ragel quote.rl
gcc -fPIC -shared -o quote.so quote.c

ragel references.rl
gcc -fPIC -shared -o references.so references.c

ragel scope.rl
gcc -fPIC -shared -o scope.so scope.c

ragel split.rl
gcc -fPIC -shared -o split.so split.c

ragel subequations.rl
gcc -fPIC -shared -o subequations.so subequations.c

ragel table.rl
gcc -fPIC -shared -o table.so table.c

ragel tabular.rl
gcc -fPIC -shared -o tabular.so tabular.c

ragel theorem.rl
gcc -fPIC -shared -o theorem.so theorem.c

ragel titlepage.rl
gcc -fPIC -shared -o titlepage.so titlepage.c

ragel verbatim.rl
gcc -fPIC -shared -o verbatim.so verbatim.c
ragel texttt.rl
gcc -fPIC -shared -o texttt.so texttt.c
ragel texttt.rl
gcc -fPIC -shared -o texttt.so texttt.c
ragel url.rl
gcc -fPIC -shared -o url.so url.c
ragel subsection.rl
gcc -fPIC -shared -o subsection.so subsection.c
ragel caption.rl
gcc -fPIC -shared -o caption.so caption.c
