if [[ ! -f Punkt_LaTeX_SENT_Tokenizer.pickle ]];
then 
        xz -d Punkt_LaTeX_SENT_Tokenizer.pickle.xz	
fi



ragel abstract.rl
ragel affiliation.rl
ragel algorithm.rl
ragel aligned.rl
ragel align.rl
ragel author.rl
ragel bibitem.rl
ragel caption.rl
ragel cases.rl
ragel center.rl
ragel cite.rl
ragel definition.rl
ragel description.rl
ragel displaymath.rl
#ragel email.rl
ragel emph.rl
ragel enumerate.rl
ragel eqnarray.rl
ragel equation.rl
ragel figure.rl
ragel flushleft.rl
ragel flushright.rl
ragel fmfgraph.rl
ragel gather.rl
ragel itemize.rl
ragel keywords.rl
ragel label.rl
ragel lemma.rl
ragel list.rl
ragel lstcode.rl
ragel lstlisting.rl
ragel mathletters.rl
ragel matrix.rl
ragel minipage.rl
ragel minted.rl
ragel multline.rl
ragel picture.rl
ragel pmatrix.rl
ragel proof.rl
ragel proposition.rl
ragel prop.rl
ragel quotation.rl
ragel quote.rl
ragel references.rl
ragel ref.rl
ragel scope.rl
ragel section.rl
ragel slm.rl
ragel split.rl
ragel subequations.rl
ragel subsection.rl
ragel table.rl
ragel tabular.rl
ragel textbf.rl
ragel textit.rl
ragel texttt.rl
ragel theorem.rl
ragel titlepage.rl
ragel title.rl
ragel url.rl
ragel usepackage.rl
ragel verbatim.rl
gcc -fPIC -shared -o abstract.so abstract.c
gcc -fPIC -shared -o affiliation.so affiliation.c
gcc -fPIC -shared -o algorithm.so algorithm.c
gcc -fPIC -shared -o aligned.so aligned.c
gcc -fPIC -shared -o align.so align.c
gcc -fPIC -shared -o author.so author.c
gcc -fPIC -shared -o bibitem.so bibitem.c
gcc -fPIC -shared -o caption.so caption.c
gcc -fPIC -shared -o cases.so cases.c
gcc -fPIC -shared -o center.so center.c
gcc -fPIC -shared -o cite.so cite.c
gcc -fPIC -shared -o definition.so definition.c
gcc -fPIC -shared -o description.so description.c
gcc -fPIC -shared -o displaymath.so displaymath.c
#gcc -fPIC -shared -o email.so email.c
gcc -fPIC -shared -o emph.so emph.c
gcc -fPIC -shared -o enumerate.so enumerate.c
gcc -fPIC -shared -o eqnarray.so eqnarray.c
gcc -fPIC -shared -o equation.so equation.c
gcc -fPIC -shared -o figure.so figure.c
gcc -fPIC -shared -o flushleft.so flushleft.c
gcc -fPIC -shared -o flushright.so flushright.c
gcc -fPIC -shared -o fmfgraph.so fmfgraph.c
gcc -fPIC -shared -o gather.so gather.c
gcc -fPIC -shared -o itemize.so itemize.c
gcc -fPIC -shared -o keywords.so keywords.c
gcc -fPIC -shared -o label.so label.c
gcc -fPIC -shared -o lemma.so lemma.c
gcc -fPIC -shared -o list.so list.c
gcc -fPIC -shared -o lstcode.so lstcode.c
gcc -fPIC -shared -o lstlisting.so lstlisting.c
gcc -fPIC -shared -o mathletters.so mathletters.c
gcc -fPIC -shared -o matrix.so matrix.c
gcc -fPIC -shared -o minipage.so minipage.c
gcc -fPIC -shared -o minted.so minted.c
gcc -fPIC -shared -o multline.so multline.c
gcc -fPIC -shared -o picture.so picture.c
gcc -fPIC -shared -o pmatrix.so pmatrix.c
gcc -fPIC -shared -o proof.so proof.c
gcc -fPIC -shared -o proposition.so proposition.c
gcc -fPIC -shared -o prop.so prop.c
gcc -fPIC -shared -o quotation.so quotation.c
gcc -fPIC -shared -o quote.so quote.c
gcc -fPIC -shared -o references.so references.c
gcc -fPIC -shared -o ref.so ref.c
gcc -fPIC -shared -o scope.so scope.c
gcc -fPIC -shared -o section.so section.c
gcc -fPIC -shared -o slm.so slm.c
gcc -fPIC -shared -o split.so split.c
gcc -fPIC -shared -o subequations.so subequations.c
gcc -fPIC -shared -o subsection.so subsection.c
gcc -fPIC -shared -o table.so table.c
gcc -fPIC -shared -o tabular.so tabular.c
gcc -fPIC -shared -o textbf.so textbf.c
gcc -fPIC -shared -o textit.so textit.c
gcc -fPIC -shared -o texttt.so texttt.c
gcc -fPIC -shared -o theorem.so theorem.c
gcc -fPIC -shared -o titlepage.so titlepage.c
gcc -fPIC -shared -o title.so title.c
gcc -fPIC -shared -o url.so url.c
gcc -fPIC -shared -o usepackage.so usepackage.c
gcc -fPIC -shared -o verbatim.so verbatim.c
ragel textit.rl
gcc -fPIC -shared -o textit.so textit.c
ragel algorithm.rl
gcc -fPIC -shared -o algorithm.so algorithm.c
ragel definition.rl
gcc -fPIC -shared -o definition.so definition.c
ragel pageref.rl
gcc -fPIC -shared -o pageref.so pageref.c
ragel date.rl
gcc -fPIC -shared -o date.so date.c
ragel itemize.rl
gcc -fPIC -shared -o itemize.so itemize.c
ragel enumerate.rl
gcc -fPIC -shared -o enumerate.so enumerate.c
ragel scope.rl
gcc -fPIC -shared -o scope.so scope.c
ragel axis.rl
gcc -fPIC -shared -o axis.so axis.c
ragel eqnarray.rl
gcc -fPIC -shared -o eqnarray.so eqnarray.c
