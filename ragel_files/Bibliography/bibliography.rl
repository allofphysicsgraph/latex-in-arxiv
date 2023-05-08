/*
 * @LANG: c++
			any { printf("%s",std::string(ts,te).c_str()); };
 */
#include <cstdio>
#include <cstdlib>
#include <string>
#include <ctype.h>
#include <err.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>


%%{
	machine part_token;
	main := |*

'\n'	 { printf("\n"); };
'\\begin{thebibliography}'	{ printf("<%s>",std::string(ts,te).c_str()); };
'\\end{thebibliography}'	{ printf("<%s>",std::string(ts,te).c_str()); };
'\\bibitem{' (any-'}'){1,15} '}' 	{ printf("<%s>",std::string(ts,te).c_str()); };
'{\\it' (any-'}'){1,25} '}' 	{ printf("<%s>",std::string(ts,te).c_str()); };
'{\\bf' (any-'}'){1,15} '}' 	{ printf("<%s>",std::string(ts,te).c_str()); };
'(' digit{4} ')' 	{ printf("<%s>",std::string(ts,te).c_str()); };
' and '|' of '|' the '|' are '	{ printf("<%s>",std::string(ts,te).c_str()); };
any	{ printf("<%s>",std::string(ts,te).c_str()); };



'(Academia Nationale dei Lincei' (any-')'){0,10}')'|'(Academia Nationale dei Lincei, Rome' (any-')'){0,10}')'|'(Academia Nazionale dei Lincei' (any-')'){0,10}')'|'(Academia Nazionale dei Lincei Roma, Italy' (any-')'){0,10}')'|'(Academia Rom^anv a, Iac si, Romv ania' (any-')'){0,10}')'|'( Academic, Boston' (any-')'){0,10}')'|'(Academic ,London' (any-')'){0,10}')'|'(Academic,new York' (any-')'){0,10}')'|'(Academic, New-York' (any-')'){0,10}')'|'(Academic, NY' (any-')'){0,10}')'|'(}Academic Press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(}Academic Press' (any-')'){0,10}')'|'(Academic  Press' (any-')'){0,10}')'|'(Academic Press 1972' (any-')'){0,10}')'|'(Academic Press, 1979' (any-')'){0,10}')'|'(Academic Press, 1982' (any-')'){0,10}')'|'(Academic Press,1982' (any-')'){0,10}')'|'(Academic Press, Bosoton' (any-')'){0,10}')'|'(Academic Press Inc' (any-')'){0,10}')'|'( Academic Press INC.' (any-')'){0,10}')'|'(Academic Press, INC' (any-')'){0,10}')'|'(Academic Press Inc., Fifth Edition' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Academic Press Inc., Fifth Edition' (any-')'){0,10}')'|'(Academic Press Inc, London' (any-')'){0,10}')'|'(Academic Press, Inc., London' (any-')'){0,10}')'|'(Academic Press, INC., London' (any-')'){0,10}')'|'(Academic Press Inc., New York ' (any-')'){0,10}')'|'( Academic Press INC., New York' (any-')'){0,10}')'|'(Academic Press, Inc. New York, Fourth edition' (any-')'){0,10}')'|'(Academic Press Inc., Orlando' (any-')'){0,10}')'|'(Academic Press Inc., San Diego' (any-')'){0,10}')'|'(Academic Press Limited, London' (any-')'){0,10}')'|'( Academic Press, London' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'( Academic Press, London' (any-')'){0,10}')'|'(Academic  Press, London' (any-')'){0,10}')'|'(Academic~Press, London' (any-')'){0,10}')'|'(}{Academic Press, New York' (any-')'){0,10}')'|'(Academic  Press, New York' (any-')'){0,10}')'|'(Academic Press, New~York' (any-')'){0,10}')'|'(Academic Press, NewYork' (any-')'){0,10}')'|'(Academic Press,New York' (any-')'){0,10}')'|'(Academic Press; New York' (any-')'){0,10}')'|'(Academic Press, New York, fourth edition' (any-')'){0,10}')'|'(Academic Press, New York -- London' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Academic Press, New York -- London' (any-')'){0,10}')'|'(Academic Press, New York, London' (any-')'){0,10}')'|'(Academic Press, New York-London' (any-')'){0,10}')'|'(Academic Press: NY' (any-')'){0,10}')'|'(Academic Press, Orlando, FL' (any-')'){0,10}')'|'(Academic Press, San Diego, CA' (any-')'){0,10}')'|'(Academic Press, San Diego, California' (any-')'){0,10}')'|'(Academic Press, San Francisco' (any-')'){0,10}')'|'(Academic Press, Toronto' (any-')'){0,10}')'|'(Academic, San Diego' (any-')'){0,10}')'|'(Academic - Verlag, Berlin' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Academic - Verlag, Berlin' (any-')'){0,10}')'|'(Academiei, Romania' (any-')'){0,10}')'|'(Acad. Naz. dei Lincei, Rome' (any-')'){0,10}')'|'(Acad  Press' (any-')'){0,10}')'|'(Acad. Press, N.-Y.' (any-')'){0,10}')'|'(Acad. Sinica' (any-')'){0,10}')'|'(Accademia Nazionale dei Lincei' (any-')'){0,10}')'|'(Accademia Nazionale dei Lincei, Roma' (any-')'){0,10}')'|'(Accademia Nazionale dei Lincei, Rome' (any-')'){0,10}')'|'(Accademia Nazionale de Lincei' (any-')'){0,10}')'|'(Accademic Press, INC' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Accademic Press, INC' (any-')'){0,10}')'|'(Accad. Naz. dei Lincei press, Rome' (any-')'){0,10}')'|'(Accad.~Naz.~deiLincei, Rome' (any-')'){0,10}')'|'(Accad.Naz.deiLincei, Rome' (any-')'){0,10}')'|'(Acedemic Press' (any-')'){0,10}')'|'(A. Coley, D. Levi, C. Rogers and P. Winternitz' (any-')'){0,10}')'|'(Ac. Press' (any-')'){0,10}')'|'(Adam Hilgar, Bristol' (any-')'){0,10}')'|'(Adam Hilger,  Bristol' (any-')'){0,10}')'|'(Adam Hilger,Bristol' (any-')'){0,10}')'|'(Adam Hilger: Bristol' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Adam Hilger: Bristol' (any-')'){0,10}')'|'(Adam Hilger, Bristol, England' (any-')'){0,10}')'|'(Adam Hilger, Bristol UK' (any-')'){0,10}')'|'(Adam Hilger Ltd, Bristol' (any-')'){0,10}')'|'(Adam Hilger Ltd., Bristol' (any-')'){0,10}')'|'(Adam IOP Publishing' (any-')'){0,10}')'|'(Addison and Wesley' (any-')'){0,10}')'|'(Addison & Wesley' (any-')'){0,10}')'|'(Addison-Wesley, 1985, Frontiers in Physics' (any-')'){0,10}')'|'(Addison-Wesley, California' (any-')'){0,10}')'|'(Addison--Wesley, Cambridge' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Addison--Wesley, Cambridge' (any-')'){0,10}')'|'(Addison-Wesley, Cambridge' (any-')'){0,10}')'|'(Addison-Wesley, Canada' (any-')'){0,10}')'|'(Addison-Wesley, Inc., Reading, MA' (any-')'){0,10}')'|'(Addison--Wesley, London' (any-')'){0,10}')'|'(Addison-Wesley, Massachusetts' (any-')'){0,10}')'|'( Addison-Wesley, Menlo Park' (any-')'){0,10}')'|'(Addison--Wesley, Menlo Park' (any-')'){0,10}')'|'(Addison-Wesley,Menlo Park,CA' (any-')'){0,10}')'|'(Addison-Wesley, Menlo Park, California' (any-')'){0,10}')'|'(Addison - Wesley, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Addison - Wesley, New York' (any-')'){0,10}')'|'(Addison-Wesley, N.Y.' (any-')'){0,10}')'|'(Addison-Wesley Pabl.Comp.' (any-')'){0,10}')'|'(Addison-Wesley P. Co., New York' (any-')'){0,10}')'|'(Addison-Wesley Press' (any-')'){0,10}')'|'(Addison-Wesley Pub Co' (any-')'){0,10}')'|'(Addison-Wesley Pub. Co. ' (any-')'){0,10}')'|'(Addison-Wesley Pub. Co., Inc., California' (any-')'){0,10}')'|'(Addison-Wesley Pub. Co., Inc., Redwood City, California ' (any-')'){0,10}')'|'(Addison-Wesley Pub. Company, Redwood City, CA' (any-')'){0,10}')'|'(Addison-Wesley Publ. Co., New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Addison-Wesley Publ. Co., New York' (any-')'){0,10}')'|'(Addison-Wesley Publishing Co.' (any-')'){0,10}')'|'(Addison-Wesley Publishing Company, Inc.' (any-')'){0,10}')'|'(Addison--Wesley Publishing Company, London' (any-')'){0,10}')'|'(Addison-Wesley Publishing Company, Massachusetts' (any-')'){0,10}')'|'(Addison-Wesley Publishing Company, New York' (any-')'){0,10}')'|'(Addison-Wesley Publishing Company: Seoul' (any-')'){0,10}')'|'(Addison-Wesley Publishing Company, The Advanced Book' (any-')'){0,10}')'|'(Addison--Wesley Publishing Comp., New York' (any-')'){0,10}')'|'(Addison-Wesley,  Reading' (any-')'){0,10}')'|'(Addison-Wesley; Reading' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Addison-Wesley; Reading' (any-')'){0,10}')'|'(Addison-Wesley, Reading, Ma' (any-')'){0,10}')'|'( Addison-Wesley, Reading, MA' (any-')'){0,10}')'|'(Addison Wesley, Reading, MA' (any-')'){0,10}')'|'(Addison-Wesley,  Reading, MA' (any-')'){0,10}')'|'(Addison-Wesley. Reading, MA' (any-')'){0,10}')'|'(Addison-Wesley: Reading, MA' (any-')'){0,10}')'|'(Addison-Wesley, Reading, MA, 1988' (any-')'){0,10}')'|'(Addison-Wesley,Reading, MA,1988' (any-')'){0,10}')'|'(Addison Wesley, Reading, Mass.' (any-')'){0,10}')'|'(Addison-Wesley,  Reading, Mass.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Addison-Wesley,  Reading, Mass.' (any-')'){0,10}')'|'(Addison-Wesley, Reading -- Massachusets' (any-')'){0,10}')'|'(Addison Wesley, Reading, Massachusetts' (any-')'){0,10}')'|'(Addison-Wesley, Reading Massachusetts' (any-')'){0,10}')'|'(Addison Wesley, Redwood CA' (any-')'){0,10}')'|'(Addison-Wesley, Redwood, CA' (any-')'){0,10}')'|'(Addison-Wesley, Redwood/CA' (any-')'){0,10}')'|'(Addison-Wesley, Redwood, California' (any-')'){0,10}')'|'(Addison Wesley, Redwood City' (any-')'){0,10}')'|'(Addison-Wesley Redwood City' (any-')'){0,10}')'|'(Addison  Wesley, Redwood City, Ca' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Addison  Wesley, Redwood City, Ca' (any-')'){0,10}')'|'(Addison-Wesley, Redwood City, Ca' (any-')'){0,10}')'|'(Addison-Wesley, Redwood City CA' (any-')'){0,10}')'|'(Addison Wesley, Redwood City, California' (any-')'){0,10}')'|'(Addison-Wesley, USA' (any-')'){0,10}')'|'(Addison-Wessley, Reading, MA' (any-')'){0,10}')'|'(Addisson Wesley, Massachusetts' (any-')'){0,10}')'|'(Adison-Wesley, London' (any-')'){0,10}')'|'(Advanced Series in Astrophysics and Cosmology' (any-')'){0,10}')'|'(Advanced Series on Direcctions in High Energy Physics' (any-')'){0,10}')'|'(Adv. Sov. Math.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Adv. Sov. Math.' (any-')'){0,10}')'|'(A. Gleason' (any-')'){0,10}')'|'(A.~Hilger, Bristol' (any-')'){0,10}')'|'(A.Hilger, Bristol' (any-')'){0,10}')'|'(A. Hilger, Bristol, UK' (any-')'){0,10}')'|'(A.~Hilger, Bristol UK' (any-')'){0,10}')'|'(A.~Hilger, Bristol, UK' (any-')'){0,10}')'|'(A. Hilger, New York' (any-')'){0,10}')'|'(AIP Conf. Proc. No. 23, New York' (any-')'){0,10}')'|'(A.I.P. Congress Proc. 433' (any-')'){0,10}')'|'(AIP Press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(AIP Press' (any-')'){0,10}')'|'(AIP press, New York' (any-')'){0,10}')'|'(AIP Press, NewYork' (any-')'){0,10}')'|'(AIP Press: NY' (any-')'){0,10}')'|'(AIP Press, Woodbury' (any-')'){0,10}')'|'(AIP, Woodbury' (any-')'){0,10}')'|'( Akademie-Verlag' (any-')'){0,10}')'|'(Akademische Verlagsgesellschaft Geest & Portig, Leipzig' (any-')'){0,10}')'|'(Akademische Verlagsgesellschaft, Leipzig' (any-')'){0,10}')'|'(Akad. Verlagsges., Leipzig' (any-')'){0,10}')'|'(Akedemische Verlagsgesellschaft, Geest & Portig K.{--}G., Leipzig' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Akedemische Verlagsgesellschaft, Geest & Portig K.{--}G., Leipzig' (any-')'){0,10}')'|'(A K Peters, Wellesley' (any-')'){0,10}')'|'(Allerton Press' (any-')'){0,10}')'|'(Allerton Press, New York' (any-')'){0,10}')'|'(Almgvist and Wiksells, Stockholm' (any-')'){0,10}')'|'(Almquist and Forlag, Stockholm' (any-')'){0,10}')'|'(Almquist and Wicksells, Stockholm' (any-')'){0,10}')'|'(Almquist and Wiksell, Stockholm' (any-')'){0,10}')'|'(Almquist and Wiskell, Stockholm' (any-')'){0,10}')'|'(Almqvist and Wiksell, Stockholm' (any-')'){0,10}')'|'(Almqvist and Wiksell, Stockhom' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Almqvist and Wiksell, Stockhom' (any-')'){0,10}')'|'(Almqvist, Stockholm' (any-')'){0,10}')'|'(Almunecar, Spain' (any-')'){0,10}')'|'(,alpha=1, r_0=arbitrary|(Alushta Conference' (any-')'){0,10}')'|'(Americal Math. Soc., Providence' (any-')'){0,10}')'|'(American Institute of Physics,Melville, New York' (any-')'){0,10}')'|'(American Institute of Physics, Melville, NY' (any-')'){0,10}')'|'(American   Institute of        Physics , New York' (any-')'){0,10}')'|'(American Institute of Physics, Woodbury' (any-')'){0,10}')'|'(American Inst. of Physics' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(American Inst. of Physics' (any-')'){0,10}')'|'(American Mathematical Society, 1992' (any-')'){0,10}')'|'(American Mathematical Society Providence' (any-')'){0,10}')'|'(American Mathematical Society: Providence' (any-')'){0,10}')'|'(American Mathematical Society Providence, RI' (any-')'){0,10}')'|'(American Mathematical Society, Rhode Island' (any-')'){0,10}')'|'(American Math.  Soc.' (any-')'){0,10}')'|'(American Math. Soc.' (any-')'){0,10}')'|'(American Math. Soc., Providence, Rhode Island' (any-')'){0,10}')'|'(American Math. Soc., Providence, Rhode Island' (any-')'){0,10}')'|'(American Math. Soc., Providence, R.I.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(American Math. Soc., Providence, R.I.' (any-')'){0,10}')'|'(American Physical Society, New York' (any-')'){0,10}')'|'(Amer. Inst. Phys., Melville, N.Y.' (any-')'){0,10}')'|'(Amer. Inst. Phys., Melville, N.Y. 267' (any-')'){0,10}')'|'(Amer. Inst. Phys. Woodbury' (any-')'){0,10}')'|'(Amer.Math. Soc.' (any-')'){0,10}')'|'(Amer. Math. Society' (any-')'){0,10}')'|'(Amer. Math. Soc./International Press' (any-')'){0,10}')'|'(Amer. Math. Soc., New York' (any-')'){0,10}')'|'(Amer. Math. Soc., Providence, PI' (any-')'){0,10}')'|'(Amer.Math.Soc.Transl. of Math. Monographs, vol.22' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Amer.Math.Soc.Transl. of Math. Monographs, vol.22' (any-')'){0,10}')'|'(Am.  Math. Soc.' (any-')'){0,10}')'|'(Am. Math. Soc.' (any-')'){0,10}')'|'(Am. Math. Soc., Berkeley, CA' (any-')'){0,10}')'|'(Am. Math Soc., Providence' (any-')'){0,10}')'|'(Am.~Math.~Soc., Providence' (any-')'){0,10}')'|'(A.M.S.College Publ., Providence' (any-')'){0,10}')'|'(AMS/IAS, Providence, RI' (any-')'){0,10}')'|'(AMS: Providence' (any-')'){0,10}')'|'(AMS Pro-vi-den-ce, Rhode Is-land' (any-')'){0,10}')'|'(AMS Providence, Rhode Island' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(AMS Providence, Rhode Island' (any-')'){0,10}')'|'(AMS, Providence-Rhode Island' (any-')'){0,10}')'|'(A.M.S., Providence, R.I.' (any-')'){0,10}')'|'(AMS pub.' (any-')'){0,10}')'|'(AMS Publications, Rhode Island' (any-')'){0,10}')'|'(Amste rdam' (any-')'){0,10}')'|'(Amsterdam, Berlin, Heidelberg, New York' (any-')'){0,10}')'|'(Amsterdam: Elsevier' (any-')'){0,10}')'|'(Amsterdam, North-Holland' (any-')'){0,10}')'|'(Amsterdam: North-Holland' (any-')'){0,10}')'|'(Amsterdam: Noth-Holland' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Amsterdam: Noth-Holland' (any-')'){0,10}')'|'(Amsterdam, W. A. Benjamin' (any-')'){0,10}')'|'(Amsterdan: Elsevier' (any-')'){0,10}')'|'(AMS University Lecture Series, Vol. 10' (any-')'){0,10}')'|'(analytic regularization' (any-')'){0,10}')'|'(and the Liouville mode' (any-')'){0,10}')'|'(Ann Arbor' (any-')'){0,10}')'|'(Annecy, France' (any-')'){0,10}')'|'(Ann. Fond. Louis de Broglie' (any-')'){0,10}')'|'(April 1-5, 1997' (any-')'){0,10}')'|'(April 1992' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(April 1992' (any-')'){0,10}')'|'(April 1994' (any-')'){0,10}')'|'(April 8' (any-')'){0,10}')'|'(Asakura Shoten' (any-')'){0,10}')'|'(Asakura, Tokyo' (any-')'){0,10}')'|'(Athens, GA' (any-')'){0,10}')'|'(Athens University Press' (any-')'){0,10}')'|'( Atomizdat, Moscow' (any-')'){0,10}')'|'(Atomzidad, Moscow' (any-')'){0,10}')'|'(Audretsch J' (any-')'){0,10}')'|'( Aug. 1999' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'( Aug. 1999' (any-')'){0,10}')'|'(A. Zichichi' (any-')'){0,10}')'|'(b ^2 e^{Sigma}, b X, b F, phi' (any-')'){0,10}')'|'(Baifukan, Tokyo' (any-')'){0,10}')'|'(Banff, Canada' (any-')'){0,10}')'|'(Bardonecchia, September 1-5' (any-')'){0,10}')'|'(bar{mathbb Q}' (any-')'){0,10}')'|'(Baruch College, New York' (any-')'){0,10}')'|'(Basic Books' (any-')'){0,10}')'|'(Basic Books, Inc., Publishers, New-York' (any-')'){0,10}')'|'(Basic Books, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Basic Books, New York' (any-')'){0,10}')'|'(Batalin and Marnelius' (any-')'){0,10}')'|'(B. DeWitt and R. Stora' (any-')'){0,10}')'|'(Beijing, China' (any-')'){0,10}')'|'(Belfer Graduate School' (any-')'){0,10}')'|'(Belfer Graduate School of Science, New York' (any-')'){0,10}')'|'(Belfer Graduate School of Science, Yeshiba University, New York' (any-')'){0,10}')'|'(Belfer Graduate school of science, Yeshiva University, New york' (any-')'){0,10}')'|'(Belfer Graduate School of Science, Yeshiva University, New York' (any-')'){0,10}')'|'(Belfer Graduate School of Science, Yeshiva University Press, New York' (any-')'){0,10}')'|'( Belfer graduate School, Yeshiba University Press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'( Belfer graduate School, Yeshiba University Press' (any-')'){0,10}')'|'(Belfer graduate School, Yeshiba University Press' (any-')'){0,10}')'|'(Belfer School of Science, Yeshiva University, New York' (any-')'){0,10}')'|'(Ben-Gurion University Negev Press' (any-')'){0,10}')'|'(ben-Gurion Univ. opf the Negev Prss' (any-')'){0,10}')'|'(Benjamin, Amsterdam' (any-')'){0,10}')'|'(Benjamin and Cummings' (any-')'){0,10}')'|'(Benjamin and Cummings, New York' (any-')'){0,10}')'|'(Benjamin/Commings, Reading' (any-')'){0,10}')'|'(Benjamin / Cummings' (any-')'){0,10}')'|'(Benjamin-Cummings, 1984' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Benjamin-Cummings, 1984' (any-')'){0,10}')'|'(Benjamin Cummings, California' (any-')'){0,10}')'|'(Benjamin/Cummings, California' (any-')'){0,10}')'|'(Ben-ja-min/Cummings, London' (any-')'){0,10}')'|'(Benjamin-Cummings, London' (any-')'){0,10}')'|'( Benjamin/Cummings, Massachusetts' (any-')'){0,10}')'|'(Benjamin-Cummings, Massachusetts' (any-')'){0,10}')'|'(Benjamin/Cummings, Massachusetts' (any-')'){0,10}')'|'(Benjamin/ Cummings, Menlo Park' (any-')'){0,10}')'|'(Benjamin-Cummings, Menlo Park, CA' (any-')'){0,10}')'|'(Benjamin/Cummings, Menlo Park, CA' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Benjamin/Cummings, Menlo Park, CA' (any-')'){0,10}')'|'(Benjamin/Cummings, Menlo Park -- California' (any-')'){0,10}')'|'(Benjamin/Cummings, Menlo Park, California' (any-')'){0,10}')'|'(Benjamin/Cummings, New York' (any-')'){0,10}')'|'(Benjamin/Cummings, NY' (any-')'){0,10}')'|'(Benjamin/Cummings Pub. Co.' (any-')'){0,10}')'|'(Benjamin/Cummings Pub. Co. Inc., California' (any-')'){0,10}')'|'(Benjamin/Cummings Pub. Co., Ink.' (any-')'){0,10}')'|'(Benjamin/ Cummings Publ. Comp., Reading, Mass.' (any-')'){0,10}')'|'( Benjamin/Cummings Publishing Company' (any-')'){0,10}')'|'(Benjamin/Cummings Publishing, London' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Benjamin/Cummings Publishing, London' (any-')'){0,10}')'|'(Benjamin/Cummings Publishing, Menlo Park' (any-')'){0,10}')'|'(Benjamin-Cummings Pu-bli-shing, Reading, Massachusetts' (any-')'){0,10}')'|'(Benjamin/Cummings Pub., MA' (any-')'){0,10}')'|'(Benjamin Cummings, Reading' (any-')'){0,10}')'|'(Benjamin & Cummings, Reading, MA' (any-')'){0,10}')'|'(Benjamin Cummings, Reading, MA.' (any-')'){0,10}')'|'(Benjamin--Cummings, Reading MA' (any-')'){0,10}')'|'(Benjamin--Cummings, Reading, MA' (any-')'){0,10}')'|'(Benjamin-Cummings, Reading MA' (any-')'){0,10}')'|'(Benjamin Cummings, Reading, Mass' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Benjamin Cummings, Reading, Mass' (any-')'){0,10}')'|'(Benjamin-Cummings, Reading, Mass.' (any-')'){0,10}')'|'(Benjamin/Cummings, Reading, Mass.' (any-')'){0,10}')'|'(Benjamin/Cummings,Reading, Mass' (any-')'){0,10}')'|'(Benjamin Cummings, Reading, PA' (any-')'){0,10}')'|'(Benjamin/Cummings, Reading, USA' (any-')'){0,10}')'|'(Benjamin/Cummins Publ. Co., Inc., Reading, MA' (any-')'){0,10}')'|'(Benjamin/Cummins, Reading Mass.' (any-')'){0,10}')'|'(Benjamin, Inc., MA' (any-')'){0,10}')'|'(Benjamin,  London' (any-')'){0,10}')'|'(Benjamin, London' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Benjamin, London' (any-')'){0,10}')'|'(Benjamin, Mass.' (any-')'){0,10}')'|'( Benjamin, Massachusetts' (any-')'){0,10}')'|'(Benjamin, Menlo Park' (any-')'){0,10}')'|'( Benjamin, New York' (any-')'){0,10}')'|'(Benjamin New York' (any-')'){0,10}')'|'(Benjamin: New York' (any-')'){0,10}')'|'(Benjamin Press' (any-')'){0,10}')'|'(Benjamin Press., New York' (any-')'){0,10}')'|'(Benjamin Pub. Co., Boston' (any-')'){0,10}')'|'(Benjamin Publishing Company' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Benjamin Publishing Company' (any-')'){0,10}')'|'(Benjamin, Reading, MA' (any-')'){0,10}')'|'(Benjamin, Reading, Massachsetts' (any-')'){0,10}')'|'(Benjamin, Reading, Massachusetts' (any-')'){0,10}')'|'(Beogrado, Publ. Inst. Math.' (any-')'){0,10}')'|'(Berkeley, CA' (any-')'){0,10}')'|'(Berkeley, Calif.' (any-')'){0,10}')'|'(Berkeley, California' (any-')'){0,10}')'|'(Berkeley, CA, USA' (any-')'){0,10}')'|'(Berkeley preprint 1998' (any-')'){0,10}')'|'(Berkeley: Publish or Perish Inc.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Berkeley: Publish or Perish Inc.' (any-')'){0,10}')'|'(Berkeley Univ. Press, Berkeley, CA' (any-')'){0,10}')'|'(Berkeley, USA' (any-')'){0,10}')'|'(Berlin, Germany: Springer ' (any-')'){0,10}')'|'(Berlin, Germany:Springer' (any-')'){0,10}')'|'(Berlin Springer-Verlag' (any-')'){0,10}')'|'(Berlin:  Springer-Verlag' (any-')'){0,10}')'|'(Bilbo, Spain, World Scient. Publ. Co.' (any-')'){0,10}')'|'(Birkh$ddot a$user, Basel' (any-')'){0,10}')'|'(Birkh$ddot{a}$user, Boston' (any-')'){0,10}')'|'(Birkhaeuser, Basel' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Birkhaeuser, Basel' (any-')'){0,10}')'|'(Birkh"{a}ser, Stuttgart' (any-')'){0,10}')'|'(Bir-khas-ter, Boston' (any-')'){0,10}')'|'(Birkh{"a}usen, Boston' (any-')'){0,10}')'|'(Birkhauser ' (any-')'){0,10}')'|'(Birk-hauser, Basel' (any-')'){0,10}')'|'(Birkh"{a}user, Basel' (any-')'){0,10}')'|'(Birkha"{u}ser, Basel' (any-')'){0,10}')'|'(Birkh" auser, Boston' (any-')'){0,10}')'|'(Birkh"a user, Boston' (any-')'){0,10}')'|'(BirkH{a}user, Boston' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(BirkH{a}user, Boston' (any-')'){0,10}')'|'(Birkh"{a}user, Boston, Basel' (any-')'){0,10}')'|'(Birkh"auser, Boston Basel Berlin' (any-')'){0,10}')'|'(Birkh"auser, Boston-Basel-Berlin' (any-')'){0,10}')'|'(Birkh"auser Boston, Boston' (any-')'){0,10}')'|'(Birkh"{a}user Boston Inc.' (any-')'){0,10}')'|'(Birkh"auser Boston Inc.' (any-')'){0,10}')'|'(Birkhauser Boston Inc.' (any-')'){0,10}')'|'(Birkh{"a}user Verlag' (any-')'){0,10}')'|'(Birkh"auser Verlag, Basel' (any-')'){0,10}')'|'(Birkha"user--Verlag, Basel' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Birkha"user--Verlag, Basel' (any-')'){0,10}')'|'(Birkhauser Verlag, Basel' (any-')'){0,10}')'|'(Birk{"o}user, Boston' (any-')'){0,10}')'|'(Blackie, London' (any-')'){0,10}')'|'( Blackie{&}Son, Glasgow' (any-')'){0,10}')'|'(Blackie & Son, London' (any-')'){0,10}')'|'(Blackwell Scientific Publications' (any-')'){0,10}')'|'(Boca Raton, FL:CRC' (any-')'){0,10}')'|'(Bogoliubov Institute, Kiev' (any-')'){0,10}')'|'(Bologna, Nicola Zanichelli' (any-')'){0,10}')'|'(Boringhieri; Torino' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Boringhieri; Torino' (any-')'){0,10}')'|'(Boston: Birkh"{a}user' (any-')'){0,10}')'|'(Boston: International Press' (any-')'){0,10}')'|'(Boston, USA: Birkh"auser' (any-')'){0,10}')'|'(Boulder, CO' (any-')'){0,10}')'|'(Boulder, Colorado' (any-')'){0,10}')'|'(Brandeis University report BRX-TH-350, hep-th/9307057' (any-')'){0,10}')'|'(Brandeis University Summer Intitute' (any-')'){0,10}')'|'(Bristol, Adam Hilger' (any-')'){0,10}')'|'(Bristol and Philadelphia, Adam Hilger' (any-')'){0,10}')'|'(Bristol: Hilger' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Bristol: Hilger' (any-')'){0,10}')'|'(Bristol: IOP Publishing' (any-')'){0,10}')'|'(Bristol, Uk: Hilger' (any-')'){0,10}')'|'(BRST, harmonics' (any-')'){0,10}')'|'(Brunswick, Maine' (any-')'){0,10}')'|'(Bucharesr, Romania: Academiei' (any-')'){0,10}')'|'(Buckow, Germany' (any-')'){0,10}')'|'(Buckow, September 1-5' (any-')'){0,10}')'|'(Bucurec sti' (any-')'){0,10}')'|'(Butterworth, London' (any-')'){0,10}')'|'(Calderon Press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Calderon Press' (any-')'){0,10}')'|'(Calendon Press, Oxford' (any-')'){0,10}')'|'({cal M}' (any-')'){0,10}')'|'({cal S}' (any-')'){0,10}')'|'(Caltech report CALT-68-1833, hep-th/9211011' (any-')'){0,10}')'|'(Cambdridge University Press' (any-')'){0,10}')'|'(Cambridge, Cambridge, 1995' (any-')'){0,10}')'|'(Cambridge, Cambridge  Univ. Press' (any-')'){0,10}')'|'(Cambridge, Cambridge Univ. Press' (any-')'){0,10}')'|'(Cambridge, CUP' (any-')'){0,10}')'|'(Cambridge, England, August 13' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Cambridge, England, August 13' (any-')'){0,10}')'|'(Cambridge, Massachusetts' (any-')'){0,10}')'|'(Cambridge: MIT Press' (any-')'){0,10}')'|'(Cambridge Monographs on Mathematical Physics' (any-')'){0,10}')'|'(Cambridge Monographs On Mathematical Physics' (any-')'){0,10}')'|'(Cambridge Press' (any-')'){0,10}')'|'( Cambridge Press, New York' (any-')'){0,10}')'|'(Cambridge Press, NY' (any-')'){0,10}')'|'(Cambridge -- UK' (any-')'){0,10}')'|'(Cambridge, UK: Cambridge University Press' (any-')'){0,10}')'|'(Cambridge, UK: Univ. Pr.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Cambridge, UK: Univ. Pr.' (any-')'){0,10}')'|'(Cambridge, UK: Univ. Pr. ' (any-')'){0,10}')'|'(Cambridge U., New York' (any-')'){0,10}')'|'(Cambridge Uni. Press, Cambridge' (any-')'){0,10}')'|'(Cambridge Univ.' (any-')'){0,10}')'|'(Cambridge Univeersity Press' (any-')'){0,10}')'|'(Cambridge Univeristy Press' (any-')'){0,10}')'|'(Cambridge Universe Press, Cambridge' (any-')'){0,10}')'|'(Cambridge University, Cambridge' (any-')'){0,10}')'|'(cambridge University press' (any-')'){0,10}')'|'(Cambridge University press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Cambridge University press' (any-')'){0,10}')'|'(Cambridge University 	Press' (any-')'){0,10}')'|'(Cambridge University   Press' (any-')'){0,10}')'|'(Cambridge University~Press' (any-')'){0,10}')'|'(Cambridge University Press 1995' (any-')'){0,10}')'|'(Cambridge University Press, 1998' (any-')'){0,10}')'|'(Cambridge University Press, 2nd. edition' (any-')'){0,10}')'|'(Cambridge University Press, 4th ed.' (any-')'){0,10}')'|'(Cambridge University Press, Cambridg' (any-')'){0,10}')'|'(Cambridge university press, Cambridge' (any-')'){0,10}')'|'(Cambridge university Press, Cambridge' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Cambridge university Press, Cambridge' (any-')'){0,10}')'|'(Cambridge University press, Cambridge' (any-')'){0,10}')'|'( Cambridge University Press, Cambridge' (any-')'){0,10}')'|'(Cambridge University Press. Cambridge' (any-')'){0,10}')'|'(Cambridge University Press., Cambridge' (any-')'){0,10}')'|'(}Cambridge University Press, Cambridge, England' (any-')'){0,10}')'|'(Cambridge~University~Press, Cambridge, England' (any-')'){0,10}')'|'(Cambridge University Press, Cambridge, first printing' (any-')'){0,10}')'|'(Cambridge University Press, Cambridge, Ma' (any-')'){0,10}')'|'(Cambridge University Press, Cambridge, U.K.' (any-')'){0,10}')'|'(Cambridge University Press, Cambridge,UK' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Cambridge University Press, Cambridge,UK' (any-')'){0,10}')'|'(Cambridge University Press, Cambridge/UK' (any-')'){0,10}')'|'(Cambridge University Press, Cambridge United Kingdom' (any-')'){0,10}')'|'(Cambridge University Press, Cambrigde, UK' (any-')'){0,10}')'|'(Cambridge University Press, Ed. J.M. Charap' (any-')'){0,10}')'|'(Cambridge University Press, London and New York' (any-')'){0,10}')'|'(Cambridge  University Press. News York' (any-')'){0,10}')'|'(Cambridge University Press: New York' (any-')'){0,10}')'|'(Cambridge University Press, N.Y.' (any-')'){0,10}')'|'(Cambridge University Press,NY' (any-')'){0,10}')'|'(Cambridge University Press, UK' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Cambridge University Press, UK' (any-')'){0,10}')'|'(Cambridge University Publishing, Cambridge' (any-')'){0,10}')'|'(Cambridge Univesity Press, Cambridge, England' (any-')'){0,10}')'|'(Cambridge Univ., N.Y.' (any-')'){0,10}')'|'(Cambridge Univ. Pr.' (any-')'){0,10}')'|'(Cambridge univ. press' (any-')'){0,10}')'|'(Cambridge Univ. press' (any-')'){0,10}')'|'( Cambridge Univ. Press' (any-')'){0,10}')'|'(Cambridge  Univ  Press' (any-')'){0,10}')'|'(Cambridge  Univ. Press' (any-')'){0,10}')'|'(Cambridge Univ, Press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Cambridge Univ, Press' (any-')'){0,10}')'|'(Cambridge Univ. Press, 3rd ed.' (any-')'){0,10}')'|'(Cambridge Univ. Press, Cambdridge' (any-')'){0,10}')'|'(Cambridge Univ. Press, Cambridge ' (any-')'){0,10}')'|'(Cambridge Univ. Press., Cambridge' (any-')'){0,10}')'|'(Cambridge Univ. Press: Cambridge' (any-')'){0,10}')'|'(Cambridge Univ. Press: Cambridge, 1902' (any-')'){0,10}')'|'(Cambridge Univ. Press., Cambridge, Eng.' (any-')'){0,10}')'|'(Cambridge Univ. Press, Cambridge Press' (any-')'){0,10}')'|'(Cambridge Univ. Press, London' (any-')'){0,10}')'|'(Cambridge Univ., UK' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Cambridge Univ., UK' (any-')'){0,10}')'|'(Cambridge Unversity Press' (any-')'){0,10}')'|'(Cambridge U.P' (any-')'){0,10}')'|'(Cambridge UP, 1984' (any-')'){0,10}')'|'(Cambridge U.P., 2nd Edition' (any-')'){0,10}')'|'(Cambridge UP, Cambridge, England' (any-')'){0,10}')'|'(Cambridge UP, Cambridge/UK' (any-')'){0,10}')'|'(Cambridge U. Pr., Cambridge' (any-')'){0,10}')'|'(Cambridge U. Press' (any-')'){0,10}')'|'(Cambridge U. Press, London' (any-')'){0,10}')'|'(Cambrigde University Press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Cambrigde University Press' (any-')'){0,10}')'|'(Cambrigde Univ. Press, Cambrigde' (any-')'){0,10}')'|'(Cambrige University, Cambrige' (any-')'){0,10}')'|'( Cambrige University Press' (any-')'){0,10}')'|'(Cambrige University Press, Cambridge' (any-')'){0,10}')'|'(Cambr.Univ.Press, Cambridge, 1990' (any-')'){0,10}')'|'(Camb. Univ. Press' (any-')'){0,10}')'|'(Camgridge University Press' (any-')'){0,10}')'|'(Canadian Math.Soc.Conf.Proc., Vol.12' (any-')'){0,10}')'|'(Canbridge University Press, Canbridge' (any-')'){0,10}')'|'(Cargese 1987' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Cargese 1987' (any-')'){0,10}')'|'(Carg`ese NATO Workshop' (any-')'){0,10}')'|'(Carl Hanser Verlag' (any-')'){0,10}')'|'(Catania University; Catania' (any-')'){0,10}')'|'(C. Bartocci, U. Bruzzo' (any-')'){0,10}')'|'(C. Bartocci, U. Bruzzo,, R. Cianci' (any-')'){0,10}')'|'(CBMS Regional Conference Series in Mathematics textbf{85}, AMS' (any-')'){0,10}')'|'(C. DeWitt and M. Jacob' (any-')'){0,10}')'|'(C. de Witt and R. Stora' (any-')'){0,10}')'|'(C. Domb and J.L. Lebowitz' (any-')'){0,10}')'|'(C. Domb and M. Green' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(C. Domb and M. Green' (any-')'){0,10}')'|'(C. Efthimiou and B. Greene' (any-')'){0,10}')'|'(Center A. Volta, Como' (any-')'){0,10}')'|'(Center for Relativity, The University of Texas at Austin' (any-')'){0,10}')'|'(Centre de Recherche Math., Montreal' (any-')'){0,10}')'|'(C.E. Pearson' (any-')'){0,10}')'|'(CERN, Geneva' (any-')'){0,10}')'|'(CERN report CERN-TH.6889/93, gr-qc/9305012' (any-')'){0,10}')'|'(Chalk River/Deep River' (any-')'){0,10}')'|'(Chambridge press' (any-')'){0,10}')'|'( Chambridge University press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'( Chambridge University press' (any-')'){0,10}')'|'(Chambridge University Press' (any-')'){0,10}')'|'(Chapman and Hall/CRC, London' (any-')'){0,10}')'|'(Chapman and Hall, London' (any-')'){0,10}')'|'(Charles Griffin, London' (any-')'){0,10}')'|'(Chelsea Pub. Co.' (any-')'){0,10}')'|'(Chelsea Pub.Co' (any-')'){0,10}')'|'(Chelsea Pub.Co.' (any-')'){0,10}')'|'(Chelsea Publ. Co.' (any-')'){0,10}')'|'(Chelsea Publ. Co., New York' (any-')'){0,10}')'|'(Chelsea Publishing Company, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Chelsea Publishing Company, New York' (any-')'){0,10}')'|'(Chelsea Publishing Company, NY' (any-')'){0,10}')'|'(Chelsea Publishing Co., N.Y.' (any-')'){0,10}')'|'(Chelsea Publ., New York' (any-')'){0,10}')'|'(Chicago IL' (any-')'){0,10}')'|'(Chicago, Ill' (any-')'){0,10}')'|'(Chicago U., EFI' (any-')'){0,10}')'|'(Chicago  University Press, Chicago' (any-')'){0,10}')'|'(Chichester, England' (any-')'){0,10}')'|'(Chic sinu au' (any-')'){0,10}')'|'(Chinese translation,Science Publishers,Beijing' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Chinese translation,Science Publishers,Beijing' (any-')'){0,10}')'|'(Chmmbridge University Press' (any-')'){0,10}')'|'(Chungbum, Seoul' (any-')'){0,10}')'|'(Chungbum, Seul' (any-')'){0,10}')'|'(Chur, Switzerland' (any-')'){0,10}')'|'(CIEMAT, Madrid' (any-')'){0,10}')'|'(CIEMAT/RSEF, Madrid' (any-')'){0,10}')'|'(City Coll.' (any-')'){0,10}')'|'(City College, New York' (any-')'){0,10}')'|'(C. J. Isham {em et al}' (any-')'){0,10}')'|'(Claredon; Oxford' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Claredon; Oxford' (any-')'){0,10}')'|'(Claredon Press; 3rd ed.' (any-')'){0,10}')'|'(Clarendon Oxford' (any-')'){0,10}')'|'(Clarendon, Oxfprd' (any-')'){0,10}')'|'(Clarendon Press $cdot$ Oxford' (any-')'){0,10}')'|'(Clarendon Press, London' (any-')'){0,10}')'|'( Clarendon Press, Oxford' (any-')'){0,10}')'|'(Clarendon Press . Oxford' (any-')'){0,10}')'|'(Clarendon Press Oxford' (any-')'){0,10}')'|'(Clarendon Press,  Oxford' (any-')'){0,10}')'|'(Clarendon Press, Oxford, England' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Clarendon Press, Oxford, England' (any-')'){0,10}')'|'(Clarendon Press, Oxford, second ed.' (any-')'){0,10}')'|'(Clarendon Press, Oxford, second edition' (any-')'){0,10}')'|'(Clarendon Press, Oxford University' (any-')'){0,10}')'|'(Clarendron, Oxford' (any-')'){0,10}')'|'(Clarenton Press, Oxford' (any-')'){0,10}')'|'(Class. Quant. Grav.' (any-')'){0,10}')'|'(Class. Quant. Grav.' (any-')'){0,10}')'|'(CNRS, Paris' (any-')'){0,10}')'|'(CNYITP, Stony Brook, NY, December 1-2' (any-')'){0,10}')'|'(Colier-Macmillan, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Colier-Macmillan, New York' (any-')'){0,10}')'|'(College Park, Md.' (any-')'){0,10}')'|'(Collier Macmillan, London' (any-')'){0,10}')'|'(Colloquium, Hannover' (any-')'){0,10}')'|'(Cologne Univ. Print-91-0225' (any-')'){0,10}')'|'(Colorado Associated Press' (any-')'){0,10}')'|'(Colorado Associated Univ. Press, Boulder' (any-')'){0,10}')'|'(Colorado Assoc. Univ. Press, Boulder' (any-')'){0,10}')'|'(Columbia Univ. Press, New York' (any-')'){0,10}')'|'(Commack, N.Y. Nova Science' (any-')'){0,10}')'|'(Compositori, Bologna' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Compositori, Bologna' (any-')'){0,10}')'|'(Computer Algebra Nederland, Amsterdam' (any-')'){0,10}')'|'(Conf. at Imperial College, London' (any-')'){0,10}')'|'(Consiglio Nazionale delle Ricerche, Roma' (any-')'){0,10}')'|'( Consultant Bureau' (any-')'){0,10}')'|'(Consultant Bureau, New York' (any-')'){0,10}')'|'(Consultant Bureau, N. Y. ' (any-')'){0,10}')'|'(Consultants Bureau, London' (any-')'){0,10}')'|'(Consultants Bureau, N.Y.' (any-')'){0,10}')'|'(Consultants Bureau, NY' (any-')'){0,10}')'|'(Contemporary Soviet Mathematics, Consultants Bureau, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Contemporary Soviet Mathematics, Consultants Bureau, New York' (any-')'){0,10}')'|'(copyright 1969' (any-')'){0,10}')'|'(Corfu, September' (any-')'){0,10}')'|'(Cornell University' (any-')'){0,10}')'|'(Cornell University, Ithaca, NY' (any-')'){0,10}')'|'(Cornell University Press, Ithaca' (any-')'){0,10}')'|'(Cornell Univ. Press, Ithaca' (any-')'){0,10}')'|'(Course on Theor. Phys.' (any-')'){0,10}')'|'(C.P., Oxford' (any-')'){0,10}')'|'(CRC press' (any-')'){0,10}')'|'(CRC Press, Boca Raton, Florida' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(CRC Press, Boca Raton, Florida' (any-')'){0,10}')'|'(Crete, Greece' (any-')'){0,10}')'|'(Crimea, Ukraine' (any-')'){0,10}')'|'(CRM, Montreal University Press' (any-')'){0,10}')'|'(C. Scribner & sons, New York' (any-')'){0,10}')'|'( c Stiinc ta, Chic sinv au' (any-')'){0,10}')'|'(C. Teitelboim' (any-')'){0,10}')'|'(Cuautitlan, Mexico' (any-')'){0,10}')'|'(C.U.P, Cambridge' (any-')'){0,10}')'|'(C.U.P.  Cambridge' (any-')'){0,10}')'|'(CUP, }Cambridgeemph{' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(CUP, }Cambridgeemph{' (any-')'){0,10}')'|'(d_a{}^b ,|(Dallas, Texas' (any-')'){0,10}')'|'(DAMPT, Cambridge, England' (any-')'){0,10}')'|'(D.C.Spencer and S.Iyanaga' (any-')'){0,10}')'|'(Dec. 2-5' (any-')'){0,10}')'|'(Dec 90' (any-')'){0,10}')'|'(December 13-18' (any-')'){0,10}')'|'(December 7' (any-')'){0,10}')'|'(De Gruyter' (any-')'){0,10}')'|'(de Gruyter, Berlin' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(de Gruyter, Berlin' (any-')'){0,10}')'|'(Dekker, 1993' (any-')'){0,10}')'|'(del Olmo M A' (any-')'){0,10}')'|'(Department of Physics, Nagoya University, Nagoya' (any-')'){0,10}')'|'(Deser, Grisaru and Pendleton eds.' (any-')'){0,10}')'|'(de union init' (any-')'){0,10}')'|'(Deutscher Verlag der Wissenschaften, Berlin' (any-')'){0,10}')'|'(Deutscher Verlag Der Wissenschaften, Berlin' (any-')'){0,10}')'|'(D. Heidel, Publ. Co., Dordrecht' (any-')'){0,10}')'|'(D. Horvath, P. Levai, A. Patkos' (any-')'){0,10}')'|'(D.I.A.S., Dublin' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(D.I.A.S., Dublin' (any-')'){0,10}')'|'(diploma thesis' (any-')'){0,10}')'|'(Diploma Thesis, Bonn University 2000' (any-')'){0,10}')'|'(diploma thesis in german' (any-')'){0,10}')'|'(Diploma thesis, Vienna' (any-')'){0,10}')'|'(DMV, Berlin' (any-')'){0,10}')'|'(DO $,|(Doctorial dissertation, 1994,May' (any-')'){0,10}')'|'(Dordrecht: D. Reidel' (any-')'){0,10}')'|'(Dordrecht: Kluwer' (any-')'){0,10}')'|'(Dordrecht, Netherlands: Kluwer Academic' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Dordrecht, Netherlands: Kluwer Academic' (any-')'){0,10}')'|'(Dordrecht Reidel' (any-')'){0,10}')'|'(Dover, 2nd Edition' (any-')'){0,10}')'|'(Dover, 9th printing' (any-')'){0,10}')'|'(Dover Edition, New York' (any-')'){0,10}')'|'(Dover Edition, NY' (any-')'){0,10}')'|'(Dover Inc.' (any-')'){0,10}')'|'( Dover, New York' (any-')'){0,10}')'|'( Dover, New York ' (any-')'){0,10}')'|'(Dover, New, York' (any-')'){0,10}')'|'(Dover, New--York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Dover, New--York' (any-')'){0,10}')'|'(Dover, New-York' (any-')'){0,10}')'|'(Dover: New York, 1950' (any-')'){0,10}')'|'(Dover, New York, NY' (any-')'){0,10}')'|'(Dover, NY' (any-')'){0,10}')'|'(Dover paperback' (any-')'){0,10}')'|'(Dover Press, New York' (any-')'){0,10}')'|'(Dover Pub.' (any-')'){0,10}')'|'(Dover Pub. Inc. N. Y.' (any-')'){0,10}')'|'(Dover Publ.' (any-')'){0,10}')'|'(Dover  Publications' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Dover  Publications' (any-')'){0,10}')'|'(Dover publications, inc.' (any-')'){0,10}')'|'(Dover Publications, Inc.' (any-')'){0,10}')'|'( Dover Publications,Inc. New York' (any-')'){0,10}')'|'(Dover Publications Inc., New York' (any-')'){0,10}')'|'(Dover Publications, London' (any-')'){0,10}')'|'(Dover Publications , New York ' (any-')'){0,10}')'|'(Dover Publications, New York, 1965' (any-')'){0,10}')'|'(Dover Publ. Inc., New York' (any-')'){0,10}')'|'(Dover Publ., INC, N. Y.' (any-')'){0,10}')'|'(Dover Publ., New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Dover Publ., New York' (any-')'){0,10}')'|'(Dover Publ. N. York' (any-')'){0,10}')'|'(Dover Publs.' (any-')'){0,10}')'|'(Dover, Toronto' (any-')'){0,10}')'|'(Dower Publ., New York' (any-')'){0,10}')'|'(D.Redel Publish Company, Dordrecht' (any-')'){0,10}')'|'(D. Reidel' (any-')'){0,10}')'|'(D. Reidel, Boston' (any-')'){0,10}')'|'( D. Reidel, Dordrecht' (any-')'){0,10}')'|'(D.~Reidel, Dordrecht' (any-')'){0,10}')'|'(D.Reidel, Dordrecht' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(D.Reidel, Dordrecht' (any-')'){0,10}')'|'(D. Reidel Pub. Co. , Dordrecht, Boston' (any-')'){0,10}')'|'(D. Reidel Publ. Co.: Dordrecht' (any-')'){0,10}')'|'(D. Reidel Publ. Comp.' (any-')'){0,10}')'|'(D.~Reidel Publishing' (any-')'){0,10}')'|'(D. Reidel Publishing Co., Dordrecht' (any-')'){0,10}')'|'(D.Reidel Publishing Company, Dordrecht' (any-')'){0,10}')'|'(D. Reidel Publishing Company, the  Netherlands' (any-')'){0,10}')'|'(D. Reidel Publishing, Dordrecht' (any-')'){0,10}')'|'(D. Reidel Publishing, Dordrecht-Holland' (any-')'){0,10}')'|'(D. Stauffer' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(D. Stauffer' (any-')'){0,10}')'|'(Dt. Verlag Wiss.' (any-')'){0,10}')'|'(Dubna, 8-12 July' (any-')'){0,10}')'|'(Dubna, July 13-17' (any-')'){0,10}')'|'(Dunod,  Paris' (any-')'){0,10}')'|'(Dunod, Paris ' (any-')'){0,10}')'|'(Durham, England' (any-')'){0,10}')'|'(Dutton, New York' (any-')'){0,10}')'|'(D. van Nostrand Co. Ltd., Toronto' (any-')'){0,10}')'|'(D. van Nostrand, Princeton' (any-')'){0,10}')'|'(D.V Shirkov et al, JINR publ.,Dubna' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(D.V Shirkov et al, JINR publ.,Dubna' (any-')'){0,10}')'|'(E2-99-35, Dubna' (any-')'){0,10}')'|'(E: B {bf 407}' (any-')'){0,10}')'|'(E: {bf B 364}' (any-')'){0,10}')'|'(E: {bf B89}' (any-')'){0,10}')'|'(E:{bf D30}' (any-')'){0,10}')'|'(Ed.Academiei, Romania' (any-')'){0,10}')'|'(ed. A. Zichichi, Plenum Press, New York' (any-')'){0,10}')'|'(E:  D {bf 58}' (any-')'){0,10}')'|'(ed. B. Jancewicz and J. Lukierski, World-Scientific' (any-')'){0,10}')'|'(ed. by A.L. Onishchik, Springer-Verlag' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(ed. by A.L. Onishchik, Springer-Verlag' (any-')'){0,10}')'|'(ed. by J. Leech, Pergamon Press' (any-')'){0,10}')'|'(ed. by L. Witten, Wiley, New York' (any-')'){0,10}')'|'(Ed. Cremonese, Roma' (any-')'){0,10}')'|'(Ed. Didacticv a c si Pedagogicv a, Bucurec sti' (any-')'){0,10}')'|'(ed. D. Stump and D. Weingarten, Wiley' (any-')'){0,10}')'|'(Ed. Fronti`eres' (any-')'){0,10}')'|'(ed. F. Wilczek, World Sc., Singapore' (any-')'){0,10}')'|'(ed  H   de Vega et al, Sringer' (any-')'){0,10}')'|'(ed. H.  de Vega et al, Sringer' (any-')'){0,10}')'|'(ed. H.  de Vega et al, Sringer, Berlin' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(ed. H.  de Vega et al, Sringer, Berlin' (any-')'){0,10}')'|'(ed. HS Mani et al, W. Sc.' (any-')'){0,10}')'|'(edited by Friedan' (any-')'){0,10}')'|'(Editions Fronti`{e}res' (any-')'){0,10}')'|'(Editions Frontieres, Gif-sur-Yvette' (any-')'){0,10}')'|'(Editions Frontieres, Gif-Sur Yvette, France' (any-')'){0,10}')'|'(Editions Mir, Moscou' (any-')'){0,10}')'|'(Editori Riuniti -- Edizioni MIR; Roma' (any-')'){0,10}')'|'(Editrice Compositori, Bolonga' (any-')'){0,10}')'|'(Editura Tehnicv a, Bucurec sti' (any-')'){0,10}')'|'(Editura Tehnocv a, Bucurec sti' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Editura Tehnocv a, Bucurec sti' (any-')'){0,10}')'|'(Editzioni Crenonese, Rome' (any-')'){0,10}')'|'(Edizioni Cremonese, Roma' (any-')'){0,10}')'|'(ed. J.Baez' (any-')'){0,10}')'|'(ed. J B Zuber et al' (any-')'){0,10}')'|'(ed. J. Hietarinta et al, Springer' (any-')'){0,10}')'|'(ed. J. Hietarinta et al, Springer,Berlin' (any-')'){0,10}')'|'(Ed.~K.~Yamawaki, World Scientific Pub. Co.' (any-')'){0,10}')'|'(Ed Lindstrom' (any-')'){0,10}')'|'(Ed.M.Boiti,L.Martina and F.Pompinelli ,World Sc.' (any-')'){0,10}')'|'(Ed. Mir, Moscow' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Ed. Mir, Moscow' (any-')'){0,10}')'|'(ed. M. Jimbo' (any-')'){0,10}')'|'(ed Mo-Lin Ge and Bao-Heng Zhao, Singapore, World Scientific' (any-')'){0,10}')'|'(ed Nevai P, NATO ASI Ser. C294' (any-')'){0,10}')'|'(Ed. R. Chand' (any-')'){0,10}')'|'(eds. Bussey and Knowles, I. O. P.' (any-')'){0,10}')'|'(eds. C. Castro and M.S. El Naschie, Elsevier Science' (any-')'){0,10}')'|'(eds. C. Isham, R. Penrose and D. Sciama' (any-')'){0,10}')'|'(eds. C. M. De Witt' (any-')'){0,10}')'|'(eds. D. Axen, D. Bryman and M. Comyn, World Scientific' (any-')'){0,10}')'|'(ed. S. Doplicher et al., Rome' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(ed. S. Doplicher et al., Rome' (any-')'){0,10}')'|'(eds. Ellis and Ferrara' (any-')'){0,10}')'|'(eds. Ferarra and Taylor' (any-')'){0,10}')'|'(Eds. Ferrara and Taylor, C. U. P' (any-')'){0,10}')'|'(Eds.: Hawking, S.W.  and Israel, W., Cambridge Univ. Press' (any-')'){0,10}')'|'(Eds. H. Rollnik' (any-')'){0,10}')'|'(Eds. Isham, Penrose and Sciama' (any-')'){0,10}')'|'(Eds. L. Castellani and J. Wess, IOS Press, Amsterdam' (any-')'){0,10}')'|'(Eds. M. Bonini' (any-')'){0,10}')'|'(Eds.R.Bullough, P.Caudrey, New York' (any-')'){0,10}')'|'(eds. S.~B.~Treiman' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(eds. S.~B.~Treiman' (any-')'){0,10}')'|'(eds. S.B.~Treiman' (any-')'){0,10}')'|'(Ed. S.W. Hawking and W. Israel, Cambridge Univ. Press. Cambridge' (any-')'){0,10}')'|'(Ed: V V Dvoeglazov, Nova Science Publishers' (any-')'){0,10}')'|'(ed. W. Svartholm, Almquist and Wiskell, Stockholm' (any-')'){0,10}')'|'(Ed. Zichichi, Plenum' (any-')'){0,10}')'|'(E.F. Bolinder' (any-')'){0,10}')'|'(E. Gava' (any-')'){0,10}')'|'(Eger, Hungary' (any-')'){0,10}')'|'(EGER, Hungary' (any-')'){0,10}')'|'(e.g. H. SAZDJIAN,  Phys. Rev. D {bf 33}' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(e.g. H. SAZDJIAN,  Phys. Rev. D {bf 33}' (any-')'){0,10}')'|'(E. Horwood Ltd.' (any-')'){0,10}')'|'(Einstein Studies' (any-')'){0,10}')'|'(E.: {it ibid.} {bf B206}' (any-')'){0,10}')'|'(Ellis Harwood, Chichester' (any-')'){0,10}')'|'(Ellis Horwood' (any-')'){0,10}')'|'(Ellis Horwood, Chicester' (any-')'){0,10}')'|'( Ellis Horwood, Chichester' (any-')'){0,10}')'|'(Ellis Horwood Limited, Chichester' (any-')'){0,10}')'|'(Ellis Horwood Limited, West Sussex' (any-')'){0,10}')'|'(Ellis Horwood, West Sussex' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Ellis Horwood, West Sussex' (any-')'){0,10}')'|'(Elseiver Science Publishers B.V.' (any-')'){0,10}')'|'( Elsevier' (any-')'){0,10}')'|'(Elsevier; Amsterdam' (any-')'){0,10}')'|'( Elsevier, NewYork' (any-')'){0,10}')'|'(Elsevier, North Holland' (any-')'){0,10}')'|'(Elsevier, Noth Holland' (any-')'){0,10}')'|'(Elsevier Science' (any-')'){0,10}')'|'(Elsevier Science, Amsterdam' (any-')'){0,10}')'|'(Elsevier Science Ltd, Amsterdam' (any-')'){0,10}')'|'(Elsevier Science Pub. B.V.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Elsevier Science Pub. B.V.' (any-')'){0,10}')'|'(Elsevier Science Publischers B.V.' (any-')'){0,10}')'|'(Elsevier Science Publisher' (any-')'){0,10}')'|'(Elsevier Science Publishers' (any-')'){0,10}')'|'(Elsevier Science Publishers BV' (any-')'){0,10}')'|'(Elsevier Science Publishiers B. V.' (any-')'){0,10}')'|'({em Birkh"auser Boston Inc.' (any-')'){0,10}')'|'({em erratum|({em i.e.' (any-')'){0,10}')'|'({em JETP Lett.} {bf 50}' (any-')'){0,10}')'|'({em J.  Math.  Phys.}' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'({em J.  Math.  Phys.}' (any-')'){0,10}')'|'({em Springer-Verlag, New York' (any-')'){0,10}')'|'({em World Scientific}, Singapore' (any-')'){0,10}')'|'(Englewood Cliffs' (any-')'){0,10}')'|'(Englewood Cliffs, N.J.' (any-')'){0,10}')'|'(English translation- {em Sov. Phys. Dokl.} {bf 2}' (any-')'){0,10}')'|'(English translation JETP 32' (any-')'){0,10}')'|'(English translation: Leningrad Math. J. {bf 1}' (any-')'){0,10}')'|'(English translation: Sov.Phys.JETP {bf 47}' (any-')'){0,10}')'|'(English version, Springer-Verlag, Berlin' (any-')'){0,10}')'|'( Engl. Transl. JETP Lett. {bf 38}' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'( Engl. Transl. JETP Lett. {bf 38}' (any-')'){0,10}')'|'(Engl. transl.: Russian Math. Surveys {bf 37}:5' (any-')'){0,10}')'|'(entries 4.2.5,36 and 4.2.5' (any-')'){0,10}')'|'(e-print archive' (any-')'){0,10}')'|'(e-print, hep-th, April' (any-')'){0,10}')'|'(Erevan, EGU' (any-')'){0,10}')'|'(Erice, Italy, Sept. 7--15' (any-')'){0,10}')'|'(Erice Lectures' (any-')'){0,10}')'|'(Errata: {bf D30}' (any-')'){0,10}')'|'(Erratum-ibid. {bf D18}' (any-')'){0,10}')'|'(Erratum: Nucl. Phys. {bf 456}' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Erratum: Nucl. Phys. {bf 456}' (any-')'){0,10}')'|'(e^{Sigma}, X, F, phi' (any-')'){0,10}')'|'(ETH lectures, Z"urich' (any-')'){0,10}')'|'(ETH, Zuerich' (any-')'){0,10}')'|'(ETS Editrice, Pisa' (any-')'){0,10}')'|'(ETS, Pisa' (any-')'){0,10}')'|'(Ettore Majorana International Science Series, Plenum Press' (any-')'){0,10}')'|'(EUP, Edinburgh' (any-')'){0,10}')'|'(Eur. Phys. J. {bf C}' (any-')'){0,10}')'|'(Eur. Phys. Journ. {bf C}' (any-')'){0,10}')'|'(Euskal Herriko Unibertsitatea, Bilbo' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Euskal Herriko Unibertsitatea, Bilbo' (any-')'){0,10}')'|'(Evora, Portugal' (any-')'){0,10}')'|'(E. Witten' (any-')'){0,10}')'|'(Exp. No. 792' (any-')'){0,10}')'|'(Fermilab, Batavia, Il' (any-')'){0,10}')'|'(Fermilab, Chicago U.' (any-')'){0,10}')'|'(Fiedrich Schiller University, Jena' (any-')'){0,10}')'|'(Firenze ' (any-')'){0,10}')'|'(Fitmatgiz, Moscow' (any-')'){0,10}')'|'(Fizmatgiz, Moscow' (any-')'){0,10}')'|'(Fizmatgiz, Moskwa' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Fizmatgiz, Moskwa' (any-')'){0,10}')'|'(Flammarion Sciences, Paris' (any-')'){0,10}')'|'(Florence, Italy' (any-')'){0,10}')'|'(Fond. Louis de Broglie, Paris' (any-')'){0,10}')'|'(For a more comprehensive list of references' (any-')'){0,10}')'|'(for short reviews see: D. Antonov' (any-')'){0,10}')'|'(Freeman and co.' (any-')'){0,10}')'|'(Freeman and Company' (any-')'){0,10}')'|'(Freeman Press' (any-')'){0,10}')'|'(Freeman, San-Francisco' (any-')'){0,10}')'|'(Freeman, San Francisco, CA' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Freeman, San Francisco, CA' (any-')'){0,10}')'|'(Freeman, San Franciso' (any-')'){0,10}')'|'(Freeman, SF' (any-')'){0,10}')'|'( Friedmann' (any-')'){0,10}')'|'(Friedmann Laboratory, St. Petersburg' (any-')'){0,10}')'|'(from Peskin' (any-')'){0,10}')'|'( Frontier in Physics' (any-')'){0,10}')'|'(Frontiers in physics' (any-')'){0,10}')'|'( Frontiers In Physics' (any-')'){0,10}')'|'(Frontiers In Physics' (any-')'){0,10}')'|'(Frontiers in Physics, Addison-Wesley' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Frontiers in Physics, Addison-Wesley' (any-')'){0,10}')'|'(Frontiers in Physics, Benjamin Cummings' (any-')'){0,10}')'|'(Frontiers in Physics: Vol. 74, Addison-Wesley Pub. Co.' (any-')'){0,10}')'|'(Frontiers in Physics: Vol. 77, Addison-Wesley Pub. Co.' (any-')'){0,10}')'|'(FU Berlin' (any-')'){0,10}')'|'(function of $S' (any-')'){0,10}')'|'(Gakujutsu Bunken Fukyu-Kai, Tokyo' (any-')'){0,10}')'|'(Gamma^3_{ [12]}|(Gauther-Villars, Paris' (any-')'){0,10}')'|'(Gauthiers-Villars, Paris' (any-')'){0,10}')'|'(Gauthier- Villars, Paris' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Gauthier- Villars, Paris' (any-')'){0,10}')'|'(G.-C. Rota' (any-')'){0,10}')'|'(G. Denardo et al.' (any-')'){0,10}')'|'(Ge,~M.-L. and Zhao' (any-')'){0,10}')'|'(G. Furlan et al.' (any-')'){0,10}')'|'(G.~Furlan et~al.' (any-')'){0,10}')'|'(G.G. Harrap and Co., London' (any-')'){0,10}')'|'(Ghostekhizdat, Moscow' (any-')'){0,10}')'|'(Ghost Sector 1' (any-')'){0,10}')'|'(Ginn and Company' (any-')'){0,10}')'|'(Gordon and Beach Science Publishers' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Gordon and Beach Science Publishers' (any-')'){0,10}')'|'( Gordon and Breach' (any-')'){0,10}')'|'(Gordon and Breach, Cargese' (any-')'){0,10}')'|'(Gordon and Breach, Langhorne' (any-')'){0,10}')'|'( Gordon and Breach, London' (any-')'){0,10}')'|'(Gordon and Breach, London' (any-')'){0,10}')'|'(Gordon and Breach, London, New York' (any-')'){0,10}')'|'(Gordon and Breach, Luxemburg' (any-')'){0,10}')'|'(Gordon and  Breach, New York' (any-')'){0,10}')'|'( Gordon and Breach Press' (any-')'){0,10}')'|'(Gordon and Breach Science publishers, Amsterdam' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Gordon and Breach Science publishers, Amsterdam' (any-')'){0,10}')'|'(Gordon and Breach Science Publishers, Langhorne' (any-')'){0,10}')'|'(Gordon and Breach Science Publishers, New York' (any-')'){0,10}')'|'(Gordon and Breach Sci. Pub., New York' (any-')'){0,10}')'|'(Gordon {&} Breach' (any-')'){0,10}')'|'(Gordon & Breach; New York' (any-')'){0,10}')'|'(Gordon Breach, New York' (any-')'){0,10}')'|'(Gordon & Breach, NY' (any-')'){0,10}')'|'(Gordon Breach, NY' (any-')'){0,10}')'|'(Gordon & Breach Science Publishers' (any-')'){0,10}')'|'(Gordon & Breach Science Publishers, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Gordon & Breach Science Publishers, New York' (any-')'){0,10}')'|'(G"{o}teborg, Sweden' (any-')'){0,10}')'|'(Goteborg, Sweden' (any-')'){0,10}')'|'({Got su}(1' (any-')'){0,10}')'|'(graduate text in mathematics' (any-')'){0,10}')'|'(Graduate Texts in Mathematics, vol. 60' (any-')'){0,10}')'|'(Gran Sasso & Moscow' (any-')'){0,10}')'|'(Groningen, Netherland' (any-')'){0,10}')'|'(G. `t hooft et al.' (any-')'){0,10}')'|'(Guanajuato, Mexico' (any-')'){0,10}')'|'(Guelph, 1995' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Guelph, 1995' (any-')'){0,10}')'|'(G. Velo, A.S. Wightman' (any-')'){0,10}')'|'(habilitation thesis' (any-')'){0,10}')'|'(Habilitation Thesis' (any-')'){0,10}')'|'(Hachette Literature, Paris' (any-')'){0,10}')'|'(Hadronic Press Inc, Palm Harbor' (any-')'){0,10}')'|'(Hadronic Press Inc., Palm Harbor' (any-')'){0,10}')'|'(Hadronic Press. Nonautum' (any-')'){0,10}')'|'(Hadronic Press, Palm Harbour' (any-')'){0,10}')'|'(Hadronic Press, Parl Harbor' (any-')'){0,10}')'|'(Hafner, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Hafner, New York' (any-')'){0,10}')'|'(Hafner Pub. Co. , New York' (any-')'){0,10}')'|'(Halsted Press, New York' (any-')'){0,10}')'|'(Hamburg University' (any-')'){0,10}')'|'(Hangzhou, China' (any-')'){0,10}')'|'(Han Lim Won Printing Company, Seoul' (any-')'){0,10}')'|'(H. Araki' (any-')'){0,10}')'|'(H. Aratyn' (any-')'){0,10}')'|'(H. Aratyn. T.D. Imbo, W.-Y. Keung' (any-')'){0,10}')'|'(Harcourt Brace Jovanovich, Publishers, N.Y.' (any-')'){0,10}')'|'(Hardwood Academic, Chur, Switzerland' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Hardwood Academic, Chur, Switzerland' (any-')'){0,10}')'|'(Hardwood Academic Pub' (any-')'){0,10}')'|'(Harper $&$ Row' (any-')'){0,10}')'|'(Harper and Row, New York' (any-')'){0,10}')'|'(Harri Deutsch, Frankfurt/Main' (any-')'){0,10}')'|'(Harry Deutsch, Thun and Frankfurt am Main' (any-')'){0,10}')'|'(Hart Publishing Co., New York' (any-')'){0,10}')'|'(Harvard Acad. Publ., London-New York' (any-')'){0,10}')'|'(Harvard Lecture Notes' (any-')'){0,10}')'|'(Harvard University Press' (any-')'){0,10}')'|'(Harvard University Press, Cambridge' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Harvard University Press, Cambridge' (any-')'){0,10}')'|'(Harvard Univ. Press' (any-')'){0,10}')'|'(Harvard U. P., Cambridge, MA' (any-')'){0,10}')'|'(Harvard U. Press, Cambridge' (any-')'){0,10}')'|'(Harward Academic, Chur, Switzerland' (any-')'){0,10}')'|'( Harwood Academic' (any-')'){0,10}')'|'(Harwood Academic Chur' (any-')'){0,10}')'|'(Harwood Academic, Chur' (any-')'){0,10}')'|'(Harwood Academic, Chur, Switzerland' (any-')'){0,10}')'|'(Harwood, Academic, Chur, Switzerland' (any-')'){0,10}')'|'(Harwood Academic, New-York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Harwood Academic, New-York' (any-')'){0,10}')'|'(Harwood Academic, NY' (any-')'){0,10}')'|'(Harwood Academic Press' (any-')'){0,10}')'|'(Harwood Academic Publ.' (any-')'){0,10}')'|'(Harwood Academic Publ, Chur' (any-')'){0,10}')'|'(Harwood Academic Publishers, Chur, Switzerland' (any-')'){0,10}')'|'(Harwood Academic Publishers GmbH' (any-')'){0,10}')'|'(Harwood Academic Publishers,  London' (any-')'){0,10}')'|'(Harwood Academic Publishers: New York' (any-')'){0,10}')'|'(Harwood Acad., London' (any-')'){0,10}')'|'(Harwood Acad. Publ., Chur e. a., Switzerland' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Harwood Acad. Publ., Chur e. a., Switzerland' (any-')'){0,10}')'|'(Harwood Acad. Publ., Chur, Switzerld.' (any-')'){0,10}')'|'(Harwood Acad. Publ., New York' (any-')'){0,10}')'|'(Harwood , Chur, Switzerland' (any-')'){0,10}')'|'(Harwood,  Chur, Switzerland' (any-')'){0,10}')'|'(Harwood, London' (any-')'){0,10}')'|'( Harwood, N. Y.' (any-')'){0,10}')'|'(Harwood Press, Chur, Switzerland' (any-')'){0,10}')'|'(Harwood Publ., Chur, Switzerland' (any-')'){0,10}')'|'(Harwood Scientific Pub., Switzerland' (any-')'){0,10}')'|'(Harwood, Switzerland' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Harwood, Switzerland' (any-')'){0,10}')'|'(hat A_(M-1' (any-')'){0,10}')'|'(H. Bateman Manuscript Projet' (any-')'){0,10}')'|'(Heidelberg etc.: Springer-Verlag' (any-')'){0,10}')'|'(Heldermann Verlag, Berlin' (any-')'){0,10}')'|'(held Padova, 4-9 July' (any-')'){0,10}')'|'(Hemisphere Publishing Company, New York' (any-')'){0,10}')'|'(hepth-9605207, KYUSHU-HET-31' (any-')'){0,10}')'|'(hep-th/9712110, hep-th/9802130' (any-')'){0,10}')'|'(Herman and Cie Editeur, Paris' (any-')'){0,10}')'|'(Hermann, Paris, France' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Hermann, Paris, France' (any-')'){0,10}')'|'(Herman, Paris' (any-')'){0,10}')'|'(Heron Press, Sofia' (any-')'){0,10}')'|'(H. Haber' (any-')'){0,10}')'|'(Hilger, Bristol.' (any-')'){0,10}')'|'(Hilger; Bristol' (any-')'){0,10}')'|'(Hilger, Bristol, England' (any-')'){0,10}')'|'(Hilger, Bristol, UK' (any-')'){0,10}')'|'(Hilger, Bristol/UK' (any-')'){0,10}')'|'(Hilger, Gristd' (any-')'){0,10}')'|'(Hindustan Book Agency, New Delhi' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Hindustan Book Agency, New Delhi' (any-')'){0,10}')'|'(Hirzel Verlag, Leipzig' (any-')'){0,10}')'|'(H.~Itoyama et al.' (any-')'){0,10}')'|'(H. Mark and S. Fernbach' (any-')'){0,10}')'|'(H.~Mitter and H.~Gausterer' (any-')'){0,10}')'|'(Holden Day, San Francisco' (any-')'){0,10}')'|'(Holden-Day; San Francisco' (any-')'){0,10}')'|'(Holt, Rinehart and Winston' (any-')'){0,10}')'|'(Holt, Rinehart and Winston, New York' (any-')'){0,10}')'|'(Horwood Publishers, Chichester' (any-')'){0,10}')'|'(H. Rollnik and K. Dietz' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(H. Rollnik and K. Dietz' (any-')'){0,10}')'|'(HRS International Editions, Philadelphia, PA' (any-')'){0,10}')'|'(Huntington, New York: R.E.Krieger Publ. Comp.' (any-')'){0,10}')'|'(Iac si' (any-')'){0,10}')'|'(IAEA, Viena' (any-')'){0,10}')'|'(I.A.E.A., Vienna' (any-')'){0,10}')'|'(IAFA, Vienna' (any-')'){0,10}')'|'(ICPT preprint, Trieste, 1965' (any-')'){0,10}')'|'(ICTP Series in Theoretical Physics' (any-')'){0,10}')'|'( ICTP Trieste' (any-')'){0,10}')'|'(ICTP Trieste' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(ICTP Trieste' (any-')'){0,10}')'|'(ICTP; Trieste' (any-')'){0,10}')'|'(i.e., conventional DLCQ cite{M&Y' (any-')'){0,10}')'|'(IEEE Computer Society Press, Los Alamitos, California' (any-')'){0,10}')'|'(IEEE Press' (any-')'){0,10}')'|'( IHEP, Protvino, July 27-29' (any-')'){0,10}')'|'(Il Ciocco' (any-')'){0,10}')'|'(I.M. Gelfand' (any-')'){0,10}')'|'(IMPA, Rio de Janeiro' (any-')'){0,10}')'|'(Imperial College, London' (any-')'){0,10}')'|'(Imperial College Press, London' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Imperial College Press, London' (any-')'){0,10}')'|'(Imperial Coll. Press, London' (any-')'){0,10}')'|'(IN2P3, Paris' (any-')'){0,10}')'|'(in emph{Goddard, P. and Olive' (any-')'){0,10}')'|'(in Japanese, Springer-Verlag, Tokyo' (any-')'){0,10}')'|'(in particular, Appendix 10' (any-')'){0,10}')'|'(In particular chapters 6' (any-')'){0,10}')'|'(In practice, we may take $Y_-=0' (any-')'){0,10}')'|'(in preparation' (any-')'){0,10}')'|'(in Proc. Winter School Geom. Phys., Srni' (any-')'){0,10}')'|'(In *Rebbi' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(In *Rebbi' (any-')'){0,10}')'|'(in Russian edition: {bf 162}, No.8' (any-')'){0,10}')'|'(in Russian, Mir' (any-')'){0,10}')'|'(Inst. f"{u}r Hochenenergiephysik - IfH' (any-')'){0,10}')'|'(Institute for Advanced Study report' (any-')'){0,10}')'|'(Institute of Mathematics, Novosibirsk' (any-')'){0,10}')'|'(Institute of Physics' (any-')'){0,10}')'|'(Institute of Physics, Belgrade' (any-')'){0,10}')'|'(Institute of Physics, Czech. Acad. Sci., Prague' (any-')'){0,10}')'|'(Institute of Physics Press, Bristol' (any-')'){0,10}')'|'(Institute of Physics Pub., Bristol' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Institute of Physics Pub., Bristol' (any-')'){0,10}')'|'(Institute of Physics Publishing' (any-')'){0,10}')'|'(Institute  of Physics Publishing, Bristol' (any-')'){0,10}')'|'(Institute of Physics Publishing, Bristol, Philadelphia' (any-')'){0,10}')'|'(Institute of Physics Publishing, London' (any-')'){0,10}')'|'(Inter Editions' (any-')'){0,10}')'|'(Inter Editions/Editions du CNRS' (any-')'){0,10}')'|'(Intereditions, Paris' (any-')'){0,10}')'|'(Inter Editions, Paris' (any-')'){0,10}')'|'(Inter-Editions, Paris' (any-')'){0,10}')'|'(Inter European Edition, Amsterdam' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Inter European Edition, Amsterdam' (any-')'){0,10}')'|'(International Atomic Energy Agency, Vienna' (any-')'){0,10}')'|'(International Centre for Theoretical Physics report IC/79/69' (any-')'){0,10}')'|'(International Press, Cambridge' (any-')'){0,10}')'|'(International Press Incorporated, Boston' (any-')'){0,10}')'|'(International series of monographs on physics' (any-')'){0,10}')'|'(Internat, Press Inc., Boston' (any-')'){0,10}')'|'(Interscience, N' (any-')'){0,10}')'|'(Interscience, NewYork' (any-')'){0,10}')'|'(Interscience, New York, 1959' (any-')'){0,10}')'|'(Interscience, N.Y.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Interscience, N.Y.' (any-')'){0,10}')'|'(Interscience Pub.,  John Wiley' (any-')'){0,10}')'|'(Interscience Publish.' (any-')'){0,10}')'|'(Interscience publishers' (any-')'){0,10}')'|'(Interscience publishers, J. Wiley and Sons, New York' (any-')'){0,10}')'|'(Interscience Publishers, New York, London, Sydney' (any-')'){0,10}')'|'(Interscience Publishers, New York-London-Sydney' (any-')'){0,10}')'|'( Interscience Publishers, N.Y.' (any-')'){0,10}')'|'(Interscience Publishers, N.Y.' (any-')'){0,10}')'|'(Interscience Publishers, NY' (any-')'){0,10}')'|'(Interscience Publ., New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Interscience Publ., New York' (any-')'){0,10}')'|'(Interscience Publ., N.Y.' (any-')'){0,10}')'|'(Intersciences, New York' (any-')'){0,10}')'|'(Interscince, New York' (any-')'){0,10}')'|'(Intersci., N.Y.' (any-')'){0,10}')'|'(Intersience, New York' (any-')'){0,10}')'|'(Int. J. Mod. Phys A.' (any-')'){0,10}')'|'(Int.~J. Mod.~Phys.~D' (any-')'){0,10}')'|'(Intl. Press, Hong Kong' (any-')'){0,10}')'|'(Int. Press Co.' (any-')'){0,10}')'|'(Int. Press. Co., Hong Kong' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Int. Press. Co., Hong Kong' (any-')'){0,10}')'|'(Int. Press, Hong Kong' (any-')'){0,10}')'|'(Int.~Press, Hong Kong' (any-')'){0,10}')'|'(Int. Press, Honk Kong' (any-')'){0,10}')'|'(Int. Publishers, New York' (any-')'){0,10}')'|'(IOP, Bristol, 1995' (any-')'){0,10}')'|'(IOPP, Bristol' (any-')'){0,10}')'|'(IOP Pub., Bristol, UK' (any-')'){0,10}')'|'(IOP Publ., Bristol' (any-')'){0,10}')'|'(IOP Publishers Ltd., Bristol' (any-')'){0,10}')'|'(IOP Publishing, 1995; Revised Edition' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(IOP Publishing, 1995; Revised Edition' (any-')'){0,10}')'|'(IOP Publishing: Bristol' (any-')'){0,10}')'|'(}IOP Publishing {it  }Ltd' (any-')'){0,10}')'|'(IOP Publishing Ltd' (any-')'){0,10}')'|'(IOP Publishing Ltd., Bristol, 1995' (any-')'){0,10}')'|'(IOP Publishing Ltd., Bristol, Phyladelphia' (any-')'){0,10}')'|'( IOP Publishing Ltd, London' (any-')'){0,10}')'|'(IOS Press, Oxford' (any-')'){0,10}')'|'(Iova City, Iova' (any-')'){0,10}')'|'(Iowa City, Iowa' (any-')'){0,10}')'|'(Iowa State University Press, Ames' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Iowa State University Press, Ames' (any-')'){0,10}')'|'(IRMA Strasbourg' (any-')'){0,10}')'|'(Irvine, CA' (any-')'){0,10}')'|'(Israel Program of Sci., Jerusalem, Transl.' (any-')'){0,10}')'|'(Isvestya Akademii Nauk Respubliki Moldova' (any-')'){0,10}')'|'({it Akademie Verlag, Berlin' (any-')'){0,10}')'|'({it Funct.~Anal.~Appl.} {bf 19}' (any-')'){0,10}')'|'({it i.e.' (any-')'){0,10}')'|'({it John Wiley & Sons}, New York' (any-')'){0,10}')'|'({it Longman Scientific & Technical}, Essex' (any-')'){0,10}')'|'({it Math.~USSR Sbornik} {bf 60}' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'({it Math.~USSR Sbornik} {bf 60}' (any-')'){0,10}')'|'({it McGraw Hill, New York}' (any-')'){0,10}')'|'({it McGraw-Hill}, New York' (any-')'){0,10}')'|'({it Modular invariance of string theory on $AdS_3$}' (any-')'){0,10}')'|'({it Phys.Lett. B}' (any-')'){0,10}')'|'(ITP, Kiev' (any-')'){0,10}')'|'({it Reports NAS RA}' (any-')'){0,10}')'|'({it Sov. J. Contemp. Phys.}, {bf 33}, No.6' (any-')'){0,10}')'|'({it Sov. J. Nucl. Phys.} {bf 40}' (any-')'){0,10}')'|'({it Springer}, Berlin--Heidelberg' (any-')'){0,10}')'|'({it Springer-Verlag},  Berlin' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'({it Springer-Verlag},  Berlin' (any-')'){0,10}')'|'(its real part' (any-')'){0,10}')'|'({it The Theory of Spinors}, MIT Press' (any-')'){0,10}')'|'(IUCAA, Pune' (any-')'){0,10}')'|'(Iwanami Book Co., 1960' (any-')'){0,10}')'|'(Iwanami Pub.' (any-')'){0,10}')'|'(Iwanami Shoten' (any-')'){0,10}')'|'( Iwanamishoten,{it in japanese} 19?? or Springer' (any-')'){0,10}')'|'(Iwanami shoten, Tokyo' (any-')'){0,10}')'|'(Iwanami syoten' (any-')'){0,10}')'|'(Izvestya Akademii Nauk Republiki Moldova' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Izvestya Akademii Nauk Republiki Moldova' (any-')'){0,10}')'|'(Izvestya Akademii Nauk Respublici Moldova' (any-')'){0,10}')'|'(Izv. Vuz' (any-')'){0,10}')'|'(Izv. VUZov' (any-')'){0,10}')'|'(J. Bagger Ed., World Scientific, Singapore' (any-')'){0,10}')'|'(J. B. M. Duprat, Paris' (any-')'){0,10}')'|'(J.E. Purkyne Univ.' (any-')'){0,10}')'|'(JETP Lett. 45' (any-')'){0,10}')'|'(JETP Lett. 62' (any-')'){0,10}')'|'(JETP Lett.~{bf 12}' (any-')'){0,10}')'|'(JETP Lett. {bf 20}' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(JETP Lett. {bf 20}' (any-')'){0,10}')'|'(JETP Lett. {bf 38}' (any-')'){0,10}')'|'(JETP Lett. {bf 4}' (any-')'){0,10}')'|'(JETP Lett. {bf 56}' (any-')'){0,10}')'|'(J. Harvey and J. Polchinski' (any-')'){0,10}')'|'(Jhon Wiley $ & $ Sons, New York' (any-')'){0,10}')'|'(J. Hubbard' (any-')'){0,10}')'|'(J. Kollar' (any-')'){0,10}')'|'(J. Kollar, R. Lazarsfeld' (any-')'){0,10}')'|'(J. L. Gervais and A. Neveu' (any-')'){0,10}')'|'(J. Math. Phys.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(J. Math. Phys.' (any-')'){0,10}')'|'(J. Mehra' (any-')'){0,10}')'|'(John Benjamins' (any-')'){0,10}')'|'(Johns Hopkins University, Baltimore' (any-')'){0,10}')'|'(Johns Hopkins University, Baltimore, MD' (any-')'){0,10}')'|'(Johnson Rep. Co.; New York' (any-')'){0,10}')'|'( John Wiley' (any-')'){0,10}')'|'(John Wiley $&$ Sons, New York' (any-')'){0,10}')'|'(John Wiley $&$ Sons, New York etc.' (any-')'){0,10}')'|'(John Wiley and sons' (any-')'){0,10}')'|'( John Wiley and Sons' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'( John Wiley and Sons' (any-')'){0,10}')'|'(John Wiley and Sons, Inc., New York' (any-')'){0,10}')'|'(John Wiley and Sons, London' (any-')'){0,10}')'|'(John Wiley and Sons Ltd' (any-')'){0,10}')'|'(John Wiley and Sons, New York 1963' (any-')'){0,10}')'|'(John Wiley and Sons, New York, pp.375-404' (any-')'){0,10}')'|'(John Wiley and Sons, N.Y.' (any-')'){0,10}')'|'(John Wiley, London' (any-')'){0,10}')'|'(John Wiley n$&$ Sons, Inc. ' (any-')'){0,10}')'|'(John  Wiley, New York' (any-')'){0,10}')'|'(John Wiley, N. Y.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(John Wiley, N. Y.' (any-')'){0,10}')'|'(John Wiley, N. Y. ' (any-')'){0,10}')'|'(John Wiley, NY' (any-')'){0,10}')'|'(John Wiley&Sons' (any-')'){0,10}')'|'(John Wiley & Sons Inc., New York' (any-')'){0,10}')'|'(John Wiley & Sons,Inc. New York' (any-')'){0,10}')'|'(John Wiley &Sons, Inc. New York' (any-')'){0,10}')'|'(John Wiley & Sons, London' (any-')'){0,10}')'|'(John Wiley & Sons Ltd.' (any-')'){0,10}')'|'( John Wiley & Sons, new York' (any-')'){0,10}')'|'( John Wiley & Sons , New York ' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'( John Wiley & Sons , New York ' (any-')'){0,10}')'|'(John Wiley {&} Sons, New York' (any-')'){0,10}')'|'(John Wiley & Sons, NY' (any-')'){0,10}')'|'(John Wiley & Sons, USA' (any-')'){0,10}')'|'(John Wileys & Sons, New York' (any-')'){0,10}')'|'(John Willey and Sons' (any-')'){0,10}')'|'(John Willey & Sons' (any-')'){0,10}')'|'(John Willey & Sons, New York' (any-')'){0,10}')'|'(John Willey & Sons, New-York' (any-')'){0,10}')'|'(John Willey & Sons, New-York ' (any-')'){0,10}')'|'(John Willey & Sons, New-York, London, Sydney, Toronto' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(John Willey & Sons, New-York, London, Sydney, Toronto' (any-')'){0,10}')'|'(John Willy & Sons, New York' (any-')'){0,10}')'|'(Joint Institute for Nuclear Research, Dubna' (any-')'){0,10}')'|'(J. Phys.' (any-')'){0,10}')'|'(J. Springer, Berlin -- Heidelberg -- New York' (any-')'){0,10}')'|'(Jul.27-Aug.2,2000,Osaka Int. House,Osaka' (any-')'){0,10}')'|'(July 13' (any-')'){0,10}')'|'(July 16 - August 4' (any-')'){0,10}')'|'(July 1966' (any-')'){0,10}')'|'(July 1994' (any-')'){0,10}')'|'(July 1996' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(July 1996' (any-')'){0,10}')'|'(July 1999' (any-')'){0,10}')'|'(June 3-7, 1991, New York' (any-')'){0,10}')'|'(J.~Wiley and Sons' (any-')'){0,10}')'|'(J.Wiley and Sons' (any-')'){0,10}')'|'(J. Wiley ed.' (any-')'){0,10}')'|'(J. Wiley; London' (any-')'){0,10}')'|'( J. Wiley, New York' (any-')'){0,10}')'|'( J. Wiley, N.Y.' (any-')'){0,10}')'|'(J. Wiley, N.Y.' (any-')'){0,10}')'|'(J. Wiley & Sons, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(J. Wiley & Sons, New York' (any-')'){0,10}')'|'(J.Wiley & Sons, New York' (any-')'){0,10}')'|'(J. Willey, New York' (any-')'){0,10}')'|'(J.Willey & Sons, New York' (any-')'){0,10}')'|'(Kaisisha, Shigaken' (any-')'){0,10}')'|'(Kauffman, L.H., Baadhio, R.A.' (any-')'){0,10}')'|'(Kazani, University Press' (any-')'){0,10}')'|'(Kegan Paul, London' (any-')'){0,10}')'|'(KEK report 79-18' (any-')'){0,10}')'|'(KEK Report 79-18' (any-')'){0,10}')'|'(KEK Report No.79-18 Tsukuba' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(KEK Report No.79-18 Tsukuba' (any-')'){0,10}')'|'(Kharkov, January 5-7' (any-')'){0,10}')'|'(Kharkov, July 25--29' (any-')'){0,10}')'|'(Kharkov University report' (any-')'){0,10}')'|'(K.-I. Aoki' (any-')'){0,10}')'|'(Kiev, USSR' (any-')'){0,10}')'|'(Kiev, USSR, April 6-12' (any-')'){0,10}')'|'(Kingston, Ont.' (any-')'){0,10}')'|'(Kinokuniya-Academic, Tokyo' (any-')'){0,10}')'|'(Kinokuniya-Shoten, 1994; Springer-Verlag' (any-')'){0,10}')'|'(K. Kikkawa' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(K. Kikkawa' (any-')'){0,10}')'|'(Kluver Acad. ' (any-')'){0,10}')'|'(Kluver Academic Publishers, Boston' (any-')'){0,10}')'|'(Kluver Academic Publishers, Dordrecht' (any-')'){0,10}')'|'(Kluwer Academic' (any-')'){0,10}')'|'(Kluwer Academic, Hingham, Mass.' (any-')'){0,10}')'|'(Kluwer Academic Press, the Netherlands' (any-')'){0,10}')'|'( Kluwer Academic Publishers' (any-')'){0,10}')'|'(Kluwer Academic Publishers, Boston' (any-')'){0,10}')'|'(Kluwer Academic Publishers, Dordrecht, Boston, London' (any-')'){0,10}')'|'(Kluwer Academic Publishers, Dordrecht-Boston-London' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Kluwer Academic Publishers, Dordrecht-Boston-London' (any-')'){0,10}')'|'(Kluwer Academic Publishers, Dordrecht, The Netherlands' (any-')'){0,10}')'|'(Kluwer Academic Publishers, The Netherlands' (any-')'){0,10}')'|'(Kluwer Academy' (any-')'){0,10}')'|'(Kluwer Acadmic Publishers, Boston' (any-')'){0,10}')'|'(Kluwer Acad. Pub., Dordrecht' (any-')'){0,10}')'|'(Kluwer Acad. Publ., Dordchet' (any-')'){0,10}')'|'(Kluwer acad. publish.' (any-')'){0,10}')'|'(Kluwer Acad. publish.' (any-')'){0,10}')'|'(Kluwer Acad. Publishers' (any-')'){0,10}')'|'(Kluwer Ac. Pub. Dorolrecht' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Kluwer Ac. Pub. Dorolrecht' (any-')'){0,10}')'|'(Kluwer Ac. Publishers, Dordrecht' (any-')'){0,10}')'|'(Kluwer AP, Dordrecht' (any-')'){0,10}')'|'( Kluwer, Boston' (any-')'){0,10}')'|'(Kluwer, Dodrecht' (any-')'){0,10}')'|'( Kluwer, Dordrecht' (any-')'){0,10}')'|'(Kluwer, Dordrecht, Boston' (any-')'){0,10}')'|'(Kluwer, Dordrecht, Holland' (any-')'){0,10}')'|'(Kluwer, Dordretch' (any-')'){0,10}')'|'(Kluwer Edit. Co. ' (any-')'){0,10}')'|'(Kluwer, London' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Kluwer, London' (any-')'){0,10}')'|'(Kluwer Scient. Publ.' (any-')'){0,10}')'|'(Knizhnik, V.G.' (any-')'){0,10}')'|'(Kodansha Ltd., Tokyo, and Wyley, New York' (any-')'){0,10}')'|'(Kohdansha, Tokyo' (any-')'){0,10}')'|'( Kolymbari, Crete, Greece' (any-')'){0,10}')'|'(Korean Physical Society, Seoul' (any-')'){0,10}')'|'(Kostarakis Publishers, Athens' (any-')'){0,10}')'|'(Kov sice, Slovakia' (any-')'){0,10}')'|'(Krieger, Florida' (any-')'){0,10}')'|'(Krieger Publ.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Krieger Publ.' (any-')'){0,10}')'|'(Kyoto and Tokyo' (any-')'){0,10}')'|'(Kyoto, Japan' (any-')'){0,10}')'|'(Kyoto, July' (any-')'){0,10}')'|'(Lajos Kossuth University, Debrecen, Hungary' (any-')'){0,10}')'|'(Lanik-Noga, Bratislava' (any-')'){0,10}')'|'(La Plata' (any-')'){0,10}')'|'(L. Baulieu' (any-')'){0,10}')'|'(LBL preprint' (any-')'){0,10}')'|'(L.~Brink, D.~Friedan, and A.~M. Polyakov' (any-')'){0,10}')'|'(L. Durand and L.G. Pondrom' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(L. Durand and L.G. Pondrom' (any-')'){0,10}')'|'(lead to modified action' (any-')'){0,10}')'|'(Lect. Notes Phys. 169, Springer-Verlag, Berlin-New York' (any-')'){0,10}')'|'(Lecture given at the GR 14 conference' (any-')'){0,10}')'|'(Lecture given at the GR14 Conference' (any-')'){0,10}')'|'(Lecture Notes, 1988' (any-')'){0,10}')'|'( Lecture Notes In Physics' (any-')'){0,10}')'|'(Lecture Notes In Physics' (any-')'){0,10}')'|'(Lecture Notes in Physics 469, Springer, Berlin' (any-')'){0,10}')'|'(Lecture Notes in Physics 51, Springer' (any-')'){0,10}')'|'(Lecture Notes in Physics m12, Berlin, Springer' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Lecture Notes in Physics m12, Berlin, Springer' (any-')'){0,10}')'|'(Lecture Notes in Physics, Vol. 169, Springer-Verlag' (any-')'){0,10}')'|'(Lecture Notes in Physics, Vol. 26, World Scientific' (any-')'){0,10}')'|'(Lecture Notes in Physics, Vol. 396, Springer-Verlag' (any-')'){0,10}')'|'(Lecture Notes in Physics, Vol. 5, World Scientific' (any-')'){0,10}')'|'(Lecture Notes in Physics, vol {bf 169}, Springer - Verlag, New York/Berlin' (any-')'){0,10}')'|'(Lectures in Les Houches' (any-')'){0,10}')'|'(Lectures Notes in Physics, Springer International, Berlin' (any-')'){0,10}')'|'( Lectures presented at TASI' (any-')'){0,10}')'|'(Leiden University' (any-')'){0,10}')'|'(Leningrad Math. J. 1' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Leningrad Math. J. 1' (any-')'){0,10}')'|'(Leningrad Math. J. {bf 1}' (any-')'){0,10}')'|'(Leningrad State University, Leningrad' (any-')'){0,10}')'|'(Les Houches 1988, Eds. E. Brezin and J. Zinn-Justin' (any-')'){0,10}')'|'(Les Houches, Session LXIV' (any-')'){0,10}')'|'(Les Houches Summer School publ.' (any-')'){0,10}')'|'(Les Houches Summer School, Session LVII' (any-')'){0,10}')'|'(Les Houches Summer School, Session LXII' (any-')'){0,10}')'|'(Leuven University Press' (any-')'){0,10}')'|'(Leuven University Press, Leuven' (any-')'){0,10}')'|'(Leuven Univ. Press, Leuven' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Leuven Univ. Press, Leuven' (any-')'){0,10}')'|'(Leuven U. P., Leuven' (any-')'){0,10}')'|'(LGU, Leningrad' (any-')'){0,10}')'|'(Little Brown and Company, Boston-New York-London' (any-')'){0,10}')'|'(L.-L. Chau and W.~Nahm' (any-')'){0,10}')'|'( London and New York' (any-')'){0,10}')'|'(London, John Wiley and Sons ' (any-')'){0,10}')'|'(London Mathematical Society monographs' (any-')'){0,10}')'|'(Longman Group, UK' (any-')'){0,10}')'|'(Longman, Harlow, Essex, UK' (any-')'){0,10}')'|'(Longmans, Essex, England' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Longmans, Essex, England' (any-')'){0,10}')'|'(Los Angeles' (any-')'){0,10}')'|'(L. Streit' (any-')'){0,10}')'|'(L. Witten' (any-')'){0,10}')'|'(M$^{{rm c}}$ Graw Hill' (any-')'){0,10}')'|'(Macdonald, London' (any-')'){0,10}')'|'(Mac Donald, London' (any-')'){0,10}')'|'(MacDonald, London' (any-')'){0,10}')'|'(MacGraw Hill' (any-')'){0,10}')'|'(MacGraw-Hill Book Co.' (any-')'){0,10}')'|'(Mac Graw Hill, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Mac Graw Hill, New York' (any-')'){0,10}')'|'(Macmillan Co.' (any-')'){0,10}')'|'(M.A. del Olmo ' (any-')'){0,10}')'|'(Marcel Dekker etc.' (any-')'){0,10}')'|'(Marcel Dekker Inc., New York' (any-')'){0,10}')'|'(Marcel Dekker, Inc., New York' (any-')'){0,10}')'|'(Marcel Dekker, inc. New York and Basel' (any-')'){0,10}')'|'(Marcel Dekker Inc., New York and Basel' (any-')'){0,10}')'|'(March 11-18,1987' (any-')'){0,10}')'|'(March 18-23, 1997' (any-')'){0,10}')'|'(March 1962' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(March 1962' (any-')'){0,10}')'|'(March 22' (any-')'){0,10}')'|'(Marina del Rey,Feb.23' (any-')'){0,10}')'|'(Marstrand, Sweden' (any-')'){0,10}')'|'(Mashhad, March' (any-')'){0,10}')'|'(Massachusetts Institute of Technology' (any-')'){0,10}')'|'(Masson & Cie., Paris' (any-')'){0,10}')'|'(Master Thesis, Kyoto University' (any-')'){0,10}')'|'(Math. dept., 1995 series' (any-')'){0,10}')'|'(Mathematical Association of America , Washington' (any-')'){0,10}')'|'(Mathematical Lectures, Univ. of California' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Mathematical Lectures, Univ. of California' (any-')'){0,10}')'|'(Mathematical Physics Studies' (any-')'){0,10}')'|'(Mathematical Sciences Research Institute Publications' (any-')'){0,10}')'|'(Mathematical Surveys and Monographs' (any-')'){0,10}')'|'(Mathematics and its applications' (any-')'){0,10}')'|'(Mathematics and its Applications' (any-')'){0,10}')'|'(Mathematics and Its Applications' (any-')'){0,10}')'|'({mathfrak sl}(2' (any-')'){0,10}')'|'(Math. Notes {bf 49}' (any-')'){0,10}')'|'(matrix{i,& 0cr 0' (any-')'){0,10}')'|'(May 19.-25.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(May 19.-25.' (any-')'){0,10}')'|'(May 1992, Zvenigorod' (any-')'){0,10}')'|'(May 27-31, 1999' (any-')'){0,10}')'|'(May 94' (any-')'){0,10}')'|'(Maynooth, Ireland' (any-')'){0,10}')'|'(M. Bonini' (any-')'){0,10}')'|'(M.~Cahen and M.~Flato' (any-')'){0,10}')'|'(Mc Graw-Hill' (any-')'){0,10}')'|'(Mc-Graw Hill' (any-')'){0,10}')'|'(Mc Graw-Hill Book Co.' (any-')'){0,10}')'|'(McGraw-Hill Book Co' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(McGraw-Hill Book Co' (any-')'){0,10}')'|'(McGraw-Hill Book Co., Inc, New York' (any-')'){0,10}')'|'(McGraw--Hill Book Company' (any-')'){0,10}')'|'(McGRAW-HILL BOOK COMPANY' (any-')'){0,10}')'|'( Mc-Graw Hill Book Company,New York' (any-')'){0,10}')'|'(Mc-Graw Hill Book Company,New York' (any-')'){0,10}')'|'(McGraw-Hill Book Co. New York' (any-')'){0,10}')'|'(McGraw-Hill, ed. A. Erdelyi' (any-')'){0,10}')'|'(McGraw-Hill Inc.' (any-')'){0,10}')'|'(McGraw-Hill, Inc.' (any-')'){0,10}')'|'(McGraw--Hill Inc., London' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(McGraw--Hill Inc., London' (any-')'){0,10}')'|'(McGraw--Hill, Inc. London' (any-')'){0,10}')'|'( Mc-Graw-Hill, Inc., New York' (any-')'){0,10}')'|'(McGraw-Hill Inc, New York' (any-')'){0,10}')'|'(McGraw-Hill Inc., New York' (any-')'){0,10}')'|'(McGraw-Hill, Inc., New York' (any-')'){0,10}')'|'(McGraw-Hill Inc., U.S.A' (any-')'){0,10}')'|'(Mcgraw-Hill, London' (any-')'){0,10}')'|'( McGraw Hill, New York' (any-')'){0,10}')'|'( McGraw-Hill, New York' (any-')'){0,10}')'|'(Mc Graw - Hill, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Mc Graw - Hill, New York' (any-')'){0,10}')'|'(Mc Graw Hill, New York' (any-')'){0,10}')'|'(Mc--Graw--Hill, New York' (any-')'){0,10}')'|'(McGraw - Hill, New York' (any-')'){0,10}')'|'(McGraw--Hill; New York' (any-')'){0,10}')'|'(McGraw-Hill, New-York' (any-')'){0,10}')'|'(McGraw-Hill, New~York' (any-')'){0,10}')'|'(McGraw-Hill,New York' (any-')'){0,10}')'|'(McGraw-Hill; New York' (any-')'){0,10}')'|'(Mc Graw-Hill, New York, N.Y.' (any-')'){0,10}')'|'(Mc. Graw-Hill, N.Y.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Mc. Graw-Hill, N.Y.' (any-')'){0,10}')'|'(McGraw Hill, N.Y.' (any-')'){0,10}')'|'(McGraw-Hill,  N. Y.' (any-')'){0,10}')'|'(}Mc-GrawHill, Singapore' (any-')'){0,10}')'|'(McGraw Hill, Singapore' (any-')'){0,10}')'|'(McGraw--Hill, Singapore' (any-')'){0,10}')'|'(McGraw--Hill; U.S.A.' (any-')'){0,10}')'|'(McGrow Hill, NY' (any-')'){0,10}')'|'(M.~Chretien and S.~Deser' (any-')'){0,10}')'|'(MCNMO, Moscow' (any-')'){0,10}')'|'(M. Dekker, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(M. Dekker, New York' (any-')'){0,10}')'|'(Methuen, London' (any-')'){0,10}')'|'(Mexico, Mexico City' (any-')'){0,10}')'|'(MGPI Press, Moscow' (any-')'){0,10}')'|'(M. Green and D. Gross' (any-')'){0,10}')'|'(M.-H. Saito, Y. Shimizu and K. Ueno' (any-')'){0,10}')'|'(Mineumsa Publishing Co., Seoul' (any-')'){0,10}')'|'(Min Eum Sa, Seoul' (any-')'){0,10}')'|'(M.I.T., Cambridge' (any-')'){0,10}')'|'(MIT, Cambridge' (any-')'){0,10}')'|'(M. I. T. Press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(M. I. T. Press' (any-')'){0,10}')'|'(MIT Press, Brandeis Lectures' (any-')'){0,10}')'|'(MIT press, Cambridge' (any-')'){0,10}')'|'( MIT Press, Cambridge' (any-')'){0,10}')'|'(MIT Press. Cambridge' (any-')'){0,10}')'|'(MIT Press,  Cambridge, MA' (any-')'){0,10}')'|'(MIT Press, Cambridge MA' (any-')'){0,10}')'|'(M.I.T. Press, Cambridge, Mass' (any-')'){0,10}')'|'(MIT Press, Cambridge, Massachusetts' (any-')'){0,10}')'|'(MIT Press, Cambridge, Massachussets' (any-')'){0,10}')'|'(MIT Press, Cambrige, MA' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(MIT Press, Cambrige, MA' (any-')'){0,10}')'|'(MIT Press, Massachusetts' (any-')'){0,10}')'|'(MIT: Scott' (any-')'){0,10}')'|'(M. Kaku et al.' (any-')'){0,10}')'|'(M. Levy' (any-')'){0,10}')'|'(M. Levy and S. Deser' (any-')'){0,10}')'|'(M.-L. Ge' (any-')'){0,10}')'|'(M.N. Harakeh, J.H. Koch, O. Scholten' (any-')'){0,10}')'|'(Mod. Phys. Lett. A' (any-')'){0,10}')'|'(Monsaraz and Lisboa' (any-')'){0,10}')'|'(Montecatini Terme' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Montecatini Terme' (any-')'){0,10}')'|'(Montreal, Que.' (any-')'){0,10}')'|'(Morikita, 1968' (any-')'){0,10}')'|'(Moscow, 1975' (any-')'){0,10}')'|'(Moscow Energoatomizdat' (any-')'){0,10}')'|'(Moscow, Energoatomizdat' (any-')'){0,10}')'|'(Moscow, Energoizdat' (any-')'){0,10}')'|'(Moscow, Gostechizdat' (any-')'){0,10}')'|'(Moscow, {it Nauka}' (any-')'){0,10}')'|'(Moscow, Mir, 1991' (any-')'){0,10}')'|'(Moscow: Moscow State Pedagogical Inst.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Moscow: Moscow State Pedagogical Inst.' (any-')'){0,10}')'|'(Moscow, Moscow University Press' (any-')'){0,10}')'|'(Moscow: Moscow Univ. Press' (any-')'){0,10}')'|'( Moscow , Nauka ' (any-')'){0,10}')'|'(Moscow , Nauka ' (any-')'){0,10}')'|'(Moscow ,Nauka ' (any-')'){0,10}')'|'(Moscow: Nauka, 1965; N.Y.' (any-')'){0,10}')'|'(Moscow, Nauka,1973; Mir Publishers' (any-')'){0,10}')'|'(Moscow, Russia, 23-29th August' (any-')'){0,10}')'|'(Moscow State University Press' (any-')'){0,10}')'|'(Moscow State University Press, Moscow' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Moscow State University Press, Moscow' (any-')'){0,10}')'|'(Moscow Univ. Press, Moscow' (any-')'){0,10}')'|'(Mos-kow, Nauka' (any-')'){0,10}')'|'(Moskva, Nauka' (any-')'){0,10}')'|'(MRSI Berkeley' (any-')'){0,10}')'|'(MSRI, Berkeley, CA.' (any-')'){0,10}')'|'(n_{1},n_{2}, ...' (any-')'){0,10}')'|'(Nagoya Univ.' (any-')'){0,10}')'|'(Nagoya University' (any-')'){0,10}')'|'(Nagoya University, Nagoya' (any-')'){0,10}')'|'(Nagoya University, Nagoya, Japan' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Nagoya University, Nagoya, Japan' (any-')'){0,10}')'|'(Nara, Japan' (any-')'){0,10}')'|'(Nasa Conference Publications' (any-')'){0,10}')'|'(NASA Conf. Pub. N. 31353' (any-')'){0,10}')'|'(NASA, Washington, D. C.' (any-')'){0,10}')'|'(Nathan, Paris' (any-')'){0,10}')'|'(National Bureau of Standards, Washington, D. C.' (any-')'){0,10}')'|'(National Bureau of Standards, Washington, D.C., USA' (any-')'){0,10}')'|'(National Bureau of Standard, Washington D.C.' (any-')'){0,10}')'|'(National Bureau of Standarts' (any-')'){0,10}')'|'(National Laboratory for High Energy Physics' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(National Laboratory for High Energy Physics' (any-')'){0,10}')'|'(NATO Advanced Study Institutes' (any-')'){0,10}')'|'(NATO ASI {bf C520}, Carg`ese' (any-')'){0,10}')'|'(NATO ASI series' (any-')'){0,10}')'|'(NATO Asi Series B, Physics' (any-')'){0,10}')'|'(NATO ASI Series, Plenum Press' (any-')'){0,10}')'|'(NATO ASI Series, Zakopane, June 1997' (any-')'){0,10}')'|'(Nauka and Technika, Minsk' (any-')'){0,10}')'|'(Nauka i Tekhnika' (any-')'){0,10}')'|'(Nauka i Tekhnika, Minsk' (any-')'){0,10}')'|'(Nauka, Leningrad' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Nauka, Leningrad' (any-')'){0,10}')'|'(Nauka, Moscow' (any-')'){0,10}')'|'(Nauka Moscow' (any-')'){0,10}')'|'(NAUKA, Moscow' (any-')'){0,10}')'|'(Nauka, Moscow, 1969; Wiley, New York' (any-')'){0,10}')'|'(Nauka, Moscow, 1981' (any-')'){0,10}')'|'(Nauka, Moscow, 1986' (any-')'){0,10}')'|'(Nauka, Moscow, 1989' (any-')'){0,10}')'|'(Nauka Publishers, Moscow' (any-')'){0,10}')'|'(Naukova Doumka, Kiev' (any-')'){0,10}')'|'(Naukova Dumka' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Naukova Dumka' (any-')'){0,10}')'|'(NBI, University of Copenhagen' (any-')'){0,10}')'|'(NEEDS 2001 proceedings' (any-')'){0,10}')'|'(New Haven' (any-')'){0,10}')'|'(New Science Publisher, New York' (any-')'){0,10}')'|'(New Science Publishers, New York' (any-')'){0,10}')'|'(new ser.' (any-')'){0,10}')'|'( New-York' (any-')'){0,10}')'|'(New York: Academic' (any-')'){0,10}')'|'(New York Academy of Science' (any-')'){0,10}')'|'(New York  Academy of Sciences' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(New York  Academy of Sciences' (any-')'){0,10}')'|'(New York: Acadimic' (any-')'){0,10}')'|'(New York, AIP' (any-')'){0,10}')'|'(New York, Belfer Graduate School of Science, Yeshiva University' (any-')'){0,10}')'|'(New York: Belfer Graduate School of Science, Yeshiva University' (any-')'){0,10}')'|'(New York: Benjamin-Cummings' (any-')'){0,10}')'|'(New York/Berlin' (any-')'){0,10}')'|'(New York: Colier-Macmillan, 1964' (any-')'){0,10}')'|'(New York, Frederick Ungar Publishing Co' (any-')'){0,10}')'|'(New York, Gordon and Breach Science Publishers' (any-')'){0,10}')'|'(New York, Halsted' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(New York, Halsted' (any-')'){0,10}')'|'(New York, Harwood' (any-')'){0,10}')'|'(New York: Harwood' (any-')'){0,10}')'|'(New  York  - Heidelberg - Berlin: Springer' (any-')'){0,10}')'|'(New York: Interscience' (any-')'){0,10}')'|'(New York, London' (any-')'){0,10}')'|'(New York - London, Academic' (any-')'){0,10}')'|'(New York-London-Paris: Gordon and Breach' (any-')'){0,10}')'|'(New-York, Macgraw-Hill' (any-')'){0,10}')'|'(New York  Mc Graw-Hill' (any-')'){0,10}')'|'(New York, McGraw Hill' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(New York, McGraw Hill' (any-')'){0,10}')'|'(New York, McGraw-Hill' (any-')'){0,10}')'|'(New York: McGraw--Hill' (any-')'){0,10}')'|'(New York, McGraw - Hill Book Company' (any-')'){0,10}')'|'(New York, Morrow' (any-')'){0,10}')'|'(New York, N. Y.' (any-')'){0,10}')'|'(New York, October 1-2' (any-')'){0,10}')'|'(New York, Oxford University Press' (any-')'){0,10}')'|'(New York, Pergamon Press' (any-')'){0,10}')'|'(New York, Plenum Press' (any-')'){0,10}')'|'(New-York, Plenum Press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(New-York, Plenum Press' (any-')'){0,10}')'|'( New York: Plenum Publ. Corp.' (any-')'){0,10}')'|'(New-York,Row,Peterson ' (any-')'){0,10}')'|'(New-York,Row-Peterson ' (any-')'){0,10}')'|'(New York,Scribner' (any-')'){0,10}')'|'(New York, Springer' (any-')'){0,10}')'|'(New York, Springer-Verlag' (any-')'){0,10}')'|'(New York, Toronto' (any-')'){0,10}')'|'(New York: W.H. Freeeman and Company' (any-')'){0,10}')'|'(New York, Wiley' (any-')'){0,10}')'|'(New York: Wiley Interscience' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(New York: Wiley Interscience' (any-')'){0,10}')'|'(New York, Yeshiva University' (any-')'){0,10}')'|'(New York: Yeshiva University' (any-')'){0,10}')'|'(New-York, Yeshiva University ' (any-')'){0,10}')'|'(New York: Yeshiva University Press' (any-')'){0,10}')'|'(New Zealand Mathematical Society, Wellington' (any-')'){0,10}')'|'(Ney York, Wiley' (any-')'){0,10}')'|'(N. Holland' (any-')'){0,10}')'|'(N. Holland, Amsterdam' (any-')'){0,10}')'|'(N.Holland, Amsterdam' (any-')'){0,10}')'|'(Nicola Zanichelli, Bologna' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Nicola Zanichelli, Bologna' (any-')'){0,10}')'|'(Niels Bohr Institute' (any-')'){0,10}')'|'(N.J. Hitchin, P.E. Newstead and W.M. Oxbury' (any-')'){0,10}')'|'(N.~Kamran and P.~J. Olver' (any-')'){0,10}')'|'(N. L. white' (any-')'){0,10}')'|'(No 11' (any-')'){0,10}')'|'(Nor Amberd, Armenia, September' (any-')'){0,10}')'|'(Nordita report NORDITA-93/45A' (any-')'){0,10}')'|'(North Carolina State University, Raleigh' (any-')'){0,10}')'|'(North Holand' (any-')'){0,10}')'|'(North--Holand, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(North--Holand, New York' (any-')'){0,10}')'|'(North Hollamd, Holland, Amsterdam' (any-')'){0,10}')'|'(north Holland' (any-')'){0,10}')'|'(North-Holland, Amesterdam' (any-')'){0,10}')'|'( North Holland, Amsterdam' (any-')'){0,10}')'|'(North - Holland, Amsterdam' (any-')'){0,10}')'|'(North - Holland,Amsterdam' (any-')'){0,10}')'|'(North Holland,Amsterdam' (any-')'){0,10}')'|'(North Holland: Amsterdam' (any-')'){0,10}')'|'(North-Holland,  Amsterdam' (any-')'){0,10}')'|'(North-Holland, Amster-dam' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(North-Holland, Amster-dam' (any-')'){0,10}')'|'(North-Holland; Amsterdam' (any-')'){0,10}')'|'(North Holland, Amsterdam - London' (any-')'){0,10}')'|'(North-Holland, Amsterdam; Masson' (any-')'){0,10}')'|'(North Holland, Amsterdam, The Netherlands' (any-')'){0,10}')'|'(North-Holland, Amsterdan' (any-')'){0,10}')'|'(North-Holland and World Scientific' (any-')'){0,10}')'|'(North-Holland, Bologne' (any-')'){0,10}')'|'( North-Holland/Kodansha' (any-')'){0,10}')'|'(North Holland, New York' (any-')'){0,10}')'|'(North-Holland, New-York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(North-Holland, New-York' (any-')'){0,10}')'|'(North Holland, New York, 1988, vol. 5B' (any-')'){0,10}')'|'(North-Holland Physics Publishing, Amsterdam' (any-')'){0,10}')'|'(North-Holland Physics Publishing Company' (any-')'){0,10}')'|'(North-Holland Physics Publishing, Holland' (any-')'){0,10}')'|'(North Holland Pub.,Amsterdam' (any-')'){0,10}')'|'(North-Holland Pub. Co.' (any-')'){0,10}')'|'(North-Holland Pub. Co., Amsterdam' (any-')'){0,10}')'|'(North Holland publ.' (any-')'){0,10}')'|'(North Holland Publ. Co.' (any-')'){0,10}')'|'(North-Holland Publ.Co., Amsterdam' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(North-Holland Publ.Co., Amsterdam' (any-')'){0,10}')'|'(North--Holland Publ. Comp.' (any-')'){0,10}')'|'(North-Holland Publ.  Comp., Amsterdam, New York, Oxford' (any-')'){0,10}')'|'(North-Holland Publishing' (any-')'){0,10}')'|'(North-Holland Publishing Co., Amsterdam' (any-')'){0,10}')'|'(North-Holland Publishing Company' (any-')'){0,10}')'|'(North Holland Publishing Company, Amsterdam' (any-')'){0,10}')'|'(North-Holland Publishing Company --- Amsterdam' (any-')'){0,10}')'|'(North Holland Publishing Company, New York' (any-')'){0,10}')'|'(North Holland Publishing, New York' (any-')'){0,10}')'|'(North-Holland, the Netherlands' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(North-Holland, the Netherlands' (any-')'){0,10}')'|'(North Holland--World Scientific' (any-')'){0,10}')'|'(Northo-Holland, Amsterdam' (any-')'){0,10}')'|'(Nova Science, Commack' (any-')'){0,10}')'|'(Nova Science, Commack, N. Y.' (any-')'){0,10}')'|'(Nova Science, N. Y.' (any-')'){0,10}')'|'(Nova Science Publisher Inc. Huntington, NY' (any-')'){0,10}')'|'(Nova Science Publishers, Commack' (any-')'){0,10}')'|'(Nova Science Publishers, Commack, N.Y.' (any-')'){0,10}')'|'(N.Y., Benjamin' (any-')'){0,10}')'|'(N.-Y.,Interscience Publishers' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(N.-Y.,Interscience Publishers' (any-')'){0,10}')'|'(N.-Y.: Interscience Publishers' (any-')'){0,10}')'|'(NY June 6-10' (any-')'){0,10}')'|'(N.Y., London' (any-')'){0,10}')'|'(NY, WIley-Intersc.' (any-')'){0,10}')'|'(O. Alvarez, E. Marinari and P. Windey' (any-')'){0,10}')'|'(O.~Alvarez, E.~Marinari and P.~Windey' (any-')'){0,10}')'|'(O.~Babelon, P.~Cartier, and  Y.~Kosmann-Schwarzbach' (any-')'){0,10}')'|'(Obs. Paris-Meudon' (any-')'){0,10}')'|'(Oct.19-21,1992,YITP,Kyoto Univ.' (any-')'){0,10}')'|'(October 15' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(October 15' (any-')'){0,10}')'|'(October 1997' (any-')'){0,10}')'|'(Odense University Press, Odense' (any-')'){0,10}')'|'(Oliver and Boyd' (any-')'){0,10}')'|'(Olms, Hildesheim' (any-')'){0,10}')'|'(Open Court,London' (any-')'){0,10}')'|'(or {$11 = 7 + 4$}' (any-')'){0,10}')'|'(or $11 = 7 + 4$' (any-')'){0,10}')'|'(or $11=7+4$' (any-')'){0,10}')'|'(or 11=7+4' (any-')'){0,10}')'|'(Or 11 = 7 + 4' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Or 11 = 7 + 4' (any-')'){0,10}')'|'(Original Russian edition: Atomizdat, Moscow' (any-')'){0,10}')'|'(OUP and Wiedenfeld and Nicolson' (any-')'){0,10}')'|'(OUP, Oxford' (any-')'){0,10}')'|'(Ox Bow Press, Woodbridge, Connecticut' (any-')'){0,10}')'|'(Oxfold Press' (any-')'){0,10}')'|'(Oxford, 2nd ed.' (any-')'){0,10}')'|'(Oxford, Clarendon, England' (any-')'){0,10}')'|'(Oxford: Clarendon Press, 3rd edition' (any-')'){0,10}')'|'(Oxford: Oxford University Press' (any-')'){0,10}')'|'(Oxford: Pergamon' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Oxford: Pergamon' (any-')'){0,10}')'|'(Oxford, Pergamon Press' (any-')'){0,10}')'|'(Oxford: Pergamon Press' (any-')'){0,10}')'|'(Oxford preprint' (any-')'){0,10}')'|'(Oxford Preprint' (any-')'){0,10}')'|'(Oxford Science Publications' (any-')'){0,10}')'|'(Oxford SciencePublications, London' (any-')'){0,10}')'|'(Oxford Science Publications, New York' (any-')'){0,10}')'|'(Oxfordshire, England' (any-')'){0,10}')'|'(Oxford, UK' (any-')'){0,10}')'|'(Oxford, UK, July 2-3' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Oxford, UK, July 2-3' (any-')'){0,10}')'|'(Oxford Univeristy Press, Oxford' (any-')'){0,10}')'|'(Oxford University, New York' (any-')'){0,10}')'|'(Oxford university press' (any-')'){0,10}')'|'(Oxford university Press' (any-')'){0,10}')'|'(Oxford  University Press' (any-')'){0,10}')'|'(Oxford, University Press' (any-')'){0,10}')'|'(Oxford University Press, 2nd corrected edition' (any-')'){0,10}')'|'(Oxford University Press Inc., New York' (any-')'){0,10}')'|'(Oxford University Press,New York ' (any-')'){0,10}')'|'(Oxford University Press, NY' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Oxford University Press, NY' (any-')'){0,10}')'|'(Oxford University Press,Oxford' (any-')'){0,10}')'|'(Oxford University Press, Oxford, England' (any-')'){0,10}')'|'(Oxford University Press, Oxford, Third Edition' (any-')'){0,10}')'|'(Oxford University Press, Oxford, UK' (any-')'){0,10}')'|'(Oxford University Press, Walton Street, Oxford OX2 6DP' (any-')'){0,10}')'|'(Oxford Univ., New York' (any-')'){0,10}')'|'( Oxford Univ. Press' (any-')'){0,10}')'|'(Oxford Univ. Press' (any-')'){0,10}')'|'(Oxford Univ.Press' (any-')'){0,10}')'|'(Oxford Univ. Press Inc., New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Oxford Univ. Press Inc., New York' (any-')'){0,10}')'|'(Oxford Univ. Press: Oxford' (any-')'){0,10}')'|'(Oxford Univ.Press, Oxford' (any-')'){0,10}')'|'(Oxford U. P.' (any-')'){0,10}')'|'(Oxford U.P.' (any-')'){0,10}')'|'(Oxford UP, New York' (any-')'){0,10}')'|'(Oxford U. Press' (any-')'){0,10}')'|'(Oxford U.Press' (any-')'){0,10}')'|'(Oxford U. Press, Clarendon Press' (any-')'){0,10}')'|'(Oxford U. Press, Fourth ed.' (any-')'){0,10}')'|'(Palm Harbor, Hadronic Press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Palm Harbor, Hadronic Press' (any-')'){0,10}')'|'(paper presented at Clifford Centennial Meeting, Princeton' (any-')'){0,10}')'|'(Paris: Dunod' (any-')'){0,10}')'|'(Paris: Flammarion' (any-')'){0,10}')'|'(Paris, France, 5-9th June' (any-')'){0,10}')'|'(Paris: Gauthier-Villars' (any-')'){0,10}')'|'(Paris: Her-mann' (any-')'){0,10}')'|'(Paris: Hermann & Cie.' (any-')'){0,10}')'|'(Parisianou S.A., Athens' (any-')'){0,10}')'|'(Paris, July 18--25' (any-')'){0,10}')'|'(Paris U.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Paris U.' (any-')'){0,10}')'|'(Park City, Utah' (any-')'){0,10}')'|'(Parma University' (any-')'){0,10}')'|'(Parma University, Parma' (any-')'){0,10}')'|'(P. Di Vecchia and J. L. Petersen' (any-')'){0,10}')'|'(Pegamon Press, New York' (any-')'){0,10}')'|'(Pegamon Press, Oxford, U.K.' (any-')'){0,10}')'|'(Pergammon, Oxford' (any-')'){0,10}')'|'(Pergammon Press, London' (any-')'){0,10}')'|'(Pergammon Press Ltd.' (any-')'){0,10}')'|'(Pergamon and PWN, Oxford' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Pergamon and PWN, Oxford' (any-')'){0,10}')'|'(Pergamon, Elmsford, 4th ed.' (any-')'){0,10}')'|'(Pergamon,  New York' (any-')'){0,10}')'|'(Pergamon,  Oxford' (any-')'){0,10}')'|'(Pergamon: Oxford' (any-')'){0,10}')'|'(Pergamon, Oxford, England' (any-')'){0,10}')'|'(Pergamon press' (any-')'){0,10}')'|'( Pergamon Press' (any-')'){0,10}')'|'(Pergamon Press, 1977' (any-')'){0,10}')'|'(Pergamon Press, 2nd edition' (any-')'){0,10}')'|'(Pergamon Press, Elmsford, NY' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Pergamon Press, Elmsford, NY' (any-')'){0,10}')'|'(Pergamon Press, London and New York' (any-')'){0,10}')'|'(Pergamon Press, London - Paris' (any-')'){0,10}')'|'(Pergamon Press Ltd., Oxford' (any-')'){0,10}')'|'(Pergamon Press, N.Y.' (any-')'){0,10}')'|'( Pergamon Press, Oxford' (any-')'){0,10}')'|'(Pergamon Press. Oxford' (any-')'){0,10}')'|'(Pergamon Press, Oxford, England' (any-')'){0,10}')'|'(Pergamon Press, Tokyo' (any-')'){0,10}')'|'(Pergamon Press, USA' (any-')'){0,10}')'|'(Pergamon Pr, Oxford, Frankfurt' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Pergamon Pr, Oxford, Frankfurt' (any-')'){0,10}')'|'( Pergamon  publ.,' (any-')'){0,10}')'|'(Pergmon Press, Oxford' (any-')'){0,10}')'|'(Permagon Press' (any-')'){0,10}')'|'(Perseus Publishing' (any-')'){0,10}')'|'(Perseus, Reading, Massachusetts' (any-')'){0,10}')'|'(Perth, Western Australia' (any-')'){0,10}')'|'(Petrozavodsk, URSS' (any-')'){0,10}')'|'(P. G. O. Freund and K. T. Mahanthappa' (any-')'){0,10}')'|'(Ph.D. Thesis' (any-')'){0,10}')'|'(PhD thesis, Harvard mathematical physics' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(PhD thesis, Harvard mathematical physics' (any-')'){0,10}')'|'(Ph.D. thesis in german' (any-')'){0,10}')'|'(Ph.D. thesis in german' (any-')'){0,10}')'|'(Ph.D. thesis in German' (any-')'){0,10}')'|'(PhD. thesis; Leiden Univ.' (any-')'){0,10}')'|'(Ph.D thesis, Science Univ. of Tokyo' (any-')'){0,10}')'|'(Ph.D. Thesis, TU Wien' (any-')'){0,10}')'|'(PhD Thesis, University of Cambridge' (any-')'){0,10}')'|'(Ph. D. thesis, University of Utrecht' (any-')'){0,10}')'|'(Ph. D. Thesis, Univ. of Tokyo' (any-')'){0,10}')'|'(Ph.D. thesis, Utrecht' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Ph.D. thesis, Utrecht' (any-')'){0,10}')'|'( Phi (1' (any-')'){0,10}')'|'(Physica 124A' (any-')'){0,10}')'|'(Physical Society of Japan' (any-')'){0,10}')'|'(Physics Letters B' (any-')'){0,10}')'|'(Physics of Atomic Nuclei {bf 64}' (any-')'){0,10}')'|'(Physics Uspekhi' (any-')'){0,10}')'|'(Physics Uspekhi, {bf 37}' (any-')'){0,10}')'|'(Phys. Lett. A' (any-')'){0,10}')'|'(Phys. Lett. B.' (any-')'){0,10}')'|'(Phys. Lett. {bf B}' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Phys. Lett. {bf B}' (any-')'){0,10}')'|'(Phys.~Lett. {bf B}' (any-')'){0,10}')'|'(Phys. Rep.' (any-')'){0,10}')'|'(Phys. Reports' (any-')'){0,10}')'|'(Phys. Rev. D' (any-')'){0,10}')'|'(Phys. Rev. Lett. {bf 73}' (any-')'){0,10}')'|'(Pisa: Scuola Normale Superiore' (any-')'){0,10}')'|'(Pitagora Editrice' (any-')'){0,10}')'|'(Pitagora Editrice, Bologna' (any-')'){0,10}')'|'(Pitman Advanced Publishing Program, Boston' (any-')'){0,10}')'|'(Pitman, London, 1968; Dover' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Pitman, London, 1968; Dover' (any-')'){0,10}')'|'(Pitman,San Fransisco' (any-')'){0,10}')'|'(plasma ,|(Plenumm Press' (any-')'){0,10}')'|'( Plenum, New York' (any-')'){0,10}')'|'(Plenum, New-York' (any-')'){0,10}')'|'(Plenum:  New  York' (any-')'){0,10}')'|'(Plenum; New York' (any-')'){0,10}')'|'(Plenum, New York and London' (any-')'){0,10}')'|'(Plenum, New York & London' (any-')'){0,10}')'|'(plenum, N.Y.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(plenum, N.Y.' (any-')'){0,10}')'|'( Plenum, NY' (any-')'){0,10}')'|'(Plenum ,NY' (any-')'){0,10}')'|'(Plenum NY' (any-')'){0,10}')'|'(Plenum, N. Y.' (any-')'){0,10}')'|'(Plenum: NY' (any-')'){0,10}')'|'(plenum Press' (any-')'){0,10}')'|'(Plenum Press, 1982' (any-')'){0,10}')'|'(Plenum Press, London' (any-')'){0,10}')'|'(Plenum  Press, New  York' (any-')'){0,10}')'|'(Plenum Press, New York and London' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Plenum Press, New York and London' (any-')'){0,10}')'|'(Plenum Press, New York - London' (any-')'){0,10}')'|'(Plenum Press, New York & London' (any-')'){0,10}')'|'(Plenum Press, New York London' (any-')'){0,10}')'|'(Plenum Press, New York, London' (any-')'){0,10}')'|'(Plenum Press, New York NY' (any-')'){0,10}')'|'(Plenum Press, New Yourk and London' (any-')'){0,10}')'|'(plenum Press, NY' (any-')'){0,10}')'|'(Plenum Press, N.-Y.' (any-')'){0,10}')'|'(Plenum Press, N.Y' (any-')'){0,10}')'|'(Plenum Pub. Co., New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Plenum Pub. Co., New York' (any-')'){0,10}')'|'(Plenum Pub. Co., New York ' (any-')'){0,10}')'|'(Plenum Publishing' (any-')'){0,10}')'|'(Plenum Publishing C., New York' (any-')'){0,10}')'|'(Plenum Publishing Co.' (any-')'){0,10}')'|'(Plenum Publishing Corporation, New York' (any-')'){0,10}')'|'(P. Nath and S. Reucroft' (any-')'){0,10}')'|'(P. Noordhoff, Ltd. Groningen' (any-')'){0,10}')'|'(Polish Scientific Publischers' (any-')'){0,10}')'|'(Polish  Scientific  Publishers, Warsaw' (any-')'){0,10}')'|'(Polish Scientific Publishers, Warzawa' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Polish Scientific Publishers, Warzawa' (any-')'){0,10}')'|'(Polish Scientific Publisher, Warszawa' (any-')'){0,10}')'|'(Polish Sci.Publishers, Warsaw' (any-')'){0,10}')'|'(Polish Sc. Publ.' (any-')'){0,10}')'|'(Pontificia Academia Scientiarum, Vatican City' (any-')'){0,10}')'|'(P.P. Kulish' (any-')'){0,10}')'|'(Prentice-Hall, Englewood Cliffs' (any-')'){0,10}')'|'(Prentice Hall, Englewood Cliffs NJ' (any-')'){0,10}')'|'(Prentice-Hall, Englewood Cliffs, NJ' (any-')'){0,10}')'|'(Prentice-Hall, Englewood, N.J.' (any-')'){0,10}')'|'(Prentice-Hall, Inc.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Prentice-Hall, Inc.' (any-')'){0,10}')'|'(Prentice-Hall, Inc., Englewood Cliffs' (any-')'){0,10}')'|'(Prentice-Hall, Inc. Englewood Cliffs, New Jersey' (any-')'){0,10}')'|'(Prentice-Hall, Inc., Englewood Cliffs, New Jersey' (any-')'){0,10}')'|'(Prentice-Hall Inc., Englewood Cliffs, N.J.' (any-')'){0,10}')'|'(Prentice-Hall, London' (any-')'){0,10}')'|'(Prentice Hall, New Jersey' (any-')'){0,10}')'|'(Prentice-Hall, New Jersey, USA' (any-')'){0,10}')'|'(Prentice-Hall, New York' (any-')'){0,10}')'|'(Prentice Hall PTR, Englewood Cliffs' (any-')'){0,10}')'|'(Prentice Hall PTR, Upper Saddle River, NJ' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Prentice Hall PTR, Upper Saddle River, NJ' (any-')'){0,10}')'|'(Preprint F-7, Academy of Sci. of Estonia' (any-')'){0,10}')'|'(preprint hep-lat/9709042' (any-')'){0,10}')'|'(Preprint IAS' (any-')'){0,10}')'|'(Preprint, IP GAS-4-97, Tbilisi' (any-')'){0,10}')'|'(preprint ITEP' (any-')'){0,10}')'|'(preprint, Leningrad' (any-')'){0,10}')'|'(Preprint LPTENS-92/18' (any-')'){0,10}')'|'(preprint RU-95-37' (any-')'){0,10}')'|'(preprint SLAC-PUB-6938, CERN-TH/95-159' (any-')'){0,10}')'|'(Preprint TH.2332-CERN' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Preprint TH.2332-CERN' (any-')'){0,10}')'|'(Presses Universitaires de France' (any-')'){0,10}')'|'(Priceton University Press' (any-')'){0,10}')'|'(Princeton, N.J., Princeton University Press' (any-')'){0,10}')'|'(Princeton, NJ: Princeton University Press' (any-')'){0,10}')'|'(Princeton: Princeton Univ. Press' (any-')'){0,10}')'|'(Princeton Series in Physics, Princeton Univ. Press 1983, Princeton' (any-')'){0,10}')'|'(Princeton University Pres, Princeton' (any-')'){0,10}')'|'(Princeton  University  Press' (any-')'){0,10}')'|'(Princeton  University Press' (any-')'){0,10}')'|'(Princeton University Press ' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Princeton University Press ' (any-')'){0,10}')'|'(Princeton University Press and University of Tokyo Press' (any-')'){0,10}')'|'( Princeton University Press, New Jersey' (any-')'){0,10}')'|'(Princeton University Press, N. J.' (any-')'){0,10}')'|'(Princeton University Press, N.Y.' (any-')'){0,10}')'|'(Prin-ce-ton University Press, Prin-ce-ton' (any-')'){0,10}')'|'(Princeton University Press,  Princeton' (any-')'){0,10}')'|'(Princeton University Press: Princeton' (any-')'){0,10}')'|'(Princeton University-Press, Princeton' (any-')'){0,10}')'|'(Princeton University Press, Princeton, 1983' (any-')'){0,10}')'|'(Princeton University Press, Princeton, 1991' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Princeton University Press, Princeton, 1991' (any-')'){0,10}')'|'(Princeton University Press: Princeton, New Jersey' (any-')'){0,10}')'|'(Princeton University press, Princeton, New Jersy' (any-')'){0,10}')'|'(Princeton University Press, Princeton N.J.' (any-')'){0,10}')'|'(Princeton University Press, Princeton NJ' (any-')'){0,10}')'|'(Princeton University Press, Princeton NJ, USA' (any-')'){0,10}')'|'(Princeton University Press/World Scientific, Princeton, NJ/Singapore' (any-')'){0,10}')'|'(Princeton University, Princeton' (any-')'){0,10}')'|'(Princeton University, Princeton, NJ' (any-')'){0,10}')'|'(Princeton University report PUPT-1373, hep-th/9301021' (any-')'){0,10}')'|'(Princeton Univ.Press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Princeton Univ.Press' (any-')'){0,10}')'|'(Princeton Univ. Press, 1st ed. 1983' (any-')'){0,10}')'|'( Princeton Univ. Press,  New Jersey' (any-')'){0,10}')'|'(Princeton Univ. Press, NJ' (any-')'){0,10}')'|'( Princeton Univ. Press, Princeton' (any-')'){0,10}')'|'(Princeton  Univ Press, Princeton' (any-')'){0,10}')'|'(Princeton Univ-Press, Princeton' (any-')'){0,10}')'|'(Princeton Univ. Press, Princeton' (any-')'){0,10}')'|'(Princeton Univ. Press, Princeton, New Jersey' (any-')'){0,10}')'|'( Princeton Univ. Press, Princeton, N.J.' (any-')'){0,10}')'|'(Princeton Univ. Press: Princeton, NJ' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Princeton Univ. Press: Princeton, NJ' (any-')'){0,10}')'|'(Princeton Univ. Press, Princeton, NJ' (any-')'){0,10}')'|'(Princeton Univ. Press, Prinston' (any-')'){0,10}')'|'(Princeton Univ. Press/World Scientific, Singapore' (any-')'){0,10}')'|'(Princeton Un. Press' (any-')'){0,10}')'|'(Princeton Un. Press/World Scientific' (any-')'){0,10}')'|'(Princeton Unversity Press' (any-')'){0,10}')'|'(Princeton U. P.' (any-')'){0,10}')'|'(Princeton U.P.' (any-')'){0,10}')'|'(Princeton UP' (any-')'){0,10}')'|'(Princeton U.P., Prenceton' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Princeton U.P., Prenceton' (any-')'){0,10}')'|'(Princeton U. P., Princeton' (any-')'){0,10}')'|'(Princeton U. P./World Scientific, Princeton NJ, Singapore' (any-')'){0,10}')'|'(Princeton, Wess $&$ Bagger' (any-')'){0,10}')'|'(Prinston ' (any-')'){0,10}')'|'(Printed in Hoddeson and al. ' (any-')'){0,10}')'|'(printed in Japan' (any-')'){0,10}')'|'(Proc. Conf. Aug 24-30 Brno' (any-')'){0,10}')'|'(Proc. Conf. Midwest, Cincinnati, Ohio' (any-')'){0,10}')'|'(Proc. Delhi' (any-')'){0,10}')'|'(Proceedings of A. Swieca School' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Proceedings of A. Swieca School' (any-')'){0,10}')'|'(proceedings of the 16$^{th}$ International Symposium on Lattice Field Theory, Boulder, CO' (any-')'){0,10}')'|'(Proceedings of the 1992 Rome Workshop, World Scientific' (any-')'){0,10}')'|'(Proceedings of the Steklov Math. Inst., LOMI' (any-')'){0,10}')'|'(Proc. Int. Seminar, Potsdam, Germany' (any-')'){0,10}')'|'(Proc. NATO Adv. Study Inst., Geilo' (any-')'){0,10}')'|'(Proc. Of 2nd Max Born Symposium, Wroclaw, Poland' (any-')'){0,10}')'|'(Proc. of NATO Advanced Research Workshop, Chicago' (any-')'){0,10}')'|'(Proc. of the Superstring Workshop, Texas A & M Univ.' (any-')'){0,10}')'|'(Proc. Recent progress in statistical mechanics and quantum field theory, Los Angeles' (any-')'){0,10}')'|'(Proc. Roy. Soc. {bf A333}' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Proc. Roy. Soc. {bf A333}' (any-')'){0,10}')'|'(Proc. Suppl} {bf 90}' (any-')'){0,10}')'|'(Proc. Symp. Pure Math.' (any-')'){0,10}')'|'(Proc. Trento' (any-')'){0,10}')'|'(Progress in Math. {bf 65}' (any-')'){0,10}')'|'(Progress in Mathematical; Vol' (any-')'){0,10}')'|'(Progress in mathematics' (any-')'){0,10}')'|'(Progress in Math., vol. 36' (any-')'){0,10}')'|'( Progress In Physics' (any-')'){0,10}')'|'(Protvino, 1986' (any-')'){0,10}')'|'(Protvino, Russia' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Protvino, Russia' (any-')'){0,10}')'|'(Providence, Amer. Math. Soc.' (any-')'){0,10}')'|'( Providence, Rhode Island' (any-')'){0,10}')'|'(Providence, Rhode Island' (any-')'){0,10}')'|'(Providence, RI' (any-')'){0,10}')'|'(Providence, RI: American Mathematical Society' (any-')'){0,10}')'|'(Providence, RI, AMS/IAS' (any-')'){0,10}')'|'(Providence, RI, USA, AMS/IAS' (any-')'){0,10}')'|'(Pub. Inst. Math., Beogrado' (any-')'){0,10}')'|'(Publ. du CNRS, Paris' (any-')'){0,10}')'|'(Publicaciones del I.A.M., Buenos Aires' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Publicaciones del I.A.M., Buenos Aires' (any-')'){0,10}')'|'(Publications Observatoire de Paris' (any-')'){0,10}')'|'(Publications of Mathematical Society, Tokyo' (any-')'){0,10}')'|'(Publich or Perich Inc.' (any-')'){0,10}')'|'(Published in Nucl. Phys. B' (any-')'){0,10}')'|'(Publish or Perish, Delaware' (any-')'){0,10}')'|'(Publish or Perish, Houston' (any-')'){0,10}')'|'(Publish or Perish, Inc.' (any-')'){0,10}')'|'(Publish or Perish, Inc. ' (any-')'){0,10}')'|'(Publish or Perish, INC' (any-')'){0,10}')'|'(Publish or Perish Inc., Boston' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Publish or Perish Inc., Boston' (any-')'){0,10}')'|'(Publish or Perish Inc.,  Boston, Ma.' (any-')'){0,10}')'|'(Publish or Perish, Inc., Math. Lect. series no. 11' (any-')'){0,10}')'|'(Publish or Perish, Vilmington' (any-')'){0,10}')'|'(Publish or Perish, Wilmington' (any-')'){0,10}')'|'(Publish or Perish, Wilmington, DE, USA' (any-')'){0,10}')'|'(Publ. JINR E2-96-224, Dubna' (any-')'){0,10}')'|'(Pure and Applied Mathematics' (any-')'){0,10}')'|'(P. van Baal' (any-')'){0,10}')'|'(PWN-Polish Scientific Publishers' (any-')'){0,10}')'|'(PWN-Polish Scientific Publishers, Warsaw' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(PWN-Polish Scientific Publishers, Warsaw' (any-')'){0,10}')'|'(PWN Polish Scientific Publishers,Warszawa' (any-')'){0,10}')'|'(PWN-Polish Sci. Publ., Warszawa' (any-')'){0,10}')'|'(quark confinement' (any-')'){0,10}')'|'(quoted in M.K. Gaillard and B. Zumino' (any-')'){0,10}')'|'(R. Ablamowicz' (any-')'){0,10}')'|'(Rajarama Bhat et al eds, AMS' (any-')'){0,10}')'|'(R. Bleuler, H. Petry, A. Reetz' (any-')'){0,10}')'|'(R. Dijkgraaf, C.Faber and G. van der Geer' (any-')'){0,10}')'|'(R. Dobrushin et al.' (any-')'){0,10}')'|'(Reading MA' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Reading MA' (any-')'){0,10}')'|'(Reading, MA : Addison-Wesley' (any-')'){0,10}')'|'(Reading, Massachusetts' (any-')'){0,10}')'|'(Readwood City: Addison-Wesley, 1965' (any-')'){0,10}')'|'(Redwood City, California' (any-')'){0,10}')'|'(Redwood City, California: Addison-Wesley' (any-')'){0,10}')'|'(Reidel; Dordrecht' (any-')'){0,10}')'|'(Reidel, Dordrecht-Holland' (any-')'){0,10}')'|'(Reidel Pub., Dordrecht' (any-')'){0,10}')'|'(Reidel Publ. Co.' (any-')'){0,10}')'|'(Reidel Publ., Dordrecht' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Reidel Publ., Dordrecht' (any-')'){0,10}')'|'(Reidel Publishing Company, Holland' (any-')'){0,10}')'|'(Reimer, Berlin' (any-')'){0,10}')'|'(Reports NAS RA' (any-')'){0,10}')'|'( reprinted by Dover, New York' (any-')'){0,10}')'|'(Reprinted in *Goldhaber' (any-')'){0,10}')'|'(Reprinted in {it Solitons and Particles}, eds. C.~Rebbi and G.~Soliani' (any-')'){0,10}')'|'(reprintes Chelsea' (any-')'){0,10}')'|'(revised edition' (any-')'){0,10}')'|'(Revised Edition' (any-')'){0,10}')'|'(revised on May' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(revised on May' (any-')'){0,10}')'|'(revised version' (any-')'){0,10}')'|'(Rhode Island' (any-')'){0,10}')'|'(R. Hwa' (any-')'){0,10}')'|'(Riedel, Dordrecht' (any-')'){0,10}')'|'(Riedel Publ. Co., Dordrecht' (any-')'){0,10}')'|'(RIMS, Montreal' (any-')'){0,10}')'|'(River Edge, NJ: World Scientific' (any-')'){0,10}')'|'(R.K.~Bullough and P.S.~Caudrey' (any-')'){0,10}')'|'({rm sl(2' (any-')'){0,10}')'|'({rm su}(1' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'({rm su}(1' (any-')'){0,10}')'|'(Roma, Consiglio Nazionale Delle Ricerche' (any-')'){0,10}')'|'(Ro-me, Academia Nacionale dei Lincei' (any-')'){0,10}')'|'(Rome, Italy' (any-')'){0,10}')'|'(Routledge and Kegan Paul' (any-')'){0,10}')'|'(Routledge, London' (any-')'){0,10}')'|'(Row, Elmsford' (any-')'){0,10}')'|'(Row, Peterson and Co, 1961' (any-')'){0,10}')'|'(Row, Peterson and Co., New York' (any-')'){0,10}')'|'(Row, Peterson and Co., USA' (any-')'){0,10}')'|'(Row, Peterson, Evanson' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Row, Peterson, Evanson' (any-')'){0,10}')'|'(Row Peterson, New York' (any-')'){0,10}')'|'(R. P. Kerr, Phys. Rev. Lett. {bf 11}' (any-')'){0,10}')'|'(Russian Edition' (any-')'){0,10}')'|'(Russian edition: Yad. Fiz., {bf 56}' (any-')'){0,10}')'|'(Russian original: Dokl.Akad. Nauk SSSR {bf 250}' (any-')'){0,10}')'|'(R. V. Kadison' (any-')'){0,10}')'|'(Saclay, France, June 5-7' (any-')'){0,10}')'|'(Saiensu Co., Tokyo' (any-')'){0,10}')'|'(Sandansky, Bulgaria, 9--15 June' (any-')'){0,10}')'|'(S. Andersson and M. Lapidus' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(S. Andersson and M. Lapidus' (any-')'){0,10}')'|'(San Diego' (any-')'){0,10}')'|'(San Diego, CA, Academic Press' (any-')'){0,10}')'|'( San Francisco; Freeman' (any-')'){0,10}')'|'(San Francisco: Freeman' (any-')'){0,10}')'|'(San Francisco: Holden-Day' (any-')'){0,10}')'|'(San Francisco: W.H.Freeman and Company' (any-')'){0,10}')'|'(Santa Monica' (any-')'){0,10}')'|'(S~{a}o Paulo, IFT' (any-')'){0,10}')'|'(Saunders College Publishing, Philadelphia' (any-')'){0,10}')'|'(S.~Catto and A.~Rocha' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(S.~Catto and A.~Rocha' (any-')'){0,10}')'|'(S. Catto, A. Rocha' (any-')'){0,10}')'|'(scheduled for Feb. 15' (any-')'){0,10}')'|'(Science, China' (any-')'){0,10}')'|'(Science Network Publishing, Konstanz' (any-')'){0,10}')'|'(Science Network Publishing: Tlaxcala' (any-')'){0,10}')'|'(Science Press, Beijing' (any-')'){0,10}')'|'(Sciences Press, Beijing' (any-')'){0,10}')'|'(Scuala Normale Superiore Publ., Pisa, Italy' (any-')'){0,10}')'|'(Scuola Normale Superiore' (any-')'){0,10}')'|'(S. Deser, K. W. Ford' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(S. Deser, K. W. Ford' (any-')'){0,10}')'|'(S. Deser, M. Grisaru and H. Pendleton' (any-')'){0,10}')'|'(S.~Deser, M.~Grisaru and S.~Pendleton' (any-')'){0,10}')'|'(second edition, Princeton University Press' (any-')'){0,10}')'|'(second edition, Springer, Berlin, Heidelberg, New York' (any-')'){0,10}')'|'(second edition, Springer-Verlag, New York' (any-')'){0,10}')'|'(second ed., Nauka, Moscow' (any-')'){0,10}')'|'(see [27]' (any-')'){0,10}')'|'(See also B. Mashhoon, {it Phys. Rev.} {bf D}, 8' (any-')'){0,10}')'|'(see also cite{Gr,Gr1,G1' (any-')'){0,10}')'|'(see also hep-th/9312167' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(see also hep-th/9312167' (any-')'){0,10}')'|'(see also Ref.[17]' (any-')'){0,10}')'|'(see also Ref.cite{BS' (any-')'){0,10}')'|'(see also S.R. Wadia' (any-')'){0,10}')'|'(see also T. Deguchi' (any-')'){0,10}')'|'(see also the textbook cite{PI}' (any-')'){0,10}')'|'(see also T. Suzuki' (any-')'){0,10}')'|'(see F. Dyson, Phys. Rev. 85' (any-')'){0,10}')'|'(see fig.,5 of ref.|(see, for example' (any-')'){0,10}')'|'(See formulas 3.471, 8.411, 6.576, 8.820, 8.733' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(See formulas 3.471, 8.411, 6.576, 8.820, 8.733' (any-')'){0,10}')'|'(see his table 17' (any-')'){0,10}')'|'(see in A.V. Kotikov' (any-')'){0,10}')'|'(see Ref. 5' (any-')'){0,10}')'|'(see Ref.cite{[28]}' (any-')'){0,10}')'|'(see Refs. cite{AM89,AM20,AM30,PG,Hag' (any-')'){0,10}')'|'(See U. Jentschura and E. Weniger' (any-')'){0,10}')'|'(Semestr 3' (any-')'){0,10}')'|'(Semestr 4' (any-')'){0,10}')'|'(Seoul: Chungburn' (any-')'){0,10}')'|'(Sept. 18' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Sept. 18' (any-')'){0,10}')'|'(Sept. 94' (any-')'){0,10}')'|'( S.Gindikin and I.M.Singer' (any-')'){0,10}')'|'(Shaker Verlag, Aachen' (any-')'){0,10}')'|'( Shanghai Scientific and Technical Publishers' (any-')'){0,10}')'|'(Shanghai Scientific & Technical Publishers' (any-')'){0,10}')'|'(S.~Hawking and M.~Rov{c}ek' (any-')'){0,10}')'|'(Shelter Island' (any-')'){0,10}')'|'(Shiva Publishing Limited' (any-')'){0,10}')'|'(Shiva Publishing Limited, Orpington' (any-')'){0,10}')'|'(  Shokado, Tokyo' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(  Shokado, Tokyo' (any-')'){0,10}')'|'(Shumen, Bulgaria' (any-')'){0,10}')'|'(SIAM, Bristol' (any-')'){0,10}')'|'(SIAM Press, Philadelphia' (any-')'){0,10}')'|'(Sijthoff & Noordhoof' (any-')'){0,10}')'|'(Singapore, New Jersey, Hong Kong' (any-')'){0,10}')'|'(Singapore, Singapore: World Scientific' (any-')'){0,10}')'|'(Singapore,  World Scientific' (any-')'){0,10}')'|'(SISSA, Trieste' (any-')'){0,10}')'|'(SLAC, Stanford' (any-')'){0,10}')'|'({sl Birkh"auser},~Basel' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'({sl Birkh"auser},~Basel' (any-')'){0,10}')'|'(Society for Industrial and Applied Mathematics, Philadelphia' (any-')'){0,10}')'|'(Sogang Univ.' (any-')'){0,10}')'|'(South Hadley, MA' (any-')'){0,10}')'|'(Soviet Math. Dokl. {bf 36}' (any-')'){0,10}')'|'(Soviet Physics JETP. {bf 42}' (any-')'){0,10}')'|'(Soviet Physics Uspekhi' (any-')'){0,10}')'|'(Soviet Physics Uspekhi {bf 35}' (any-')'){0,10}')'|'(Soviet Scientific Reviews A' (any-')'){0,10}')'|'(Sov. J. Contemp. Math. Anal. {bf 22}' (any-')'){0,10}')'|'(Sov. J. Contemp. Phys. {bf 22}' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Sov. J. Contemp. Phys. {bf 22}' (any-')'){0,10}')'|'(Sov. J. Nucl. Phys. {bf 35}' (any-')'){0,10}')'|'(Sov.Phys.Dokl.{bf 8}' (any-')'){0,10}')'|'(Sov.Phys.Dolk.{bf 37}' (any-')'){0,10}')'|'(Sov. Phys. JETP 42' (any-')'){0,10}')'|'(Sov. Phys. JETP {bf 20}' (any-')'){0,10}')'|'(Sov. Phys. JETP {bf 42}' (any-')'){0,10}')'|'(Sov. Phys. JETP {bf 7}' (any-')'){0,10}')'|'(Sov. Phys. JETP, V. 48' (any-')'){0,10}')'|'(Spektrum Akad.Verl.' (any-')'){0,10}')'|'(Spinger Verlag' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Spinger Verlag' (any-')'){0,10}')'|'(Spinger-Verlag, Berlin' (any-')'){0,10}')'|'(Spinger-Verlag, New York' (any-')'){0,10}')'|'(Spriger-Verlag, Berlin' (any-')'){0,10}')'|'(Spriner-Verlag, Berlin' (any-')'){0,10}')'|'(Springer, 2002' (any-')'){0,10}')'|'( Springer,Berlin' (any-')'){0,10}')'|'(Spring-er, Berlin' (any-')'){0,10}')'|'(Springer,  Berlin' (any-')'){0,10}')'|'(Springer,- Berlin' (any-')'){0,10}')'|'(Springer, Berlin, 1992[1st ed.]' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Springer, Berlin, 1992[1st ed.]' (any-')'){0,10}')'|'(Springer, Berlin, 3rd Edition' (any-')'){0,10}')'|'(Springer, Berlin etc.' (any-')'){0,10}')'|'(Springer, Berlin, Heidelberg' (any-')'){0,10}')'|'(Springer, Berlin Heidelberg New York' (any-')'){0,10}')'|'(Springer, Berlin--Heidelberg--New York' (any-')'){0,10}')'|'(Springer, Berlin/Heidelberg/New York' (any-')'){0,10}')'|'(Springer, Berlin - New York' (any-')'){0,10}')'|'(Springer Graduate Texts in Mathematics 42' (any-')'){0,10}')'|'(Springer: Heidelberg' (any-')'){0,10}')'|'(Springer International, Berlin' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Springer International, Berlin' (any-')'){0,10}')'|'(Springer International Students Edition, New Delhi' (any-')'){0,10}')'|'(Springer Lect. Notes in Nonlinear Dynamics' (any-')'){0,10}')'|'(Springer lecture Notes in Physics' (any-')'){0,10}')'|'(Springer Lecture Notes in Physics $# 280$' (any-')'){0,10}')'|'(Springer Lecture Notes in Physics {bf 180}' (any-')'){0,10}')'|'(Springer Lecture Notes Math. {bf 1510}' (any-')'){0,10}')'|'(Springer, London' (any-')'){0,10}')'|'( Springer, NewYork' (any-')'){0,10}')'|'(Sprin-ger, New York' (any-')'){0,10}')'|'(Springer, New-York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Springer, New-York' (any-')'){0,10}')'|'(Springer, NewYork' (any-')'){0,10}')'|'(Springer, New York--Berlin--Heidelberg--Tokyo' (any-')'){0,10}')'|'(Springer, New York etc.' (any-')'){0,10}')'|'(Springer, New York/ Heidelberg/ Berlin' (any-')'){0,10}')'|'( Springer New York, Springer' (any-')'){0,10}')'|'(Springer, New York/Wien' (any-')'){0,10}')'|'(Springer Publishers, Heidelberg' (any-')'){0,10}')'|'(Springer Ser. Nonlinear Dynamics, Springer' (any-')'){0,10}')'|'( Springer--Verlag' (any-')'){0,10}')'|'(Springer- Verlag' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Springer- Verlag' (any-')'){0,10}')'|'(Springer-Verlag ' (any-')'){0,10}')'|'(Springer-Verlag, 1966' (any-')'){0,10}')'|'(Springer-Verlag, 1968' (any-')'){0,10}')'|'(Springer Verlag 1993' (any-')'){0,10}')'|'(Springer Verlag, 1994' (any-')'){0,10}')'|'(Springer-Verlag, 2nd Ed.' (any-')'){0,10}')'|'(Springer-Verlag, 4th edition' (any-')'){0,10}')'|'(Springer-Verlag, ADDRESS' (any-')'){0,10}')'|'(Springer-Verlag, Berin' (any-')'){0,10}')'|'(Springer verlag, Berlin' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Springer verlag, Berlin' (any-')'){0,10}')'|'(Springer-verlag, Berlin' (any-')'){0,10}')'|'( Springer Verlag, Berlin' (any-')'){0,10}')'|'({Springer-Verlag, Berlin' (any-')'){0,10}')'|'(Springer - Verlag, Berlin' (any-')'){0,10}')'|'(Springer Verlag, Berlin ' (any-')'){0,10}')'|'(Springer- Verlag, Berlin' (any-')'){0,10}')'|'(Springer-Verlag Berlin' (any-')'){0,10}')'|'(Springer-Verlag; Berlin' (any-')'){0,10}')'|'(Springer-Verlag: Berlin, 1989' (any-')'){0,10}')'|'(Springer-Verlag, Berlin, 2nd edition' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Springer-Verlag, Berlin, 2nd edition' (any-')'){0,10}')'|'(Springer-Verlag, Berlin and Les Editions de Physique, Les Ulis' (any-')'){0,10}')'|'(Springer-Verlag, Berlin, heidelberg' (any-')'){0,10}')'|'(Springer Verlag, Berlin, Heidelberg' (any-')'){0,10}')'|'(Springer Verlag,Berlin Heidelberg' (any-')'){0,10}')'|'(Springer--Verlag, Berlin Heidelberg' (any-')'){0,10}')'|'(Springer--Verlag, Berlin, Heidelberg' (any-')'){0,10}')'|'(Springer-Verlag Berlin Heidelberg' (any-')'){0,10}')'|'(Springer-Verlag Berlin, Heidelberg' (any-')'){0,10}')'|'(Springer-Verlag; Berlin, Heidelberg' (any-')'){0,10}')'|'(Springer-Verlag,  Berlin-Heidelberg-New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Springer-Verlag,  Berlin-Heidelberg-New York' (any-')'){0,10}')'|'(Springer-Verlag, Berlin Heidelberg New York' (any-')'){0,10}')'|'(Springer-Verlag, Berlin, Heidelberg, New York, NY' (any-')'){0,10}')'|'(Springer-Verlag, Berlin, New York' (any-')'){0,10}')'|'(Springer Verlag, Bonn' (any-')'){0,10}')'|'(Springer-Verlage, Berlin' (any-')'){0,10}')'|'(Springer Verlag, EDP Sciences' (any-')'){0,10}')'|'(Springer--Verlag, Germany' (any-')'){0,10}')'|'(Springer Verlag, Heidelberg, New York' (any-')'){0,10}')'|'(Springer-Verlag, Heidelberg - New York' (any-')'){0,10}')'|'(Springer--Verlag, London' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Springer--Verlag, London' (any-')'){0,10}')'|'( Springer-Verlag, New York' (any-')'){0,10}')'|'(Springer-Verlag, New-York' (any-')'){0,10}')'|'(Springer Verlag, New York-Berlin' (any-')'){0,10}')'|'(Springer-Verlag, New York, Berlin' (any-')'){0,10}')'|'(Springer-Verlag, New York-Berlin' (any-')'){0,10}')'|'(Springer Verlag, New York-Berlin - Heidelberg - Tokyo' (any-')'){0,10}')'|'(Springer-Verlag, New York, Berlin, Heidelberg, Tokyo' (any-')'){0,10}')'|'(Springer-verlag, New York, Heidelberg, 1990' (any-')'){0,10}')'|'(Springer-Verlag, New York, Heidelberg,  1990' (any-')'){0,10}')'|'( Springer-Verlag, New York, Heidelberg, Berlin' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'( Springer-Verlag, New York, Heidelberg, Berlin' (any-')'){0,10}')'|'(Springer-Verlag New York, Inc.' (any-')'){0,10}')'|'(Springer-Verlag, New York, NY' (any-')'){0,10}')'|'(Springer-Verlag, New York, second edition' (any-')'){0,10}')'|'(Springer-Verlag, New York, Second Edition' (any-')'){0,10}')'|'(Springer-Verlag, New York, USA' (any-')'){0,10}')'|'(Springer Verlag, NY' (any-')'){0,10}')'|'(Springer-Verlag, NY' (any-')'){0,10}')'|'(Springer-Verlag, N.Y. etc.' (any-')'){0,10}')'|'(Springer-Verlag, Tokyo' (any-')'){0,10}')'|'(Springer--Verlag, Yew York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Springer--Verlag, Yew York' (any-')'){0,10}')'|'(Springer Verlang, Berlin' (any-')'){0,10}')'|'(Spring--Verlag, London' (any-')'){0,10}')'|'( Stanford California, July 26-August 6' (any-')'){0,10}')'|'(Stanford U.' (any-')'){0,10}')'|'(Stanford University report SU-ITP-93-13, gr-qc/9306035' (any-')'){0,10}')'|'(Stanford University report SU-ITP-93-1, hep-th/9301082' (any-')'){0,10}')'|'(Stichting Mathematisch Centrum, Amsterdam' (any-')'){0,10}')'|'(Stony Brook, NY' (any-')'){0,10}')'|'(St. Petersburg' (any-')'){0,10}')'|'(St.Petersburg State University' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(St.Petersburg State University' (any-')'){0,10}')'|'(St. Petersburg University Press, St. Petersburg' (any-')'){0,10}')'|'(St.-Petersburg University Press, St.-Petersburg' (any-')'){0,10}')'|'(S.-T. Yau' (any-')'){0,10}')'|'(summer school at Poiana Brasov' (any-')'){0,10}')'|'(SUNY Press, Albany' (any-')'){0,10}')'|'(Supringer, New York' (any-')'){0,10}')'|'(SUSSP Publications' (any-')'){0,10}')'|'(S. Yau' (any-')'){0,10}')'|'(Syracuse University, Syracuse' (any-')'){0,10}')'|'(Taiyuan, China' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Taiyuan, China' (any-')'){0,10}')'|'(Talk given at Cargese Summer School' (any-')'){0,10}')'|'(Talk given on the $XXX$ PNPI Winter School' (any-')'){0,10}')'|'(TASI Publications, Ann Arbor, Michigan' (any-')'){0,10}')'|'( Tata Institute Fundamental Research, India' (any-')'){0,10}')'|'(Tata McGraw-Hill, New-Delhi' (any-')'){0,10}')'|'(Taylor and Francis' (any-')'){0,10}')'|'(Taylor and Francis, London' (any-')'){0,10}')'|'(Technion, Haifa' (any-')'){0,10}')'|'(Techniques of physics' (any-')'){0,10}')'|'(Teor. i Mat. Fiz. {bf 50}' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Teor. i Mat. Fiz. {bf 50}' (any-')'){0,10}')'|'(Teor. i Mat. Fiz. {bf 94}' (any-')'){0,10}')'|'(Teor. Mat. Fiz. {bf 64}' (any-')'){0,10}')'|'(Teubner, Berlin' (any-')'){0,10}')'|'(Teubner, Stuttgart' (any-')'){0,10}')'|'(Texas A&M' (any-')'){0,10}')'|'(Texas AM Press' (any-')'){0,10}')'|'(Texas A&M University, College Station' (any-')'){0,10}')'|'(Texas A&M University, College Station, Texas' (any-')'){0,10}')'|'(Texas Univ. Press, Austin' (any-')'){0,10}')'|'(Texel Island' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Texel Island' (any-')'){0,10}')'|'(The 2-nd Wigner Symp., Goslar' (any-')'){0,10}')'|'(The American Mathematical Society' (any-')'){0,10}')'|'(The Australian National University' (any-')'){0,10}')'|'(The Benjamin/Cummings, Menlo Park, California' (any-')'){0,10}')'|'(The Benjamin/Cummings Publ. Co. Inc., Massachusets, USA' (any-')'){0,10}')'|'(The Benjamin/Cummings Publishing Company' (any-')'){0,10}')'|'(The Benjamin/Cummings Publishing, Reading' (any-')'){0,10}')'|'(The Benjamin/Cummings, Reading, MA' (any-')'){0,10}')'|'(The Clarendon Press, Oxford' (any-')'){0,10}')'|'(The Institute of Physics Publishing, Bristol' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(The Institute of Physics Publishing, Bristol' (any-')'){0,10}')'|'(The Macmillan Company, New York' (any-')'){0,10}')'|'(The MIT press, Cambridge' (any-')'){0,10}')'|'(The MIT Press, Cambridge, Massachusetts' (any-')'){0,10}')'|'(the Niels Bohr Institute' (any-')'){0,10}')'|'(The Niels Bohr Institute' (any-')'){0,10}')'|'(Theor. and Math Fiz. {bf 92}' (any-')'){0,10}')'|'(Theor. and Math. Fiz. {bf 92}' (any-')'){0,10}')'|'(Theoretical Physics Seminar in Trondheim, No. 13' (any-')'){0,10}')'|'(Theor. Math. Phys. {bf 86}' (any-')'){0,10}')'|'(Theor. Phys. Dept.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Theor. Phys. Dept.' (any-')'){0,10}')'|'(thesis, Leiden' (any-')'){0,10}')'|'(The University of Chicago Press, Chicago and London' (any-')'){0,10}')'|'(The University of Chicago Press, Chicago, IL' (any-')'){0,10}')'|'(The University Press of Virginia' (any-')'){0,10}')'|'(The Univ. of Chicago Press' (any-')'){0,10}')'|'(The Unviersity Press of Virginia Charlottesville' (any-')'){0,10}')'|'(third edition' (any-')'){0,10}')'|'(third edition, Springer, Berlin' (any-')'){0,10}')'|'(Th.~M. Rassias' (any-')'){0,10}')'|'(tilde d' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(tilde d' (any-')'){0,10}')'|'({tilde d}' (any-')'){0,10}')'|'(Timisoara, Romania' (any-')'){0,10}')'|'(Tirrenia, Pisa' (any-')'){0,10}')'|'(to appear' (any-')'){0,10}')'|'(to appear in a special issue of``Chaos' (any-')'){0,10}')'|'(to appear in Comm.,Math.|(to appear in {em Theor. Math. Phys.}' (any-')'){0,10}')'|'(to appear in J. Math. Phys.' (any-')'){0,10}')'|'(to appear in J.,Op.|(to appear in Nucl.Phys. B' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(to appear in Nucl.Phys. B' (any-')'){0,10}')'|'(to appear in Phys. Rev. {bf A}' (any-')'){0,10}')'|'(to appear in the Proceedings' (any-')'){0,10}')'|'(to appear in the Proceedings of the II LASSF, Caracas' (any-')'){0,10}')'|'(to appear on Phys. Rev. D' (any-')'){0,10}')'|'(to be published by World Scientific' (any-')'){0,10}')'|'(to be published from AMS/CMI' (any-')'){0,10}')'|'(to be published in Found.Phys.' (any-')'){0,10}')'|'(Tohoku univ.' (any-')'){0,10}')'|'(Tohoku University' (any-')'){0,10}')'|'(Tohoku University, Japan' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Tohoku University, Japan' (any-')'){0,10}')'|'(Tohoku University report TU/93/440, hep-th/9307181' (any-')'){0,10}')'|'(Tokyo Institute of Technology' (any-')'){0,10}')'|'(Tokyo, Iwanami Shoten' (any-')'){0,10}')'|'(Tokyo University report, hep-th/9302101' (any-')'){0,10}')'|'(Toronto, ON' (any-')'){0,10}')'|'(Toronto University Press' (any-')'){0,10}')'|'(Trans. Am. Math. Soc., Ser. 2' (any-')'){0,10}')'|'(translated by A.~D.~King' (any-')'){0,10}')'|'(translated by Earle Raymond Hedrick' (any-')'){0,10}')'|'(translation from Izv. Vyssh. Uchebn. Zaved.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(translation from Izv. Vyssh. Uchebn. Zaved.' (any-')'){0,10}')'|'(Translations of Mathematical Monographs, Vol. 40 AMS' (any-')'){0,10}')'|'(transl.: JEPT Lett. {bf 12}' (any-')'){0,10}')'|'(transl. : Leningrad Math. J. {bf 1}' (any-')'){0,10}')'|'(transl. : Sov. J. Nucl. Phys. {bf 43}' (any-')'){0,10}')'|'(Trieste, July' (any-')'){0,10}')'|'(Trieste Seminar' (any-')'){0,10}')'|'(T.R. Taylor' (any-')'){0,10}')'|'(Tsukuba, Japan' (any-')'){0,10}')'|'({tt Hypergeometric1F1[a,b' (any-')'){0,10}')'|'(TU Darmstadt' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(TU Darmstadt' (any-')'){0,10}')'|'(TUM--TH--123/91 ' (any-')'){0,10}')'|'(TUM--TH 125/91' (any-')'){0,10}')'|'(Turin University' (any-')'){0,10}')'|'(Turku, Finland' (any-')'){0,10}')'|'(U. Jannsen, S. Kleiman, J.-P.  Serre' (any-')'){0,10}')'|'(UNAM Press; Mexico City' (any-')'){0,10}')'|'(UNESCO, St. Petersburg U., Euro-Asian Physical Society' (any-')'){0,10}')'|'(Ungar, New York' (any-')'){0,10}')'|'(Univ. Acad. Press' (any-')'){0,10}')'|'(Univ. Chicago, Chicago' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Univ. Chicago, Chicago' (any-')'){0,10}')'|'(Univ. di Como, Como, Italy' (any-')'){0,10}')'|'(Universal Academy Press' (any-')'){0,10}')'|'(Universal Academy Press, Tokyo' (any-')'){0,10}')'|'(Universit`a Statale di Catania; Catania' (any-')'){0,10}')'|'(Universit"at Bonn' (any-')'){0,10}')'|'(Universit"at Hamburg' (any-')'){0,10}')'|'(University Lecture Series' (any-')'){0,10}')'|'(University of Arizona preprint' (any-')'){0,10}')'|'(University of California Press, Berkely' (any-')'){0,10}')'|'(University of Cambridge report, hep-th/9304084' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(University of Cambridge report, hep-th/9304084' (any-')'){0,10}')'|'(University of Chicago' (any-')'){0,10}')'|'(University of Chicago, Chicago' (any-')'){0,10}')'|'(University of ChicagoPress' (any-')'){0,10}')'|'(University of Chicago Press, USA' (any-')'){0,10}')'|'(University of Chicago report EFI 93-42, gr-qc/9307038' (any-')'){0,10}')'|'(University of Illinois Press, Urbana' (any-')'){0,10}')'|'(University of Leuven Press' (any-')'){0,10}')'|'(University of Manitoba, Winnipeg' (any-')'){0,10}')'|'(University of Paris-Sud, Orsay' (any-')'){0,10}')'|'(University of Priv stina' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(University of Priv stina' (any-')'){0,10}')'|'(University of Texas at Austin' (any-')'){0,10}')'|'(University of Texas report UTTG-22-93, hep-th/9307143' (any-')'){0,10}')'|'( University of Tokio Press, Tokio, Springer, Berlin' (any-')'){0,10}')'|'(University of Tokyo Press, Tokyo' (any-')'){0,10}')'|'(University of Tokyo Press, Tokyo, Springer' (any-')'){0,10}')'|'(University of Tokyo Press, Tokyo, Springer, Berlin' (any-')'){0,10}')'|'(University of Tokyo Press,Tokyo;Springer,Berlin' (any-')'){0,10}')'|'(University of Tokyo, Tokyo' (any-')'){0,10}')'|'(University of Udmurtia, Izhevsk' (any-')'){0,10}')'|'(University of Utah report' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(University of Utah report' (any-')'){0,10}')'|'(University of Utrecht' (any-')'){0,10}')'|'(University of Washington' (any-')'){0,10}')'|'(University of Washington Press' (any-')'){0,10}')'|'(University of Waterloo, Waterloo' (any-')'){0,10}')'|'(University of Wisconsin Press, Madison' (any-')'){0,10}')'|'(University Press, Cambridge, UK' (any-')'){0,10}')'|'(University Press, Chicago' (any-')'){0,10}')'|'(University Press of Tokyo' (any-')'){0,10}')'|'(University Press, Oxford' (any-')'){0,10}')'|'(University Press, Princeton, NJ' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(University Press, Princeton, NJ' (any-')'){0,10}')'|'(University Publ. House' (any-')'){0,10}')'|'(University Publ.House' (any-')'){0,10}')'|'(University Publ.House, Moscow' (any-')'){0,10}')'|'(University Science Books, Mill Valley' (any-')'){0,10}')'|'(Univers. of Tokyo Press, Springer-Verlag, Berlin' (any-')'){0,10}')'|'(Univ. Laval' (any-')'){0,10}')'|'(Univ. Montreal' (any-')'){0,10}')'|'(Univ. of California Press, Berkeley' (any-')'){0,10}')'|'(Univ. of Chicago Press, Chicago' (any-')'){0,10}')'|'(Univ. of Colorado Press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Univ. of Colorado Press' (any-')'){0,10}')'|'(Univ. of North Carolina' (any-')'){0,10}')'|'(Univ. of Texas Press' (any-')'){0,10}')'|'(Univ. of Tokyo Press, Tokyo' (any-')'){0,10}')'|'(Univ. of Toronto Press' (any-')'){0,10}')'|'(Univ. of Twente' (any-')'){0,10}')'|'(Univ. of Utrecht' (any-')'){0,10}')'|'(Univ. Toronto Press' (any-')'){0,10}')'|'(unpublished, file moment3.tex' (any-')'){0,10}')'|'(unpublished, Hannover' (any-')'){0,10}')'|'(unpublished notes' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(unpublished notes' (any-')'){0,10}')'|'(Unpublished notes' (any-')'){0,10}')'|'(Unpublished Notes' (any-')'){0,10}')'|'(unpublished Ph.D. thesis, University of Guelph' (any-')'){0,10}')'|'(Un. Twente' (any-')'){0,10}')'|'(U. of Chicago Press' (any-')'){0,10}')'|'(URSS Publ., Moscow' (any-')'){0,10}')'|'(U.S. Government Printing Office, Washington' (any-')'){0,10}')'|'(U.S. Government Printing Office, Washington, D.C.' (any-')'){0,10}')'|'(U. S. GPO, Washington, D.C.' (any-')'){0,10}')'|'(US National Bureau of Standards, Washington' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(US National Bureau of Standards, Washington' (any-')'){0,10}')'|'(Uspekhi Math. Nauk. {bf 31}:4' (any-')'){0,10}')'|'(U. Sussex' (any-')'){0,10}')'|'(UWO/NUIG report, 2002' (any-')'){0,10}')'|'(UWP/UM report, 2002' (any-')'){0,10}')'|'(Van Nostrand Co., New York' (any-')'){0,10}')'|'(van Nostrand, London' (any-')'){0,10}')'|'(Van Nostrand, London' (any-')'){0,10}')'|'(Van Nostrand Reinhold Company' (any-')'){0,10}')'|'(Van Nostrand Reinhold Company, London' (any-')'){0,10}')'|'(V. Arnold' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(V. Arnold' (any-')'){0,10}')'|'(V. Bargmann' (any-')'){0,10}')'|'(VCH, New York' (any-')'){0,10}')'|'(VCH Press, New York' (any-')'){0,10}')'|'(VCH, Weinheim' (any-')'){0,10}')'|'(V. Dietrich, K. Habetha' (any-')'){0,10}')'|'(vec r|(Verlag Harri Deutsch, Frankfurt' (any-')'){0,10}')'|'(Verlag von Julius Springer, Berlin' (any-')'){0,10}')'|'(version 3 of 20th of June' (any-')'){0,10}')'|'(Vestn. Mosk. Univ.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Vestn. Mosk. Univ.' (any-')'){0,10}')'|'(V. G. Kac' (any-')'){0,10}')'|'(V.I. Arnold' (any-')'){0,10}')'|'(Vienna, Austria' (any-')'){0,10}')'|'(Vieweg: Braunschweig' (any-')'){0,10}')'|'(Viking, New York' (any-')'){0,10}')'|'(VINITI, Moscow' (any-')'){0,10}')'|'(Vintage, London' (any-')'){0,10}')'|'(V.  Kav c' (any-')'){0,10}')'|'(Vladivostok, Russia' (any-')'){0,10}')'|'(vol. 1' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(vol. 1' (any-')'){0,10}')'|'(Vol.I, Academic Press' (any-')'){0,10}')'|'(vols. 1' (any-')'){0,10}')'|'(vols. I' (any-')'){0,10}')'|'(VSP Int. Science Publ.' (any-')'){0,10}')'|'(Vyshcha Shkola, Kiev' (any-')'){0,10}')'|'(W A Benjamin' (any-')'){0,10}')'|'(W. A. Benjamin' (any-')'){0,10}')'|'(W. A. Benjamin' (any-')'){0,10}')'|'(W. A. Benjamin Inc.' (any-')'){0,10}')'|'(W.~A. Benjamin, Inc.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(W.~A. Benjamin, Inc.' (any-')'){0,10}')'|'(W.A.Benjamin Inc., Massachusetts' (any-')'){0,10}')'|'(W.A.Benjamin, Inc., Massachusetts' (any-')'){0,10}')'|'(W. A. Benjamin Inc., New York' (any-')'){0,10}')'|'(W.A. Benjamin Inc., New York' (any-')'){0,10}')'|'(W.A.~Benjamin Inc., New York' (any-')'){0,10}')'|'(W.A.Benjamin Inc., New York' (any-')'){0,10}')'|'(W. A. Benjamin, Inc., New York-Amsterdam' (any-')'){0,10}')'|'(W.A.Benjamin Inc. New York-Amsterdam' (any-')'){0,10}')'|'(W. A. Benjamin Inc., Reading, Mass.' (any-')'){0,10}')'|'(W. A. Benjamin, Inc., Reading, Mass.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(W. A. Benjamin, Inc., Reading, Mass.' (any-')'){0,10}')'|'(W.A. Benjamin, N.Y.' (any-')'){0,10}')'|'(W.~A.~Benjamin Publ., NY' (any-')'){0,10}')'|'(W.A. Benjamin, Reading, MA' (any-')'){0,10}')'|'(W.A. Benjamin, Reading, Massachusetts' (any-')'){0,10}')'|'(Walter de Grutyer, Berlin' (any-')'){0,10}')'|'(Walter de Gruyter, Berlin' (any-')'){0,10}')'|'(Warsaw U.' (any-')'){0,10}')'|'( Warszawa' (any-')'){0,10}')'|'(Washington, D.C.: US GPO, Dover' (any-')'){0,10}')'|'(W. Barth, K. Hulek and H. Lange' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(W. Barth, K. Hulek and H. Lange' (any-')'){0,10}')'|'(W. B. Saunders Co., Philadelphia, PA' (any-')'){0,10}')'|'(W. de Gruyter, Berlin' (any-')'){0,10}')'|'(Weidenfeld and Nicolson and Basic Books, London and New York' (any-')'){0,10}')'|'(Wesley, Massachusetts' (any-')'){0,10}')'|'(Western Periodicals Co.' (any-')'){0,10}')'|'(Westview Press, Boulder' (any-')'){0,10}')'|'(where the $SO(1' (any-')'){0,10}')'|'(W. H. Freeman and company' (any-')'){0,10}')'|'(W.H. Freeman and Company' (any-')'){0,10}')'|'(W. H. Freeman and Company, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(W. H. Freeman and Company, New York' (any-')'){0,10}')'|'(W.~H.~Freeman and Company, New York' (any-')'){0,10}')'|'(W.H. Freeman and Company, New York' (any-')'){0,10}')'|'(W. H. Freeman and Company, San Francisco' (any-')'){0,10}')'|'(W.H. Freeman and Company, San Francisco' (any-')'){0,10}')'|'(W.H. Freeman and Co., New York, NY' (any-')'){0,10}')'|'(W. H. Freeman and Co., San Francisco' (any-')'){0,10}')'|'(W.H. Freeman and Co., San Francisco' (any-')'){0,10}')'|'(W.H.Freeman & Company' (any-')'){0,10}')'|'(W.H. Freeman Co., San Francisco' (any-')'){0,10}')'|'(W. H. Freeman, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(W. H. Freeman, New York' (any-')'){0,10}')'|'(W. H. Freeman, San Francisco' (any-')'){0,10}')'|'(W.H.~Freeman, San Francisco' (any-')'){0,10}')'|'( Wiley' (any-')'){0,10}')'|'(Wiley and Sons, New York' (any-')'){0,10}')'|'(Wiley Eastern' (any-')'){0,10}')'|'(Wiley Eastern Ltd.' (any-')'){0,10}')'|'(Wiley Eastern Ltd., New Delhi' (any-')'){0,10}')'|'(Wiley Eastren Ltd., New Delhi' (any-')'){0,10}')'|'(Wiley-Interscience, John Wiley & Sons, New York' (any-')'){0,10}')'|'(Wiley--Interscience, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Wiley--Interscience, New York' (any-')'){0,10}')'|'(Wiley~-Interscience, New~York' (any-')'){0,10}')'|'(Wiley-Interscience Publ.' (any-')'){0,10}')'|'(Wiley-Interscience Publication' (any-')'){0,10}')'|'(Wiley, London ' (any-')'){0,10}')'|'(}Wiley, New York' (any-')'){0,10}')'|'(Wiley, NewYork' (any-')'){0,10}')'|'( Wiley, New Yorl' (any-')'){0,10}')'|'(Wiley, N-Y' (any-')'){0,10}')'|'(Wiley & Sons, New York' (any-')'){0,10}')'|'(WILEY-VCH Verlag, Berlin' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(WILEY-VCH Verlag, Berlin' (any-')'){0,10}')'|'(Wiley-VCH, Weinheim' (any-')'){0,10}')'|'(Wilmington, DE, Publish or Perish' (any-')'){0,10}')'|'(Wissenschaftsverlag, Mannheim, Wien, Z"{u}rich' (any-')'){0,10}')'|'(W.M. Freedman' (any-')'){0,10}')'|'(W.M. Freeman' (any-')'){0,10}')'|'(W.M. Freeman, San Francisco' (any-')'){0,10}')'|'(Wold Scientific, Singapore' (any-')'){0,10}')'|'(Wolfram Media---Cambridge University Press' (any-')'){0,10}')'|'(Wolfram Media/Cambridge University Press' (any-')'){0,10}')'|'(Wolfram Research, Inc., Champaign' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Wolfram Research, Inc., Champaign' (any-')'){0,10}')'|'(Word Scientific' (any-')'){0,10}')'|'(Word Scientific Publishing Company, Singapore' (any-')'){0,10}')'|'(Word Scientific, Singapore' (any-')'){0,10}')'|'(Word Sientific, Singapore' (any-')'){0,10}')'|'(World Publishing' (any-')'){0,10}')'|'(World Sc ' (any-')'){0,10}')'|'(World Sci' (any-')'){0,10}')'|'(World Scientfic' (any-')'){0,10}')'|'(World Scientifc' (any-')'){0,10}')'|'(World Scientifc, Singapore' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(World Scientifc, Singapore' (any-')'){0,10}')'|'(world scientific' (any-')'){0,10}')'|'(}World Scientific' (any-')'){0,10}')'|'(World Scientific ' (any-')'){0,10}')'|'(World Scientific,1991' (any-')'){0,10}')'|'(World Scientific, 1995' (any-')'){0,10}')'|'(World Scientific, 1996' (any-')'){0,10}')'|'(World Scientific, Berlin' (any-')'){0,10}')'|'(World Scientific Co.' (any-')'){0,10}')'|'(World Scientific Co. 1988' (any-')'){0,10}')'|'(World Scientific Co. 1990' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(World Scientific Co. 1990' (any-')'){0,10}')'|'(World Scientific Co., 1996' (any-')'){0,10}')'|'(World Scientific Co. Singapore' (any-')'){0,10}')'|'(World Scientific,ingapore' (any-')'){0,10}')'|'(World Scientific, London' (any-')'){0,10}')'|'(World Scientific, London and Singapore' (any-')'){0,10}')'|'(World Scientific, London-New York-Singapore' (any-')'){0,10}')'|'(World Scientific, New Jersey' (any-')'){0,10}')'|'(World Scientific, New York' (any-')'){0,10}')'|'(World Scientific, NY' (any-')'){0,10}')'|'(World Scientific P.C.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(World Scientific P.C.' (any-')'){0,10}')'|'(World Scientific Press' (any-')'){0,10}')'|'(World Scientific Press, Singapore' (any-')'){0,10}')'|'(World Scientific Pub.' (any-')'){0,10}')'|'(World Scientific Pub Co.' (any-')'){0,10}')'|'(World Scientific Pub. Co.,  Singapore' (any-')'){0,10}')'|'(World Scientific Publ.' (any-')'){0,10}')'|'(World Scientific Publ. Co., Signapore' (any-')'){0,10}')'|'(World Scientific, Publ. Co., Singapore' (any-')'){0,10}')'|'(World Scientific Publication Co. Singapore' (any-')'){0,10}')'|'( World Scientific Publishing Co.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'( World Scientific Publishing Co.' (any-')'){0,10}')'|'(World Scientific Publishing Co., Aachen, 1992' (any-')'){0,10}')'|'(World Scientific Publishing Co. Pte.Ltd., London' (any-')'){0,10}')'|'(World Scientific Publishing Co. Sinapore' (any-')'){0,10}')'|'(World Scientific Publ., Singapore' (any-')'){0,10}')'|'(World Scientific Pub., Singapore' (any-')'){0,10}')'|'(World Scientific, River Edge' (any-')'){0,10}')'|'(World Scientific, River Edge, N.J.' (any-')'){0,10}')'|'(World Scientifics' (any-')'){0,10}')'|'(World Scientific, Singapor' (any-')'){0,10}')'|'(World Scientific, singapore' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(World Scientific, singapore' (any-')'){0,10}')'|'( World Scientific, Singapore ' (any-')'){0,10}')'|'(World Scientific Singapore' (any-')'){0,10}')'|'(World Scientific, Singa-pore' (any-')'){0,10}')'|'(World Scientific., Singapore' (any-')'){0,10}')'|'(World~Scientific, Singapore' (any-')'){0,10}')'|'(World Scientific, Singapore, 1986' (any-')'){0,10}')'|'(World Scientific, Singapore, 1987' (any-')'){0,10}')'|'(World Scientific, Singapore, 1991' (any-')'){0,10}')'|'(World Scientific, Singapore, 2000' (any-')'){0,10}')'|'(World Scientific, Singapore, New Jersey, Hong Kong' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(World Scientific, Singapore, New Jersey, Hong Kong' (any-')'){0,10}')'|'(World Scientific, Singapore, second revised edition' (any-')'){0,10}')'|'( World Scientific, Singapure' (any-')'){0,10}')'|'(World Scientific, Singapure, 187' (any-')'){0,10}')'|'(World Scientific, Singapure, New Jersey, London' (any-')'){0,10}')'|'(World Scientific, Singpore' (any-')'){0,10}')'|'(World Scientifmbox{}ic, New Jersey' (any-')'){0,10}')'|'(World Scientifuc, Singapore' (any-')'){0,10}')'|'(World Scient. Singapore' (any-')'){0,10}')'|'(World Scient.; Singapore' (any-')'){0,10}')'|'(World Scietific, Singapore' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(World Scietific, Singapore' (any-')'){0,10}')'|'(World Scintific, Singapore' (any-')'){0,10}')'|'(World Sci., Philadelphia' (any-')'){0,10}')'|'(World Sci. Publ. Co, Singapore' (any-')'){0,10}')'|'(World Sci. Publishing, River Edge, NJ' (any-')'){0,10}')'|'(World Sci. Pub., Singapore' (any-')'){0,10}')'|'(World-Sci., Singapore' (any-')'){0,10}')'|'(World Sci., Singapoure' (any-')'){0,10}')'|'(World Sc. Publ. Co.' (any-')'){0,10}')'|'(World Sc.  Publ. Co., Singapore' (any-')'){0,10}')'|'(World Sc. Publ.  Co., Singapore' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(World Sc. Publ.  Co., Singapore' (any-')'){0,10}')'|'(World Sc. Publ. Co., Singapore' (any-')'){0,10}')'|'(World Sc., Singapore' (any-')'){0,10}')'|'(World Sientific' (any-')'){0,10}')'|'(World Sientific, Singapore' (any-')'){0,10}')'|'(Worlds Scientific, Singapore' (any-')'){0,10}')'|'(Worlk Scientific' (any-')'){0,10}')'|'(Worl Scientific, Singapore' (any-')'){0,10}')'|'(Worls Scientific, Singapore' (any-')'){0,10}')'|'(Wourld Sci., Singapure' (any-')'){0,10}')'|'( Wroclav' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'( Wroclav' (any-')'){0,10}')'|'(W. R"uhl' (any-')'){0,10}')'|'(WSPC, Singapore' (any-')'){0,10}')'|'(W.S., Singapore' (any-')'){0,10}')'|'(WUW; Wroclaw' (any-')'){0,10}')'|'(W.W. Norton and Co.' (any-')'){0,10}')'|'(~(w, x' (any-')'){0,10}')'|'(x_{1}, x_{2}' (any-')'){0,10}')'|'(x_1, x_2, cdots' (any-')'){0,10}')'|'(x+la w, x+la w' (any-')'){0,10}')'|'(XXXth Rencontre de Moriand' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(XXXth Rencontre de Moriand' (any-')'){0,10}')'|'(Yad. Fiz., 50' (any-')'){0,10}')'|'(Yale University Press' (any-')'){0,10}')'|'( Yale University Press, New Haven' (any-')'){0,10}')'|'(Yale University Press, New~Haven' (any-')'){0,10}')'|'(Yale University Press, New Haven, CT' (any-')'){0,10}')'|'(Yale Univ. Press' (any-')'){0,10}')'|'(Yale Univ. Press, New Haven, Conn.' (any-')'){0,10}')'|'(Yale U. P., New Haven' (any-')'){0,10}')'|'(Ya. S. Derbenev and A. M. Kondratenko, Zh. Eksp. Teor. Fiz. 64' (any-')'){0,10}')'|'(Yeschiva University' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Yeschiva University' (any-')'){0,10}')'|'(Yeshiva, New York' (any-')'){0,10}')'|'(Yeshiva Press, New York' (any-')'){0,10}')'|'(Yeshiva Univ.' (any-')'){0,10}')'|'( Yeshiva University' (any-')'){0,10}')'|'(Yeshiva University, Academic Press, New York' (any-')'){0,10}')'|'(Yeshiva University,\ New York ' (any-')'){0,10}')'|'(Yeshiva University, New York, N.Y.' (any-')'){0,10}')'|'(Yeshiva University, N.Y.' (any-')'){0,10}')'|'(Yeshiva University, NY' (any-')'){0,10}')'|'( Yeshiva Univ., NY ' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'( Yeshiva Univ., NY ' (any-')'){0,10}')'|'(Yeshiva Univ., NY' (any-')'){0,10}')'|'(Yeshiva Univ. Press, New York' (any-')'){0,10}')'|'(Yeshiva Univ. Press, New York' (any-')'){0,10}')'|'(Yeshive University, New York' (any-')'){0,10}')'|'(Yeshive University Press, New York' (any-')'){0,10}')'|'(Yesiva University Press' (any-')'){0,10}')'|'(Y.X. Gui, F.C. Khanna, Z.B. Su' (any-')'){0,10}')'|'(Zacatecas, Mexico' (any-')'){0,10}')'|'(Zakopane, Poland' (any-')'){0,10}')'|'(Zentrum H"ohere Studien, Leipzig' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Zentrum H"ohere Studien, Leipzig' (any-')'){0,10}')'|'(Z{" u}rich' (any-')'){0,10}')'|'(Academia Nazionale dei Lincei, Rome' (any-')'){0,10}')'|'(Academic, Boston' (any-')'){0,10}')'|'(Academic press' (any-')'){0,10}')'|'( Academic Press' (any-')'){0,10}')'|'(Academic Press, London, New York' (any-')'){0,10}')'|'(Academic Press,  New York' (any-')'){0,10}')'|'(Academic Press, New--York' (any-')'){0,10}')'|'(Academic Press, New-York' (any-')'){0,10}')'|'( Academic Press, New York and London' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'( Academic Press, New York and London' (any-')'){0,10}')'|'(Academic Press, New York, NY' (any-')'){0,10}')'|'(Academic Press, N.Y.' (any-')'){0,10}')'|'(Academic Press,N.Y.' (any-')'){0,10}')'|'(Academic Press, Orlando' (any-')'){0,10}')'|'(Acad. Press' (any-')'){0,10}')'|'(Adam Hilger, Bristol and New York' (any-')'){0,10}')'|'(Adam Hilger, Bristol, UK' (any-')'){0,10}')'|'(Addison-Wesley, London' (any-')'){0,10}')'|'(Addison-Wesley, Mass.' (any-')'){0,10}')'|'(Addison-Wesley Pub. Co.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Addison-Wesley Pub. Co.' (any-')'){0,10}')'|'( Addison-Wesley Publishing Company' (any-')'){0,10}')'|'(Addison-Wesley, Readings, MA' (any-')'){0,10}')'|'(Addison-Wesley, Redwood City, California' (any-')'){0,10}')'|'(A. Hilger, Bristol' (any-')'){0,10}')'|'(AIP Press, New York' (any-')'){0,10}')'|'(Allyn and Bacon, Boston' (any-')'){0,10}')'|'(American Institute of Physics, New York' (any-')'){0,10}')'|'(American Mathematical Society, Providence RI, USA' (any-')'){0,10}')'|'(Amer. Math. Soc., Providence, RI' (any-')'){0,10}')'|'(Amer. Math. Soc., Providence, RI' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Amer. Math. Soc., Providence, RI' (any-')'){0,10}')'|'(Am. Inst. Phys.' (any-')'){0,10}')'|'(Am. Math. Soc., Providence' (any-')'){0,10}')'|'(AMS, Berkeley' (any-')'){0,10}')'|'(AMS, Providence, Rhode Island' (any-')'){0,10}')'|'(AMS, Providence, RI' (any-')'){0,10}')'|'(Apeiron, Montreal' (any-')'){0,10}')'|'(Belfer graduate School, Yeshiba University Press, New York' (any-')'){0,10}')'|'(Benjamin - Cummings' (any-')'){0,10}')'|'(Benjamin-Cummings, Menlo Park' (any-')'){0,10}')'|'(Benjamin/Cummings Publishing Co.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Benjamin/Cummings Publishing Co.' (any-')'){0,10}')'|'(Benjamin-Cummings, Reading' (any-')'){0,10}')'|'(Benjamin-Cummings, Reading, MA' (any-')'){0,10}')'|'(Benjamin/Cummings, Reading, MA' (any-')'){0,10}')'|'(Benjamin/Cummings, Reading, Massachusetts' (any-')'){0,10}')'|'(Benjamin/Cunnings, Reading, MA' (any-')'){0,10}')'|'(Berkeley preprint' (any-')'){0,10}')'|'(Berlin: Springer-Verlag' (any-')'){0,10}')'|'(Bibliopolis, Naples' (any-')'){0,10}')'|'(Birkh"{a}user, Berlin' (any-')'){0,10}')'|'(Birkh"auser,  Boston' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Birkh"auser,  Boston' (any-')'){0,10}')'|'(Birkh"auser Verlag' (any-')'){0,10}')'|'(Birkhauser Verlag' (any-')'){0,10}')'|'(Butterworth-Heinemann, Oxford' (any-')'){0,10}')'|'(Calimanesti, Romania' (any-')'){0,10}')'|'(Cambridge, Cambridge' (any-')'){0,10}')'|'(Cambridge, London' (any-')'){0,10}')'|'(Cambridge, MA' (any-')'){0,10}')'|'(Cambridge Univ., Cambridge' (any-')'){0,10}')'|'(Cambridge university press' (any-')'){0,10}')'|'(Cambridge, University Press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Cambridge, University Press' (any-')'){0,10}')'|'(Cambridge University  Press, Cambridge' (any-')'){0,10}')'|'( Cambridge University Press, Cambridge, England' (any-')'){0,10}')'|'(Cambridge Univ. Press, Cambridge, England' (any-')'){0,10}')'|'(Cambridge Univ. Press, London' (any-')'){0,10}')'|'(Cambridge UP, Cambridge' (any-')'){0,10}')'|'(Cambridge U. P., Cambridge UK' (any-')'){0,10}')'|'(Cambridge  U. Press' (any-')'){0,10}')'|'(Cambridge U.~Press, Cambridge' (any-')'){0,10}')'|'(Cambr. Univ. Press' (any-')'){0,10}')'|'(Cargese, France' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Cargese, France' (any-')'){0,10}')'|'(Chelsea Publishing Company' (any-')'){0,10}')'|'(Chicago Univ. Press, Chicago' (any-')'){0,10}')'|'(Claredon, Oxford' (any-')'){0,10}')'|'(Clarendon Press, Oxford, UK' (any-')'){0,10}')'|'(Columbia University Press, New York' (any-')'){0,10}')'|'(Consultants Bureau, New York' (any-')'){0,10}')'|'(Contemporary concepts in physics' (any-')'){0,10}')'|'(Contemporary Concepts in Physics' (any-')'){0,10}')'|'(CRC, Boca Raton, FL' (any-')'){0,10}')'|'(de Gruyter' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(de Gruyter' (any-')'){0,10}')'|'(Diffusion C.C.L.S.' (any-')'){0,10}')'|'(Dordrecht, Kluwer Academic' (any-')'){0,10}')'|'(Dordrecht: Reidel' (any-')'){0,10}')'|'(Dover publications' (any-')'){0,10}')'|'(D. Reidel Publishing Company' (any-')'){0,10}')'|'(D. Reidel Publishing Company, Dordrecht' (any-')'){0,10}')'|'(Editions Frontieres' (any-')'){0,10}')'|'(Editions Mir' (any-')'){0,10}')'|'(Editorice Compositori, Bologna' (any-')'){0,10}')'|'(Editrice Compositori, Bologna' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Editrice Compositori, Bologna' (any-')'){0,10}')'|'(Ellis Horwood, Chichester' (any-')'){0,10}')'|'(Elsevier, New York' (any-')'){0,10}')'|'(English translation: {it Amer. Math. Soc. Trans. Series 2}, {bf 6}' (any-')'){0,10}')'|'(Freeman and Co, New York' (any-')'){0,10}')'|'(Freeman, New York' (any-')'){0,10}')'|'(Freeman, Sanfrancisco' (any-')'){0,10}')'|'(Freie Universit"{a}t Berlin' (any-')'){0,10}')'|'(Friedmann Laboratory Publishing, St. Petersburg' (any-')'){0,10}')'|'(Frontiers in Physics' (any-')'){0,10}')'|'(GIFML, Moskva' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(GIFML, Moskva' (any-')'){0,10}')'|'(Gordan and Breach, New York' (any-')'){0,10}')'|'(Gordon and Breach, N.Y.' (any-')'){0,10}')'|'(Gordon and Breach Science Publishers' (any-')'){0,10}')'|'(Gordon Breach' (any-')'){0,10}')'|'(Gostehizdat, Moscow' (any-')'){0,10}')'|'(Graduate Texts in Mathematics' (any-')'){0,10}')'|'(Hadronic Press' (any-')'){0,10}')'|'(Hadronic Press, Palm Harbor' (any-')'){0,10}')'|'(Harper & Row' (any-')'){0,10}')'|'(Harwood Academic, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Harwood Academic, New York' (any-')'){0,10}')'|'(Harwood Academic Publishers, New York' (any-')'){0,10}')'|'(Harwood, New York, NY' (any-')'){0,10}')'|'(IHEP, Protvino' (any-')'){0,10}')'|'(INFN, Frascati' (any-')'){0,10}')'|'(in Russian' (any-')'){0,10}')'|'(InterEditions, Paris' (any-')'){0,10}')'|'(Interscience Publ.' (any-')'){0,10}')'|'(Interscience Publishers' (any-')'){0,10}')'|'(IOP, Bristol and Philadelphia' (any-')'){0,10}')'|'(Iwanami, Tokyo' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Iwanami, Tokyo' (any-')'){0,10}')'|'(John Wiley $&$ Sons' (any-')'){0,10}')'|'(John Wiley & Sons, Inc.' (any-')'){0,10}')'|'(John Wiley & Sons, Inc., New York' (any-')'){0,10}')'|'(John Wiley & Sons,  New York' (any-')'){0,10}')'|'(KEK, Tsukuba' (any-')'){0,10}')'|'(Kluwer Academic, Dordrecht' (any-')'){0,10}')'|'(Kluwer Academic Publ., Dordrecht' (any-')'){0,10}')'|'(Kluwer Acad. Pub.' (any-')'){0,10}')'|'(Kluwer Acad. Publ., Dordrecht' (any-')'){0,10}')'|'(Kluwer, Boston' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Kluwer, Boston' (any-')'){0,10}')'|'(Kyoto Univ.' (any-')'){0,10}')'|'(London: Pergaman' (any-')'){0,10}')'|'(MacGraw-Hill, New York' (any-')'){0,10}')'|'(M.A. Shifman' (any-')'){0,10}')'|'(McGraw Hill' (any-')'){0,10}')'|'(McGraw-Hill Book Co., New York' (any-')'){0,10}')'|'(McGraw-Hill, NewYork' (any-')'){0,10}')'|'(Mc Graw-Hill, NY' (any-')'){0,10}')'|'(McGraw-Hill, N.Y.' (any-')'){0,10}')'|'(McGraw-Hill, San Francisco' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(McGraw-Hill, San Francisco' (any-')'){0,10}')'|'(McGraw-Hill, USA' (any-')'){0,10}')'|'(McGrow-Hill, New York' (any-')'){0,10}')'|'(MIR; Moscow' (any-')'){0,10}')'|'(MIT press' (any-')'){0,10}')'|'(M.I.T. Press' (any-')'){0,10}')'|'(MIT Press, Cambridge, MA' (any-')'){0,10}')'|'(Moscow: Energoatomizdat' (any-')'){0,10}')'|'(Moscow, Eneroizdat' (any-')'){0,10}')'|'(Moscow: Inst. Nuclear Research' (any-')'){0,10}')'|'(Moscow: Moscow State Univ.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Moscow: Moscow State Univ.' (any-')'){0,10}')'|'(Moscow State University' (any-')'){0,10}')'|'(Moscow State University, Moscow' (any-')'){0,10}')'|'(Moscow: Univer.Press' (any-')'){0,10}')'|'(National Bureau of Standards' (any-')'){0,10}')'|'(National Bureau of Standards, Washington' (any-')'){0,10}')'|'(NATO ASI Series B' (any-')'){0,10}')'|'( Nauka, Moscow' (any-')'){0,10}')'|'(Naukova Dumka, Kiev' (any-')'){0,10}')'|'(New York: Academic Press' (any-')'){0,10}')'|'(New York: Gordon and Breach' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(New York: Gordon and Breach' (any-')'){0,10}')'|'(New York, Plenum' (any-')'){0,10}')'|'(New York: Plenum Press' (any-')'){0,10}')'|'( North-Holland' (any-')'){0,10}')'|'(North-Holland, Amsterdam, The Netherlands' (any-')'){0,10}')'|'(North-Holland Publ. Co.' (any-')'){0,10}')'|'(North-Holland Publications' (any-')'){0,10}')'|'(North Holland Publishing, Amsterdam' (any-')'){0,10}')'|'(North-Holland Publishing Co.' (any-')'){0,10}')'|'(North-Holland--World Scientific' (any-')'){0,10}')'|'(North-Holland/World Scientific' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(North-Holland/World Scientific' (any-')'){0,10}')'|'(Noth-Holland, Amsterdam' (any-')'){0,10}')'|'(Nova Science, New York' (any-')'){0,10}')'|'(Observatoire de Paris' (any-')'){0,10}')'|'(Oxford 1989' (any-')'){0,10}')'|'(Oxford, Clarendon' (any-')'){0,10}')'|'(Oxford, London' (any-')'){0,10}')'|'(Oxford Mathematical Monographs' (any-')'){0,10}')'|'(Oxford, New York' (any-')'){0,10}')'|'(Oxford, Oxford University Press' (any-')'){0,10}')'|'(Oxford: Oxford Univ. Press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Oxford: Oxford Univ. Press' (any-')'){0,10}')'|'(Oxford Univ. Press, New York' (any-')'){0,10}')'|'(Oxford U.P., Oxford' (any-')'){0,10}')'|'(Pergammon, London' (any-')'){0,10}')'|'(Pergammon Press' (any-')'){0,10}')'|'(Pergamon press, Oxford' (any-')'){0,10}')'|'(Pergamon Press: Oxford' (any-')'){0,10}')'|'(Pergamon Press, Oxford and New York' (any-')'){0,10}')'|'(Ph.D. thesis' (any-')'){0,10}')'|'(PhD thesis' (any-')'){0,10}')'|'(Physical Society of Japan, Tokyo' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Physical Society of Japan, Tokyo' (any-')'){0,10}')'|'(Phys. Lett. B' (any-')'){0,10}')'|'(Phys. Soc. Japan, Tokyo' (any-')'){0,10}')'|'(Pitman, Boston' (any-')'){0,10}')'|'(Pitman, London' (any-')'){0,10}')'|'( Plenum' (any-')'){0,10}')'|'(Plenum, London' (any-')'){0,10}')'|'(Plenum, N.Y.' (any-')'){0,10}')'|'(Plenum Press, New-York' (any-')'){0,10}')'|'(Plenum Press, N.Y. and London' (any-')'){0,10}')'|'(Plenum Publishing Co., New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Plenum Publishing Co., New York' (any-')'){0,10}')'|'(Prentice-Hall, New Jersey' (any-')'){0,10}')'|'(Princeton Series in Physics' (any-')'){0,10}')'|'(Princeton University Press, New Jeresy, Princeton' (any-')'){0,10}')'|'(Princeton University Press, Princeton, N.J.' (any-')'){0,10}')'|'(Princeton University Press, Princeton, USA' (any-')'){0,10}')'|'(Princeton Univ. Press., Princeton' (any-')'){0,10}')'|'(Princeton Univ. Press, Princeton, New Jersey' (any-')'){0,10}')'|'(Princeton U.P., New Jersey' (any-')'){0,10}')'|'(Princeton U.P., Princeton' (any-')'){0,10}')'|'(Princeton UP, Princeton' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Princeton UP, Princeton' (any-')'){0,10}')'|'(Progress in Mathematics' (any-')'){0,10}')'|'(Progress in Physics' (any-')'){0,10}')'|'(Progress In Physics' (any-')'){0,10}')'|'(Publish or Perish Inc.' (any-')'){0,10}')'|'(PWN, Warszawa' (any-')'){0,10}')'|'(Reidel, Dordrecht, Netherlands' (any-')'){0,10}')'|'(Row, Peterson and Co $bullet$ Evanston, Ill., Elmsford' (any-')'){0,10}')'|'(San Francisco' (any-')'){0,10}')'|'(Santa Barbara' (any-')'){0,10}')'|'(S. Catto and A. Rocha' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(S. Catto and A. Rocha' (any-')'){0,10}')'|'(Scuola Normale Superiore, Pisa' (any-')'){0,10}')'|'(see [7]' (any-')'){0,10}')'|'(see also cite{kardar' (any-')'){0,10}')'|'(short version `Planar' (any-')'){0,10}')'|'( Springer, Berlin' (any-')'){0,10}')'|'(Springer Berlin' (any-')'){0,10}')'|'(Springer, Berlin, Heidelberg, New York' (any-')'){0,10}')'|'(Springer, Berlin - N.Y.' (any-')'){0,10}')'|'(Springer Lecture Notes, textbf{79}' (any-')'){0,10}')'|'(Springer, New York-Heidelberg-Berlin' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Springer, New York-Heidelberg-Berlin' (any-')'){0,10}')'|'(Springer, N.Y.' (any-')'){0,10}')'|'( Springer-Verlag' (any-')'){0,10}')'|'( Springer-Verlag, Berlin' (any-')'){0,10}')'|'(Springer-Verlag: Berlin' (any-')'){0,10}')'|'(Springer-Verlag, Berlin, Germany' (any-')'){0,10}')'|'(Springer Verlag, Berlin - Heidelberg - New York' (any-')'){0,10}')'|'(Springer Verlag, Berlin-Heidelberg-New York' (any-')'){0,10}')'|'(Springer-Verlag, Berlin, Heidelberg, New York' (any-')'){0,10}')'|'(Springer-Verlag, Berlin-Heidelberg-New York' (any-')'){0,10}')'|'(Springer Verlag, Heidelberg' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Springer Verlag, Heidelberg' (any-')'){0,10}')'|'(Springer--Verlag, New York' (any-')'){0,10}')'|'(Springer-Verlag: New York' (any-')'){0,10}')'|'(Springer Verlag, New York/Berlin' (any-')'){0,10}')'|'(Springer, Wien' (any-')'){0,10}')'|'(Spring-Verlag, Berlin' (any-')'){0,10}')'|'(Stuttgart: Teubner' (any-')'){0,10}')'|'(Taylor & Francis, London' (any-')'){0,10}')'|'(Teubner, Leipzig' (any-')'){0,10}')'|'(Texas A& M' (any-')'){0,10}')'|'(The MIT Press, Cambridge' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(The MIT Press, Cambridge' (any-')'){0,10}')'|'(The University of Chicago Press' (any-')'){0,10}')'|'(Ti-mic s-oara University Press, Romania' (any-')'){0,10}')'|'(TUBITAK, Ankara' (any-')'){0,10}')'|'( University of Tokio Press, Tokio, Springer' (any-')'){0,10}')'|'(University of Tokyo' (any-')'){0,10}')'|'(University of Toronto Press' (any-')'){0,10}')'|'(Univ. Press, Cambridge' (any-')'){0,10}')'|'(U. of Chicago' (any-')'){0,10}')'|'(Van Nostrand, New York' (any-')'){0,10}')'|'(Van Nostrand, Princeton' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Van Nostrand, Princeton' (any-')'){0,10}')'|'(W.A. Benjamin' (any-')'){0,10}')'|'(W.A. Benjamin, Inc., New York' (any-')'){0,10}')'|'(W.A.~Benjamin, New York' (any-')'){0,10}')'|'(Walter de Gruyter' (any-')'){0,10}')'|'(W.H. Freeman' (any-')'){0,10}')'|'(W.~H.~Freeman and Co.' (any-')'){0,10}')'|'(W. H. Freeman and Company' (any-')'){0,10}')'|'(Wiley, Chichester' (any-')'){0,10}')'|'(Wiley Interscience' (any-')'){0,10}')'|'(Wiley Interscience, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Wiley Interscience, New York' (any-')'){0,10}')'|'( Wiley, New York' (any-')'){0,10}')'|'(Wiley,New York' (any-')'){0,10}')'|'(Wiley: New York' (any-')'){0,10}')'|'(Wiley, New York, London' (any-')'){0,10}')'|'(World Sc.' (any-')'){0,10}')'|'(world Scientific' (any-')'){0,10}')'|'(World  Scientific' (any-')'){0,10}')'|'(World Scientific, 1993' (any-')'){0,10}')'|'(World Scientific Co, Singapore' (any-')'){0,10}')'|'(World Scientific Co., Singapore' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(World Scientific Co., Singapore' (any-')'){0,10}')'|'(World Scientific Publ. Co., Singapore' (any-')'){0,10}')'|'(World Scientific, River Edge, NJ' (any-')'){0,10}')'|'(World  Scientific, Singapore' (any-')'){0,10}')'|'(World Scientific; Singapore' (any-')'){0,10}')'|'(World-Scientific, Singapore' (any-')'){0,10}')'|'(World Scientific, Singapour' (any-')'){0,10}')'|'(World Scientific, Singapoure' (any-')'){0,10}')'|'(World Scientific, Singapure' (any-')'){0,10}')'|'(World Scietific' (any-')'){0,10}')'|'(World Sci, Singapore' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(World Sci, Singapore' (any-')'){0,10}')'|'(World Sc.  Publ.  Co., Singapore' (any-')'){0,10}')'|'(W. Scientific, Singapore' (any-')'){0,10}')'|'(WSPC: Singapore' (any-')'){0,10}')'|'(WS, Singapore' (any-')'){0,10}')'|'(Yale University Press, New Haven' (any-')'){0,10}')'|'(Yale Univ Press' (any-')'){0,10}')'|'(Yale Univ. Press, New Haven' (any-')'){0,10}')'|'(Yeshiva University Press' (any-')'){0,10}')'|'(Yeshiva Univ., New York' (any-')'){0,10}')'|'(Yeshiva Univ., N.Y.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Yeshiva Univ., N.Y.' (any-')'){0,10}')'|'(Academic Press, Inc.' (any-')'){0,10}')'|'(Academic press, New York' (any-')'){0,10}')'|'(Academic Press, New York and London' (any-')'){0,10}')'|'(Addison Wesley, New York' (any-')'){0,10}')'|'(Addison-Wesley, Reading, Mass.' (any-')'){0,10}')'|'(Addison-Wesley, Redwood City, CA' (any-')'){0,10}')'|'(Amer. Math. Soc., Providence' (any-')'){0,10}')'|'(Atomizdat, Moscow' (any-')'){0,10}')'|'(Belfer Graduate School of Science, Yeshiva University' (any-')'){0,10}')'|'(Benjamin/Cummings, Reading' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Benjamin/Cummings, Reading' (any-')'){0,10}')'|'(Benjamin, Reading' (any-')'){0,10}')'|'(Benjamin, Reading, Mass.' (any-')'){0,10}')'|'(Berlin, Springer' (any-')'){0,10}')'|'(Berlin, Springer-Verlag' (any-')'){0,10}')'|'(Bibliopolis, Napoli' (any-')'){0,10}')'|'(Birkhauser, Basel' (any-')'){0,10}')'|'(Birkh{"a}user, Boston' (any-')'){0,10}')'|'(Cambridge, Cambridge/UK' (any-')'){0,10}')'|'(Cambridge, England' (any-')'){0,10}')'|'(Cambridge, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Cambridge, New York' (any-')'){0,10}')'|'(Cambridge, UK' (any-')'){0,10}')'|'(Cambridge University Press, England' (any-')'){0,10}')'|'(Cambridge Univ.~Press' (any-')'){0,10}')'|'(Cambridge Univ.Press' (any-')'){0,10}')'|'(Cambridge Univ.Press, Cambridge' (any-')'){0,10}')'|'(Chelsea, New York' (any-')'){0,10}')'|'(Clarendon press, Oxford' (any-')'){0,10}')'|'(Course of Theoretical Physics' (any-')'){0,10}')'|'(CRC Press' (any-')'){0,10}')'|'(CRC Press, Boca Raton' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(CRC Press, Boca Raton' (any-')'){0,10}')'|'(Dekker, New York' (any-')'){0,10}')'|'(Dordrecht, Boston' (any-')'){0,10}')'|'(Dover, New York, USA' (any-')'){0,10}')'|'(Dover, N.Y.' (any-')'){0,10}')'|'(Dover Publications Inc, New York' (any-')'){0,10}')'|'(Dover Pub., New York' (any-')'){0,10}')'|'(D. Reidel, Dordrecht' (any-')'){0,10}')'|'(Editions Fronti`eres, Gif-sur-Yvette' (any-')'){0,10}')'|'(Energoatomizdat, Moscow' (any-')'){0,10}')'|'(Engl. transl.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Engl. transl.' (any-')'){0,10}')'|'(Freeman, San Francisco' (any-')'){0,10}')'|'(Gauthier--Villars, Paris' (any-')'){0,10}')'|'(Gordon and Breach, NY' (any-')'){0,10}')'|'(Harper & Row, New York' (any-')'){0,10}')'|'(Harvard Univ. Press, Cambridge' (any-')'){0,10}')'|'(Harwood Academic' (any-')'){0,10}')'|'(ICTP, Trieste' (any-')'){0,10}')'|'(Imperial College Press' (any-')'){0,10}')'|'(Institute of Physics Publishing, Bristol' (any-')'){0,10}')'|'(Institute of Physics Publishing, Bristol and Philadelphia' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Institute of Physics Publishing, Bristol and Philadelphia' (any-')'){0,10}')'|'(International Press, Hong Kong' (any-')'){0,10}')'|'(Interscience, NY' (any-')'){0,10}')'|'(IOP, Bristol' (any-')'){0,10}')'|'(IOP Publishing Ltd, Bristol' (any-')'){0,10}')'|'({it McGraw Hill}, New York' (any-')'){0,10}')'|'({it Springer-Verlag}, Berlin' (any-')'){0,10}')'|'(Iwanami Shoten, Tokyo' (any-')'){0,10}')'|'(J. Wiley and Sons' (any-')'){0,10}')'|'(Kluwer Acad. Publ.' (any-')'){0,10}')'|'(Marcel Dekker' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Marcel Dekker' (any-')'){0,10}')'|'(Masson, Paris' (any-')'){0,10}')'|'(McGraw-Hill, London' (any-')'){0,10}')'|'(McGraw-Hill, NY' (any-')'){0,10}')'|'(McGraw-Hill, Singapore' (any-')'){0,10}')'|'(Moscow, Atomizdat' (any-')'){0,10}')'|'(Moscow: Mir' (any-')'){0,10}')'|'(Moscow. Nauka' (any-')'){0,10}')'|'( Nauka' (any-')'){0,10}')'|'(Nauka, Moskva' (any-')'){0,10}')'|'(New York: Plenum' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(New York: Plenum' (any-')'){0,10}')'|'(North--Holland, Amsterdam' (any-')'){0,10}')'|'(North-Holland Publ. Co., Amsterdam' (any-')'){0,10}')'|'(North-Holland Publishing Company, Amsterdam' (any-')'){0,10}')'|'(Oxford, Clarendon Press' (any-')'){0,10}')'|'(Oxford Science Publications, Oxford' (any-')'){0,10}')'|'(Oxford Univ. Press, London' (any-')'){0,10}')'|'(Oxford UP' (any-')'){0,10}')'|'(Pergamon, Oxford UK' (any-')'){0,10}')'|'(Physics of Atomic Nuclei' (any-')'){0,10}')'|'(Plenum, NY' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Plenum, NY' (any-')'){0,10}')'|'(Plenum Press, NY' (any-')'){0,10}')'|'(Princeton University' (any-')'){0,10}')'|'(Princeton University Press, New Jersey' (any-')'){0,10}')'|'(Princeton University Press, Princeton, New Jersey' (any-')'){0,10}')'|'(Princeton Univ. Press' (any-')'){0,10}')'|'(Princeton U. Press' (any-')'){0,10}')'|'(private communication' (any-')'){0,10}')'|'(Publish or Perish, Berkeley' (any-')'){0,10}')'|'(second edition' (any-')'){0,10}')'|'( Springer' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'( Springer' (any-')'){0,10}')'|'(Springer, NY' (any-')'){0,10}')'|'( Springer Verlag' (any-')'){0,10}')'|'(Springer-Verlag,  Berlin' (any-')'){0,10}')'|'(Springer-Verlag, Berlin etc.' (any-')'){0,10}')'|'(Springer-Verlag, New York, Heidelberg, Berlin' (any-')'){0,10}')'|'(The University of Chicago Press, Chicago' (any-')'){0,10}')'|'(Univ. Chicago Press, Chicago' (any-')'){0,10}')'|'(Univ. Press' (any-')'){0,10}')'|'(Vieweg, Braunschweig' (any-')'){0,10}')'|'(W. A. Benjamin, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(W. A. Benjamin, New York' (any-')'){0,10}')'|'(Wiley, New-York' (any-')'){0,10}')'|'(Wiley, N.Y.' (any-')'){0,10}')'|'(Willey, New York' (any-')'){0,10}')'|'(World Scientific Pub. Co. ' (any-')'){0,10}')'|'(World Scientific, Sigapore' (any-')'){0,10}')'|'(World scientific, Singapore' (any-')'){0,10}')'|'(World Scientific,  Singapore' (any-')'){0,10}')'|'(Yeshiva University' (any-')'){0,10}')'|'(Yeshiva University Press, New York' (any-')'){0,10}')'|'(Academic Press Inc.' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Academic Press Inc.' (any-')'){0,10}')'|'( Academic Press, New York' (any-')'){0,10}')'|'(Academic Press, N. Y.' (any-')'){0,10}')'|'(Addison-Wesley, Menlo Park' (any-')'){0,10}')'|'(Addison-Wesley, Redwood' (any-')'){0,10}')'|'(Akademie-Verlag, Berlin' (any-')'){0,10}')'|'(American Mathematical Society, Providence, Rhode Island' (any-')'){0,10}')'|'(American Mathematical Society, Providence, RI' (any-')'){0,10}')'|'(Benjamin Cummings' (any-')'){0,10}')'|'(Benjamin/Cummings, London' (any-')'){0,10}')'|'(Benjamin/Cummings, Menlo Park' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Benjamin/Cummings, Menlo Park' (any-')'){0,10}')'|'(Cambridge, Cambridge University Press' (any-')'){0,10}')'|'(Cambridge: Cambridge Univ. Press' (any-')'){0,10}')'|'( Cambridge University Press' (any-')'){0,10}')'|'(Cambridge University Press,Cambridge' (any-')'){0,10}')'|'(Cambridge Univ.  Press' (any-')'){0,10}')'|'(Cambridge Univ. Press, Cambridge' (any-')'){0,10}')'|'(Cambridge U. P.' (any-')'){0,10}')'|'(Cambridge U. Press' (any-')'){0,10}')'|'(Cambridge U. Press, Cambridge' (any-')'){0,10}')'|'(Cambrige University Press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Cambrige University Press' (any-')'){0,10}')'|'(C.U.P., Cambridge' (any-')'){0,10}')'|'(Dunod, Paris' (any-')'){0,10}')'|'(Gordon & Breach' (any-')'){0,10}')'|'(Harwood Academic Publishers' (any-')'){0,10}')'|'(Harwood, New York' (any-')'){0,10}')'|'(International Press, Boston' (any-')'){0,10}')'|'(Interscience Publishers, New York' (any-')'){0,10}')'|'(IOP Publishing, Bristol' (any-')'){0,10}')'|'(IOP Publishing, Bristol and Philadelphia' (any-')'){0,10}')'|'({it Academic Press}, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'({it Academic Press}, New York' (any-')'){0,10}')'|'({it World Scientific}, Singapore' (any-')'){0,10}')'|'(JINR, Dubna' (any-')'){0,10}')'|'(J. Wiley' (any-')'){0,10}')'|'(J. Wiley and Sons, New York' (any-')'){0,10}')'|'(Kinokuniya, Tokyo' (any-')'){0,10}')'|'(Kluwer Academic Publ.' (any-')'){0,10}')'|'(McGraw-Hill Book Co.' (any-')'){0,10}')'|'(McGraw-Hill Book Company' (any-')'){0,10}')'|'(Moscow: Atomizdat' (any-')'){0,10}')'|'(Nauka, Novosibirsk' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Nauka, Novosibirsk' (any-')'){0,10}')'|'( New York' (any-')'){0,10}')'|'(New York, Academic Press' (any-')'){0,10}')'|'(New York, N.Y.' (any-')'){0,10}')'|'(Nova Science' (any-')'){0,10}')'|'(Pergamon Press, London' (any-')'){0,10}')'|'(Plenum Publishing Corporation' (any-')'){0,10}')'|'(Prentice-Hall, Englewood Cliffs, New Jersey' (any-')'){0,10}')'|'(Princeton: Princeton University Press' (any-')'){0,10}')'|'(Reidel, Boston' (any-')'){0,10}')'|'(SIAM, Philadelphia' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(SIAM, Philadelphia' (any-')'){0,10}')'|'(Springer, Berlin-Heidelberg' (any-')'){0,10}')'|'(Springer-Verlag, Berlin, Heidelberg' (any-')'){0,10}')'|'(Springer-Verlag, Heidelberg' (any-')'){0,10}')'|'(University of Chicago Press' (any-')'){0,10}')'|'(University of Chicago Press, Chicago' (any-')'){0,10}')'|'(Univ. of Chicago Press' (any-')'){0,10}')'|'(W.A. Benjamin, New York' (any-')'){0,10}')'|'(W.H. Freeman and Co.' (any-')'){0,10}')'|'(World Scient.' (any-')'){0,10}')'|'( World Scientific' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'( World Scientific' (any-')'){0,10}')'|'(World Scientific Publishing Co.' (any-')'){0,10}')'|'(World Scientific Publishing, Singapore' (any-')'){0,10}')'|'( World Scientific, Singapore' (any-')'){0,10}')'|'(Yeshiva University, New York' (any-')'){0,10}')'|'(Addison-Wesley, Redwood City' (any-')'){0,10}')'|'(Amer. Math. Soc.' (any-')'){0,10}')'|'(Cambridge: Cambridge University Press' (any-')'){0,10}')'|'(Cambridge University' (any-')'){0,10}')'|'(Cambridge University Press, London' (any-')'){0,10}')'|'(Cambridge U. P., Cambridge' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Cambridge U. P., Cambridge' (any-')'){0,10}')'|'(Dover Publications' (any-')'){0,10}')'|'(Dover Publications, Inc., New York' (any-')'){0,10}')'|'(Gordon & Breach, New York' (any-')'){0,10}')'|'(Harwood, Chur, Switzerland' (any-')'){0,10}')'|'(Hilger, Bristol' (any-')'){0,10}')'|'(J. Wiley, New York' (any-')'){0,10}')'|'(Kluwer; Dordrecht' (any-')'){0,10}')'|'(Lecture Notes in Physics' (any-')'){0,10}')'|'(McGraw-Hill Book Company, New York' (any-')'){0,10}')'|'(Mc Graw-Hill, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Mc Graw-Hill, New York' (any-')'){0,10}')'|'(McGraw--Hill, New York' (any-')'){0,10}')'|'(Nauka, Moskow' (any-')'){0,10}')'|'(North-Holland, New York' (any-')'){0,10}')'|'(Oxford University Press, London' (any-')'){0,10}')'|'(Pergamon Press, New York' (any-')'){0,10}')'|'(Plenum Press, N.Y.' (any-')'){0,10}')'|'(Springer-Verlag, Berlin-Heidelberg' (any-')'){0,10}')'|'(Wiley, NY' (any-')'){0,10}')'|'(World Scientific Pub. Co., Singapore' (any-')'){0,10}')'|'(World Scientific Publishing Co., Singapore' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(World Scientific Publishing Co., Singapore' (any-')'){0,10}')'|'(Academic, London' (any-')'){0,10}')'|'(AIP, New York' (any-')'){0,10}')'|'(American Institute of Physics' (any-')'){0,10}')'|'(Berlin: Springer' (any-')'){0,10}')'|'(Harwood Academic Publishers, Chur' (any-')'){0,10}')'|'(Harwood, Chur' (any-')'){0,10}')'|'(Institute of Physics, Bristol' (any-')'){0,10}')'|'(International Press' (any-')'){0,10}')'|'(IOP Publishing' (any-')'){0,10}')'|'(John Wiley, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(John Wiley, New York' (any-')'){0,10}')'|'(Kluwer Academic Publishers, Dordrecht' (any-')'){0,10}')'|'(Les Houches' (any-')'){0,10}')'|'(Marcel Dekker, New York' (any-')'){0,10}')'|'(MIT Press' (any-')'){0,10}')'|'(Oxford University Press, New York' (any-')'){0,10}')'|'(Publish or Perish' (any-')'){0,10}')'|'(Singapore: World Scientific' (any-')'){0,10}')'|'(Springer-Verlag, Berlin Heidelberg' (any-')'){0,10}')'|'(Wiley-Interscience, New York' (any-')'){0,10}')'|'(World Scientific Publishing' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(World Scientific Publishing' (any-')'){0,10}')'|'(Academic Press, Boston' (any-')'){0,10}')'|'(Addison Wesley' (any-')'){0,10}')'|'(Addison-Wesley Publishing Company' (any-')'){0,10}')'|'(Addison-Wesley, Reading, Massachusetts' (any-')'){0,10}')'|'(American Mathematical Society, Providence' (any-')'){0,10}')'|'(Birkh"auser, Basel' (any-')'){0,10}')'|'(Cambridge Univ. Press, New York' (any-')'){0,10}')'|'(Cambridge U.P., Cambridge' (any-')'){0,10}')'|'(John Wiley and Sons, New York' (any-')'){0,10}')'|'(Mir, Moscow' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Mir, Moscow' (any-')'){0,10}')'|'(MIT Press, Cambridge' (any-')'){0,10}')'|'(Pergamon, London' (any-')'){0,10}')'|'(Singapore, World Scientific' (any-')'){0,10}')'|'(Springer-Verlag, N.Y.' (any-')'){0,10}')'|'(University Press, Cambridge' (any-')'){0,10}')'|'(World Sci., Singapore' (any-')'){0,10}')'|'(AMS, Providence' (any-')'){0,10}')'|'(Berlin, Heidelberg' (any-')'){0,10}')'|'(Birkh"auser, Boston' (any-')'){0,10}')'|'(Cambridge Univ. Press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Cambridge Univ. Press' (any-')'){0,10}')'|'(Claredon Press, Oxford' (any-')'){0,10}')'|'(Gauthier-Villars, Paris' (any-')'){0,10}')'|'(Hermann, Paris' (any-')'){0,10}')'|'(John Wiley' (any-')'){0,10}')'|'(John Wiley and Sons' (any-')'){0,10}')'|'(McGraw Hill, New York' (any-')'){0,10}')'|'(Princeton University Press, Princeton, NJ' (any-')'){0,10}')'|'(Springer--Verlag, Berlin' (any-')'){0,10}')'|'(Adam Hilger, Bristol' (any-')'){0,10}')'|'(American Mathematical Society' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(American Mathematical Society' (any-')'){0,10}')'|'(Birkh"{a}user, Boston' (any-')'){0,10}')'|'(Dover Publications, New York' (any-')'){0,10}')'|'(Kluwer Academic Publishers' (any-')'){0,10}')'|'(Moscow: Nauka' (any-')'){0,10}')'|'(Oxford Univ. Press, Oxford' (any-')'){0,10}')'|'(Academic Press, NY' (any-')'){0,10}')'|'(Adam Hilger' (any-')'){0,10}')'|'(Birkhauser, Boston' (any-')'){0,10}')'|'(Cambridge University Press, Cambridge, UK' (any-')'){0,10}')'|'(Cambridge UP' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Cambridge UP' (any-')'){0,10}')'|'(Pergamon, New York' (any-')'){0,10}')'|'(Academic Press, San Diego' (any-')'){0,10}')'|'(Addison-Wesley, Reading' (any-')'){0,10}')'|'(Elsevier, Amsterdam' (any-')'){0,10}')'|'(Reidel, Dordrecht' (any-')'){0,10}')'|'(World Scientific,Singapore' (any-')'){0,10}')'|'(Oxford Univ. Press' (any-')'){0,10}')'|'(World Sci.' (any-')'){0,10}')'|'(Addison-Wesley, New York' (any-')'){0,10}')'|'(Benjamin, New York' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Benjamin, New York' (any-')'){0,10}')'|'(Cambridge University Press, New York' (any-')'){0,10}')'|'(John Wiley & Sons, New York' (any-')'){0,10}')'|'(Kluwer, Dordrecht' (any-')'){0,10}')'|'(Princeton Univ. Press, Princeton' (any-')'){0,10}')'|'(Springer Verlag, New York' (any-')'){0,10}')'|'(CUP, Cambridge' (any-')'){0,10}')'|'(Interscience, New York' (any-')'){0,10}')'|'(Cambridge U.P.' (any-')'){0,10}')'|'(John Wiley & Sons' (any-')'){0,10}')'|'(Pergamon Press, Oxford' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Pergamon Press, Oxford' (any-')'){0,10}')'|'(Moscow, Nauka' (any-')'){0,10}')'|'(Springer, Heidelberg' (any-')'){0,10}')'|'(Clarendon Press' (any-')'){0,10}')'|'(Academic, New York' (any-')'){0,10}')'|'(North Holland, Amsterdam' (any-')'){0,10}')'|'(Princeton Univ. Press' (any-')'){0,10}')'|'(Academic Press, London' (any-')'){0,10}')'|'(Clarendon, Oxford' (any-')'){0,10}')'|'(Pergamon, Oxford' (any-')'){0,10}')'|'(Addison-Wesley, Reading, MA' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Addison-Wesley, Reading, MA' (any-')'){0,10}')'|'(Clarendon Press, Oxford' (any-')'){0,10}')'|'(Oxford University Press, Oxford' (any-')'){0,10}')'|'(Gordon and Breach, New York' (any-')'){0,10}')'|'(McGraw-Hill, New York' (any-')'){0,10}')'|'(Pergamon Press' (any-')'){0,10}')'|'(Princeton University Press, Princeton' (any-')'){0,10}')'|'(Cambridge University Press, Cambridge, England' (any-')'){0,10}')'|'(Gordon and Breach' (any-')'){0,10}')'|'(Nauka, Moscow' (any-')'){0,10}')'|'(North Holland' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(North Holland' (any-')'){0,10}')'|'(Plenum Press, New York' (any-')'){0,10}')'|'(Oxford University Press' (any-')'){0,10}')'|'(Dover, New York' (any-')'){0,10}')'|'(Cambridge Univ. Press, Cambridge' (any-')'){0,10}')'|'(Springer, New York' (any-')'){0,10}')'|'(Plenum, New York' (any-')'){0,10}')'|'(Plenum Press' (any-')'){0,10}')'|'(Springer Verlag, Berlin' (any-')'){0,10}')'|'(Wiley, New York' (any-')'){0,10}')'|'(Springer Verlag' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };


'(Springer Verlag' (any-')'){0,10}')'|'(Academic Press, New York' (any-')'){0,10}')'|'(North-Holland, Amsterdam' (any-')'){0,10}')'|'(Princeton University Press' (any-')'){0,10}')'|'(Springer-Verlag, New York' (any-')'){0,10}')'|'(Cambridge Univ. Press' (any-')'){0,10}')'|'(New York' (any-')'){0,10}')'|'(Springer, Berlin' (any-')'){0,10}')'|'(World Scientific, Singapore' (any-')'){0,10}')'|'(Springer-Verlag, Berlin' (any-')'){0,10}')'|'(Cambridge University Press, Cambridge' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };

'(Cambridge University Press, Cambridge' (any-')'){0,10}')'|'(World Scientific' (any-')'){0,10}')'|'(Academic Press' (any-')'){0,10}')'|'(Cambridge University Press' (any-')'){0,10}')' => { printf("token: %sn", std::string(ts, te).c_str()); };



'A. A. Abrikosov'|'A. A. Andrianov'|'A. Abada'|'A. Abdurrahman'|'A. Abel'|'A. A. Belavin'|'A. A. Bichl'|'A. A. Bogush'|'A. A. Borgardt'|'A. Abouelsaood'|'A. Abramovici' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Abramovici'|'A. Abrikosov'|'A. A. Bytsenko'|'A. Accardi'|'A. Ach'|'A. Achucarro'|'A. A. Coley'|'A. Actor'|'A. Adams'|'A. A. Deriglazov'|'A. A. Galperin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. A. Galperin'|'A. A. Gerasimov'|'A. Aghamohammadi'|'A. Agodi'|'A. A. Grib'|'A. Aharony'|'A. A. Johansen'|'A. A. Kehagias'|'A. A. Kirillov'|'A. A. Klyachko'|'A. Albrecht' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Albrecht'|'A. Alekseev'|'A. Ali'|'A. A. Lisyansky'|'A. A. Logunov'|'A. Alonso'|'A. Altland'|'A. A. Migdal'|'A. Anderson'|'A. Andrianov'|'A. Anisimov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Anisimov'|'A. Antill'|'A. Armoni'|'A. A. Rosly'|'A. A. Ruzmaikin'|'A. A. Saharian'|'A. A. Sharapov'|'A. Ashtekar'|'A. A. Slavnov'|'A. Aspect'|'A. A. Starobinski' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. A. Starobinski'|'A. A. Starobinsky'|'A. Astashkevich'|'A. Aste'|'A. A. Tseytlin'|'A. Aurilia'|'A. A. Vladimirov'|'A. Avram'|'A. Awada'|'A. A. Zheltukhin'|'A. Babichenko' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Babichenko'|'A. Bagger'|'A. Bais'|'A. Baker'|'A. Balachandran'|'A. Ballesteros'|'A. Bandos'|'A. Baranov'|'A. Bardeen'|'A. Barducci'|'A. Bares' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Bares'|'A. Barut'|'A. Barvinsky'|'A. Bashir'|'A. Bassett'|'A. Bassetto'|'A. Batakis'|'A. Batalin'|'A. Battistel'|'A. Battye'|'A. B. Balantekin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. B. Balantekin'|'A. Beauville'|'A. Beilinson'|'A. Bejancu'|'A. Belavin'|'A. Belhaj'|'A. Belinskii'|'A. Belinsky'|'A. Belli'|'A. Bellini'|'A. Belopolsky' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Belopolsky'|'A. Belov'|'A. Benjamin'|'A. Berends'|'A. Berezin'|'A. Bergman'|'A. Bergshoeff'|'A. Berkovich'|'A. Bertlmann'|'A. Bethe'|'A. Bichl' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Bichl'|'A. Bilal'|'A. Billoire'|'A. Biswas'|'A. B. Lahanas'|'A. Blasi'|'A. Bobenko'|'A. Bohm'|'A. Bonanno'|'A. Borde'|'A. Borel' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Borel'|'A. Boresch'|'A. Borisov'|'A. Borowiec'|'A. Brandhuber'|'A. Brandt'|'A. Brignole'|'A. Brito'|'A. Brizola'|'A. Bronnikov'|'A. Brychkov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Brychkov'|'A. B. Shabat'|'A. Buchel'|'A. Buonanno'|'A. Burinskii'|'A. Bytsenko'|'A. Bytsko'|'A. B. Zamolodchikov'|'A. Cabo'|'A. Calogeracos'|'A. Campbell' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Campbell'|'A. Campos'|'A. Candiello'|'A. Capelli'|'A. Cappelli'|'A. Cardy'|'A. Carey'|'A. Carlini'|'A. Casas'|'A. Casher'|'A. Castro-Alvaredo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Castro-Alvaredo'|'A. Cattaneo'|'A. C. Cadavid'|'A. C. Davis'|'A. Ceresole'|'A. C. Gossard'|'A. Chakrabarti'|'A. Chamblin'|'A. Chamorro'|'A. Chamseddine'|'A. Chatterjee' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Chatterjee'|'A. Chenaghlou'|'A. Cherkis'|'A. Chervyakov'|'A. C. Hirshfeld'|'A. Chodos'|'A. Chou'|'A. C. Kalloniatis'|'A. Clayton'|'A. Cohen'|'A. Coley' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Coley'|'A. Collins'|'A. Comtet'|'A. Connell'|'A. Connes'|'A. Cooper'|'A. Corichi'|'A. Coste'|'A. C. Ottewill'|'A. Cox'|'A. C. Petkou' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. C. Petkou'|'A. Crumeyrolle'|'A. C. Tort'|'A. Cucchieri'|'A. Culatti'|'A. Dabholkar'|'A. Dancer'|'A. Das'|'A. Dasgupta'|'A. Dasni'|'A. Davidson' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Davidson'|'A. Davis'|'A. D. Dolgov'|'A. De'|'A. Deckmyn'|'A. Degasperis'|'A. Delgado'|'A. Demichev'|'A. Denner'|'A. Depireux'|'A. Deriglazov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Deriglazov'|'A. Dettki'|'A. Dhar'|'A. Di'|'A. Diamandis'|'A. Diaz'|'A. Dickey'|'A. Dikii'|'A. Dilkes'|'A. Dimakis'|'A. Dixon' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Dixon'|'A. D. Linde'|'A. Dobado'|'A.  Doikou'|'A. Doikou'|'A. Dolan'|'A. Dold'|'A. Donini'|'A. Donnachie'|'A. D. Popov'|'A. Dresse' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Dresse'|'A. D. Sakharov'|'A.  D.  Shapere'|'A. D. Shapere'|'A. D. Sokal'|'A. Dubrovin'|'A. Duncan'|'A. Easson'|'A. Echeverr'|'A. E. Faraggi'|'A. E. Filippov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. E. Filippov'|'A. Einstein'|'A. El'|'A. E. Nelson'|'A. Erd'|'A. Erdelyi'|'A. Eris'|'A. Ershov'|'A. E. Santana'|'A. E. Shabad'|'A. Fabbri' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Fabbri'|'A. Falkowski'|'A. Faraggi'|'A. Fateev'|'A. Fatollahi'|'A. Fayyazuddin'|'A. Feingold'|'A. Feinstein'|'A. Feldman'|'A. Feoli'|'A. Ferber' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Ferber'|'A. Ferrando'|'A. Ferreira'|'A. Fetter'|'A. F. Grillo'|'A. Filippi'|'A. Fisher'|'A. Flachi'|'A. Floer'|'A. Flohr'|'A. Flournoy' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Flournoy'|'A. Fock'|'A. Foerster'|'A. Fomenko'|'A. Font'|'A. Forge'|'A. Fotopoulos'|'A. F. Ra'|'A. Frank'|'A. Franke'|'A. Friedman' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Friedman'|'A. Frieman'|'A. Fring'|'A. Frolov'|'A. Frydryszak'|'A. Fujii'|'A. Fulling'|'A. Galajinsky'|'A. Galiautdinov'|'A. Galindo'|'A.  Galperin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A.  Galperin'|'A. Galperin'|'A. Gamba'|'A. Ganchev'|'A. Gangopadhyaya'|'A. Garc'|'A. Garcia'|'A. G. Cohen'|'A. Gerasimov'|'A. Gersten'|'A. Ghezelbash' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Ghezelbash'|'A. Ghodsi'|'A. Ghosh'|'A. Giryavets'|'A. Givental'|'A.  Giveon'|'A. Giveon'|'A. G. Izergin'|'A. G. Lyapin'|'A. G. Mirzabekian'|'A. Gocksch' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Gocksch'|'A. Gogilidze'|'A. Gol'|'A. Goldhaber'|'A. Goldin'|'A. Golfand'|'A. Gomberoff'|'A. Gonz'|'A. Gonzales-Arroyo'|'A. Gonzalez'|'A. Gonzalez-Arroyo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Gonzalez-Arroyo'|'A. Gonzalez-Lopez'|'A. Gorskii'|'A. Gorsky'|'A. G. Polnarev'|'A. Gracey'|'A. Granik'|'A. Grassi'|'A. Gray'|'A. Grebeniuk'|'A. Gregori' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Gregori'|'A. Grib'|'A. G. Riess'|'A. Griffin'|'A. Griffiths'|'A. Grigoriev'|'A. Grillo'|'A. Gritsenko'|'A. Grothendieck'|'A. Guijosa'|'A. Gupta' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Gupta'|'A. G. Ushveridze'|'A. Guth'|'A. Halasz'|'A. Hanany'|'A. Hanson'|'A. Harindranath'|'A. Hart'|'A. Hartnoll'|'A.  Harvey'|'A. Harvey' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Harvey'|'A. Hasenfratz'|'A. Hashimoto'|'A. Hatzinikitas'|'A. Hauck'|'A. Hayashi'|'A. H. Castro'|'A. H. Chamseddine'|'A. Hebecker'|'A. Helay'|'A. Held' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Held'|'A. Herrera'|'A. Herrera-Aguilar'|'A. H. Guth'|'A. Hietam'|'A. Higuchi'|'A. Hilger'|'A. Hindawi'|'A. Hiscock'|'A. H. Mac'|'A. H. Mueller' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. H. Mueller'|'A. Hojman'|'A. Honecker'|'A. Horv'|'A. Horvathy'|'A. Hosoya'|'A. Hotes'|'A. Houghton'|'A. H. Taub'|'A. Hurst'|'A. Huse' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Huse'|'A. H. Zimerman'|'A. I. Akhiezer'|'A. I. Bochkarev'|'A. Ibort'|'A. I. Davydychev'|'A. I. Karanikas'|'A. I. Larkin'|'A. Ilha'|'A. Imaanpur'|'A. I. Nikishov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. I. Nikishov'|'A. Inomata'|'A. Intriligator'|'A. I. Oksak'|'A. Iorio'|'A. I. Pashnev'|'A. Iqbal'|'A. Irb'|'A. Ishibashi'|'A. Ishida'|'A. Ishikawa' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Ishikawa'|'A. I. Sokolov'|'A. Its'|'A. I. Vainshtein'|'A. I. Vainstein'|'A. Ivanov'|'A. Ivanova'|'A. I. Veselov'|'A. Iwazaki'|'A. I. Zel'|'A. I. Zelnikov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. I. Zelnikov'|'A. Izergin'|'A. Jackson'|'A. Jacobson'|'A. Jadczyk'|'A. Jaffe'|'A. James'|'A. Janik'|'A. Janner'|'A. Jannussis'|'A. J. Bordner' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. J. Bordner'|'A. J. Bracken'|'A. J. Bray'|'A. Jeffrey'|'A. Jellal'|'A.  Jevicki'|'A. Jevicki'|'A. J. Hanson'|'A. J. Heeger'|'A. J. Leggett'|'A. J. Macfarlane' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. J. Macfarlane'|'A. J. M. Medved'|'A. J. Mountain'|'A. J. Niemi'|'A. Johansen'|'A. Johnston'|'A. Joseph'|'A. J. Tolley'|'A. Kalloniatis'|'A. Kapitulnik'|'A. Kapustin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Kapustin'|'A. Kapustnikov'|'A. Karasu'|'A. Karch'|'A. Karev'|'A. Karlhede'|'A. Karmanov'|'A. Kashani-Poor'|'A. Kastor'|'A. Kastrup'|'A. Kato' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Kato'|'A. Kavalov'|'A. Kaya'|'A. Kazakov'|'A. Kazhdan'|'A. K. Biswas'|'A. Kehagias'|'A. Kempf'|'A. Kent'|'A. Kerman'|'A. Keurentjes' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Keurentjes'|'A. Khare'|'A. Khavaev'|'A. K. H. Bengtsson'|'A. Khoruzhenko'|'A. Khoudeir'|'A. Khvedelidze'|'A. Kirillov'|'A. Kirzhnits'|'A. Kivel'|'A. Kivelson' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Kivelson'|'A. K. Kerman'|'A. Kl'|'A. Kleber'|'A. Klein'|'A. Klemm'|'A. Kleppe'|'A. Kliem'|'A. Klimyk'|'A. Kling'|'A. Knutson' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Knutson'|'A. Koci'|'A. Kocic'|'A. Kofman'|'A. Kokado'|'A. Komar'|'A. Komarov'|'A. Konechny'|'A. Kor'|'A. Korchemskaya'|'A. Kosower' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Kosower'|'A. Kosteleck'|'A. Kostelecky'|'A. Koubek'|'A. Kovner'|'A. Kramers'|'A. Krasnitz'|'A. Kronfeld'|'A. Krykhtin'|'A. Krzywicki'|'A. Kubyshin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Kubyshin'|'A. Kumar'|'A. Kundu'|'A. Kuniba'|'A. Kupershmidt'|'A. Kupiainen'|'A. Kupianen'|'A. Kuraev'|'A. Kusenko'|'A. Kuzmin'|'A. Kuznetsov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Kuznetsov'|'A. Laberge'|'A. Lahanas'|'A. Lahiri'|'A. Larin'|'A. Larsen'|'A. Lascoux'|'A. Lawrence'|'A. L. Besse'|'A. Le'|'A. Leclair' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Leclair'|'A. Lee'|'A. Leese'|'A. Leites'|'A. Lerda'|'A. Lesniewski'|'A. Levin'|'A. Lewis'|'A. Leznov'|'A. L. Fetter'|'A. L. Gadelha' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. L. Gadelha'|'A. Libgober'|'A. Liccardo'|'A. Lichnerowicz'|'A. Liddle'|'A. Liguori'|'A. Lima-Santos'|'A. Linde'|'A. Litvintsev'|'A. L. Larsen'|'A. Lled' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Lled'|'A. Lledo'|'A. Loewy'|'A. Logunov'|'A. Lohe'|'A. Lopez'|'A. Lorek'|'A. Losev'|'A. Love'|'A. Lowe'|'A. Lozada' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Lozada'|'A. Ludwig'|'A. Lue'|'A. Lugo'|'A. Lukas'|'A. Lunev'|'A. Luther'|'A. Lutken'|'A. Luty'|' Am. '|'A. Mac' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Mac'|'A. Macfarlane'|'A. Macias'|'A. Maciocia'|'A. Magnon'|'A. Magpantay'|'A. Maia'|'A. Maloney'|'A. Mann'|'A. Manogue'|'A. Manohar' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Manohar'|'A. Marchetti'|'A. Margaritis'|'A. Mariottini'|'A. Markov'|'A. Marshakov'|'A. Martin'|'A. Masiero'|'A. Maslikov'|'A. Matacz'|'A. Math' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Math'|'A. Matsuo'|'A. Matusis'|'A. Matveev'|'A. Matytsin'|'A. Matzner'|'A. M. Awad'|'A. Maznytsia'|'A. Mazumdar'|'A. McGhee'|'A. McLachlan' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. McLachlan'|'A. Medved'|'A. Meessen'|'A. Meisels'|'A. Meissner'|'A. Melchiorri'|'A. Melfo'|'A. Melikyan'|'A. Mello'|'A. Melvin'|'A. Mennim' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Mennim'|'A. Messiah'|'A. Meurman'|'A. Mezhlumian'|'A. M. Ghezelbash'|'A. M. Gleason'|'A. Micu'|'A. Mielke'|'A. Miemiec'|'A.  Migdal'|'A. Migdal' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Migdal'|'A. Mignaco'|'A. Mikhailov'|'A. Mikovi'|'A. Mikovic'|'A. Miller'|'A. Milton'|'A. Minahan'|'A. Mirabelli'|'A. Miransky'|'A. Mironov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Mironov'|'A. Misra'|'A. M. J. Schakel'|'A. Molev'|'A. Momen'|'A. Montero'|'A. Morales-T'|'A. Morel'|'A. Moroz'|'A. Morozov'|'A. Mostafazadeh' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Mostafazadeh'|'A. Moura-Melo'|'A. M. Perelomov'|'A. M. Polyakov'|'A. M. Semikhatov'|'A. M. Sengupta'|'A. M. Tsvelik'|'A. Mueller'|'A. Mukherjee'|'A. Mukhtarov'|'A. M. Uranga' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. M. Uranga'|'A. Muschietti'|'A. M. Vershik'|'A. Naftulin'|'A. Naimark'|'A. Nakamichi'|'A. Nakamura'|'A. Nakayashiki'|'A. Namazie'|'A. Naqvi'|'A. Nayeri' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Nayeri'|'A. Neitzke'|'A. Nekrasov'|'A. Nelson'|'A. Nersessian'|'A. Neveu'|'A. Ni'|'A. Nica'|'A. Nichols'|'A. Nicolaidis'|'A. Niemeyer' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Niemeyer'|'A. Niemi'|'A. Nieto'|'A. Nijenhuis'|'A. N. Ivanov'|'A. N. Kirillov'|'A. N. Kolmogorov'|'A. N. Leznov'|'A. Nogueira'|'A. Nordsieck'|'A. Novicki' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Novicki'|'A. Novikov'|'A. Nowak'|'A. Nowicki'|'A. N. Redlich'|'A. N. Schellekens'|'A. N. Sissakian'|'A. N. Tavkhelidze'|'A. Nudelman'|'A. Nurmagambetov'|'A. N. Vaidya' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. N. Vaidya'|'A. Nyffeler'|'A. O. Barut'|'A. O. Barvinski'|'A. O. Barvinsky'|'A. Obers'|'A. O. Caldeira'|'A. Ocneanu'|'A. Okazaki'|'A. Okopi'|'A. Okopinska' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Okopinska'|'A. Olive'|'A. Olshanetsky'|'A. O. Radul'|'A. Ori'|'A. Orlov'|'A. Orszag'|'A. O. Starinets'|'A. Ovrut'|'A. Padilla'|'A. Pagnamenta' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Pagnamenta'|'A. Pais'|'A. Palanques-Mestre'|'A. Pando'|'A. Pando-Zayas'|'A. Pankiewicz'|'A. Papadopoulos'|'A. Papapetrou'|'A. Papazoglou'|'A. Paredes'|'A. Parkes' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Parkes'|'A. Parnachev'|'A. Pashnev'|'A. Pasquinucci'|'A. Patk'|'A. Patkos'|'A. Patrascioiu'|'A. Paulin-Campbell'|'A. P. Ba'|'A. P. Balachandran'|'A. P. Billyard' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. P. Billyard'|'A. P. C. Malbouisson'|'A. Pearce'|'A. Peet'|'A. Pelissetto'|'A. Pelster'|'A. Perelomov'|'A. Peres'|'A. Perez'|'A. Perez-Lorenzana'|'A. Perkins' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Perkins'|'A. Perlmutter'|'A. Peter'|'A. Peterman'|'A. Petermann'|'A. Petkos'|'A. Petkou'|'A. Phys'|'A. Pich'|'A. Pichugin'|'A. Pickering' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Pickering'|'A. Pinzul'|'A. P. Isaev'|'A. P. Nersessian'|'A. Pocklington'|'A. Polishchuk'|'A. Polyakov'|'A. Polychronakos'|'A. Pomarol'|'A. Popov'|'A. Postnikov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Postnikov'|'A. P. Polychronakos'|'A. P. Prudnikov'|'A. Pressley'|'A. Proca'|'A. Pruisken'|'A. P. Zubarev'|'A. Radicati'|'A. Radul'|'A. Rajaraman'|'A. Rakhmanov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Rakhmanov'|'A. Ram'|'A. Ramallo'|'A. Ramani'|'A. Rasheed'|'A. Rasin'|'A. R. Bishop'|'A. Rebhan'|'A. Recknagel'|'A. Redlich'|'A. Refolli' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Refolli'|'A. Rendall'|'A. Rennie'|'A. Reshetnyak'|'A. Restuccia'|'A. R. Frey'|'A. R. Hibbs'|'A. Ridgway'|'A. Rieffel'|'A. Rimini'|'A. Ringwald' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Ringwald'|'A. Riotto'|'A. R. Its'|'A. Ritz'|'A. Rivero'|'A. R. Liddle'|'A. Rocha'|'A. Rocha-Caridi'|'A. Rodrigues'|'A. Rodriguez'|'A. Rogers' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Rogers'|'A. Roman'|'A. Romeo'|'A. Rosenberg'|'A. Rosly'|'A. Ross'|'A. Rouet'|'A. Roy'|'A. Rozenberg'|'A. R. Steif'|'A. Rubakov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Rubakov'|'A. Rubin'|'A. Rytchkov'|'A. R. Zhitnitsky'|'A. Saa'|'A. Sabra'|'A. Sadrzadeh'|'A. Sagnotti'|'A. Sahakyan'|'A. Sako'|'A. Salam' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Salam'|'A. Sandulescu'|'A. Sankaranarayanan'|'A. Santambrogio'|'A. Santos'|'A. Savoy'|'A. S. Cattaneo'|'A. Sch'|'A. Schaale'|'A. Schaposnik'|'A. Schellekens' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Schellekens'|'A. Schild'|'A. Schilling'|'A. Schirrmacher'|'A. Schouten'|'A. Schwartz'|'A. Schwarz'|'A. Schwimmer'|'A. Sciarrino'|'A. Scrucca'|'A. S. Dancer' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. S. Dancer'|'A. Seaton'|'A. Selberg'|'A. Selby'|'A. Semenov-Tian'|'A. Semenov-Tyan'|'A. Semikhatov'|'A.  Sen'|'A. Sen'|'A. Sengupta'|'A. Sevrin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Sevrin'|'A. S. Fokas'|'A. S. Galperin'|'A. S. Goldhaber'|'A. Shabat'|'A. Shafiekhani'|'A. Shapere'|'A. Shapiro'|'A. Sharakin'|'A. Sharapov'|'A. Shiekh' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Shiekh'|'A. Shifman'|'A. Shirzad'|'A. Shomer'|'A. Shovkovy'|'A. Shubin'|'A. Sierra'|'A. Silva'|'A. Simoni'|'A. Simonov'|'A. Singh' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Singh'|'A. Sinha'|'A. Sinkovics'|'A. Sirlin'|'A. Sitarz'|'A. Sitenko'|'A. S. Koshelev'|'A. Slavnov'|'A. Sloane'|'A. Smailagic'|'A. Smilga' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Smilga'|'A. Smirnov'|'A. Smoller'|'A. Sokal'|'A. Sokolov'|'A. Solovev'|'A. Soloviev'|'A. Sommerfeld'|'A. Soni'|'A. Sood'|'A. Sorin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Sorin'|'A. Sornborger'|'A. Soroka'|'A. Srivastava'|'A. S. Schwartz'|'A. S. Schwarz'|'A. Starinets'|'A. Starobinski'|'A. Starobinskii'|'A. Starobinsky'|'A. Staruszkiewicz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Staruszkiewicz'|'A. Stebbins'|'A. Stegun'|'A. Steif'|'A. Stein'|'A. Stephanov'|'A. Stern'|'A. Strohmaier'|'A.  Strominger'|'A. Strominger'|'A. Strumia' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Strumia'|'A. Subramanian'|'A. Sudb'|'A. Sudbery'|'A. Sugamoto'|'A. Sutulin'|'A. S. Vshivtsev'|'A. S. Vytheeswaran'|'A. Swann'|'A. Swieca'|'A. S. Wightman' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. S. Wightman'|'A. Szczepaniak'|'A. Szenes'|'A. S. Zhedanov'|'A. Tagirov'|'A. Takahashi'|'A. Takhtadzhyan'|'A. Takhtajan'|'A. Tanaka'|'A. Tanzini'|'A. Taormina' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Taormina'|'A. Taranc'|'A. Teleman'|'A. Terras'|'A. Teukolsky'|'A. T. Filippov'|'A. T. Fomenko'|'A. Tjon'|'A. Todorov'|'A. Tofighi'|'A. Tokura' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Tokura'|'A. Tomasiello'|'A. Tomimatsu'|'A. Tonomura'|'A. Tracy'|'A. Tran'|'A. Trautman'|'A. Travesset'|'A. Trias'|'A. Trugenberger'|'A.  Tseytlin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A.  Tseytlin'|'A. Tseytlin'|'A. Tsokur'|'A. Tsuchiya'|'A. T. Suzuki'|'A. Tsvelik'|'A. Tsyetlin'|'A. Turbiner'|'A. Tureanu'|'A. Tyurin'|'A. Uchiyama' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Uchiyama'|'A. Ukawa'|'A. Uranga'|'A. Ushveridze'|'A. Vaccarino'|'A. Vainshtein'|'A. Vainstein'|'A. Vaintrob'|'A. Vairo'|'A. Valle'|'A. Valleriani' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Valleriani'|'A.  Van'|'A. Van'|'A. Varchenko'|'A. Vasilev'|'A. Vasiliev'|'A. Vazquez-Mozo'|'A. Veselov'|'A. Vilenkin'|'A. Vilkoviskii'|'A. Vilkovisky' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Vilkovisky'|'A. Virasoro'|'A. Vladimirov'|'A. V. Manohar'|'A. V. Matytsin'|'A. V. Mikhailov'|'A. Volkov'|'A. Volovich'|'A. Voronov'|'A. Voros'|'A. V. Ramallo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. V. Ramallo'|'A. V. Razumov'|'A. V. Smilga'|'A. V. Turbiner'|'A. V. Yung'|'A. V. Zabrodin'|'A. Waldron'|'A. Walton'|'A. Wang'|'A. Weber'|'A. Weidenm' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Weidenm'|'A. Weil'|'A. Weingartshofer'|'A. Weinstein'|'A. Weldon'|'A. Westerberg'|'A. Weston'|'A. Wheeler'|'A. White'|'A. Widom'|'A. Wiedemann' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Wiedemann'|'A. Wightman'|'A. Wilch'|'A. Wilkins'|'A. William'|'A. Wilson'|'A. Wipf'|'A. Wirzba'|'A. Wisskirchen'|'A. W. Knapp'|'A. W. Ludwig' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. W. Ludwig'|'A. Wolf'|'A. Wolpert'|'A. W. Peet'|'A. W. Schreiber'|'A. W. Steiner'|'A. W. W. Ludwig'|'A. Y. Alekseev'|'A. Yildiz'|'A. Yost'|'A. Yu' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Yu'|'A. Yung'|'A. Zabrodin'|'A. Zaccone'|'A. Zadra'|'A. Zaffaroni'|'A. Zaks'|'A. Zamolodchikov'|'A. Zampa'|'A. Zapletal'|'A. Z. Capri' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Z. Capri'|'A. Zee'|'A. Zeilinger'|'A. Zelnikov'|'A. Zentella'|'A. Zheltukhin'|'A. Zhitnitsky'|'A. Zhuk'|'A. Zichichi'|'A. Zimerman'|'A. Z. Petrov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'A. Z. Petrov'|'A. Zubkov'|'A. Zuk'|'B. A. Bassett'|'B. Abdalla'|'B. Abdesselam'|'B. A. Campbell'|'B. Acharya'|'B. A. Dobrescu'|'B. A. Dubrovin'|'B. A. Khesin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. A. Khesin'|'B. Alkalaev'|'B. Allen'|'B. Andreas'|'B. A. Ovrut'|'B. Bagchi'|'B. Bajc'|'B. Balantekin'|'B. Bassett'|'B. Basumallick'|'B. Basu-Mallick' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Basu-Mallick'|'B. B. Deo'|'B. Bednarz'|'B. Beg'|'B. Benaoum'|'B. Berestetskii'|'B. Berg'|'B. Bergerhoff'|'B. Bertotti'|'B. Binegar'|'B. Biran' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Biran'|'B. Birnir'|'B. Blackadar'|'B. Blok'|'B. Bogomol'|'B. Bogomolny'|'B. Boisseau'|'B. Bonner'|'B. Bost'|'B. Br'|'B. Brinne' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Brinne'|'B. Broda'|'B. Bruegmann'|'B. Campbell'|'B. Carneiro'|'B. Carter'|'B. Chakraborty'|'B. Chen'|'B. Cheng'|'B. Chibisov'|'B. Cleaver' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Cleaver'|'B. Conlong'|'B. Craps'|'B. Creamer'|'B. Cui'|'B. Davies'|'B. De'|'B. Delamotte'|'B. Denby'|'B. Derrida'|'B. D. Jones' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. D. Jones'|'B. Dolan'|'B. Drabant'|'B. Dragovich'|'B. Dubrovin'|'B. Duplantier'|'B. Durhuus'|'B. Dynkin'|'B. Eckmann'|'B. Eden'|'B. Efetov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Efetov'|'B. E. Fridling'|'B. Einhorn'|'B. Enriquez'|'B. E. W. Nilsson'|'B. Eynard'|'B. Fairlie'|'B. Fantechi'|'B. Fauser'|'B. Fedosov'|'B. Feigin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Feigin'|'B. Felsager'|'B. Feng'|'B. Field'|'B. Fiol'|'B. Florea'|'B. Freedman'|'B. Frenkel'|'B. F. Samsonov'|'B. F. Schutz'|'B. F. Svaiter' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. F. Svaiter'|'B. Fuchs'|'B. Fuks'|'B. F. Whiting'|'B. Gato-Rivera'|'B. Gaveau'|'B. Geyer'|'B. Ghosh'|'B. Giddings'|'B. Gilkey'|'B. G. Nickel' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. G. Nickel'|'B. Grammaticos'|'B.  Green'|'B. Green'|'B. Greene'|'B. Griffiths'|'B. Grinstein'|'B. Gross'|'B. Grossman'|'B. Gruber'|'B. G. Schmidt' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. G. Schmidt'|'B. G. Wybourne'|'B. Haeri'|'B. H. Allen'|'B. Halperin'|'B. Halpern'|'B. Hammou'|'B. Hanna'|'B. Harms'|'B. Hartle'|'B. Hartmann' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Hartmann'|'B. Hasslacher'|'B. Hatfield'|'B. Haugen'|'B. Hill'|'B. Hindmarsh'|'B. H. Lian'|'B. Hoffmann'|'B. Holdom'|'B. Holstein'|'B. Hunt' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Hunt'|'B. Idri'|'B. I. Halperin'|'B. Iochum'|'B. Isaak'|'B. Isakov'|'B. Jancewicz'|'B. Janssen'|'B. J. Carr'|'B. Jensen'|'B. Julia' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Julia'|'B. Jur'|'B. Jurco'|'B. J. Warr'|'B. Kaganovich'|'B. Kaplan'|'B. Kastening'|'B. K. Chung'|'B. Khesin'|'B. Khriplovich'|'B. Kibble' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Kibble'|'B. Kim'|'B. Kiritsis'|'B. Klaiber'|'B. Kleihaus'|'B. Kleijn'|'B. Knaepen'|'B. Kobakhidze'|'B. Kogut'|'B. Kol'|'B. Konopelchenko' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Konopelchenko'|'B. Kopeliovich'|'B. Kors'|'B. Kostant'|'B. Krishnan'|'B. Kronheimer'|'B. Kulik'|'B. Kupershmidt'|'B. Kurdikov'|'B. Kursonoglu'|'B. Kuznetsov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Kuznetsov'|'B. Kyae'|'B. Lahanas'|'B. L. Altshuler'|'B. Lang'|'B. Laughlin'|'B. Lautrup'|'B. Lawson'|'B. L. Cerchiai'|'B. Lee'|'B. L. Feigin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. L. Feigin'|'B. L. Hu'|'B. Li'|'B. Lian'|'B. Liao'|'B. Linet'|'B. Lucini'|'B. L. Voronov'|'B. Mandelzweig'|'B. Mann'|'B. Marston' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Marston'|'B. Mashhoon'|'B. Matveev'|'B. M. Barbashov'|'B. McClain'|'B. McCoy'|'B. McInnes'|'B. Medvedev'|'B. Mensky'|'B. Mielnik'|'B. Migdal' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Migdal'|'B. Milewski'|'B. Misra'|'B. M. McCoy'|'B. Monserrat'|'B. Morariu'|'B. Morel'|'B. M. Pimentel'|'B. Mueller'|'B. Muller'|'B. Muratori' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Muratori'|'B. M. Zupnik'|'B. Nagel'|'B. Narozhny'|'B. Nelson'|'B. Netterfield'|'B. Nickel'|'B. Nicolescu'|'B. Nielsen'|'B. Niemeyer'|'B. Nienhuis' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Nienhuis'|'B. Nilsson'|'B. Nodland'|'B. Okun'|'B. Ovrut'|'B. Paranjape'|'B. P. Barber'|'B. P. Dolan'|'B. Pearson'|'B. Peeters'|'B. Perkins' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Perkins'|'B. Petersson'|'B. Petkova'|'B. P. Flannery'|'B. Piette'|'B. Pioline'|'B. P. Kosyakov'|'B. P. Mandal'|'B. Podolsky'|'B. Ponsot'|'B. Pontecorvo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Pontecorvo'|'B. Raabe'|'B. Radak'|'B. Rai'|'B. Ramos'|'B. Ratner'|'B. Ratra'|'B. Ray'|'B. R. Greene'|'B. R. Holstein'|'B. Rosenstein' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Rosenstein'|'B. Rostand'|'B. Roth'|'B. Rusakov'|'B. R. Zhou'|'B. S. Acharya'|'B. Sakita'|'B. Samsonov'|'B. Sathiapalan'|'B. Sazdovi'|'B. S. Balakrishna' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. S. Balakrishna'|'B. Schellekens'|'B. Schmidke'|'B. Schroer'|'B. Schroers'|'B. Schwesinger'|'B. S. De'|'B. Segal'|'B. Selipsky'|'B. Shabat'|'B. Simon' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Simon'|'B. Skagerstam'|'B. S. Kay'|'B. Spence'|'B. Spendig'|'B. S. Shastry'|'B. S. Skagerstam'|'B. Stefa'|'B. Stefanski'|'B. Stenzel'|'B. Strachan' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Strachan'|'B. Sturmfels'|'B. Su'|'B. Sundborg'|'B. Suris'|'B. Sutherland'|'B. Svetitsky'|'B. Tausk'|'B. Tekin'|'B. Thacker'|'B. Thaller' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Thaller'|'B. Thorn'|'B. Treiman'|'B. Van'|'B. Venkov'|'B. Vinberg'|'B. Voloshin'|'B. Wang'|'B. Warr'|'B. Wecht'|'B. West' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. West'|'B. W. Fatyga'|'B. Whitt'|'B. Wiegman'|'B. Wiegmann'|'B. Wise'|'B. W. Lee'|'B. Wolf'|'B. W. Xu'|'B. Yan'|'B. Ydri' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Ydri'|'B. Y. Hou'|'B. Yurke'|'B. Zamolodchikov'|'B. Zel'|'B. Zeldovich'|'B. Zellermann'|'B. Zhang'|'B. Zheng'|'B. Zhou'|'B. Zuber' => { printf("token: %sn", std::string(ts, te).c_str()); };
'B. Zuber'|'B.  Zumino'|'B. Zumino'|'B. Zupnik'|'B. Zweibach'|'B. Zwiebach'|'C. Abraham'|'C. Abreu'|'C. Acatrinei'|'C. Acerbi'|'C. Adam' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Adam'|'C. Adams'|'C. A. Garc'|'C. A. G. Sasaki'|'C. Ahn'|'C. Aichelburg'|'C. Alcaraz'|'C. Alexandrou'|'C. A. Lutken'|'C. Aneziris'|'C. Angelantonj' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Angelantonj'|'C. A. P. Galv'|'C. Aragone'|'C. Argyres'|'C. Arvanitis'|'C. A. S. Almeida'|'C. A. Savoy'|'C. A. Scrucca'|'C. A. Tracy'|'C. A. Trugenberger'|'C. Avram' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Avram'|'C. Bachas'|'C. Baez'|'C. Bagnuls'|'C. Baillie'|'C. Barcel'|'C. Barcelo'|'C. Barnes'|'C. Bartocci'|'C. Batlle'|'C. Battle' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Battle'|'C. Beasley'|'C. Becchi'|'C. Becci'|'C. Beetle'|'C. Bender'|'C. Bento'|'C. Berg'|'C. Bernard'|'C. Bervillier'|'C. Biedenharn' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Biedenharn'|'C. Bizdadea'|'C. B. Lang'|'C. Bloch'|'C. Borcea'|'C. Boyer'|'C. Brans'|'C. Breckenridge'|'C. Brower'|'C. Brown'|'C. Brunelli' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Brunelli'|'C. B. Thorn'|'C. Burges'|'C. Burgess'|'C. Cadavid'|'C. Callan'|'C. Callias'|'C. Carath'|'C. Cartier'|'C. Castro'|'C. C. Gerry' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. C. Gerry'|'C. Chamon'|'C. Charmousis'|'C. Chen'|'C. Cheng'|'C. Chevalley'|'C. Chiou-Lahanas'|'C. Chou'|'C. Chryssomalakos'|'C. Chu'|'C. Collins' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Collins'|'C. Corben'|'C. Crnkovi'|'C. Crnkovic'|'C. Crojean'|'C. Cronstr'|'C. Cs'|'C. Csaki'|'C. Curtis'|'C. Daskaloyannis'|'C. Davies' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Davies'|'C. Davis'|'C. De'|'C. Deffayet'|'C. Deliduman'|'C. Destri'|'C. Devchand'|'C. D. Fosco'|'C. D. Froggatt'|'C. Di'|'C. Diamantini' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Diamantini'|'C. Domb'|'C. Dong'|'C. Doran'|'C. Dunbar'|'C. Dunning'|'C. Duval'|'C. Eberlein'|'C. E. Carlson'|'C. Efthimiou'|'C. Ekstrand' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Ekstrand'|'C. Emmrich'|'C. E. M. Wagner'|'C. Faber'|'C. Fabre'|'C. Fabris'|'C. Farina'|'C. Fefferman'|'C. F. E. Holzhey'|'C. F. Kristjansen'|'C. Ford' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Ford'|'C. Fosco'|'C. Fr'|'C. Fraser'|'C. Froggatt'|'C. Fronsdal'|'C. F. Talavera'|'C. Ganchev'|'C. Gattringer'|'C. G. Bollini'|'C. G. Callan' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. G. Callan'|'C. Georgalas'|'C. Germani'|'C. Ghirardi'|'C. Godr'|'C. Gomez'|'C. Gonera'|'C. Gong'|'C. Gordon'|'C. Gossard'|'C. Graham' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Graham'|'C. Grojean'|'C. Grosche'|'C.  G.  Stueckelberg'|'C. G. Torre'|'C. Gundlach'|'C. Gunning'|'C. Ha'|'C. Hagen'|'C. Hanna'|'C. Herdeiro' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Herdeiro'|'C. Herrmann'|'C. Hill'|'C. Hirshfeld'|'C. H. Lee'|'C. H. Llewellyn'|'C. H. Mousatov'|'C. Hofman'|'C. H. Oh'|'C. Hohenberg'|'C. Holzhey' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Holzhey'|'C. H. Taubes'|'C. Hull'|'C. Hunter'|'C. Hurtubise'|'C. I. Lazaroiu'|'C. Imbimbo'|'C. Isham'|'C. I. Tan'|'C. Itoi'|'C. Itzikson' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Itzikson'|'C. Itzykson'|'C. Jantzen'|'C. Jarlskog'|'C. Jayewardena'|'C. Jeffrey'|'C. J. Efthimiou'|'C. J. Houghton'|'C. J. Hunter'|'C. J. Isham'|'C. Johnson' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Johnson'|'C. Joshi'|'C. J. Pickard'|'C. Kalloniatis'|'C. Kane'|'C. Kao'|'C. Kassel'|'C. Kennedy'|'C. Khanna'|'C. Kiefer'|'C. Kim' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Kim'|'C. King'|'C. K. Kim'|'C. Klim'|'C. Klimcik'|'C. Kneipp'|'C. Koehl'|'C. Kokorelis'|'C. Kolda'|'C. Kopper'|'C. Korff' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Korff'|'C. Korthals-Altes'|'C. Kounnas'|'C. Kraan'|'C. Kristjansen'|'C. K. Zachos'|'C. Laberge'|'C. Lanczos'|'C. Lazaroiu'|'C. Le'|'C. Lee' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Lee'|'C. Lescop'|'C. Leung'|'C. Lewellen'|'C. L. Hammer'|'C. Liao'|'C. Linhares'|'C. Liu'|'C. L. Kane'|'C. Lopez'|'C. Loust' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Loust'|'C. Lousto'|'C. Lovelace'|'C. Lozano'|'C. Lu'|'C. Lubensky'|'C. Lucchesi'|'C. Luciuk et al'|'C. Luperini'|'C. Malbouisson'|'C. Manogue' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Manogue'|'C. Manuel'|'C. Marino'|'C. Mart'|'C. Martin'|'C. Martinez'|'C. Marzban'|'C. Mattis'|'C. M. Bender'|'C. M. Caves'|'C. M. Chambers' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. M. Chambers'|'C. McKeon'|'C. M. De'|'C. Meyers'|'C. M. Fraser'|'C. M. Hull'|'C. Michael'|'C. Mintchev'|'C. Misner'|'C. M. Na'|'C. Molina' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Molina'|'C. Molina-Par'|'C. Molina-Paris'|'C. Montonen'|'C. Morningstar'|'C. Morosi'|'C. M. Sommerfield'|'C. Mu'|'C. Mudry'|'C. Munoz'|'C. M. Viallet' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. M. Viallet'|'C. M. Will'|'C. Myers'|'C. M. Yung'|'C. Na'|'C. Nappi'|'C. Nash'|'C. Nayak'|'C. Nemes'|'C. Neves'|'C. Newell' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Newell'|'C. N. Ferreira'|'C. Niemeyer'|'C. N. Ktorides'|'C. N. Leung'|'C. Nohl'|'C. N. Pope'|'C. Nu'|'C. Nunez'|'C. N. Yang'|'C. Okonek' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Okonek'|'C. O. Lousto'|'C. Osborn'|'C. Ottewill'|'C. Page'|'C. Park'|'C. Parrinello'|'C. Pati'|'C. Pauli'|'C. P. Bachas'|'C. P. Boyer' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. P. Boyer'|'C. P. Burgess'|'C. P. Constantinidis'|'C. Pena'|'C. Penner'|'C. Perez'|'C. Peters'|'C. Peterson'|'C. Petkou'|'C. P. Herzog'|'C. Pierleoni' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Pierleoni'|'C. Pinheiro'|'C. Piron'|'C. P. Korthals'|'C. P. Korthals-Altes'|'C. Plefka'|'C. P. Mart'|'C. P. Martin'|'C. P. Natividade'|'C. Polkinghorne'|'C. Pope' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Pope'|'C. Popescu'|'C. Preitschopf'|'C. Price'|'C. Procesi'|'C. Pryke'|'C. P. Yang'|'C. Queiroz'|'C. Quesne'|'C. Quigg'|'C. R. Acad' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. R. Acad'|'C. Ram'|'C. Ramirez'|'C. Rashkov'|'C. Rasinariu'|'C. Rebbi'|'C. Reina'|'C. Ren'|'C. Reutenauer'|'C. R. Graham'|'C. R. Hagen' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. R. Hagen'|'C. Rim'|'C. R. Nappi'|'C. Roberts'|'C. Robinson'|'C. Rogers'|'C. Roiesnel'|'C. Rojas'|'C. Romelsberger'|'C. R. Ord'|'C. Rosenzweig' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Rosenzweig'|'C. Rossi'|'C. Rota'|'C. Rovelli'|'C. R. Preitschopf'|'C. R. Stephens'|'C. Rupp'|'C. Sa'|'C. Saclioglu'|'C. Santos'|'C. Savoy' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Savoy'|'C. Scheich'|'C. Schieve'|'C. Schmid'|'C. Schmidhuber'|'C. Schomblond'|'C. S. Chu'|'C. Schubert'|'C. Schwartz'|'C. Schweigert'|'C. Schwiebert' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Schwiebert'|'C. Scrucca'|'C. Shepley'|'C. Siklos'|'C. Simpson'|'C. Sivaram'|'C. Skordis'|'C. S. Lam'|'C. Sochichiu'|'C. Sommerfield'|'C. Song' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Song'|'C. Soo'|'C. Stern'|'C. Stichel'|'C. Stornaiolo'|'C. S. Xiong'|'C. Talstra'|'C. Tan'|'C. Tang'|'C. Taubes'|'C. Taylor' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Taylor'|'C.  Teitelboim'|'C. Teitelboim'|'C. T. Hill'|'C. Thompson'|'C. Thorn'|'C. Titchmarsh'|'C. Tolman'|'C. Tracy'|'C. Truffin'|'C. Trugenberger' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Trugenberger'|'C. Tsamis'|'C. Tsui'|'C. Tze'|'C. Ungarelli'|'C.  Vafa'|'C. Vafa'|'C. Vagenas'|'C. Varilly'|'C. Vasconcellos'|'C. Vaz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Vaz'|'C. Viallet'|'C. V. Johnson'|'C. Voisin'|'C. V. Sukumar'|'C. Wali'|'C. Wallet'|'C. Wang'|'C. Ward'|'C. Warner'|'C. Wendt' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Wendt'|'C.  West'|'C. West'|'C. Wetterich'|'C. Wick'|'C. Wieczerkowski'|'C. Wiesendanger'|'C. W. Misner'|'C. Wotzasek'|'C. Wu'|'C. Yang' => { printf("token: %sn", std::string(ts, te).c_str()); };
'C. Yang'|'C. Yen'|'C. Y. Lee'|'C. Y. Lin'|'C. Zachos'|'C. Zhai'|'C. Zhang'|'C. Zhao'|'C. Zhu'|'D. A. Cox'|'D. A. Depireux' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. A. Depireux'|'D. A. Eliezer'|'D. A. Gorokhov'|'D. A. Huse'|'D. A. Kastor'|'D. A. Kirzhnits'|'D. A. Kosower'|'D. A. Leites'|'D. A. Lowe'|'D. Altschuler'|'D. Amado' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Amado'|'D. Amati'|'D. Andreev'|'D. Anselmi'|'D. Antonov'|'D. A. Owen'|'D. A. Popov'|'D. A. Rasheed'|'D. A. R. Dalvit'|'D. Armand-Ugon'|'D. Arnaudon' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Arnaudon'|'D. Arovas'|'D. A. Sahakyan'|'D. A. Samuel'|'D. Atkinson'|'D. Axen'|'D. A. Young'|'D. Bahns'|'D. Bailin'|'D. Bak'|'D. Bakalov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Bakalov'|'D. Ball'|'D. Barclay'|'D. Bar-Natan'|'D. Barrow'|'D. Bazeia'|'D. Bekenstein'|'D. Bellisai'|'D. Belov'|'D. Berenstein'|'D. Berman' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Berman'|'D. Bernard'|'D. Bernstein'|'D. Bessis'|'D. B. Fairlie'|'D. B. Fuchs'|'D. Bigatti'|'D. Binosi'|'D. Birmingham'|'D. Birrel'|'D. Birrell' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Birrell'|'D. Bjorken'|'D. B. Kaplan'|'D. Blaschke'|'D. Blum'|'D. Bohm'|'D. Bonatsos'|'D. Boulatov'|'D. Boulware'|'D. Boyanovsky'|'D. Brace' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Brace'|'D. B. Ray'|'D. Brecher'|'D. Brill'|'D. Brown'|'D. Brydges'|'D. Bryman'|'D. Buchanan'|'D. Buchholz'|'D. Cabra'|'D. Cangemi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Cangemi'|'D. Carlitz'|'D. C. Cabra'|'D. C. Dunbar'|'D. Chalonge'|'D. Chang'|'D. Chatterjee'|'D. Chitre'|'D. Choudhury'|'D. Christensen'|'D. Christodoulou' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Christodoulou'|'D. Chru'|'D. Chung'|'D. Clancy'|'D. C. Lewellen'|'D. C. Mattis'|'D. Cohen'|'D. Cohn'|'D. Colladay'|'D. Coon'|'D. Coughlan' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Coughlan'|'D. Cox'|'D. Cremades'|'D. C. Tsui'|'D. Dalmazi'|'D. De'|'D. Depireux'|'D. Deutsch'|'D. Diaconescu'|'D. Diakonov'|'D. Dissertation' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Dissertation'|'D. Doebner'|'D. Dolgov'|'D. Dominici'|'D. Drell'|'D. Dudal'|'D. Easson'|'D. Ebert'|'D. Edelstein'|'D. E. Diaconescu'|'D. Eisenbud' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Eisenbud'|'D. E. Kaplan'|'D. Eliezer'|'D. Ellinas'|'D. Ellis'|'D. E. Soper'|'D. Espriu'|'D. Evans'|'D. Fabbri'|'D. Faddeev'|'D. Faddev' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Faddev'|'D. Fadeev'|'D. Fairlie'|'D. Fay'|'D. Fine'|'D. Finkelstein'|'D. Finley'|'D. Finnell'|'D. Fioravanti'|'D. Fliegner'|'D. F. Litim' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. F. Litim'|'D. Foerster'|'D. Fosco'|'D. Francia'|'D. Freed'|'D. Freedman'|'D. Freeman'|'D. Fried'|'D. Friedan'|'D. Friedman'|'D. Froggatt' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Froggatt'|'D. Fuchs'|'D. Fursaev'|'D. Gaiotto'|'D. Gal'|'D. Gangopadhyay'|'D. Garfinkel'|'D. Garfinkle'|'D. Gargett'|'D. G. Barci'|'D. G. Boulware' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. G. Boulware'|'D. G. C. McKeon'|'D. Gepner'|'D. Gershon'|'D. Gershun'|'D. G. Gagn'|'D. Ghilencea'|'D. Ghoshal'|'D. Gianzo'|'D. Giulini'|'D. Glazek' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Glazek'|'D. Goldberger'|'D. Gonzales'|'D. Gould'|'D. G. Pak'|'D. Grasso'|'D. G. Robertson'|'D. Gromes'|'D. Gross'|'D. Grumiller'|'D. Guido' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Guido'|'D. H. Adams'|'D. Haldane'|'D. Han'|'D. Harari'|'D. Hari'|'D. Hasler'|'D. Haws'|'D. Hennig'|'D. Hern'|'D. Hestenes' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Hestenes'|'D. H. Feng'|'D. Hilbert'|'D. H. Lin'|'D. H. Lyth'|'D. Hobill'|'D. Hochberg'|'D. Horn'|'D. H. Peterson'|'D. H. Phong'|'D. H. Sharp' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. H. Sharp'|'D. H. Tchrakian'|'D. Husemoller'|'D. Huybrechts'|'D. Iagolnitzer'|'D. Ida'|'D. I. Diakonov'|'D. Iellici'|'D. I. Kazakov'|'D. Imbo'|'D. I. Meiron' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. I. Meiron'|'D. I. Olive'|'D. Ivanenko'|'D. Ivashchuk'|'D. Jackson'|'D. J. Amit'|'D. Jancic'|'D. Jarvis'|'D. Jatkar'|'D. J. A. Welsh'|'D. J. Broadhurst' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. J. Broadhurst'|'D. J. E. Callaway'|'D. Jentschura'|'D. J. Ernst'|'D. J. Fern'|'D. J. Fernandez'|'D. J. Gross'|'D. J. H. Chung'|'D. Jiang'|'D. J. Navarro'|'D. Joglekar' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Joglekar'|'D. Johnson'|'D. Johnston'|'D. Jones'|'D. Joyce'|'D. J. Raine'|'D. J. Schwarz'|'D. J. Smith'|'D. J. Thouless'|'D. J. Toms'|'D. Jungnickel' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Jungnickel'|'D. Kabat'|'D. Kamani'|'D. Kapetanakis'|'D. Kaplan'|'D. Karabali'|'D. Kastler'|'D. Kastor'|'D. Kazhdan'|'D. Kennaway'|'D. Kerlick' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Kerlick'|'D. K. Hong'|'D. Kieu'|'D. Kim'|'D. Klemm'|'D. Korotkin'|'D. K. Park'|'D. Kramer'|'D. Kreimer'|'D. Kribs'|'D. Krupka' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Krupka'|'D. Kruskal'|'D. Kutasov'|'D. La'|'D.  Lambert'|'D. Lambert'|'D. Lancaster'|'D. Landau'|'D. Lane'|'D. Langlois'|'D. Lawrie' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Lawrie'|'D. Lebedev'|'D. Lee'|'D. Lee'|'D. Lemoine'|'D. Levy'|'D. Lewellen'|'D. Li'|'D. Linde'|'D. Lindley'|'D. Litim' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Litim'|'D. Liu'|'D. Louck'|'D. Louis'|'D. Louis-Martinez'|'D. Lovelock'|'D. Lowe'|'D. Luest'|'D. Luri'|'D. Lurie'|'D. Lust' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Lust'|'D. L. Welch'|'D. L. Wiltshire'|'D. Lyakhovsky'|'D. Lykken'|'D. Lynden-Bell'|'D. Lyth'|'D. Maia'|'D. Maison'|'D. Majumdar'|'D. Marfatia' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Marfatia'|'D. Marolf'|'D. Martelli'|'D. Mateos'|'D. Mathur'|'D. Mattingly'|'D. Mattis'|'D. Mazzitelli'|'D. M. Belov'|'D. M. Bressoud'|'D. Mc' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Mc'|'D. M. Capper'|'D. McCrea'|'D. McDuff'|'D. M. Ceperley'|'D. McGuigan'|'D. McLaughlin'|'D. McMullan'|'D. Mermin'|'D. Meyer'|'D. M. Ghilencia' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. M. Ghilencia'|'D. M. Gitman'|'D. Minic'|'D. Mitchell'|'D. M. J. Calderbank'|'D. Montano'|'D. Morrison'|'D. Mouhanna'|'D. Mumford'|'D. Mustaki'|'D. Nanopoulos' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Nanopoulos'|'D. Nash'|'D. Neiman'|'D. Nelson'|'D. Nemechansky'|'D. Nemeschansky'|'D. Nemeshansky'|'D. Neumann'|'D. Newton'|'D. N. Nishnianidze'|'D. Nolland' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Nolland'|'D. Nolte'|'D. Novikov'|'D. N. Page'|'D. N. Spergel'|'D. Nunez'|'D.  Odintsov'|'D. Odintsov'|'D. Olive'|'D. Olivier'|'D. Orlov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Orlov'|'D. Page'|'D. Palev'|'D. Paniak'|'D. Papadopoulos'|'D. Park'|'D. P. Arovas'|'D. Peccei'|'D. Pershin'|'D. Peterson'|'D. Pfautsch' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Pfautsch'|'D. Phong'|'D. Pierotti'|'D. Pines'|'D. Pisarski'|'D. P. Jatkar'|'D. Polarski'|'D. Politzer'|'D. Pollard'|'D. Polyakov'|'D. Popov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Popov'|'D. Prange'|'D. P. Sorokin'|'D. Quillen'|'D. Ray'|'D. R. Brill'|'D. Reidel'|'D. Reynaud'|'D. R. Grigore'|'D. Rindani'|'D. R. Lide' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. R. Lide'|'D. R. Morrison'|'D. R. Nelson'|'D. Robaschik'|'D. Roberts'|'D. Robertson'|'D. Rodney'|'D. Roest'|'D. Rohrlich'|'D. Rolfsen'|'D. Romano' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Romano'|'D. Rothe'|'D. R. T. Jones'|'D. R. Truax'|'D. Ruelle'|'D. Saad'|'D. Sahdev'|'D. Sakharov'|'D. Salamon'|'D. Sanchez-Ruiz'|'D. S. Berman' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. S. Berman'|'D. Schack'|'D. Schiff'|'D. Schroeder'|'D. Schwartz'|'D. Sciama'|'D. Seckel'|'D. Seibert'|'D. Seminara'|'D. Sen'|'D. Senechal' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Senechal'|'D. Serban'|'D. S. Freed'|'D. S. Goldwirth'|'D. Shahar'|'D. Shapere'|'D. Shay'|'D. Shevitz'|'D. Shirkov'|'D. S. Hwang'|'D. Silva' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Silva'|'D. Simons'|'D. Singleton'|'D. Skarzhinsky'|'D. Smith'|'D. Son'|'D. Sorkin'|'D. Sorokin'|'D. Spector'|'D. Speiser'|'D. Spergel' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Spergel'|'D. S. Popovi'|'D. S. Salopek'|'D. St'|'D. Stack'|'D. Starkman'|'D. Stasheff'|'D. Stauffer'|'D. Sternheimer'|'D. Stevenson'|'D. Stewart' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Stewart'|'D. Stojkovic'|'D. Stoler'|'D. Storey'|'D. Stoyanov'|'D. Stuart'|'D. Sudarsky'|'D. Sullivan'|'D. Tabor'|'D. Talalaev'|'D. Testard' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Testard'|'D. Thacker'|'D. Thesis'|'D. Thomas'|'D. Thouless'|'D. Toms'|'D. Tong'|'D. Toublan'|'D. Toussaint'|'D. Tracas'|'D. Tsabar' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Tsabar'|'D. Tsimpis'|'D. T. Son'|'D. Turnbull'|'D. V. Ahluwalia'|'D. Vaman'|'D. Vassilevich'|'D. Vautherin'|'D. V. Boulatov'|'D. Vecchia'|'D. Vergara' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Vergara'|'D. V. Fursaev'|'D. V. Gal'|'D. Villaroel'|'D. V. Nanopoulos'|'D. Voiculescu'|'D. Volkov'|'D. V. Schroeder'|'D. V. Shirkov'|'D. V. Vassilevich'|'D. V. Volkov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. V. Volkov'|'D. Waldram'|'D. Walecka'|'D. Walgraef'|'D. Walsh'|'D. Wands'|'D. Weingarten'|'D. Welch'|'D. Wells'|'D. Wilkinson'|'D. Williams' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Williams'|'D. Wiltshire'|'D. Witt'|'D. W. Sciama'|'D. Wyler'|'D. Xu'|'D. Yetter'|'D. Youm'|'D. Yu'|'D. Zagier'|'D. Zanon' => { printf("token: %sn", std::string(ts, te).c_str()); };
'D. Zanon'|'D. Zappal'|'D. Zeh'|'D. Z. Freedman'|'D. Zhelobenko'|'D. Zwanziger'|'E. Abdalla'|'E. Abe'|'E. A. Bergshoeff'|'E. Abraham'|'E. Agishtein' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Agishtein'|'E. A. Ivanov'|'E. Akhmedov'|'E. Aldrovandi'|'E. Alvarez'|'E. A. Mirabelli'|'E. Andrews'|'E. Angelopoulos'|'E. Arbarello'|'E. Arinshtein'|'E. Artin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Artin'|'E. Arutyunov'|'E. A. Tagirov'|'E. Ay'|'E. Babaev'|'E. Bagan'|'E. Barouch'|'E. B. Bogomol'|'E. B. Bogomolny'|'E. B. Dynkin'|'E. Behrend' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Behrend'|'E. Benedict'|'E. Berbenni-Bitsch'|'E. Bergshoeff'|'E. Billey'|'E. B. Kiritsis'|'E. Bogomol'|'E. Boos'|'E. Borcherds'|'E. Br'|'E. Braaten' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Braaten'|'E. Brezin'|'E. Brittin'|'E. Brown'|'E. Buchbinder'|'E. Buffenoir'|'E. Caceres'|'E. Calabi'|'E. Calzetta'|'E. Carlson'|'E. Carrington' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Carrington'|'E. Cartan'|'E. Caswell'|'E. Celeghini'|'E. C. G. St'|'E. C. G. Stueckelberg'|'E. C. G. Sudarshan'|'E. Cheung'|'E. Clark'|'E. C. Marino'|'E. Coccia' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Coccia'|'E. Cohen'|'E. Copeland'|'E. Corinaldesi'|'E. Corrigan'|'E. Creighton'|'E. Cremer'|'E. Cremmer'|'E. C. Titchmarsh'|'E. Cutkosky'|'E. Dagotto' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Dagotto'|'E. Date'|'E. Del'|'E. Derkachov'|'E. Diaconescu'|'E. Domany'|'E. Donets'|'E. Dorey'|'E. Drigo'|'E. D. Stewart'|'E. Dudas' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Dudas'|'E. E. Flanagan'|'E. Eichten'|'E. Elizalde'|'E. Ercolessi'|'E. E. Salpeter'|'E. Everett'|'E. Eyras'|'E. Fahri'|'E. Faraggi'|'E. Farhi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Farhi'|'E. F. Corrigan'|'E. Fermi'|'E. Ferreira'|'E. Fischbach'|'E. Fisher'|'E. Flanagan'|'E. Floratos'|'E. F. Moreno'|'E. Fradkin'|'E. Fradkina' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Fradkina'|'E. Frenkel'|'E. Fridling'|'E. Fuchs'|'E. Gabrielli'|'E. Gamboa'|'E. Gardi'|'E. Gava'|'E. Gendenshtein'|'E. Getzler'|'E. G. Floratos' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. G. Floratos'|'E. G. Gimon'|'E. Gildener'|'E. Gimon'|'E. Golowich'|'E. Gompf'|'E. Gon'|'E. Goncalves'|'E. Gorbatov'|'E. Gozzi'|'E. Guadagnini' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Guadagnini'|'E. Guitter'|'E. Gunzig'|'E. Haagensen'|'E. Haber'|'E. Halyo'|'E. Harikumar'|'E. Hawkins'|'E. Herlt'|'E. Hetrick'|'E. Hille' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Hille'|'E. Hjelmeland'|'E. H. Lieb'|'E. Holzhey'|'E. H. Saidi'|'E. Hull'|'E. Humphreys'|'E. Iancu'|'E. Ib'|'E. Iba'|'E. Ibanez' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Ibanez'|'E. I. Guendelman'|'E. Imeroni'|'E. In'|'E. Inonu'|'E. Ivanov'|'E. J. Chun'|'E. J. Copeland'|'E. J. Martinec'|'E. Joos'|'E. J. Squires' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. J. Squires'|'E. J. Weinberg'|'E. Kallosh'|'E. Kamke'|'E. Kanzieper'|'E. Kaplan'|'E. Kasner'|'E. Katz'|'E. Keski-Vakkuri'|'E. Kim'|'E. Kiritsis' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Kiritsis'|'E. Klassen'|'E. Knutt'|'E. Knutt-Wehlau'|'E. Kohlprath'|'E. Kolb'|'E. Konstein'|'E. Korepin'|'E. Kraus'|'E. K. Riedel'|'E. K. Sklyanin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. K. Sklyanin'|'E. Kunze'|'E. Laenen'|'E. Laermann'|'E. Langmann'|'E. Lawrence'|'E. L. Gubankova'|'E. Lidsey'|'E. Lieb'|'E. Lifshitz'|'E. Lima' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Lima'|'E. Lim-Lombridas'|'E. Lisi'|'E. Littlewood'|'E. Looijenga'|'E. Lopatin'|'E. Lopes'|'E. Lopez'|'E. Low'|'E. Lubkin'|' {em' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Mavromatos'|'E. M. C. Abreu'|'E. M. Chudnovsky'|'E. M. Cioroianu'|'E. Meggiolaro'|'E. Meinrenken'|'E. Melzer'|'E. Mendel'|'E. Merzbacher'|'E. M. F. Curado'|'E. Miller' => { printf("token: %sn", std::string(ts, te).c_str()); };
' {em'|'E. Madelung'|'E. Maina'|'E. Majorana'|'E. Marinari'|'E. Markman'|'E. Marsden'|'E.  Martinec'|'E. Martinec'|'E.  Mavromatos'|'E. Mavromatos' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Miller'|'E. M. Lifschitz'|'E. M. Lifshits'|'E. M. Lifshitz'|'E. M. Lifshitz'|'E. Montaldi'|'E. Moreno'|'E. Mottola'|'E. Moyal'|'E. M. Sahraoui'|'E. Myers' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Myers'|'E. Napolitano'|'E. Nelson'|'E. Newman'|'E. Nissimov'|'E. Noether'|'E. Novak'|'E. Noz'|'E. N. Parker'|'E. Ogievetsky'|'E. Onofri' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Onofri'|'E. Ortiz'|'E. Osetrin'|'E. Oxman'|'E. Papantonopoulos'|'E. Paton'|'E. Peebles'|'E. Perevalov'|'E. Peskin'|'E. Picasso'|'E. Pirani' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Pirani'|'E. P. Likhtman'|'E. Poisson'|'E. Pont'|'E. Ponton'|'E. Poppitz'|'E. Prange'|'E. Predazzi'|'E. P. S. Shellard'|'E. P. Wigner'|'E. Quattrini' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Quattrini'|'E. Rabinovici'|'E. Ragoucy'|'E. Raiten'|'E. Ramos'|'E. R. Bezerra'|'E. Recami'|'E. Remiddi'|'E. R. Harrison'|'E. Roberts'|'E. Rodriguez' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Rodriguez'|'E. Roessl'|'E. Roulet'|'E. Rudd'|'E. Rugh'|'E. Ruiz'|'E. Salpeter'|'E. Sassaroli'|'E. Schmutzer'|'E. Schr'|'E. Schreiber' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Schreiber'|'E. Segal'|'E. Seiler'|'E. Semenov'|'E. Sezgin'|'E. S. Fradkin'|'E. Shaposhnikov'|'E. Sharpe'|'E. Shilov'|'E. Shrock'|'E. Shuryak' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Shuryak'|'E. Sikkema'|'E. Silverstein'|'E. Sklyanin'|'E. Smith'|'E. Sokachev'|'E. Sokatchev'|'E. Solomin'|'E. Soper'|'E. Sorace'|'E. Spallucci' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Spallucci'|'E. Speer'|'E. Stanley'|'E. Stern'|'E. Sudarshan'|'E. Sweedler'|'E. T. Akhmedov'|'E. Tanaka'|'E. Tarasov'|'E. Taylor'|'E. Teller' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Teller'|'E. Teo'|'E. Thiran'|'E. Tirapegui'|'E. T. Newman'|'E. Tomboulis'|'E. Trubowitz'|'E. Tsai'|'E. T. Tomboulis'|'E. T. Whittaker'|'E. Tyurin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Tyurin'|'E. Uhlenbeck'|'E. Ventura'|'E. Verdaguer'|'E. Verlinde'|'E. Vicari'|'E. Volovik'|'E. V. Prokhvatilov'|'E. V. Shuryak'|'E. Wang'|'E. Waxman' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Waxman'|'E. Wegge-Olsen'|'E. Wehlau'|'E. Weinberg'|'E. Werner'|'E. Whittaker'|'E. Wieczorek'|'E. Wigner'|'E. Winstanley'|'E.  Witten'|'E. Witten' => { printf("token: %sn", std::string(ts, te).c_str()); };
'E. Witten'|'E. W. Kolb'|'E. W. Mielke'|'E. Woolgar'|'E. Zakharov'|'E. Zaslow'|'E. Zehnder'|'F. A. Bais'|'F. Abbot'|'F. Abbott'|'F. Abe' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Abe'|'F. A. Berends'|'F. A. Berezin'|'F. Akman'|'F. Aldabe'|'F. A. Lunev'|'F. Anselmo'|'F. Anton'|'F. Antonsen'|'F. Antonuccio'|'F. Ardalan' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Ardalan'|'F. Arvis'|'F. A. Schaposnik'|'F. A. Shaposnik'|'F. Ashmore'|'F. A. Smirnov'|'F. Atiyah'|'F. Baillie'|'F. Bais'|'F. Barb'|'F. Barbarin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Barbarin'|'F. Barbero'|'F. Barbon'|'F. Bastianelli'|'F. Bayen'|'F. Belgiorno'|'F. Berezin'|'F. Berruto'|'F. Bigazzi'|'F. Bloch'|'F. Bonechi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Bonechi'|'F. Bonjour'|'F. Bordi'|'F. Braga'|'F. Brandt'|'F. Buccella'|'F. Cachazo'|'F. C. Alcaraz'|'F. Calogero'|'F. Cannata'|'F. Caruso' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Caruso'|'F. Chapline'|'F. Chen'|'F. C. Khanna'|'F. C. Lombardo'|'F. Colomo'|'F. Combes'|'F. Constantinescu'|'F. Cooper'|'F. Cordaro'|'F. Cordes' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Cordes'|'F. Cornwell'|'F. Corrigan'|'F. Dashen'|'F. David'|'F. Dayi'|'F. De'|'F. Defever'|'F. Delduc'|'F. Dell'|'F. Denef' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Denef'|'F. Di'|'F. D. Mazzitelli'|'F. D. M. Haldane'|'F. Donoghue'|'F. Dowker'|'F. Dunkl'|'F. Dyson'|'F. E. Low'|'F. Englert'|'F. Ezawa' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Ezawa'|'F. Falceto'|'F. Farchioni'|'F. Ferrari'|'F. Feruglio'|'F. Finelli'|'F. Finkel'|'F. Finster'|'F. Freire'|'F. Fucito'|'F. F. Voronov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. F. Voronov'|'F. Gabbiani'|'F. Geniet'|'F. Gesztesy'|'F. Giani'|'F. Gieres'|'F. Girelli'|'F. Giudice'|'F. Gliozzi'|'F. Gomes'|'F. Gomez' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Gomez'|'F. Gonzalez-Rey'|'F. Green'|'F. Grillo'|'F. Gronwald'|'F. Gross'|'F. G. Scholtz'|'F. G. Tricomi'|'F. Guerra'|'F. Guinea'|'F. Gursey' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Gursey'|'F. Haake'|'F. Hacquebord'|'F. Haider'|'F. Haldane'|'F. Halzen'|'F. Harmsze'|'F. Hasler'|'F. Hassan'|'F. Hewson'|'F. Hirzebruch' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Hirzebruch'|'F. H. L. Essler'|'F. Hoyle'|'F. Hussain'|'F. Iachello'|'F. I. Fedorov'|'F. J. De'|'F. J. Dyson'|'F. Jegerlehner'|'F. J. Ernst'|'F. J. Herranz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. J. Herranz'|'F. Jones'|'F. Jordan'|'F. J. Petriello'|'F. J. Tipler'|'F. J. Wegner'|'F. Kao'|'F. Karsch'|'F. Kirwan'|'F. Klein'|'F. Klinkhamer' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Klinkhamer'|'F. Korepin'|'F. Krahe'|'F. Kristjansen'|'F.  Labastida'|'F. Labastida'|'F. Langouche'|'F. Larsen'|'F. Leblond'|'F. Legovini'|'F. Lenz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Lenz'|'F. Lesage'|'F. Lev'|'F. Leyvraz'|'F. Li'|'F. Lin'|'F. Litim'|'F. Liu'|'F. Lizzi'|'F. London'|'F. Loran' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Loran'|'F. Low'|'F. Lucchin'|'F. Lund'|'F. Magri'|'F. Malikov'|'F. Mandl'|'F. Mansouri'|'F. Marchesano'|'F. Markopoulou'|'F. Mathiot' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Mathiot'|'F. Mende'|'F. Mendez'|'F. Moraes'|'F. Morales'|'F. Moreno'|'F. M. Saradzhev'|'F. Muhammad'|'F. Muhammed'|'F. Mukhanov'|'F. Muller-Hoissen' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Muller-Hoissen'|'F. Neri'|'F. Nesti'|'F. Nicodemi'|'F. Nicoll'|'F. Niedermayer'|'F. Nori'|'F. Oberhettinger'|'F. Occelli'|'F. Occhionero'|'F. Palumbo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Palumbo'|'F. P. Devecchi'|'F. Pezzella'|'F. Piazza'|'F. Picken'|'F. Pillon'|'F. Pleba'|'F. Plebanski'|'F. Prokushkin'|'F. Quevedo'|'F. Raciti' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Raciti'|'F. Rafeli'|'F. Ravanini'|'F. Ravndal'|'F. Riad'|'F. Ribeiro'|'F. Riccioni'|'F. Riva'|'F. R. Klinkhamer'|'F. Rodenas'|'F. Rohrlich' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Rohrlich'|'F. Rohsiepe'|'F. Roose'|'F. Ross'|'F. Roussel'|'F. Ruiz'|'F. Ruiz-Ruiz'|'F. Sannino'|'F. Schaposnik'|'F. Scheck'|'F. Schonfeld' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Schonfeld'|'F. Smirnov'|'F. Smith'|'F. S. Nogueira'|'F. Sohnius'|'F. Steiner'|'F. Streater'|'F. Strocchi'|'F. Sugino'|'F. Svaiter'|'F. Takens' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Takens'|'F. T. Brandt'|'F. Thuillier'|'F. Tighe'|'F. Toppan'|'F. Treves'|'F. Urrutia'|'F. Vakulenko'|'F. Vanderseypen'|'F. Vazquez-Poritz'|'F. Vernizzi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Vernizzi'|'F. Vian'|'F. Villars'|'F. V. Tkachov'|'F. Wagemans'|'F. Walls'|'F. Wegner'|'F. Weisskopf'|'F. Wheater'|'F. W. Hehl'|'F. Whiting' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Whiting'|'F. Wilczeck'|'F. Wilczek'|'F. Williams'|'F. Wilzcek'|'F. Woynarovich'|'F. Yang'|'F. Yu'|'F. Y. Wu'|'F. Zaccaria'|'F. Zachariasen' => { printf("token: %sn", std::string(ts, te).c_str()); };
'F. Zachariasen'|'F. Zamora'|'F. Zertuche'|'F. Zimmerschied'|'F. Zwigner'|'F. Zwirner'|'G. A. Baker'|'G. Adkins'|'G. A. Goldin'|'G. Akdeniz'|'G. Akemann' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Akemann'|'G. Aktas'|'G. Albertini'|'G.  Aldazabal'|'G. Aldazabal'|'G. Alexanian'|'G. Alford'|'G. Altarelli'|'G. Altazabal'|'G. Amaral'|'G. Amelino' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Amelino'|'G. Amelino-Camelia'|'G. Andrews'|'G. Arcioni'|'G. Arutyunov'|'G. A. Vilkovisky'|'G. Avramidi'|'G. A. Wilson'|'G. Bagrov'|'G. Baker'|'G. Bakker' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Bakker'|'G. Bali'|'G. Ballesteros'|'G. Bandelloni'|'G. Barci'|'G. Barnich'|'G. Barton'|'G. Baskaran'|'G. Baym'|'G. Bednorz'|'G. Beneventano' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Beneventano'|'G. Bergmann'|'G. Bertoldi'|'G. B. Field'|'G. Bhanot'|'G. Bimonte'|'G. Birkhoff'|'G. Blatter'|'G. Bollini'|'G. Bonelli'|'G. Bonneau' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Bonneau'|'G. Boulware'|'G. Boyd'|'G. Breit'|'G. Brodimas'|'G. B. Segal'|'G. Bytsko'|'G.  Cai'|'G. Cai'|'G. Caldi'|'G. Callan' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Callan'|'G. Calucci'|'G. Cammarata'|'G. Campbell'|'G. Cardoso'|'G. Carlino'|'G. Casimir'|'G. Chalmers'|'G. Chan'|'G. Chapline'|'G. Cheng' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Cheng'|'G. Chetyrkin'|'G. Cl'|'G. Cleaver'|'G. Clement'|'G. Cognola'|'G. Cohen'|'G. Costa'|'G. Cristofano'|'G. C. Rossi'|'G. Curci' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Curci'|'G. Curio'|'G. C. Wick'|'G. Dall'|'G. Darboux'|'G. Darmois'|'G. De'|'G. Delfino'|'G. Dell'|'G. Demers'|'G. Denardo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Denardo'|'G. Di'|'G. Ding'|'G. Dito'|'G. Dixon'|'G. Domokos'|'G. Dorda'|'G. Dosch'|'G. Dotti'|'G. Drinfel'|'G. Drinfeld' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Drinfeld'|'G. D. Starkman'|'G. Dunne'|'G. Dvali'|'G. E. Andrews'|'G. E. Arutyunov'|'G. Eastwood'|'G. E. Brown'|'G. Ecker'|'G. Edwards'|'G. Eilam' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Eilam'|'G. Ellis'|'G. Emch'|'G. E. Shilov'|'G. Esposito'|'G. Esposito-Far'|'G. Esposito-Farese'|'G. E. Uhlenbeck'|'G. Falkovich'|'G. F. Chapline'|'G. Feinberg' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Feinberg'|'G. Felder'|'G. Ferreti'|'G. Ferretti'|'G. Feverati'|'G. F. Giudice'|'G. Field'|'G. Fiore'|'G. Floratos'|'G. F. R. Ellis'|'G. F. Smoot' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. F. Smoot'|'G. Furlan'|'G. Gabadadze'|'G. Gagn'|'G. Gallavotti'|'G. Gasper'|'G. Gat'|'G. G. Athanasiu'|'G. German'|'G. Ghandour'|'G. Giachetta' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Giachetta'|'G. Giavarini'|'G. Gibbons'|'G. Gimon'|'G. Girardi'|'G. Giribet'|'G. Giudice'|'G. Gomez'|'G. Gorishny'|'G. Gour'|'G. Grignani' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Grignani'|'G. Grinstein'|'G. G. Ross'|'G. Grubb'|'G. Grunberg'|'G. Gubser'|'G. Guralnik'|'G. Hailu'|'G. Halliday'|'G. Hardy'|'G. Harris' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Harris'|'G. Hartwell'|'G. Hayward'|'G. Heckman'|'G. Hirsch'|'G. H. Lee'|'G. Hochschild'|'G. Hockney'|'G. Holzwarth'|'G. Honecker'|'G. Horowitz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Horowitz'|'G. Huang'|'G. Huey'|'G. H. Wannier'|'G. I. Ghandour'|'G. Immirzi'|'G. Ivanov'|'G. Izergin'|'G. Jacksenaev'|'G. Jensen'|'G. J. Galloway' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. J. Galloway'|'G. J. Heckman'|'G. J. Ni'|'G. Jo'|'G. Jona'|'G. Jona-Lasinio'|'G. Jorjadze'|'G. Junker'|'G. J. Zuckerman'|'G. Ka'|'G. Kac' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Kac'|'G. Kalbermann'|'G. Kalnins'|'G. Kane'|'G. Kang'|'G. Karpilovsky'|'G. Kausch'|'G. Keller'|'G. Kelnhofer'|'G. Kennedy'|'G. Kiselev' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Kiselev'|'G. K. Leontaris'|'G. Kleppe'|'G. Klimenko'|'G. Knizhnik'|'G. Kofinas'|'G. Kogut'|'G. Koh'|'G. Konisi'|'G. Korepanov'|'G. Koutsoumbas' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Koutsoumbas'|'G. Kramer'|'G. K. Savvidy'|'G. Kunstatter'|'G. Kuroki'|'G. Laidlaw'|'G. Lambiase'|'G. Landi'|'G. Landsberg'|'G. Lauwers'|'G. Lavrelashvili' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Lavrelashvili'|'G. Lazarides'|'G. L. Cardoso'|'G. Leibbrandt'|'G. Leigh'|'G. Leontaris'|'G. Lifschytz'|'G. Lin'|'G. Lindblad'|'G. L. Kane'|'G. Longhi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Longhi'|'G. Lopes'|'G. Lopez'|'G. Loyola'|'G. Lozano'|'G. L. Rossini'|'G. L. Sewell'|'G. Lusztig'|'G. Luz'|'G. Luzon'|'G. Mac' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Mac'|'G. Macdonald'|'G. Mack'|'G. Magli'|'G. Magnano'|'G. Mahoux'|'G. Maiella'|'G. Malikov'|'G. Mamaev'|'G. Mandal'|'G. Mangano' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Mangano'|'G. Marchesini'|'G. Marmo'|'G. Martinelli'|'G. Mason'|'G. Matinian'|'G. Matinyan'|'G. McCartor'|'G. McKay'|'G. McLenaghan'|'G. Meinardus' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Meinardus'|'G. Meissner'|'G. M. Gandenberger'|'G. Miao'|'G. Michaud'|'G. Miele'|'G. Mitreuter'|'G. Modanese'|'G. Montambaux'|'G. Moore'|'G. Morandi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Morandi'|'G. Morchio'|'G. Moss'|'G. M. Shore'|'G. M. Sotkov'|'G. M. T. Watts'|'G. Murthy'|'G. Mussardo'|'G. Myhill'|'G. Naculich'|'G. Nardelli' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Nardelli'|'G. Neugebauer'|'G. Newton'|'G. Nickel'|'G. Nikitin'|'G. N. Watson'|'G. Oh'|'G. Paffuti'|'G. Pak'|'G. Palma'|'G. Papadopoulos' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Papadopoulos'|'G. Papadopulos'|'G. Papageorgiou'|'G. Papp'|'G. Paquette'|'G. Parisi'|'G. Passarino'|'G. Peradze'|'G. Petrova'|'G. Pettini'|'G. Piacitelli' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Piacitelli'|'G. Piette'|'G. Pinter'|'G. Pirozhenko'|'G. P. Korchemsky'|'G. P. Lepage'|'G. Pletnev'|'G. Plunien'|'G. Pogosyan'|'G. Polhemus'|'G. Pollifrone' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Pollifrone'|'G. Ponzano'|'G. Popineau'|'G. Pradisi'|'G. Preparata'|'G. Raffelt'|'G. Rajasekaran'|'G. Rajeev'|'G. Rajesh'|'G. Reyman'|'G. R. Golner' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. R. Golner'|'G. Riess'|'G. Ripka'|'G. Rivlis'|'G. Rizzo'|'G. Roberts'|'G. Robertson'|'G. Root'|'G. Ross'|'G. Rossi'|'G. Rossini' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Rossini'|'G. Rudolph'|'G. Russo'|'G. R. Zemba'|'G. S. Adkins'|'G. S. Agarwal'|'G. Salesi'|'G. Sardanashvily'|'G. Sarkissian'|'G. Sartori'|'G. Sasaki' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Sasaki'|'G. S. Asanov'|'G. Savvidy'|'G. Scarpetta'|'G. Sch'|'G. Scharf'|'G. Schierholz'|'G. Schlesinger'|'G. Schmidt'|'G. Scholtz'|'G. S. Danilov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. S. Danilov'|'G. Segal'|'G. Selivanov'|'G. Semenoff'|'G. Sengupta'|'G. Senjanovi'|'G. Senjanovic'|'G. Servant'|'G. Sewell'|'G. S. Guralnik'|'G. Shaw' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Shaw'|'G. Shimura'|'G. Shiu'|'G. Shore'|'G. Sibiryakov'|'G. Sierra'|'G. Silva'|'G. Sinai'|'G. Siopsis'|'G. Skandalis'|'G. Sobczyk' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Sobczyk'|'G. Soff'|'G. Sokolik'|'G. Soliani'|'G. Sotkov'|'G. Sparano'|'G. St'|'G. Starkman'|'G. Steele'|'G. Sterman'|'G. Stroganov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Stroganov'|'G. Stueckelberg'|'G. Sudarshan'|'G. Szeg'|'G. Tak'|'G. Takacs'|'G. Tasinato'|'G. Taylor'|'G. Ter-Arutyunyan'|'G. Theodoridis'|'G. Thompson' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Thompson'|'G. Thorleifsson'|'G. T. Horowitz'|'G. Tian'|'G. Tiktopoulos'|'G. Tinyakov'|'G. T. Moore'|'G. Torre'|'G. Toulouse'|'G. Trahern'|'G. Travaglini' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Travaglini'|'G. Tricomi'|'G. Tsitsishvili'|'G. Tsoupros'|'G. Turaev'|'G. Turok'|'G. Tytgat'|'G. Unruh'|'G. Ushveridze'|'G. Vaillant'|'G. Valent' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Valent'|'G. V. Chibisov'|'G. V. Dunne'|'G. V. Efimov'|'G. Velo'|'G.  Veneziano'|'G. Veneziano'|'G. Venturi'|'G. Vernizzi'|'G. Vilasi'|'G. Vilkovisky' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Vilkovisky'|'G. Violero'|'G. Vitiello'|'G. V. Kraniotis'|'G. Volkov'|'G. Wasserman'|'G. Waterson'|'G. Watson'|'G. Watts'|'G. W. Delius'|'G. Weigt' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Weigt'|'G. Wen'|'G.  W.  Gibbons'|'G. W. Gibbons'|'G. Wick'|'G. Williams'|'G. Wilson'|'G. W. Moore'|'G. Woo'|'G. W. Semenoff'|'G. Wybourne' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Wybourne'|'G. Yaffe'|'G. Zemba'|'G. Zhou'|'G. Zima'|'G. Zograf'|'G. Zoupanos'|'G. Zuckerman'|'G. Zuckermann'|'G. Zumbach'|'G. Zwart' => { printf("token: %sn", std::string(ts, te).c_str()); };
'G. Zwart'|'H. Abarbanel'|'H. A. Bethe'|'H. A. Chamblin'|'H. Adams'|'H. A. Feldman'|'H. Airault'|'H. A. Kastrup'|'H. Aoki'|'H. Aoyama'|'H. Araki' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Araki'|'H. Aratyn'|'H. Arfaei'|'H. Arisue'|'H. Arod'|'H. Arodz'|'H. Au-Yang'|'H. Awata'|'H. A. Weldon'|'H. Azuma'|'H. Babujian' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Babujian'|'H. Bacry'|'H. Banerjee'|'H. Bateman'|'H. Belich'|'H. Bengtsson'|'H. Bergknoff'|'H. Bethe'|'H. B. G. Casimir'|'H. B. Kim'|'H. Blas' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Blas'|'H. B. Lawson'|'H. B. Nielsen'|'H. Boerner'|'H. Bondi'|'H. Boschi'|'H. Boschi-Filho'|'H. Bougourzi'|'H. Boyer'|'H. Braden'|'H. Brandenberger' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Brandenberger'|'H. Brodie'|'H. B. Thacker'|'H. Burgers'|'H. Buscher'|'H. B. Zheng'|'H. Cartan'|'H. Ceva'|'H. Chamseddine'|'H. Chan'|'H. Chang' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Chang'|'H. Chen'|'H. Cheng'|'H. Cho'|'H. Christ'|'H. Chung'|'H. C. Lee'|'H. Clemens'|'H. C. Liao'|'H. Collins'|'H. Conway' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Conway'|'H. Coule'|'H. C. Pauli'|'H. C. Ren'|'H. Damgaard'|'H. Danielsson'|'H. Davoudias'|'H. Davoudiasl'|'H. D. Dahmen'|'H. D. Doebner'|'H. De' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. De'|'H. Dehghani'|'H. Dehnen'|'H. Dekker'|'H. Derrick'|'H. Diaz'|'H. Dicke'|'H. Dijkstra'|'H. Dilger'|'H. D. Kim'|'H. Doebner' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Doebner'|'H. Donnelly'|'H. Dorn'|'H. D. Politzer'|'H. Duru'|'H. Dykstra'|'H. D. Zeh'|'H. E. Camblong'|'H. Egawa'|'H. E. Haber'|'H. Ehrenreich' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Ehrenreich'|'H. Eichenherr'|'H. Epstein'|'H. E. Stanley'|'H. Euler'|'H. Ewen'|'H. Exton'|'H. Ezawa'|'H. Fakhri'|'H. Falomir'|'H. Fan' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Fan'|'H. Fanchiotti'|'H. Farkas'|'H. Fatollahi'|'H. F. Dowker'|'H. Feldman'|'H. Feshbach'|'H. Figueroa'|'H. Firouzjahi'|'H. F. Jones'|'H. Flaschka' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Flaschka'|'H. Flocard'|'H. Ford'|'H. Fort'|'H. Frahm'|'H. Frampton'|'H. Freeman'|'H. Freudenthal'|'H. Friedan'|'H. Friedrich'|'H. Fritzsch' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Fritzsch'|'H. Fuji'|'H. Fujisaki'|'H. Fukuda'|'H. Fukutaka'|'H. Furstenau'|'H. Gaioli'|'H. Garc'|'H. Garcia-Compean'|'H. Garland'|'H. Gausterer' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Gausterer'|'H. G. Dosch'|'H. Georgi'|'H. Gies'|'H. Gillet'|'H. G. Kausch'|'H. Goldstein'|'H. Good'|'H. Goroff'|'H. Grabert'|'H. Grosse' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Grosse'|'H. Guo'|'H. Gustafsson'|'H. Guth'|'H. Haber'|'H. Haken'|'H. Hamber'|'H. Hammer'|'H. Hansson'|'H. Harari'|'H. Hardy' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Hardy'|'H. Hata'|'H. Hatanaka'|'H. He'|'H. Hehl'|'H. Henry'|'H. Hinrichsen'|'H. Hofer'|'H. Holden'|'H. Horne'|'H. H. Soleng' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. H. Soleng'|'H. Hsu'|'H. H. Tye'|'H. Huang'|'H. Huffel'|'H. Ichie'|'H. Ikemori'|'H. Ishihara'|'H. Ishikawa'|'H. Ita'|'H. Ito' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Ito'|'H. Itoyama'|'H. J. Boonstra'|'H. J. Borchers'|'H. J. De'|'H. Jehle'|'H. J. Kim'|'H. Joos'|'H. J. Otto'|'H. J. Pirner'|'H. J. Rothe' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. J. Rothe'|'H. J. Schnitzer'|'H. J. Schulz'|'H. J. Shin'|'H. J. Thun'|'H. Kajiura'|'H. Kanno'|'H. Karsten'|'H. Kastrup'|'H. Kataoka'|'H. Kauffman' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Kauffman'|'H. Kawai'|'H. Kawamura'|'H. Kay'|'H. Kikuchi'|'H. Kim'|'H. Kleinert'|'H. Kluberg-Stern'|'H. Kobayashi'|'H. Kodama'|'H. Kolbenstvedt' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Kolbenstvedt'|'H. Konno'|'H. Koornwinder'|'H. Kr'|'H. Kubota'|'H. Kubotani'|'H. Kuijf'|'H. Kunitomo'|'H. Kwon'|'H. Larsson'|'H. Lee' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Lee'|'H. Lehmann'|'H. Leutwyler'|'H. Levine'|'H. Li'|'H. Lian'|'H. Lieb'|'H. Liebl'|'H. Liu'|'H. Lowenstein'|'H. L. St' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. L. St'|'H. L. Stormer'|'H. Lu'|'H. Lyth'|'H. Mac'|'H. Markum'|'H. Matsumoto'|'H. M. Babujian'|'H. Meyer'|'H. M. Farkas'|'H. M. Fried' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. M. Fried'|'H. Min'|'H. Minakata'|'H. Mino'|'H. Mitter'|'H. M. Lee'|'H. Mohrbach'|'H. Montani'|'H. Moon'|'H. Moscovici'|'H. Moutarde' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Moutarde'|'H. M. Srivastava'|'H. Mueller'|'H. Mukaida'|'H. Murayama'|'H. Nachbagauer'|'H. Nagara'|'H. Nakajima'|'H. Nakano'|'H. Nakatani'|'H. Nakazato' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Nakazato'|'H. Nakkagawa'|'H. Nariai'|'H. Narnhofer'|'H. Nastase'|'H. Neuberger'|'H.  Nicolai'|'H. Nicolai'|'H. Nieder'|'H. Nielsen'|'H. Nilles' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Nilles'|'H. Nishino'|'H. Noh'|'H. Nohara'|'H. Ochiai'|'H. Oda'|'H. O. Girotti'|'H. Ooguri'|'H. Orland'|'H. Osborn'|'H. Osborne' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Osborne'|'H. Pagels'|'H. Panagopoulos'|'H. Park'|'H. Partouche'|'H. Pedersen'|'H. Pendleton'|'H. Perk'|'H. Perkins'|'H. Peterson'|'H. Pfister' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Pfister'|'H. Phong'|'H. P. Leivo'|'H. P. McKean'|'H. P. Nilles'|'H. Poincar'|'H. Poincare'|'H. Politzer'|'H. Press'|'H. Price'|'H. Primakoff' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Primakoff'|'H. Quano'|'H. Quevedo'|'H. Quinn'|'H. Rauch'|'H. Reall'|'H. Rehren'|'H. Reinhardt'|'H. Ren'|'H. Rezayi'|'H. Rhedin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Rhedin'|'H. Rietdijk'|'H. Riggs'|'H. R. Lewis'|'H. Robins'|'H. Rollnik'|'H. R. Quinn'|'H. Ruegg'|'H. Rund'|'H. Ryder'|'H. Sahlmann' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Sahlmann'|'H. Saidi'|'H. Saito'|'H. Salehi'|'H. Saleur'|'H. Saller'|'H. Samtleben'|'H. Sarmadi'|'H. Sati'|'H. Sato'|'H. Satz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Satz'|'H. Sazdjian'|'H. Schneider'|'H. Schnitzer'|'H. Schulz'|'H. Schwartz'|'H.  Schwarz'|'H. Schwarz'|'H. Segur'|'H. Seifert'|'H. Seligman' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Seligman'|'H. S. Green'|'H. Sharp'|'H. Shenker'|'H. Shiba'|'H. Shin'|'H. Shinkai'|'H. Simmons'|'H. Singh'|'H. Skarke'|'H. S. Kim' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. S. Kim'|'H. Sloan'|'H. Snyder'|'H. So'|'H. Soleng'|'H. Sonoda'|'H. Spanier'|'H. S. Reall'|'H. S. Sharatchandra'|'H. S. Snyder'|'H. St' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. St'|'H. Steinacker'|'H. Stephani'|'H. Stoica'|'H. Stumpf'|'H. Suelmann'|'H. Suganuma'|'H. Sugawara'|'H. Suzuki'|'H. Swendsen'|'H. S. Yang' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. S. Yang'|'H. Takata'|'H. Tanaka'|'H. Taub'|'H. Taubes'|'H. Tchrakian'|'H. Terao'|'H. Terashima'|'H. Terazawa'|'H. Thoma'|'H. Thomas' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Thomas'|'H. T. Nieh'|'H. Toki'|'H. Tu'|'H. Tye'|'H. Tze'|'H. Ui'|'H. Ujino'|'H. Umetsu'|'H. Umezawa'|'H. Van' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Van'|'H.  Verlinde'|'H. Verlinde'|'H. Verschelde'|'H. Vozmediano'|'H. Waelbroeck'|'H. Wagner'|'H. Walliser'|'H. Wannier'|'H. W. Braden'|'H. W. Crater' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. W. Crater'|'H. Weidenm'|'H. Weigel'|'H. Weisz'|'H. Wenzl'|'H. Weyl'|'H. W. Hamber'|'H. Wichmann'|'H. Widom'|'H. Wilson'|'H. W. J. Bl' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. W. J. Bl'|'H. W. Lee'|'H. W. L. Naus'|'H. Wong'|'H. Yabuki'|'H. Yamada'|'H. Yamagishi'|'H. Yamamoto'|'H. Yan'|'H. Yang'|'H. Yee' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Yee'|'H. Y. Guo'|'H. Yi'|'H. Yoneyama'|'H. Yukawa'|'H. Zassenhaus'|'H. Zerrouki'|'H. Zhang'|'H. Zheng'|'H. Zhou'|'H. Zimerman' => { printf("token: %sn", std::string(ts, te).c_str()); };
'H. Zimerman'|'H. Zurek'|'I. A. Bandos'|'I. A. Batalin'|'I. Affleck'|'I. Aitchison'|'I. Akhiezer'|'I. Alekseev'|'I. A. Malkin'|'I. Andri'|'I. Andric' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Andric'|'I. A. Nikoli'|'I. Antoniades'|'I. Antoniadis'|'I. Aoki'|'I. Application'|'I. Aref'|'I. Arnol'|'I. Arnold'|'I. Arshansky'|'I. A. Shovkovy' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. A. Shovkovy'|'I. A. Stegun'|'I. Avramidi'|'I. Azakov'|'I. Bakas'|'I. Balitsky'|'I. Bandos'|'I. Bars'|'I. Batalin'|'I. Bena'|'I. Bender' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Bender'|'I. Bengtsson'|'I. B. Frenkel'|'I. Bia'|'I. Bialynicki-Birula'|'I. B. Khriplovich'|'I. Bochkarev'|'I. Borevich'|'I. Brevik'|'I. Brunner'|'I. Buchbinder' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Buchbinder'|'I. Chepelev'|'I. Cherednik'|'I. Cho'|'I. Clausen'|'I. Cuza'|'I. Davydychev'|'I. Deformations'|'I. Details'|'I. Diakonov'|'I. D. Novikov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. D. Novikov'|'I. Dobroliubov'|'I. Drummond'|'I. Dyakonov'|'I. Eides'|'I. Ellwood'|'I. Ennes'|'I. Entrop'|'I. E. Segal'|'I. Existence'|'I. Flohr' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Flohr'|'I. Fomin'|'I. Fourier'|'I. Frenkel'|'I. F. Silvera'|'I. Functional'|'I. Fushchych'|'I. Gaida'|'I. G. Avramidi'|'I. Gel'|'I. Gelfand' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Gelfand'|'I. General'|'I. Geometrical'|'I. G. Halliday'|'I. Ghandour'|'I. Giannakis'|'I. G. Koh'|'I. G. Macdonald'|'I. G. Mikhailov'|'I. G. Moss'|'I. Gottlieb' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Gottlieb'|'I. G. Pirozhenko'|'I. Graded'|'I. Gradshteyn'|'I. Graev'|'I. Granovskii'|'I. Guendelman'|'I. Gurevich'|'I. Halliday'|'I. Halperin'|'I. Hauser' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Hauser'|'I. Heard'|'I. Hinchliffe'|'I. Hip'|'I. Ichinose'|'I.  I.  Cot'|'I. I. Cot'|'I. Igusa'|'I. I. Kogan'|'I. Inozemtsev'|'I. I. Tkachev' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. I. Tkachev'|'I. Izawa'|'I. Jack'|'I. J. Muzinich'|'I. J. R. Aitchison'|'I. Kani'|'I. Kaplansky'|'I. Kapusta'|'I. Karanikas'|'I. Kath'|'I. Kazakov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Kazakov'|'I. Khalatnikov'|'I. Kishimoto'|'I. K. Kostov'|'I. Klebanov'|'I. Klich'|'I. Kogan'|'I. Kondo'|'I. Kostov'|'I. Kra'|'I. Krichever' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Krichever'|'I. Krive'|'I. Kuroki'|'I. Latorre'|'I. Lazaroiu'|'I. Lazzizzera'|'I. L. Buchbinder'|'I. L. Egusquiza'|'I. Low'|'I. L. Shapiro'|'I. Maeda' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Maeda'|'I. Man'|'I. M. Anderson'|'I. Manin'|'I. Marichev'|'I. Mart'|'I. Martin'|'I. Math'|'I. M. Benn'|'I. M. Gel'|'I. M. Gelfand' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. M. Gelfand'|'I. Mitra'|'I. M. Khalatnikov'|'I. M. Krichever'|'I. M. Mandelberg'|'I. Mocioiu'|'I. Moerdijk'|'I. Montvay'|'I. Moss'|'I. M. Ryzhik'|'I. M. Singer' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. M. Singer'|'I. M. Ternov'|'I. Muzinich'|'I. Naumov'|'I.  Nepomechie'|'I. Nepomechie'|'I. Neupane'|'I. N. Frantsevich'|'I. Nikishov'|'I. Nikoli'|'I. Novikov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Novikov'|'I. Oda'|'I. Ogievetsky'|'I. Ojima'|'I. Okouchi'|'I. Oksak'|'I. Olasagasti'|'I. Olive'|'I. Papadimitriou'|'I. Pappa'|'I. Park' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Park'|'I. Pashnev'|'I. P. Ennes'|'I. Pesando'|'I. Peschel'|'I. Picek'|'I. P. Neupane'|'I. Polikarpov'|'I. Prigogine'|'I. Pronin'|'I. Raeburn' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Raeburn'|'I. Remnants'|'I. Ritus'|'I. R. Klebanov'|'I. Robinson'|'I. Roditi'|'I. Rosado'|'I. Rudychev'|'I. Runkel'|'I. Ryzhik'|'I. Sachs' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Sachs'|'I. Satake'|'I. Sato'|'I. Savonije'|'I. Scalars'|'I. Schmidt'|'I. Schur'|'I. Sedov'|'I. Senda'|'I. S. Gradshteyn'|'I. Shapiro' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Shapiro'|'I. Shil'|'I. Singer'|'I. Smyrnakis'|'I. Sokolov'|'I. Solomon'|'I. Stancu'|'I. Stegun'|'I. Sumi'|' {it '|'I. Tamm' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Tamm'|'I. Tan'|'I. Taylor'|'I. T. Drummond'|'I. The'|'I. T. Ivanov'|'I. Tkach'|'I. Tkachev'|'I. Todorov'|'I. Tsutsui'|'I. T. Todorov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. T. Todorov'|'I. Tyutin'|'I. Ussyukina'|'I. Vainshtein'|'I. Vainstein'|'I. Vaysburd'|'I. V. Cherednik'|'I. Vector'|'I. Veselov'|'I. V. Gorbunov'|'I. V. Krive' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. V. Krive'|'I. Volovich'|'I. V. Polubarinov'|'I. V. Tyutin'|'I. V. Vancea'|'I. V. Volovich'|'I. Vysotsky'|'I. Waga'|'I. Wasserman'|'I. Weisberger'|'I. Ya' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Ya'|'I. Yamanaka'|'I. Yamilov'|'I. Y. Aref'|'I. Yotsuyanagi'|'I. Y. Park'|'I. Yu'|'I. Zahed'|'I. Zakharov'|'I. Zavala'|'I. Zavialov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'I. Zavialov'|'I. Zelnikov'|'I. Zhuk'|'I. Zlatev'|'J. Abad'|'J. Ablowitz'|'J. A. Bullinaria'|'J. A. Cardy'|'J. A. Casas'|'J. Adams'|'J. A. Dixon' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. A. Dixon'|'J. Aganagic'|'J. A. Garcia'|'J. A. Gracey'|'J. A. Harvey'|'J. A. Helay'|'J. A. Helayel-Neto'|'J. A. Krumhansl'|'J. Alexandre'|'J. Alfaro'|'J. Alg' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Alg'|'J. Algebra'|'J. Algebraic'|'J. Allen'|'J. Am'|'J. Ambj'|'J. Ambjorn'|'J. Amer'|'J. A. Minahan'|'J. Amit'|'J. A. M. Vermaseren' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. A. M. Vermaseren'|'J. Anandan'|'J. Ananias'|'J. A. Nieto'|'J. Appl'|'J. Arafune'|'J. Arias'|'J. A. Schouten'|'J. A. Shapiro'|'J. Astrophys'|'J. A. Swieca' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. A. Swieca'|'J. Atick'|'J. Attick'|'J. Audretsch'|'J. Austral'|'J. Avan'|'J. Avis'|'J. A. Wheeler'|'J. A. Zuk'|'J. Baacke'|'J. Babington' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Babington'|'J. Baez'|'J. Bagger'|'J. Ball'|'J. Balog'|'J. Barb'|'J. Barbon'|'J. Barcelos'|'J. Barcelos-Neto'|'J. Bardeen'|'J. Barrett' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Barrett'|'J. Barrow'|'J. Bartels'|'J. Baxter'|'J. B. Barbour'|'J. Beckenridge'|'J. Beckers'|'J. Beggs'|'J. Bekenstein'|'J. Bell'|'J. Bellissard' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Bellissard'|'J. Berges'|'J. Bernstein'|'J. B. Griffiths'|'J. Bhabha'|'J. B. Hartle'|'J. Bhaseen'|'J. Bi'|'J. Bicak'|'J. Bie'|'J. Bienkowska' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Bienkowska'|'J. Bijnens'|'J. Bijtebier'|'J. Birman'|'J. Bischoff'|'J. Bisognano'|'J. Bisquert'|'J. Bjorken'|'J. B. Kogut'|'J. Bl'|'J. Blum' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Blum'|'J. B. Marston'|'J. Bolte'|'J. Boonstra'|'J. Boorstein'|'J. Borchers'|'J. Bordes'|'J. Bordner'|'J. Borlaf'|'J. Bowick'|'J. Boya' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Boya'|'J. Braam'|'J. Bracken'|'J. Bray'|'J. Breckenridge'|'J. Bricmont'|'J. Broadhurst'|'J. Brodie'|'J. Brodsky'|'J. Broekaert'|'J. Bros' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Bros'|'J. Brown'|'J. Buras'|'J. Burden'|'J. Burgers'|'J. Burzlaff'|'J. B. Zuber'|'J. Carazzone'|'J. Carbonell'|'J. Cardy'|'J. Cari' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Cari'|'J. Carr'|'J. Casahorran'|'J. Castelino'|'J. Caudrey'|'J. C. Baez'|'J. C. Breckenridge'|'J. C. Brunelli'|'J. C. Collins'|'J.  Chang'|'J. Chang' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Chang'|'J. Chaos'|'J. Cheeger'|'J. Chem'|'J. Chem'|'J. Chen'|'J. Christiansen'|'J. Chun'|'J. Chung'|'J. Class'|'J. Classical' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Classical'|'J. C. Le'|'J. Cline'|'J. C. Niemeyer'|'J. Collins'|'J. Comb'|'J. Combinatorics'|'J. Comellas'|'J. Comp'|'J. Comput'|'J. Contemp' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Contemp'|'J. Copeland'|'J. Cornish'|'J. Cornwall'|'J. C. Pati'|'J. C. Phillips'|'J. C. Plefka'|'J. Creighton'|'J. Crewther'|'J. C. Rojas'|'J. Cruz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Cruz'|'J. C. Taylor'|'J. Cummins'|'J. Cuntz'|'J. C. Varilly'|'J. C. Wallet'|'J. Daboul'|'J. Dai'|'J. David'|'J. D. Barrow'|'J. D. Barrow' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. D. Barrow'|'J. D. Bekenstein'|'J. D. Bjorken'|'J. D. Blum'|'J. D. Brown'|'J. De'|'J. D. Edelstein'|'J. Dell'|'J. Demaret'|'J. D. Finley'|'J. Diff' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Diff'|'J. Differ'|'J. Differential'|'J. Dimock'|'J. Distler'|'J. Dixmier'|'J. Dixon'|'J. D. Jackson'|'J. D. Lykken'|'J. D. McCrea'|'J. Donoghue' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Donoghue'|'J. Dowker'|'J. D. Stasheff'|'J.  Duff'|'J. Duff'|'J. Duistermaat'|'J. Duncan'|'J. D. Vergara'|'J. D. Walecka'|'J. D. Wells'|'J. Dyson' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Dyson'|'J. Dziarmaga'|'J. Edelstein'|'J. Eden'|'J. Eells'|'J. E. Hetrick'|'J. Ehlers'|'J. E. Humphreys'|'J. E. Kim'|'J. Elem'|'J. E. Lidsey' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. E. Lidsey'|'J. Ellis'|'J. E. Marsden'|'J. E. Moyal'|'J. E. Nelson'|'J. Eng'|'J. Engels'|'J. Erdmenger'|'J. Erler'|'J. Erlich'|'J. Ernst' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Ernst'|'J. E. Roberts'|'J. Escalona'|'J. E. Solomin'|'J. Evans'|'J. Evslin'|'J. E. Wang'|'J. Exp'|'J. Fac'|'J. Fang'|'J. Faridani' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Faridani'|'J. F. Ashmore'|'J. Fay'|'J. F. Cornwell'|'J. F. Donoghue'|'J. Feinberg'|'J. Feldman'|'J. Feng'|'J. Fern'|'J. Ferrer'|'J. Fewster' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Fewster'|'J. F. Gomes'|'J. Fields'|'J. Figueroa'|'J. Figueroa-O'|'J. Fingberg'|'J. Fisch'|'J. Fischer'|'J. Fleischer'|'J. Fluid'|'J. F. Morales' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. F. Morales'|'J. F. Nicoll'|'J. Forrester'|'J. F. Pleba'|'J. F. Plebanski'|'J. Fr'|'J. Frenkel'|'J. Frenkel'|'J. Frieman'|'J. Froehlich'|'J. Frohlich' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Frohlich'|'J. Fronteau'|'J. F. Schonfeld'|'J. Fuchs'|'J. Func'|'J. Funct'|'J. F. Wheater'|'J. Gaite'|'J. Galloway'|'J. Gamboa'|'J. Ganor' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Ganor'|'J. Garay'|'J. Garc'|'J. Garcia-Bellido'|'J. Garriga'|'J. Gasser'|'J. Gates'|'J. Gauntlett'|'J. Gegenberg'|'J. Gen'|'J. Geo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Geo'|'J. Geom'|'J. Geometry'|'J. Gervais'|'J. G. Esteve'|'J. Giambiagi'|'J. Gibbons'|'J. Giedt'|'J. Gladikowski'|'J. Glauber'|'J. Glimm' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Glimm'|'J. Goebel'|'J. Goeree'|'J. Goldstone'|'J. Gomes'|'J. Gomis'|'J. Gonz'|'J. Gotay'|'J. Govaerts'|'J. G. Pereira'|'J. Gray' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Gray'|'J. Greensite'|'J. Griego'|'J. Grimstrup'|'J. Gross'|'J. Grundberg'|'J. G. Russo'|'J. G. Taylor'|'J. Guerrero'|'J. Gutowski'|'J. Guven' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Guven'|'J. Hadamard'|'J. Hagelin'|'J. Hall'|'J. Hallin'|'J. Halliwell'|'J. Hamada'|'J. Hamer'|'J. Hands'|'J. Hanson'|'J. Hao' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Hao'|'J. Harnad'|'J. Harrington'|'J. Harris'|'J. Hartle'|'J. Harvey'|'J. Hathrell'|'J. H. Brodie'|'J. Heckman'|'J. Herrero'|'J. Heslop' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Heslop'|'J. Hetrick'|'J. H. Horne'|'J. H. H. Perk'|'J. Hietarinta'|'J. Hietarinta et al,'|'J. High'|'J. High-Energy'|'J. Hiller'|'J. Hilton'|'J. Hisano' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Hisano'|'J. Hitchin'|'J. H. Lowenstein'|'J. Ho'|'J. Hollowood'|'J. Honerkamp'|'J. Hong'|'J. Hopkins'|'J. Hoppe'|'J. Horne'|'J. Hoste' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Hoste'|'J. Houghton'|'J. Hove'|'J. Hoyos'|'J. H. Park'|'J. Hruby'|'J. H. Schwartz'|'J. H.  Schwarz'|'J. H. Schwarz'|'J. H. Sloan'|'J. Huang' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Huang'|'J. Hubbard'|'J. Hughes'|'J. Humphreys'|'J. Hunter'|'J. Hurtubise'|'J. Hwang'|'J. H. Yee'|'J. Hyun'|'J. Ibanez'|'J. Igusa' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Igusa'|'J. I. Kapusta'|'J. I. Latorre'|'J. I. Lattore'|'J. Iliopoulos'|'J. Indian'|'J. Ipser'|'J. Isberg'|'J. Isenberg'|'J. Isham'|'J. Isidro' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Isidro'|'J. Iwasaki'|'J. Izquierdo'|'J. J. Atick'|'J. J. Duistermaat'|'J. Jersak'|'J. J. Giambiagi'|'J. J. Halliwell'|'J. Jing'|'J. J. M. Verbaarschot'|'J. J. Oh' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. J. Oh'|'J. Jr'|'J. J. Sakurai'|'J. Julve'|'J. Jurkiewicz'|'J. Kalkkinen'|'J. Kalkman'|'J. Kang'|'J. Kapusta'|'J. Katriel'|'J. Katz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Katz'|'J. Kaup'|'J. Kellendonk'|'J. Keller'|'J. Khoury'|'J. Kijowski'|'J. Kim'|'J. Kiskis'|'J. K. Jain'|'J. K. Kim'|'J. Klauder' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Klauder'|'J. Kluso'|'J. Kluson'|'J. Knot'|'J. Kogut'|'J. Koller'|'J. Korean'|'J. Kowalski'|'J.  Kowalski-Glikman'|'J. Kowalski-Glikman'|'J. Kripfganz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Kripfganz'|'J. Kubo'|'J. Kumar'|'J. Kunz'|'J. Kuperzstych'|'J. Kurchan'|'J. Kuti'|'J. Labastida'|'J. Lacki'|'J. Latorre'|'J. Lauer' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Lauer'|'J. L. Cardy'|'J. L. Cort'|'J. Le'|'J. Lebowitz'|'J. Lee'|'J. Leggett'|'J. Leinaas'|'J. Lepowski'|'J. Lepowsky'|'J. Lesgourgues' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Lesgourgues'|'J. Lett'|'J. Levin'|'J. Lewandowski'|'J. L. F. Barb'|'J. L. F. Barbon'|'J. L. Gervais'|'J. L. Hewett'|'J. Li'|'J. Lidsey'|'J. Lieberman' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Lieberman'|'J. Lindesay'|'J. Liouville'|'J. Liu'|'J. L. Lebowitz'|'J. L. Lopez'|'J. Llosa'|'J. L. Miramontes'|'J. London'|'J. Lopez'|'J. Lopuszanski' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Lopuszanski'|'J. Lott'|'J. Louis'|'J. Louko'|'J. Lovis'|'J. Low'|'J. Lowenstein'|'J. L. Petersen'|'J. L. Rosner'|'J. L. Synge'|'J. L. Tomazelli' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. L. Tomazelli'|'J. L. Trueba'|'J. Lu'|'J. Lukierski'|'J. Lykken'|'J. Ma'|'J. Mac'|'J. Macfarlane'|'J. Madore'|'J. Magnen'|'J. Magueijo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Magueijo'|'J. Maharana'|'J. Majumder'|'J. Makela'|'J.  Maldacena'|'J. Maldacena'|'J. Maldecena'|'J. Mandula'|'J. Manes'|'J. March'|'J. March-Russel' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. March-Russel'|'J. March-Russell'|'J. Marciano'|'J. Marsden'|'J. Martin'|'J. Martinec'|'J. Martins'|'J. Mas'|'J. Mason'|'J. Mateos'|'J.  Math' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J.  Math'|'J. Math'|'J. Matschull'|'J. M. Bardeen'|'J. M. Camino'|'J. McCabe'|'J. McCarthy'|'J. McGreevy'|'J. M. Chung'|'J. McKay'|'J. McKinnon' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. McKinnon'|'J. M. Cline'|'J. McMinis'|'J. M. Cornwall'|'J. M. Drouffe'|'J. Mehra'|'J. M. Evans'|'J. Meyer'|'J. M. Figueroa-O'|'J. M. F. Labastida'|'J. M. Gracia-Bond' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. M. Gracia-Bond'|'J. M. Gracia-Bondia'|'J. M. Grimstrup'|'J. M. Guilarte'|'J. Micheli'|'J. Michelson'|'J. Mickelsson'|'J. Milnor'|'J. Minahan'|'J. Miramontes'|'J. M. Isidro' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. M. Isidro'|'J. M. Izquierdo'|'J. M. Jauch'|'J. M. Kosterlitz'|'J. M. Leinaas'|'J. M. L. Fisch'|'J. M. Luttinger'|'J. M. Maillet'|'J. M. Maldacena'|'J. M. McCarthy'|'J. M. McMahon' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. M. McMahon'|'J. M. Mour'|'J. M. Nester'|'J.  Mod'|'J. Mod'|'J. Modern'|'J. Modn'|'J. Moffat'|'J. Molera'|'J. Morales'|'J. Morgan' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Morgan'|'J. Moser'|'J. Mountain'|'J. Mour'|'J. Mourad'|'J. Mourao'|'J. Moyal'|'J. M. Pawlowski'|'J. M. Pierre'|'J. M. Pons'|'J. M. Rabin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. M. Rabin'|'J. M. Salim'|'J. M. Sanchez'|'J. M. Souriau'|'J. M. S. Rana'|'J. M. Stewart'|'J. Munczek'|'J. Mund'|'J. Munkres'|'J. Murakami'|'J. Muzinich' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Muzinich'|'J. Myrheim'|'J. Narganes-Quijano'|'J. Navarro'|'J.  Navarro-Salas'|'J. Navarro-Salas'|'J. Negro'|'J. Nester'|'J. Neu'|'J. Newman'|'J. Ng' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Ng'|'J. N. Ginocchio'|'J. N. Goldberg'|'J. Ni'|'J. Niederle'|'J. Niemi'|'J. Nilsson'|'J. Nishimura'|'J. Nitsch'|'J. Nucl'|'J. Nunes' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Nunes'|'J. Nuyts'|'J. Oh'|'J. Olver'|'J. O. Madsen'|'J. Operator'|'J. Opt'|'J. Orfanidis'|'J. Orloff'|'J. Osborn'|'J. Otto' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Otto'|'J. Ovalle'|'J. Pacheva'|'J. Pachos'|'J. Paeng'|'J. Panvel'|'J. Papavassiliou'|'J. Par'|'J. Paris'|'J. Park'|'J. Parke' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Parke'|'J. Parkes'|'J. Part'|'J. Patera'|'J. Pati'|'J. Paton'|'J. Pawe'|'J. Pawelczyk'|'J. P. Boon'|'J. P. Derendinger'|'J. Pearson' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Pearson'|'J. Perez-Mercader'|'J.  Perry'|'J. Perry'|'J. Petersen'|'J. Petriello'|'J. P. Gauntlett'|'J. P. Gray'|'J.  Phys'|'J. Phys'|'J. Phys' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Phys'|'J. Physics'|'J. Physique'|'J. Pierre'|'J. Pirner'|'J. Plass'|'J. Pleba'|'J. Plebanski'|'J. Plefka'|'J. P. Mimoso'|'J. P. Nunes' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. P. Nunes'|'J. Podolsk'|'J. Polchinksi'|'J.  Polchinski'|'J. Polchinski'|'J. Polchinsky'|'J. Polonyi'|'J. Ponce'|'J. P. Ostriker'|'J. P. Paz'|'J. P. Perdew' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. P. Perdew'|'J. P. Ralston'|'J. Preskill'|'J. P. Rodrigues'|'J. P. S. Lemos'|'J. Puente'|'J. Pullin'|'J. Pure'|'J. P. Vary'|'J. Quantum'|'J. Rabin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Rabin'|'J. Radzikowski'|'J. Raeymaekers'|'J. Rafelski'|'J. Rahmfeld'|'J. Ramirez'|'J. Rasmussen'|'J. R. David'|'J. Redfern'|'J. Reigert'|'J. Reine' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Reine'|'J. R. Ellis'|'J. Rembieli'|'J. Rembielinski'|'J. Res'|'J. Rey'|'J. R. Fanchi'|'J. R. Gott'|'J. R. Hiller'|'J. Riedler'|'J. Riegert' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Riegert'|'J. Rivers'|'J. Rizos'|'J. R. Klauder'|'J. Roberts'|'J. Roca'|'J. Rodgers'|'J. Rodr'|'J. Rodrigues'|'J. Rodriguez-Quintero'|'J. Rolf' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Rolf'|'J. Romans'|'J. R. Oppenheimer'|'J. Rosales'|'J. Rosen'|'J. Rothe'|'J. R. Schrieffer'|'J. R. S. Nascimento'|'J. Ruback'|'J. Rubinstein'|'J. Russo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Russo'|'J. Sakurai'|'J. Samuel'|'J. Santiago'|'J. Sato'|'J. Satsuma'|'J. Saunders'|'J. S. Bell'|'J. S. Caux'|'J. Schaefer'|'J. Schakel' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Schakel'|'J. Schechter'|'J. Scherk'|'J. Scherrer'|'J. Schiff'|'J. Schmidt'|'J. Schnittger'|'J. Schnitzer'|'J. Schonfeld'|'J. Schroers'|'J. Schulze' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Schulze'|'J. Schwartz'|'J. Schwarz'|'J. Schwenk'|'J. Schwinger'|'J. Sci'|'J. S. Dowker'|'J. S. F. Chan'|'J. S. Guillen'|'J. Shapiro'|'J. Shen' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Shen'|'J. Sherk'|'J. Shi'|'J. Shigemitsu'|'J. Shin'|'J. Shiraishi'|'J. Silk'|'J. Silva'|'J. Sim'|'J. Simon'|'J. Simons' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Simons'|'J. Sin'|'J. S. Langer'|'J. Slater'|'J. Sloan'|'J. Slov'|'J. Smit'|'J. Smith'|'J. Sniatycki'|'J. Snippe'|'J. Snyderman' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Snyderman'|'J. Sobczyk'|'J. Socorro'|'J. Soda'|'J. Sola'|'J. Sommers'|'J. Son'|'J. Sonnenschein'|'J. Sonnenshein'|'J. Soto'|'J. Sov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Sov'|'J. Soviet'|'J. Sparling'|'J. Sparnaay'|'J. Squires'|'J. S. Rozowsky'|'J. S. Schwinger'|'J. S. Song'|'J. Stachel'|'J. Stasheff'|'J. Stat' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Stat'|'J. Statist'|'J. Steinhardt'|'J. Stephany'|'J. Stern'|'J. Stewart'|'J. Strassler'|'J. Strathdee'|'J. Sucher'|'J. Summers'|'J. Suzuki' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Suzuki'|'J. Swieca'|'J. Symb'|'J. Szabo'|'J. Tabaczek'|'J. Tannenhauser'|'J. Taron'|'J. Tate'|'J. Taylor'|'J. Teper'|'J. Terning' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Terning'|'J. Teschner'|'J. Theo'|'J. Theor'|'J. Thierry-Mieg'|'J. Thompson'|'J. Thouless'|'J. Thun'|'J. Tiomno'|'J. Tits'|'J. Tjon' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Tjon'|'J. T. Liu'|'J. T. Lopuszanski'|'J. Tolksdorf'|'J. Tolley'|'J. Toms'|'J. Tran'|'J. Traschen'|'J. Troost'|'J. T. Yee'|'J. Uglum' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Uglum'|'J. Underwood'|'J. Van'|'J. Vaz'|'J. Verbaarschot'|'J. Vilenkin'|'J. Villain'|'J. Vives'|'J. V. Narlikar'|'J. Voit'|'J. Wainwright' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Wainwright'|'J. Walcher'|'J. Wallace'|'J. Wambach'|'J. Wang'|'J. Warr'|'J. Wegner'|'J. Weinberg'|'J. Weiss'|'J. Weniger'|'J. Wensley' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Wensley'|'J.  Wess'|'J. Wess'|'J. Westerholm'|'J. Weyers'|'J. Wheater'|'J. Wheeler'|'J. Wiese'|'J. Wiley'|'J. Williams'|'J. Winicour' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Winicour'|'J. Winnberg'|'J. Winters'|'J. W. Milnor'|'J. W. Moffat'|'J. Wolf'|'J. Woodhouse'|'J. Wosiek'|'J. W. R. Underwood'|'J. Wu'|'J. W. Van' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. W. Van'|'J. W. York'|'J. X. Lu'|'J. Yamron'|'J. Yee'|'J. Y. Kim'|'J. Yndurain'|'J. Yngvason'|'J. Yokoyama'|'J. Zaanen'|'J. Zak' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Zak'|'J. Zakrzewski'|'J. Zanelli'|'J. Zhang'|'J. Zhou'|'J. Zhu'|'J. Zinn'|'J. Zinn-Justin'|'J. Zittartz'|'J. Z. Simon'|'J. Zuber' => { printf("token: %sn", std::string(ts, te).c_str()); };
'J. Zuber'|'J. Zuckerman'|'J. Zuk'|'K. Akama'|'K. A. Meissner'|'K. Amemiya'|'K. A. M. Gugenheim'|'K. A. Milton'|'K. Anagnostopoulos'|'K. Aoki'|'K. A. Olive' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. A. Olive'|'K. Arthur'|'K. A. Seaton'|'K. Ashok'|'K. Babu'|'K. Bardacki'|'K. Bardak'|'K. Bardakci'|'K. Baskerville'|'K. Bautier'|'K. Becker' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Becker'|'K. Behnia'|'K. Behrndt'|'K. Benakli'|'K. Benson'|'K. Bering'|'K. Bhaduri'|'K. Binder'|'K. Biswas'|'K. Blau'|'K. Bleuler' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Bleuler'|'K. Bresser'|'K. Bullough'|'K. Burke'|'K. Cahill'|'K. Campbell'|'K. Chan'|'K. Chen'|'K. Cheung'|'K. Choi'|'K. Chung' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Chung'|'K. C. K. Chan'|'K. Clubok'|'K. C. Wali'|'K. Daikouji'|'K. Dan'|'K. Dasgupta'|'K. D. Elworthy'|'K. Demeterfi'|'K. Dienes'|'K. Dietz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Dietz'|'K. D. Kokkotas'|'K. Dobrev'|'K. Donaldson'|'K. D. Rothe'|'K. E. Cheung'|'K. Efetov'|'K. E. Kunze'|'K. Enqvist'|'K. Erickson'|'K. Everding' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Everding'|'K. Ezawa'|'K. Farakos'|'K. Foerger'|'K. Forger'|'K. Fredenhagen'|'K. Freericks'|'K. Freese'|'K. Fujii'|'K. Fujikawa'|'K. Fukaya' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Fukaya'|'K. Funahashi'|'K. Furuta'|'K. Furuuchi'|'K. Furuya'|'K. Gaillard'|'K. Galicki'|'K. Gaw'|'K. Gawedski'|'K. Gawedzki'|'K. G. Chetyrkin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. G. Chetyrkin'|'K. Ghoroku'|'K. Ghosh'|'K. G. Klimenko'|'K. Goeke'|'K. Graham'|'K. Greisen'|'K. G. Savvidy'|'K. G. Wilson'|'K. Hadjiivanov'|'K. Hagiwara' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Hagiwara'|'K. Haller'|'K. Halpern'|'K. Hamada'|'K. Harada'|'K. Harrison'|'K. Hasebe'|'K. Hasegawa'|'K. Hashimoto'|'K. Hayashi'|'K. Heitmann' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Heitmann'|'K. Hepp'|'K. Higashijima'|'K. Hikami'|'K. Hong'|'K. Hori'|'K. Hornbostel'|'K. Hornfeck'|'K. Hosomichi'|'K. Hotta'|'K. H. Rehren' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. H. Rehren'|'K. Huang'|'K. Huitu'|'K. Ikegami'|'K. I. Maeda'|'K. Intriligator'|'K. Intrilligator'|'K. Iohara'|'K. Ishikawa'|'K. Isler'|'K. It' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. It'|'K. Itakura'|'K. Ito'|'K. Itoh'|'K. Izawa'|'K. Jain'|'K. Jansen'|'K. Johnson'|'K. J. Shi'|'K. Just'|'K. Kajantie' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Kajantie'|'K. Kalashnikov'|'K. Kamimura'|'K. Kaminsky'|'K. Kanaya'|'K. Kang'|'K. Kashima'|'K. Kaul'|'K. Kaviani'|'K. Kawarabayashi'|'K. Kawasaki' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Kawasaki'|'K. Kikkawa'|'K. Kim'|'K. Kimm'|'K. Kirklin'|'K. Kirsten'|'K. Kleidis'|'K. Knecht'|'K. Kobayashi'|'K. Kodaira'|'K. Kondo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Kondo'|'K. Konishi'|'K. Kostov'|'K. Kounnas'|'K. Koyama'|'K. Krasnov'|'K. Kucha'|'K. Kuchar'|'K. Kuijken'|'K. Kunc'|'K. Kunze' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Kunze'|'K. Lamoreaux'|'K. Lanczos'|'K. Landsteiner'|'K. Lane'|'K. Lang'|'K. Langfeld'|'K. Lechner'|'K. Lee'|'K. Leontaris'|'K. Li' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Li'|'K. Lo'|'K. L. Panigrahi'|'K. Ma'|'K. Maeda'|'K. Mak'|'K. Matumoto'|'K. M. Case'|'K. Meissner'|'K. Miki'|'K. Milton' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Milton'|'K. Mitter'|'K. Mohri'|'K. Moon'|'K. Morikawa'|'K. Morita'|'K. M. Shekhter'|'K. Murakami'|'K. Murray'|'K. Nagao'|'K. Nahm' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Nahm'|'K. Nakagawa'|'K. Nakamura'|'K. Nakao'|'K. N. Anagnostopoulos'|'K. Narain'|'K. Ned'|'K. Nielsen'|'K. Nishijima'|'K. Nomizu'|'K. Nordtvedt' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Nordtvedt'|'K. Ogawa'|'K. Ogure'|'K. Oh'|'K. Ohmori'|'K. Ohnishi'|'K. Ohta'|'K. Okamoto'|'K. Okano'|'K. Okuyama'|'K. Olaussen' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Olaussen'|'K. Olive'|'K. Olsen'|'K. Osterwalder'|'K. Pak'|'K. Palo'|'K. Panigrahi'|'K. Parikh'|'K. Park'|'K. Pashaev'|'K. Patodi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Patodi'|'K. Paul'|'K. Peeters'|'K. Pilch'|'K. Pinn'|'K. Pohlmeyer'|'K. Prasad'|'K. P. Tod'|'K. Raina'|'K. Rajagopal'|'K. Rama' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Rama'|'K. Ranganathan'|'K. Rao'|'K. Ray'|'K. R. Dienes'|'K. Rebhan'|'K. Redlich'|'K. Refson'|'K. Riedel'|'K. Roland'|'K. Rothe' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Rothe'|'K. Rummukainen'|'K. Sailer'|'K. Saito'|'K. Saririan'|'K. Sato'|'K. Savvidy'|'K. S. Babu'|'K. Schalm'|'K. Schalm'|'K. Scharnhorst' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Scharnhorst'|'K. Schilcher'|'K. Schilling'|'K. Schleich'|'K. Schm'|'K. Schoutens'|'K. Selivanov'|'K. Sener'|'K. Seo'|'K. Sfetsos'|'K. S. Gupta' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. S. Gupta'|'K. Shepard'|'K. Shima'|'K. Shiraishi'|'K. Shizuya'|'K. Sibold'|'K. Sinclair'|'K. Singh'|'K. Skenderis'|'K. Sklyanin'|'K. S. Narain' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. S. Narain'|'K. Sogo'|'K. Soni'|'K. Splittorff'|'K. Srinivasan'|'K. S. Soh'|'K. S. Stelle'|'K. Stam'|'K. Stanton'|'K. Stelle'|'K. S. Thorne' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. S. Thorne'|'K. Su'|'K. Suehiro'|'K. Sugiyama'|'K. Sundermeyer'|'K. Suzuki'|'K. S. Viswanathan'|'K. Svozil'|'K. Symanzik'|'K. Szlachanyi'|'K. Takahashi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Takahashi'|'K. Takasaki'|'K. Takenaga'|'K. Tamvakis'|'K. Tanaka'|'K. Tanioka'|'K. Thielemans'|'K. Thorne'|'K. T. Mahanthappa'|'K. Tollst'|'K.  Townsend' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K.  Townsend'|'K. Townsend'|'K. Towsend'|'K. Trachenko'|'K. Tripathy'|'K. Tsokos'|'K. Tung'|'K. Uehara'|'K. Ueno'|'K. Uhlenbeck'|'K. Van' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Van'|'K. Viswanathan'|'K. V. Kucha'|'K.  V.  Kuchar'|'K. V. Kuchar'|'K. Volkov'|'K. Wakatsuki'|'K. Wali'|'K. Walker'|'K. Wang'|'K. Webb' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Webb'|'K. Wendland'|'K. W. Howard'|'K. Wilson'|'K. Wong'|'K. Woo'|'K. Wu'|'K. Yamagishi'|'K. Yamamoto'|'K. Yamawaki'|'K. Yang' => { printf("token: %sn", std::string(ts, te).c_str()); };
'K. Yang'|'K. Yano'|'K. Yazaki'|'K. Y. Kim'|'K. Yoshida'|'K. Yoshioka'|'K. Yuan'|'K. Zachos'|'K. Zarembo'|'K. Zhou'|'L. Abbott' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Abbott'|'L. Accardi'|'L. Adler'|'L. Adrianopoli'|'L. A. Ferreira'|'L. A. J. London'|'L. A. Kofman'|'L. Alonso'|'L. Altshuler'|'L. Alvarez'|'L. Alvarez-Gaum' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Alvarez-Gaum'|'L. Alvarez-Gaume'|'L. Amendola'|'L. Anchordoqui'|'L. Anderson'|'L. Andrianopoli'|'L. A. Pando'|'L. A. Takhtadzhyan'|'L. A. Takhtajan'|'L. Barbon'|'L. Baulieu' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Baulieu'|'L. Bell'|'L. Bellac'|'L. Bennett'|'L. Benoit'|'L. Berard-Bergery'|'L. Berezinskii'|'L. Berezinsky'|'L. Bers'|'L. Besse'|'L. Biedenharn' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Biedenharn'|'L. Birke'|'L. B. Okun'|'L. Boldo'|'L. Bombelli'|'L. Bonora'|'L. Borisov'|'L. Brekke'|'L. Brink'|'L. Brown'|'L. Bryant' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Bryant'|'L. Brylinski'|'L. Buchbinder'|'L. Burakovsky'|'L. Campos'|'L. Caneschi'|'L. Cantini'|'L. Cappiello'|'L. Cardoso'|'L. Cardy'|'L. Carey' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Carey'|'L. Carminati'|'L. Carr'|'L. Carrion'|'L. Carson'|'L. Castellani'|'L. Castillejo'|'L. C. Biedenharn'|'L. Cerchiai'|'L. Chan'|'L. Chandar' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Chandar'|'L. Chang'|'L. Chao'|'L. Chau'|'L. Chekhov'|'L. Chen'|'L. Chetouani'|'L. Chim'|'L. Clavelli'|'L. Cooper'|'L. Cornalba' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Cornalba'|'L. Cort'|'L. Cortes'|'L. Cotrone'|'L. C. Q. Vilar'|'L. Crane'|'L. C. R. Wijewardhana'|'L. C. Shepley'|'L. Culumovic'|'L. Curtright'|'L. Dabrowski' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Dabrowski'|'L. Davis'|'L. De'|'L. Del'|'L. D.  Faddeev'|'L. D. Faddeev'|'L. D. Fadeev'|'L. Dickey'|'L. Dixon'|'L. D. Landau'|'L. D. Landau' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. D. Landau'|'L. Dokshitzer'|'L. Dolan'|'L. Dubovsky'|'L. Durand'|'L. Dyson'|'L. E. Gendenshtein'|'L. Egusquiza'|'L. E. Ib'|'L. E. Iba'|'L. E. Ibanez' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. E. Ibanez'|'L. Eisenhart'|'L. E. Oxman'|'L. Essler'|'L. Everett'|'L. F. Abbott'|'L. Faddeev'|'L. Fadeev'|'L. F. Alday'|'L. Feh'|'L. Feher' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Feher'|'L. Feigin'|'L. Ferreira'|'L. Fetter'|'L. Fisch'|'L. F. Li'|'L. Fogli'|'L. Foldy'|'L. Fonda'|'L. Ford'|'L. Frappat' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Frappat'|'L. Freidel'|'L. Friedel'|'L. Friedman'|'L. F. Urrutia'|'L. Gallot'|'L. Ge'|'L. Gendenshtein'|'L. Gervais'|'L. Ginzburg'|'L. Girardello' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Girardello'|'L. Glashow'|'L. Goerlich'|'L. Golterman'|'L. Griguolo'|'L. Gualtieri'|'L. Gy'|'L. G. Yaffe'|'L. Hadasz'|'L. Hall'|'L. Hernquist' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Hernquist'|'L. Hewett'|'L. H. Ford'|'L. H. Karsten'|'L. H. Kauffman'|'L. Hlavat'|'L. Hlavaty'|'L. Ho'|'L. Hoffmann'|'L. Hollenberg'|'L. Houart' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Houart'|'L. Hourant'|'L. H. Ryder'|'L. Hu'|'L. Hua'|'L. Ib'|'L. Iba'|'L. Ibanez'|'L. Ibort'|'L. Ince'|'L. Infeld' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Infeld'|'L. I. Schiff'|'L. Jacobs'|'L. Jaffe'|'L. J. Boya'|'L. J. Dixon'|'L. Jeffrey'|'L. Jensen'|'L. J. Garay'|'L. J. Hall'|'L. J. Mason' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. J. Mason'|'L. Jonke'|'L. J. Romans'|'L. J. Slater'|'L. Kadanoff'|'L. Kane'|'L. Kantor'|'L. Karp'|'L. Kataev'|'L. Kauffman'|'L. K. Hadjiivanov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. K. Hadjiivanov'|'L. Kneur'|'L. Kofman'|'L. Koszul'|'L. Krauss'|'L. Lamb'|'L. Landau'|'L. Lapointe'|'L. Larsen'|'L. L. Chau'|'L. L. De' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. L. De'|'L. Leal'|'L. Lebowitz'|'L. Lellouch'|'L. Lewin'|'L. L. Foldy'|'L. Lin'|'L. Liu'|'L. Loday'|'L. Lopez'|'L. Losano' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Losano'|'L. Lucio-Martinez'|'L. Luk'|'L. Lukyanov'|'L. Lusanna'|'L. Lyakhovich'|'L. Magnea'|'L. Maiani'|'L. Mandel'|'L. Manes'|'L. Mangiarotti' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Mangiarotti'|'L. Maoz'|'L. Maroto'|'L. Martin'|'L. Martina'|'L. Martinez'|'L. Martucci'|'L. Mason'|'L. Matheus-Valle'|'L. M. Burko'|'L. McLerran' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. McLerran'|'L. Mehta'|'L. Mersini'|'L. Mesref'|'L. Messiah'|'L. Metha'|'L.  Mezincescu'|'L. Mezincescu'|'L. Mezinescu'|'L. Michel'|'L. Michelsohn' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Michelsohn'|'L. Mills'|'L. Miramontes'|'L. Mizrachi'|'L. M. Krauss'|'L. Mkrtchyan'|'L. M. Nieto'|'L. Molinari'|'L. Montanet'|'L. Motl'|'L. M. Simmons' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. M. Simmons'|'L. M. Widrow'|'L. Naus'|'L. N. Chang'|'L. N. Cooper'|'L. Nellen'|'L. N. Epele'|'L. N. Granda'|'L. N. Lipatov'|'L. N. Pfeiffer'|'L. Nyeo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Nyeo'|'L. Okun'|'L. Onsager'|'L. Pakman'|'L. Palla'|'L. Pando'|'L. Paniak'|'L. Parker'|'L. Parkes'|'L. Paul'|'L. P. Colatto' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. P. Colatto'|'L. Peliti'|'L. Perivolaropoulos'|'L. Petersen'|'L. Peterson'|'L. P. G. Amaral'|'L. P. Grishchuk'|'L.  P.  Horwitz'|'L. P. Horwitz'|'L. P. Hughston'|'L. Pilo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Pilo'|'L. Pitaevski'|'L. Pitaevskii'|'L. Pittner'|'L. P. Kadanoff'|'L. Pogosian'|'L. Polley'|'L. Popp'|'L. P. Pitaevskii'|'L. Rakow'|'L. Rana' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Rana'|'L. Randall'|'L. Rastelli'|'L. Renken'|'L. R. Mead'|'L. Romans'|'L. Rosenberg'|'L. Rosner'|'L. Rossini'|'L. Rozansky'|'L. Sadun' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Sadun'|'L. Salasnich'|'L. Salcedo'|'L. Saliu'|'L. S. Brown'|'L. Sch'|'L. Schulman'|'L. Schultz'|'L. Schwartz'|'L. Sewell'|'L. Sh' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Sh'|'L. Shapiro'|'L. Shatashvili'|'L. Shepley'|'L. Silvestrini'|'L. Smarr'|'L. Smith'|'L. Smolin'|'L. Sondhi'|'L. Sorbo'|'L. S. Schulman' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. S. Schulman'|'L. Stodolsky'|'L. Stormer'|'L. Streit'|'L. Susskind'|'L. Synge'|'L. Szymanowski'|'L. Takhtajan'|'L. Tarasov'|'L. Tataru'|'L. Tedesco' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Tedesco'|'L. Telegdi'|'L. Thorlacius'|'L. Tomazelli'|'L. Trobo'|'L. Trueman'|'L. Tu'|'L. Turko'|'L. Vaidman'|'L. Van'|'L. Vanzo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Vanzo'|'L. V. Avdeev'|'L. V. Belvedere'|'L. Vel'|'L. Verdier'|'L. Vergara'|'L. Vernon'|'L. Vinet'|'L. V. Keldysh'|'L. V. Laperashvili'|'L. Voronov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. Voronov'|'L. Wang'|'L. Welch'|'L. White'|'L. Wijewardhana'|'L. Williams'|'L. Wilson'|'L. Wiltshire'|'L. Witten'|'L. Woronowicz'|'L. W. Tu' => { printf("token: %sn", std::string(ts, te).c_str()); };
'L. W. Tu'|'L. Yaffe'|'L. Yan'|'L. Yang'|'L. Y. Chen'|'L. Yu'|'L. Zhao'|'M. A. Awada'|'M. Abdalla'|'M. Abe'|'M. A. Bershadsky' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. A. Bershadsky'|'M. Ablowitz'|'M. Abou'|'M. Abou-Zeid'|'M. Abramovitz'|'M. Abramowitz'|'M. Abud'|'M. Acciarri'|'M. A. C. Kneipp'|'M. A. Clayton'|'M. A. De' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. A. De'|'M. Ademollo'|'M. Adler'|'M. A. Flohr'|'M. Aganagic'|'M. Agishtein'|'M. A. H. Mac'|'M. A. H. Vozmediano'|'M. A. I. Flohr'|'M. Aizenman'|'M. A. Jafarizadeh' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. A. Jafarizadeh'|'M. Alford'|'M. Alimohammadi'|'M. Alishahiha'|'M. A. Lled'|'M. A. Lledo'|'M. Alpert'|'M. A. Luty'|'M. Alvarez'|'M. A. Markov'|'M. Ameduri' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Ameduri'|'M. A. Morales'|'M. A. Naimark'|'M. A. Namazie'|'M. Anastasiei'|'M. Anazawa'|'M. Anderson'|'M. A. Nowak'|'M. A. Olshanetsky'|'M. A. Rego-Monteiro'|'M. A. Rieffel' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. A. Rieffel'|'M. Arik'|'M. Aroca'|'M. A. R. Osorio'|'M. Artin'|'M. A. Rubin'|'M. Aryal'|'M. Asano'|'M. A. Semenov-Tian'|'M. A. Shifman'|'M. Asorey' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Asorey'|'M. Atiyah'|'M. A. Vasilev'|'M. A. Vasiliev'|'M. A. Vazquez-Mozo'|'M. A. Virasoro'|'M. Awad'|'M. Awada'|'M. Axenides'|'M. Ba'|'M. Baake' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Baake'|'M. Babujian'|'M. Bachmann'|'M. Baggioli'|'M. Baig'|'M. Baker'|'M. Banados'|'M. Bander'|'M. Bando'|'M. Barbashov'|'M. Bardeen' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Bardeen'|'M. Barnett'|'M. Barr'|'M. Barrio'|'M. Barriola'|'M. Bastero-Gil'|'M. Batchelor'|'M. Bauer'|'M. Becchi'|'M. Becker'|'M. B. Einhorn' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. B. Einhorn'|'M. Bellon'|'M. Belloni'|'M. Belov'|'M. Benarous'|'M. Bender'|'M. Beneke'|'M. Benn'|'M. Berger'|'M. Bergeron'|'M. Berkooz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Berkooz'|'M. Bernstein'|'M. Berry'|'M. Bershadsky'|'M. Bertola'|'M. Bertolini'|'M. B. Gitis'|'M. B. Green'|'M. B. Halpern'|'M. B. Hindmarsh'|'M. Bianchi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Bianchi'|'M. Bill'|'M. Billo'|'M. Bismut'|'M. B. Johnson'|'M. Blagojevi'|'M. Blagojevic'|'M. Blasone'|'M. Blau'|'M. Blencowe'|'M. Bochicchio' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Bochicchio'|'M. Bodner'|'M. Bogoliubov'|'M. Bojowald'|'M. Bonini'|'M. Bordag'|'M. Bordemann'|'M. Born'|'M. Bos'|'M. Botta'|'M. Bourdeau' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Bourdeau'|'M. Bowick'|'M. B. Paranjape'|'M. B. Pinto'|'M. Braendle'|'M. Braun'|'M. Bregola'|'M. Bremer'|'M. Brisudov'|'M. Brisudova'|'M. Brown' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Brown'|'M. Bruni'|'M. Bruschi'|'M. B. Silva'|'M. Bucher'|'M. Buchstaber'|'M. Burgess'|'M. Buric'|'M. Burkardt'|'M. B. Voloshin'|'M. B. Wise' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. B. Wise'|'M. C. Abdalla'|'M. Cadoni'|'M. Cahen'|'M. Caicedo'|'M. Caldarelli'|'M. Calixto'|'M. Camino'|'M. Campbell'|'M. Campostrini'|'M. Capper' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Capper'|'M. Carena'|'M. Carfora'|'M. Carmeli'|'M. Carmona'|'M. Carrol'|'M. Carroll'|'M. Carvalho'|'M. Caselle'|'M. Cataldo'|'M. Catterall' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Catterall'|'M. Cavagli'|'M. Cavaglia'|'M. Caves'|'M. Cavicchi'|'M. C. B. Abdalla'|'M. C. Bento'|'M. C. Diamantini'|'M. Cederwall'|'M. Cerdonio'|'M. C. Gutzwiller' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. C. Gutzwiller'|'M. Chaichian'|'M. Chan'|'M. Chanowitz'|'M. Charap'|'M. Chemtob'|'M. Chen'|'M. Chepilko'|'M. Chernodub'|'M. Chervyakov'|'M. Chiang' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Chiang'|'M. Chitre'|'M. Cho'|'M. Christensen'|'M. Chu'|'M. Chung'|'M. Ciafaloni'|'M. Cialfaloni'|'M. Cicuta'|'M. Ciuchini'|'M. C. Land' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. C. Land'|'M. Claudson'|'M. Cline'|'M. C. Nemes'|'M. Cohen'|'M. Comi'|'M. Comyn'|'M. Consoli'|'M. Contreras'|'M. Coppens'|'M. Cornwall' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Cornwall'|'M. Costa'|'M. Cowdall'|'M. Coxeter'|'M. C. Payne'|'M. Crampin'|'M. Crescimanno'|'M. Creutz'|'M. Cveti'|'M.  Cvetic'|'M. Cvetic' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Cvetic'|'M. Dabrowski'|'M. Dalbosco'|'M. Daniel'|'M. Danos'|'M. Daoud'|'M. Daul'|'M. Davies'|'M. Davis'|'M. De'|'M. Dehghani' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Dehghani'|'M. Dekker'|'M. Del'|'M. Demianski'|'M. Derix'|'M. D. Freeman'|'M. D. Gould'|'M. Di'|'M. Dillard-Bleick'|'M. Din'|'M. Dine' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Dine'|'M.  Dirac'|'M. Dirac'|'M. Dixon'|'M. D. Maia'|'M. Doi'|'M. Dorca'|'M. Douglas'|'M. D. Pollock'|'M. Dremin'|'M. Drouffe' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Drouffe'|'M. Droz'|'M. D. Scadron'|'M. D. Schwartz'|'M. D. Segall'|'M. Dubois'|'M. Dubois-Violette'|'M. Duetsch'|'M. Duff'|'M. Duncan'|'M. Eardley' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Eardley'|'M. E. Carrington'|'M. E. Drits'|'M. E. Fisher'|'M. Eichler'|'M. Einhorn'|'M. El'|'M. Eliashvili'|'M. Engelhardt'|'M. E. Noz'|'M. E. Ortiz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. E. Ortiz'|'M. E. Peskin'|'M. Ernzerhof'|'M. E. Shaposhnikov'|'M. E. Sweedler'|'M. Evans'|'M. E. X. Guimar'|'M. Fabbrichesi'|'M. Faber'|'M. Fabinger'|'M. Fairbairn' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Fairbairn'|'M. Falcioni'|'M. Farkas'|'M. F. Atiyah'|'M. Faux'|'M. Fei'|'M. Ferraris'|'M. Ferreira'|'M. Fierz'|'M. Figueroa-O'|'M. Fischler' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Fischler'|'M. Fisher'|'M. Flato'|'M. Fleck'|'M. Flohr'|'M. Florig'|'M. Forger'|'M. Francaviglia'|'M. Frank'|'M. Franz'|'M. Fraser' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Fraser'|'M. Frau'|'M. Freeman'|'M. Fried'|'M. Fry'|'M. F. Sohnius'|'M. Fukuma'|'M. Furman'|'M. Gabardiel'|'M. Gaberdiel'|'M. Gadella' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Gadella'|'M. Gaillard'|'M. G. Alford'|'M. Gandenberger'|'M. Garc'|'M. Gasperini'|'M. Gaudin'|'M. G. Brereton'|'M. Gel'|'M. Gelfand'|'M. Gell' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Gell'|'M. Gell-Mann'|'M. Gerstenhaber'|'M. Ghezelbash'|'M. Giovannini'|'M. Girvin'|'M. Gitman'|'M. G. Ivanov'|'M. Glazman'|'M. Gleason'|'M. Gleiser' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Gleiser'|'M. Gockeler'|'M. Gogberashvili'|'M. Goldhaber'|'M. Golshani'|'M. Golterman'|'M. Gomes'|'M. Gomez-Reino'|'M. Goodman'|'M. Goroff'|'M. Gotay' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Gotay'|'M. Gould'|'M. Goulian'|'M. Gra'|'M. Gracia-Bond'|'M. Gracia-Bondia'|'M. Grady'|'M. Graesser'|'M. Graf'|'M. Grana'|'M. Green' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Green'|'M. Gremm'|'M. Grimstrup'|'M.  Grisaru'|'M. Grisaru'|'M. Gromov'|'M. Gross'|'M. G. Schmidt'|'M. Guagnelli'|'M. Gugenheim'|'M. Gunaydin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Gunaydin'|'M. Gusein-Zade'|'M. Gutperle'|'M. Gyulassy'|'M. Haack'|'M. Hadad'|'M. Haft'|'M. Halasz'|'M. Haldane'|'M. Hall'|'M. Halpern' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Halpern'|'M. Hamanaka'|'M. Hamermesh'|'M. Harada'|'M. Hasenbusch'|'M. Hassan'|'M. Hatsuda'|'M. Hayakawa'|'M. Hazewinkel'|'M. H. Dehghani'|'M. Headrick' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Headrick'|'M. Heller'|'M. Hellmund'|'M. Henkel'|'M. Hennaux'|'M.  Henneaux'|'M. Henneaux'|'M. Hennigson'|'M. Henningson'|'M. Heusler'|'M. H. Goroff' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. H. Goroff'|'M. H. G. Tytgat'|'M. Hindmarsh'|'M. Hirayama'|'M. Hirsch'|'M. Ho'|'M. Holm'|'M. Horibe'|'M. Hott'|'M. Hotta'|'M. H. Sarmadi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. H. Sarmadi'|'M. Huang'|'M.  Hull'|'M. Hull'|'M. Huq'|'M. I. Caicedo'|'M. Idzumi'|'M. I. J. Probert'|'M. Ikehara'|'M. Ilgenfritz'|'M. Infeld' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Infeld'|'M. Ioffe'|'M. I. Polikarpov'|'M. Isidro'|'M. Ito'|'M. Izquierdo'|'M. J. Ablowitz'|'M. Jacob'|'M. Jauch'|'M. J. Bowick'|'M.  J.  Duff' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M.  J.  Duff'|'M. J. Duff'|'M. Jimbo'|'M. Jinzenji'|'M. J. Martins'|'M. Joyce'|'M. J. Perry'|'M. J. Slater'|'M. J. Strassler'|'M. Kac'|'M. Kaku' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Kaku'|'M. Kalb'|'M. Kaluza'|'M. Kamata'|'M. Kamionkowski'|'M. Kapranov'|'M. Kardar'|'M. Karliner'|'M. Karoubi'|'M. Karowski'|'M. Karowsky' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Karowsky'|'M. Kashaev'|'M. Kashiwara'|'M. Kato'|'M. Katsuki'|'M. Kawamura'|'M. Kawasaki'|'M. Kersten'|'M. K. Gaillard'|'M. Khalatnikov'|'M. Khoroshkin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Khoroshkin'|'M. Khorrami'|'M. Khudaverdian'|'M. Khvedelidze'|'M. Kibler'|'M. Kiometzis'|'M. Kirchbach'|'M. Kleban'|'M. Klein'|'M. Klein-Kreisler'|'M. Klishevich' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Klishevich'|'M. K. Murray'|'M. Knecht'|'M. Kobayashi'|'M. Kohmoto'|'M. Komachiya'|'M. Kontsevich'|'M. Koo'|'M. Kosterlitz'|'M. K. Parikh'|'M. K. Prasad' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. K. Prasad'|'M. Krasnitz'|'M. Krauss'|'M. Krautg'|'M. Kreuzer'|'M. Krichever'|'M. Krogh'|'M. Kruczenski'|'M. Kudinov'|'M. Kugler'|'M. Kuzenko' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Kuzenko'|'M. Laidlaw'|'M. Laine'|'M. Lakshmanan'|'M. Langer'|'M. Lassig'|'M. Laucelli'|'M. Laursen'|'M. Lavelle'|'M. Lavrov'|'M. Le' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Le'|'M. Leblanc'|'M. Lee'|'M. Legar'|'M. Lehn'|'M. Leinaas'|'M. Lemoine'|'M. Lev'|'M. Leviant'|'M. Levy'|'M. Levy-Leblond' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Levy-Leblond'|'M. L. Ge'|'M. L. Goldberger'|'M. Li'|'M. Lichtzier'|'M. Lifschitz'|'M. Lifshits'|'M. Lifshitz'|'M. Lindner'|'M. Litterio'|'M. Llatas' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Llatas'|'M. L. Mazou'|'M. L. Meana'|'M. L. Mehta'|'M. Loewe'|'M. Loss'|'M. Lubo'|'M. Luck'|'M. Luo'|'M. Luscher'|'M. Luty' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Luty'|'M. L. Yan'|'M. Lygren'|'M. Lynker'|'M. Mac'|'M. Maeno'|'M. Maggiore'|'M. Magro'|'M. Maillard'|'M. Maillet'|'M. Majewski' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Majewski'|'M. Majumdar'|'M. Makeenko'|'M.  Maldacena'|'M. Maldacena'|'M. Mandelberg'|'M. Mangano'|'M. Mangin-Brinet'|'M. Marcolli'|'M. Marcu'|'M. Mari' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Mari'|'M. Marino'|'M. Markl'|'M. Markov'|'M. Martellini'|'M. Masood-ul'|'M. Masoud-ul'|'M. Massar'|'M. Mathur'|'M. Matone'|'M. Mattis' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Mattis'|'M. M. Brisudov'|'M. M. Caldarelli'|'M. McAvity'|'M. McCoy'|'M. McGuigan'|'M. Mebkhout'|'M. Medved'|'M. Mehta'|'M. Mezard'|'M. Mihailescu' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Mihailescu'|'M. Milekovi'|'M. Mintchev'|'M. Misiak'|'M. Miura'|'M. Mladenov'|'M. M. Nieto'|'M. Modugno'|'M. Mondrag'|'M. Mondragon'|'M. Moreno' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Moreno'|'M. Moriconi'|'M. Morse'|'M. Morsink'|'M. Moshe'|'M. Moshinsky'|'M. Mostepanenko'|'M. Mour'|'M. Mourao'|'M. Mozrzymas'|'M. M. Sheikh' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. M. Sheikh'|'M. M. Sheikh-Jabbari'|'M. M. Taylor-Robinson'|'M. Mueller'|'M. Mukunda'|'M. Mulase'|'M. Muller'|'M. Murray'|'M. Na'|'M. Naganuma'|'M. Nagy' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Nagy'|'M. Naka'|'M. Nakahara'|'M. Namiki'|'M. Naon'|'M. Narita'|'M. Natsuume'|'M. Nauenberg'|'M. Navarro'|'M. Nazarov'|'M. N. Barber' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. N. Barber'|'M. N. Chernodub'|'M. Nelson'|'M. Nester'|'M. Neubert'|'M. Newman'|'M. Niedermaier'|'M. Nielsen'|'M. Nieto'|'M. Ninomiya'|'M. Nishigaki' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Nishigaki'|'M. Nishimura'|'M. Nitta'|'M. Noumi'|'M. Novello'|'M. Nowak'|'M. Nozaki'|'M. Oka'|'M. Okado'|'M. O. Katanaev'|'M. Okawa' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Okawa'|'M. Olechowski'|'M. Oleszczuk'|'M. Olshanetsky'|'M. Omote'|'M. Ortiz'|'M. O. Scully'|'M. Oshikawa'|'M. Osorio'|'M. Ostrogradski'|'M. P. A. Fisher' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. P. A. Fisher'|'M. Pantaleo'|'M. Paranjape'|'M. Park'|'M. Parry'|'M. Paschke'|'M. Pauri'|'M. Pav'|'M. Pavsic'|'M. Pawlowski'|'M. P. Blencowe' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. P. Blencowe'|'M. P. Dabrowski'|'M. Peardon'|'M. Pelinson'|'M. Peloso'|'M. Penkava'|'M. Pepper'|'M. Perelomov'|'M. Perelstein'|'M. Perez-Victoria'|'M. Pernici' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Pernici'|'M. Perry'|'M. Peshkin'|'M. Peskin'|'M. Petrini'|'M. Petropoulos'|'M. Peyrard'|'M. P. Fry'|'M. Picariello'|'M. Picco'|'M. Pierre' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Pierre'|'M. Pietroni'|'M. Pillin'|'M. Pimentel'|'M. Pimsner'|'M. Pinto'|'M. Pis'|'M. Pitk'|'M. Pleimling'|'M. Plesser'|'M. Plyushchay' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Plyushchay'|'M. P. Mattis'|'M. P. Nightingale'|'M. Polikarpov'|'M. Pollock'|'M. Polyak'|'M. Polyakov'|'M. Pons'|'M. Porati'|'M. Poratti'|'M. Porrati' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Porrati'|'M. Pospelov'|'M. Praszalowicz'|'M. Prosperi'|'M. Pruisken'|'M. P. Ryan'|'M. Przanowski'|'M. Puchin'|'M. Quandt'|'M. Quashnock'|'M. Quir' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Quir'|'M. Quiros'|'M. Rabin'|'M. R. Abolhasani'|'M. Raciti'|'M. Rahman'|'M. Rahmanov'|'M. Rainer'|'M. Raiteri'|'M. Rakowski'|'M. Rakowsky' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Rakowsky'|'M. Ram'|'M. Ramon'|'M. Rangamani'|'M. Rasetti'|'M. Raugas'|'M. Rausch'|'M. R. Brown'|'M. R. Douglas'|'M. Reed'|'M. Reenders' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Reenders'|'M. Reid'|'M. Reisenberger'|'M. Requardt'|'M. Reuter'|'M. Revzen'|'M. R. Gaberdiel'|'M. R. Garousi'|'M. Rho'|'M. Ribordy'|'M. Rice' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Rice'|'M. Rieffel'|'M. Rinaldi'|'M. Rinke'|'M. Rios'|'M. R. Negr'|'M. R. Niedermaier'|'M.  Ro'|'M. Ro'|'M. Robnik'|'M. Roc' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Roc'|'M. Rocek'|'M. Roelofs'|'M. Rojas'|'M. Roncadelli'|'M. Ronen'|'M. Rooman'|'M. Rosenbaum'|'M. Rossi'|'M. Rosso'|'M. Rozali' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Rozali'|'M. R. Pennington'|'M.  R.  Plesser'|'M. R. Plesser'|'M. R. Rahimi'|'M. R. Setare'|'M. Rubin'|'M. R. Ubriaco'|'M. Ruijsenaars'|'M. Ruiz-Altaba'|'M. Ryan' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Ryan'|'M. Ryzhik'|'M. Saadat'|'M. Saadi'|'M. Sabido'|'M. Saffin'|'M. Sakaguchi'|'M. Sakamoto'|'M. Sakellariadou'|'M. Salamon'|'M. Salerno' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Salerno'|'M. Salim'|'M. Salizzoni'|'M. Salmhofer'|'M. Sami'|'M. Samiullah'|'M. Samols'|'M. Sampaio'|'M. Sanchez'|'M. Santander'|'M. Santangelo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Santangelo'|'M. Santilli'|'M. Santos'|'M. Saradzhev'|'M. Sarmadi'|'M. Sasaki'|'M. Sato'|'M. Saveliev'|'M. Sawicki'|'M. Sc'|'M. Scandurra' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Scandurra'|'M. Sch'|'M. Schaden'|'M. S. Chanowitz'|'M. Scheunert'|'M. Schiffer'|'M. Schlichenmaier'|'M. Schlieker'|'M. Schmaltz'|'M. Schmidt'|'M. Schnabl' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Schnabl'|'M. Scholl'|'M. Schulz'|'M. Schvellinger'|'M. Schwarz'|'M. Schweda'|'M. Schwetz'|'M. S. Costa'|'M. Semenov'|'M. Semenov-Tian'|'M. Semikhatov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Semikhatov'|'M. Sengupta'|'M. Serdaroglu'|'M. Sergeev'|'M. Serone'|'M. S. Green'|'M. Shaposhnikov'|'M. Sheikh'|'M. Sheikh-Jabbari'|'M. Sher'|'M. Shibata' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Shibata'|'M. Shifman'|'M. Shino'|'M. Shiroishi'|'M. Shirokov'|'M. Shmakova'|'M. Shnir'|'M. Shore'|'M. Shubin'|'M. Shvartsman'|'M. Sibiryakov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Sibiryakov'|'M. Siino'|'M. Simionato'|'M. Simmons'|'M. Singer'|'M. Sivakumar'|'M. Slater'|'M. S. Marinov'|'M. S. Morris'|'M. S. Narasimhan'|'M. Sohnius' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Sohnius'|'M. Soldate'|'M. Sommerfeld'|'M. Sommerfield'|'M. Sotkov'|'M. Souriau'|'M. Spali'|'M. Spalinski'|'M. Speight'|'M. Spiegelglas'|'M. Spivak' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Spivak'|'M. S. Plyushchay'|'M.  Spradlin'|'M. Spradlin'|'M. Srednicki'|'M. Srivastava'|'M. Stanishkov'|'M. Staudacher'|'M. Stephanov'|'M. Stern'|'M. Stevenson' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Stevenson'|'M. Stewart'|'M. Stingl'|'M. Stoilov'|'M. Stone'|'M. Strassler'|'M. Strickland'|'M. Studer'|'M. S. Turner'|'M. Sugiura'|'M. Surridge' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Surridge'|'M. Sutcliffe'|'M. Suzuki'|'M. S. Volkov'|'M. Szyd'|'M. Szydlowski'|'M. Tabor'|'M. Tabuse'|'M. Tachibana'|'M. Tachiki'|'M. Takahashi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Takahashi'|'M. Takao'|'M. Takeda'|'M. Takesaki'|'M. Talon'|'M. Tanabashi'|'M. Tanaka'|'M. Taniguchi'|'M. Tanimoto'|'M. Tarlini'|'M. Taut' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Taut'|'M. Taylor'|'M. Taylor-Robinson'|'M. T. Batchelor'|'M. Teper'|'M. Terentev'|'M. Terhoeven'|'M. Ternov'|'M. Testa'|'M. T. Grisaru'|'M. Thaddeus' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Thaddeus'|'M. Thies'|'M. Tissier'|'M. T. Jaekel'|'M. Toda'|'M. Toller'|'M.  Tonin'|'M. Tonin'|'M. Torres'|'M. Trigiante'|'M. Trobo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Trobo'|'M. Trodden'|'M. Tsuda'|'M. Tsulaia'|'M. Tsvelick'|'M. Tsvelik'|'M. Tulczyjew'|'M. Turner'|'M. Turyn'|'M. Tuynman'|'M. Uehara' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Uehara'|'M. Uranga'|'M. Van'|'M. Vanderkelen'|'M. Varadarajan'|'M. Vasili'|'M. Vasiliev'|'M. V. Berry'|'M. V. Chizhov'|'M. V. Cougo-Pinto'|'M. Veltman' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Veltman'|'M. Verbaarschot'|'M. Vergne'|'M. Vermaseren'|'M. Vershik'|'M. Viallet'|'M. Villanueva'|'M. Villasante'|'M. Vinogradov'|'M. V. Ioffe'|'M. Virasoro' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Virasoro'|'M.  Visinescu'|'M. Visinescu'|'M. Visser'|'M. V. Mozo'|'M. V. N. Murthy'|'M. Volkov'|'M. Voloshin'|'M. Vozmediano'|'M. V. Raamsdonk'|'M. V. Saveliev' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. V. Saveliev'|'M. Wadati'|'M. Wagner'|'M. Wakimoto'|'M. Wald'|'M. Walker'|'M. Walton'|'M. Walze'|'M. Watson'|'M. Wehlau'|'M. Weinstein' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Weinstein'|'M. Welling'|'M. Werneck'|'M. Werner'|'M. W. Evans'|'M. Wexler'|'M. White'|'M. Widrow'|'M. Wijnholt'|'M. Will'|'M. Williams' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Williams'|'M. Wise'|'M. Witt'|'M. Wodzicki'|'M. Wohlgenannt'|'M. Wolf'|'M. Xu'|'M. Ya'|'M. Yahiro'|'M. Yamaguchi'|'M. Yamamoto' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Yamamoto'|'M. Yamasaki'|'M.  Yan'|'M. Yan'|'M. Yoshida'|'M. Yoshimura'|'M. Yu'|'M. Yung'|'M. Yurova'|'M. Zabzine'|'M. Zach' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Zach'|'M. Zagermann'|'M. Zakkari'|'M. Zaldarriaga'|'M. Zamaklar'|'M. Zeni'|'M. Zerwas'|'M. Zhang'|'M. Zinoviev'|'M. Z. Iofa'|'M. Zirnbauer' => { printf("token: %sn", std::string(ts, te).c_str()); };
'M. Zirnbauer'|'M. Znojil'|'M. Zucker'|'M. Zupnik'|'M. Zylinski'|'M. Zyskin'|'N. A. Batakis'|'N. A. Chernikov'|'N. Agasian'|'N. Aizawa'|'N. Alonso-Alberca' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Alonso-Alberca'|'N. Anagnostopoulos'|'N. Andersson'|'N. Andrei'|'N. A. Nekrasov'|'N. A. Obers'|'N. A. Papadopoulos'|'N. Arkani'|'N. Arkani-Hamed'|'N. A. Slavnov'|'N. Bahcall' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Bahcall'|'N. Baier'|'N. Banerjee'|'N. Barber'|'N. Beisert'|'N. Berkovits'|'N. Berkovitz'|'N. Berline'|'N. Bernstein'|'N. Birrell'|'N. Bogoliubov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Bogoliubov'|'N. Bogolubov'|'N. Bogolyubov'|'N. Bohr'|'N. Boulanger'|'N. Bourbaki'|'N. Brali'|'N. Bralic'|'N. Brambilla'|'N. Brene'|'N. Brown' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Brown'|'N. B. Skachkov'|'N. Cabibbo'|'N. Chair'|'N. Chang'|'N. Chernodub'|'N. Christ'|'N. Cim'|'N. Cimento'|'N. C. Leung'|'N. Constable' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Constable'|'N. Cooper'|'N. Coote'|'N. Craigie'|'N. Cruz'|'N. C. Tsamis'|'N. Dadhich'|'N. D. Birrel'|'N. D. Birrell'|'N. Debergh'|'N. Deo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Deo'|'N. Deruelle'|'N. D. Hari'|'N. D. Lambert'|'N. D. Mermin'|'N. D. Mermin'|'N. Dombey'|'N. Dorey'|'N. Dragon'|'N. Drukker'|'N. E. Frankel' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. E. Frankel'|'N. E. Mavromatos'|'N. Engberg'|'N. Evans'|'N. E. Wegge-Olsen'|'N. Feehan'|'N. Fleury'|'N. F. Svaiter'|'N. Gadella'|'N. Gisin'|'N. Goldberg' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Goldberg'|'N. Goldenfeld'|'N. Graham'|'N. Grandi'|'N. Gribov'|'N. Grillo'|'N. Gupta'|'N. Gurappa'|'N. Haba'|'N. Habegger'|'N. Halmagyi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Halmagyi'|'N. Hambli'|'N. H. Barth'|'N. H. Christ'|'N. Hitchin'|'N. Hu'|'N. Ikeda'|'N. Ilieva'|'N. Irges'|'N. Isgur'|'N. Ishibashi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Ishibashi'|'N. I. Troitskaya'|'N. Itzhaki'|'N. Ja'|'N. Jacobson'|'N. J. Hitchin'|'N. Jing'|'N. J. Mac'|'N. Jones'|'N. J. Watson'|'N. Kaloper' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Kaloper'|'N. Kamran'|'N. Kapustin'|'N. Kawakami'|'N. Kawamoto'|'N. Kemmer'|'N. K. Falck'|'N. Khuri'|'N. Khvengia'|'N. Khviengia'|'N. Kim' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Kim'|'N. Kirillov'|'N. Kitanine'|'N. Kitsunezaki'|'N. K. Nielsen'|'N. Koblitz'|'N. Kondrashuk'|'N. K. Pak'|'N. Ktorides'|'N. Kumar'|'N. Kvinikhidze' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Kvinikhidze'|'N. Lambert'|'N. Lebedev'|'N. Leung'|'N. Leznov'|'N. Li'|'N. Linden'|'N. Lipatov'|'N. Mac'|'N. Madras'|'N. Maekawa' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Maekawa'|'N. Maggiore'|'N. Magnoli'|'N. Maintas'|'N. Malkin'|'N. Manashov'|'N. Manko'|'N. Manton'|'N. Marachevsky'|'N. Marcus'|'N. Markus' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Markus'|'N. Maru'|'N. Matsumoto'|'N. Mavromatos'|'N. M. Bogoliubov'|'N. McArthur'|'N. Melnikov'|'N. Miljkovi'|'N. Miljkovic'|'N. Mitra'|'N. M. J. Woodhouse' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. M. J. Woodhouse'|'N. Moeller'|'N. Mohammedi'|'N. Mohapatra'|'N. Mukunda'|'N. Nakanishi'|'N. Nakayama'|'N. Nakazawa'|'N. N. Bogoliubov'|'N. N. Bogolubov'|'N. N. Bogolyubov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. N. Bogolyubov'|'N. Nekrasov'|'N. Nikitin'|'N. N. Khuri'|'N. N. Trunov'|'N. Obers'|'N. Obukhov'|'N. Oerter'|'N. Ogawa'|'N. Ohta'|'N. Ohtsubo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Ohtsubo'|'N. Okada'|'N. Orginos'|'N. Page'|'N. Pantoja'|'N. Panza'|'N. Papanicolaou'|'N. Pendleton'|'N. Pervushin'|'N. P. Landsman'|'N. Plechko' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Plechko'|'N. Plesser'|'N. Polonsky'|'N. Pope'|'N. Popov'|'N. Prezas'|'N. P. Warner'|'N. Pyatov'|'N. R. Constable'|'N. Read'|'N. Redlich' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Redlich'|'N. Reshetikhin'|'N. Reshetikin'|'N. R. F. Braga'|'N. Rius'|'N. Rom'|'N. Romanov'|'N. Roman-Roy'|'N. Rosen'|'N. Roshchupkin'|'N. Rybkin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Rybkin'|'N. Sadooghi'|'N. Sago'|'N. Sakai'|'N. Salingaros'|'N. Salwen'|'N. Sanchez'|'N. Sasakura'|'N. Saulina'|'N. Schellekens'|'N. Schramm' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Schramm'|'N. Scoccola'|'N. S. Craigie'|'N.  Seiberg'|'N. Seiberg'|'N. Sen'|'N. Shaju'|'N. Sherry'|'N. Shnerb'|'N. Silveira'|'N. Sissakian' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Sissakian'|'N. S. Manko'|'N. S. Manton'|'N. Sochen'|'N. Solodukhin'|'N. Sourlas'|'N. Sousa'|'N. Spergel'|'N. Steenrod'|'N. Straumann'|'N. Sugiyama' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Sugiyama'|'N. Svartholm'|'N. Taniguchi'|'N. Tavkhelidze'|'N. Tell'|'N. Terzi'|'N. Tetradis'|'N. Tolstoy'|'N. Tomaras'|'N. Toumbas'|'N. Trunov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Trunov'|'N. Tsuda'|'N. Turok'|'N. Tyukhtyaev'|'N. Varchenko'|'N. Vasil'|'N. Vergeles'|'N. Vilenkin'|'N. V. Krasnikov'|'N. V. Suryanarayana'|'N. Wallach' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Wallach'|'N. Warner'|'N. W. Ashcroft'|'N. Watson'|'N. Weiner'|'N. Weiss'|'N. Woodhouse'|'N. Wschebor'|'N. Wyllard'|'N. Ya'|'N. Yang' => { printf("token: %sn", std::string(ts, te).c_str()); };
'N. Yang'|'N. Yetter'|'N. Yokoi'|'N. Y. Reshetikhin'|'N. Yu'|'N. Zanghi'|'O. A. Battistel'|'O. Abe'|'O. Agasian'|'O. Aharony'|'O. Alvarez' => { printf("token: %sn", std::string(ts, te).c_str()); };
'O. Alvarez'|'O. Andreev'|'O. A. Rytchkov'|'O. A. Soloviev'|'O. Babelon'|'O. Barut'|'O. Barvinsky'|'O. Bergman'|'O. Bergmann'|'O. Bertolami'|'O. Bohigas' => { printf("token: %sn", std::string(ts, te).c_str()); };
'O. Bohigas'|'O. Bohr'|'O. Bowman'|'O. Bratteli'|'O. Brodbeck'|'O. B. Zaslavskii'|'O. Caldeira'|'O. Casta'|'O. Chand'|'O. Chandia'|'O. Coceal' => { printf("token: %sn", std::string(ts, te).c_str()); };
'O. Coceal'|'O. Corradini'|'O. Coussaert'|'O. D. Andreev'|'O. De'|'O. Dreyer'|'O. Eboli'|'O. Escobar'|'O. Espinosa'|'O. Feinerman'|'O. Foda' => { printf("token: %sn", std::string(ts, te).c_str()); };
'O. Foda'|'O. Freund'|'O. Ganor'|'O. Garc'|'O. Girotti'|'O. Golinelli'|'O. Gorovoy'|'O. Grandjean'|'O. Haan'|'O. Heinonen'|'O. Heinrich' => { printf("token: %sn", std::string(ts, te).c_str()); };
'O. Heinrich'|'O. I. Marichev'|'O. Jahn'|'O. J. C. Dias'|'O. J. Ganor'|'O. Katanaev'|'O. Kechkin'|'O. Kenneth'|'O. Klein'|'O. K. Pashaev'|'O. Krivonos' => { printf("token: %sn", std::string(ts, te).c_str()); };
'O. Krivonos'|'O. Lauscher'|'O. Lechtenfeld'|'O. Levin'|'O. Lindgren'|'O. Lousto'|'O. Lunin'|'O. Madsen'|'O. Martin'|'O. Mazur'|'O. M. Del' => { printf("token: %sn", std::string(ts, te).c_str()); };
'O. M. Del'|'O. Miyamura'|'O. M. Khudaverdian'|'O. Moritsch'|'O. Nachtmann'|'O. Napoly'|'O. Narayan'|'O. Obreg'|'O. Obregon'|'O. Ogievetsky'|'O. Pelc' => { printf("token: %sn", std::string(ts, te).c_str()); };
'O. Pelc'|'O. Pene'|'O. Philipsen'|'O. Piguet'|'O. Pimentel'|'O. Pires'|'O. Pujol'|'O. Pujolas'|'O. Radul'|'O. Raetzel'|'O. Ragnisco' => { printf("token: %sn", std::string(ts, te).c_str()); };
'O. Ragnisco'|'O. Reula'|'O. Rivelles'|'O. Roland'|'O. Ronco'|'O. Ruchayskiy'|'O. Saliu'|'O. Schnetz'|'O. Schramm'|'O. Scully'|'O. Seto' => { printf("token: %sn", std::string(ts, te).c_str()); };
'O. Seto'|'O. Soloviev'|'O. Stamatescu'|'O. Steinmann'|'O. S. Ventura'|'O. Tafjord'|'O. Taha'|'O. Tarasov'|'O. Tennert'|'O. Tirkkonen'|'O. Tsuchiya' => { printf("token: %sn", std::string(ts, te).c_str()); };
'O. Tsuchiya'|'O. T. Turgut'|'O. Viro'|'O. V. Tarasov'|'O. Warnaar'|'O. Wells'|'O. W. Greenberg'|'O. Winkler'|'O. Yasuda'|'O. Zaboronsky'|'O. Zakharov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'O. Zakharov'|'P. A. Clarkson'|'P. Adamietz'|'P. Ader'|'P. A. Grassi'|'P. A. Griffin'|'P.  A.  Horv'|'P. A. Horv'|'P. A. Horvathy'|'P. Akulov'|'P. A. Lee' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. A. Lee'|'P. A. Maia'|'P. A. Marchetti'|'P. A. M. Dirac'|'P. Amsterdamski'|'P. Anderson'|'P. Antoine'|'P. Ao'|'P. Aparicio'|'P. A. Pearce'|'P. Argyres' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Argyres'|'P. Arnold'|'P. Arovas'|'P. Aschieri'|'P. Aspinwall'|'P. Astone'|'P. Bachas'|'P. Bain'|'P. Bak'|'P. Balachandran'|'P. Bantay' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Bantay'|'P. Baseilhac'|'P. Becher'|'P. Bedaque'|'P. Bedaque'|'P. Bellon'|'P. Berezovoj'|'P. Berglund'|'P. B. Gilkey'|'P. Bhattacharjee'|'P. Bialas' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Bialas'|'P. Billyard'|'P. Bin'|'P. Binetruy'|'P. Bizon'|'P. B. Kronheimer'|'P. Blaizot'|'P. Blasi'|'P. Blencowe'|'P. B. Medvedev'|'P. Boucaud' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Boucaud'|'P. Bourguignon'|'P. Bouwknegt'|'P. Bowcock'|'P. Boyer'|'P. Bozhilov'|'P. Braam'|'P. Branson'|'P. Brax'|'P. Breitenlohner'|'P. Budinich' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Budinich'|'P. Bukhvostov'|'P. Burgess'|'P. Busch'|'P. Butera'|'P. B. Wiegman'|'P. B. Wiegmann'|'P. C. Aichelburg'|'P. Calabrese'|'P. Cambridge'|'P. Candelas' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Candelas'|'P.  C.  Argyres'|'P. C. Argyres'|'P. Carruthers'|'P. Carta'|'P. Cartier'|'P. Castelo'|'P. Castorina'|'P. C. Davies'|'P. Cea'|'P. Chang' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Chang'|'P. Chen'|'P. Cheng'|'P. Chingangbam'|'P. Cho'|'P. C. Hohenberg'|'P. Christe'|'P. Clarkson'|'P. Claus'|'P. C. Martin'|'P. Colatto' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Colatto'|'P. Constantinidis'|'P. Cordero'|'P. Cotta'|'P. Cotta-Ramusino'|'P. Cowdall'|'P. Cox'|'P. Creminelli'|'P. Crewther'|'P. C. Stichel'|'P. Cvitanovi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Cvitanovi'|'P. Cvitanovic'|'P. C. W. Davies'|'P. C. West'|'P. Dabrowski'|'P. Damgaard'|'P. Davies'|'P. Dazord'|'P. De'|'P. Dedecker'|'P. Dedonder' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Dedonder'|'P. Degiovanni'|'P. Deift'|'P. Deligne'|'P. Demichev'|'P. Derendinger'|'P. Devecchi'|'P. Di'|'P. Dimopoulos'|'P. Dirac'|'P. D. Jarvis' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. D. Jarvis'|'P. D. Mannheim'|'P. Dobiasch'|'P. Dolan'|'P. Donato'|'P. Dorey'|'P. Dumas'|'P. Eckle'|'P. E. Dorey'|'P. E. Haagensen'|'P. Eisenhart' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Eisenhart'|'P. Eisenstein'|'P. Elmfors'|'P. Ennes'|'P. Epstein'|'P. Etingof'|'P. Fayet'|'P. F. Bedaque'|'P. Federbush'|'P. Fendley'|'P. Ferreira' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Ferreira'|'P. Feynman'|'P. Flannery'|'P. Fletcher'|'P. F. Mende'|'P. Fordy'|'P. Forg'|'P. Forgac'|'P. Forgacs'|'P. Fr'|'P. Frampton' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Frampton'|'P. Fre'|'P. Freund'|'P. Freyd'|'P. Frolov'|'P. Furlan'|'P. Gabriel'|'P. Gaete'|'P. Gaigg'|'P. Garrahan'|'P. Gauduchon' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Gauduchon'|'P. Gauntlett'|'P. Gauron'|'P. Gavrilov'|'P. Gazeau'|'P. G. Bergman'|'P. G. Bergmann'|'P. Gerbert'|'P. Giacconi'|'P. Gilkey'|'P. Ginsparg' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Ginsparg'|'P. G. Lauwers'|'P. Goddard'|'P. G. O. Freund'|'P. Goncharov'|'P. Gosdzinsky'|'P. Gr'|'P. Grang'|'P. Green'|'P. Gregoire'|'P. Gregory' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Gregory'|'P. Griffin'|'P. Griffiths'|'P. Grigoryan'|'P. Grinevich'|'P. Grinza'|'P. Grishchuk'|'P. G. Tinyakov'|'P. Gueuvoghlanian'|'P. Gusynin'|'P. G. Zograf' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. G. Zograf'|'P. Haagensen'|'P. Haberl'|'P. Haggi-Mani'|'P. Hajicek'|'P. Hasenfratz'|'P. Hays'|'P. H. Damgaard'|'P. Hernandez'|'P. Herzog'|'P. Heslop' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Heslop'|'P. H. Frampton'|'P. Higgs'|'P. Hirschfeld'|'P. Ho'|'P. Hofer'|'P. Hoodbhoy'|'P. Horava'|'P. Horja'|'P. Horova'|'P. Horv' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Horv'|'P. Horvathy'|'P. Horwitz'|'P. Howe'|'P. Hoxha'|'P. Hu'|'P. Huet'|' Phys. Lett.'|'P. I. Fomin'|'P. I. Pronin'|'P. Irwin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Irwin'|'P. Isaev'|'P. Jain'|'P. J. Arias'|'P. Jatkar'|'P. J. E. Peebles'|'P. Jetzer'|'P. J. Forrester'|'P. J. Hasnip'|'P. J. Olver'|'P. Jordan' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Jordan'|'P. J. Ruback'|'P. J. Silva'|'P. J. Steinhardt'|'P. Kadanoff'|'P. Kanti'|'P. Karmazin'|'P. Kaste'|'P. Kaus'|'P. Kerr'|'P. K. Ghosh' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. K. Ghosh'|'P. Khastgir'|'P. Killingback'|'P. Kim'|'P. K. Kovtun'|'P. Klevansky'|'P. K. Mitter'|'P. K. N. Yu'|'P. Ko'|'P. Kobushkin'|'P. Koerber' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Koerber'|'P. Kolokotronis'|'P. Korchemsky'|'P. Korthals'|'P. Kosi'|'P. Kosinski'|'P. K. Panigrahi'|'P. Kramer'|'P. Kraus'|'P. Krauss'|'P. Kronheimer' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Kronheimer'|'P. K. Roy'|'P. K. S. Dunsby'|'P. K. Townsed'|'P.  K.  Townsend'|'P. K. Townsend'|'P. K. Tripathy'|'P. Kulish'|'P. Kumar'|'P. Kunzle'|'P. Kurzepa' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Kurzepa'|'P. Labelle'|'P. Laguna'|'P. Lakdawala'|'P. Lam'|'P. Landsman'|'P. Langacker'|'P. Langfelder'|'P. Lano'|'P. L. Antonelli'|'P. Lauwers' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Lauwers'|'P. Lavrov'|'P. Lax'|'P. Le'|'P. Lee'|'P. Lepage'|'P. Leroy'|'P. Letelier'|'P. Lett'|'P. Li'|'P. Libermann' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Libermann'|'P. Likhtman'|'P. Liljenberg'|'P. Liu'|'P. Loubeyre'|'P. Lounesto'|'P. Luminet'|'P. L. White'|'P. Ma'|'P. Majumdar'|'P. Malik' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Malik'|'P. Mansfield'|'P. Manvelian'|'P. Manvelyan'|'P. Marchetti'|'P. Maris'|'P. Mart'|'P. Martin'|'P. Martineau'|'P. Martinetti'|'P. Martins' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Martins'|'P. Maslanka'|'P. Maslov'|'P. Mathieu'|'P. Mattis'|'P. Mattsson'|'P. Mayr'|'P. Mazur'|'P. McKean'|'P. Meesen'|'P. Meessen' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Meessen'|'P. Melvin'|'P. Mende'|'P. Menotti'|'P. Merlatti'|'P. M. Garnavich'|'P. M. Ho'|'P. Minces'|'P. Minkowski'|'P. Minnaert'|'P. Miron' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Miron'|'P. Mitra'|'P. Mitter'|'P. M. Kaplan'|'P. M. Lavrov'|'P. M. Llatas'|'P. M. Morse'|'P. Moniz'|'P. Montague'|'P. Morse'|'P. Moussa' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Moussa'|'P. Moxhay'|'P. M. Petropoulos'|'P. M. Saffin'|'P. M. Stevenson'|'P. M. Sutcliffe'|'P. Mukhopadhyay'|'P. Nair'|'P. Nardone'|'P. Nath'|'P. Natividade' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Natividade'|'P. Navarro'|'P. Nelson'|'P. Nersessian'|'P. Neto'|'P. Neupane'|'P. Nicolini'|'P. Nieuwenhuizen'|'P. Nightingale'|'P. Nilles'|'P. N. Meisinger' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. N. Meisinger'|'P. Nogueira'|'P. Novikov'|'P. Nozi'|'P. N. Pyatov'|'P. Nunes'|'P. Oh'|'P. Olesen'|'P. Olver'|'P. O. Mazur'|'P. Orland' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Orland'|'P. Osland'|'P. Ostriker'|'P. Ouyang'|'P. Painlev'|'P. Panigrahi'|'P. Papadopoulos'|'P. Pasanen'|'P. Pascual'|'P.  Pasti'|'P. Pasti' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Pasti'|'P. Pavel'|'P. Paz'|'P. Pearce'|'P. Peld'|'P. Peldan'|'P. Penalba'|'P. Peter'|'P. Petreczky'|'P. Petropoulos'|'P. Pitaevski' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Pitaevski'|'P. Pitaevskii'|'P. Pitaevsky'|'P. Pitanga'|'P. P. Kulish'|'P. Podle'|'P. Podles'|'P. Polychronakos'|'P. Porfyriadis'|'P. Pouliot'|'P. Pre' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Pre'|'P. Presnajder'|'P. Prester'|'P. Pronin'|'P. Provero'|'P. Prudnikov'|'P. P. Srivastava'|'P. Ramadevi'|'P. Ramond'|'P. R. Anderson'|'P. R. Brady' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. R. Brady'|'P. Reinicke'|'P. Repo'|'P. R. Holland'|'P. Ring'|'P. Roberts'|'P. Roche'|'P. Rodrigues'|'P. Roman'|'P. Rossi'|'P. Roy' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Roy'|'P. Ruback'|'P. Ruelle'|'P. Ryan'|'P. Rybakov'|'P. Rychenkova'|'P. Saffin'|'P. Salgado'|'P. Sally'|'P. Salo'|'P. Salomonson' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Salomonson'|'P. Saltsidis'|'P. Sarnak'|'P. S. Aspinwall'|'P. Sch'|'P. Schaller'|'P. Scharbach'|'P. Schlottmann'|'P. Schofield'|'P. Schramm'|'P. Schuck' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Schuck'|'P. Schupp'|'P. Schwarz'|'P. Scott'|'P. Senjanovic'|'P. Serre'|'P. Severa'|'P. S. Green'|'P. Shanahan'|'P. S. Howe'|'P. Sikivie' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Sikivie'|'P. Silva'|'P. Simon'|'P. Simonetti'|'P. Singh'|'P. S. Joshi'|'P. S. Kurzepa'|'P. Sodano'|'P. Solovtsova'|'P. Sorba'|'P. Sorella' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Sorella'|'P. Soriani'|'P. Sorokin'|'P. Spindel'|'P. Spiridonov'|'P. Srivastava'|'P. Stanley'|'P. Steinhardt'|'P. Stichel'|'P. Stjernberg'|'P. Strigazzi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Strigazzi'|'P. Su'|'P. Sukhatme'|'P. Sun'|'P. Sundell'|'P. Suranyi'|'P. Sutcliffe'|'P. Sutton'|'P. S. Wesson'|'P. Szekeres'|'P. Teotonio-Sobrinho' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Teotonio-Sobrinho'|'P. Termonia'|'P. Thomas'|'P. Thomi'|'P. Thurston'|'P. Tinyakov'|'P. Tod'|'P. Townsend'|'P. Trivedi'|'P. Tuite'|'P. Uzan' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Uzan'|'P. Valtancoli'|'P. Van'|'P. Vanhove'|'P. Varshni'|'P. Vary'|'P. Vecserny'|'P. Vecsernyes'|'P. Veselov'|'P. Vigier'|'P. Vitale' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Vitale'|'P. V. Landshoff'|'P. Volobujev'|'P. Von'|'P. Vranas'|'P. Wagemans'|'P. Wai'|'P. W. Anderson'|'P. Warner'|'P. Watts'|'P. Wegrzyn' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Wegrzyn'|'P. Weisz'|'P. Wesson'|'P.  West'|'P. West'|'P. W. Higgs'|'P. White'|'P. Widerin'|'P. Wiegman'|'P. Wiegmann'|'P. Wigner' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Wigner'|'P. Windey'|'P. Winternitz'|'P. Woodard'|'P. Xu'|'P. Yamron'|'P. Yang'|'P. Yao'|'P. Yi'|'P. Yogendran'|'P. Y. Pac' => { printf("token: %sn", std::string(ts, te).c_str()); };
'P. Y. Pac'|'P. Yurov'|'P. Zanca'|'P. Zaugg'|'P. Zhelobenko'|'P. Zhuang'|'P. Zia'|'P. Zinn-Justin'|'P. Zograf'|'P. Zubarev'|'Q. Grav' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Q. Grav'|'Q. K. Lu'|'Q. Li'|'Q. Liang'|'Q. Liu'|'Q. Luo'|'Q. Ma'|'Q. Park'|'Q. Shafi'|'Q. Su'|'Q. Vilar' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Q. Vilar'|'Q. Wang'|'R. Ab'|'R. A. Battye'|'R. Abbaspur'|'R. A. Bertlmann'|'R. Ablamowicz'|'R. Abolhasani'|'R. Abraham'|'R. A. Brandt'|'R. Acad' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Acad'|'R. Adler'|'R. A. Frick'|'R. Aitchison'|'R. A. Janik'|'R. Akhoury'|'R. Aldrovandi'|'R. Alkofer'|'R. Aloisio'|'R. Altendorfer'|'R. A. Minlos' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. A. Minlos'|'R. Amorim'|'R. Anderson'|'R. Anishetty'|'R. A. Prange'|'R. Apreda'|'R. Argurio'|'R. Arnowitt'|'R. Aros'|'R.  Arshansky'|'R. Arshansky' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Arshansky'|'R. Askey'|'R. Asquith'|'R. Astr'|'R. Astron'|'R. A. Webb'|'R. B. Abbott'|'R. Baier'|'R. Balbinot'|'R. Balescu'|'R. Balian' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Balian'|'R. Banerjee'|'R. Barbieri'|'R. Barrett'|'R. Bartnik'|'R. Basu'|'R. Battye'|'R. Baxter'|'R. Bean'|'R. Behrend'|'R. Beig' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Beig'|'R. Ben-Av'|'R. Bertlmann'|'R. Bes'|'R. B. Griffiths'|'R. Bielawski'|'R. Bishop'|'R. Blankenbecler'|'R. B. Laughlin'|'R. Bloch'|'R. Bluhm' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Bluhm'|'R. Blumenhagen'|'R. B. Mann'|'R. Bond'|'R. Borcherds'|'R. Borissov'|'R. Bott'|'R. Bousso'|'R. B. Pearson'|'R. Brandenberger'|'R. Brauer' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Brauer'|'R. Brill'|'R. Britto-Pacumio'|'R. Brooks'|'R. Brout'|'R. Brower'|'R. Brown'|'R. Brunetti'|'R. Bruno'|'R. Brustein'|'R. Bryan' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Bryan'|'R. Bryant'|'R. B. Zhang'|'R. Cai'|'R. Caianiello'|'R. Caldwell'|'R. Camporesi'|'R. Capovila'|'R. Capovilla'|'R. Caracciolo'|'R. Carlitz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Carlitz'|'R. Carroll'|'R. Cartas-Fuentevilla'|'R. Casadio'|'R. Casalbuoni'|'R. C. Brower'|'R. C. Clay'|'R. C. Gunning'|'R. Chakrabarti'|'R. Chand'|'R. Chatterjee' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Chatterjee'|'R. Christiansen'|'R. Cianci'|'R. C. Myers'|'R. Collina'|'R. Constable'|'R. Constantinescu'|'R. Contino'|'R. Coquereaux'|'R. Corrado'|'R. Costa' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Costa'|'R. Courant'|'R. Critchley'|'R. C. Tolman'|'R. C. Trinchero'|'R. Cuerno'|'R. Das'|'R. Dashen'|'R. Dave'|'R. David'|'R. D. Ball' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. D. Ball'|'R. D. Carlitz'|'R. De'|'R. Delbourgo'|'R. Dick'|'R. Dienes'|'R. Dijgraaf'|'R.  Dijkgraaf'|'R. Dijkgraaf'|'R. Dijkgraff'|'R. Dijkraaf' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Dijkraaf'|'R. Dolen'|'R. Donagi'|'R. Douglas'|'R. D. Peccei'|'R. D. Pisarski'|'R. D. Sorkin'|'R. Durrer'|'R. Dutt'|'R. Dvali'|'R. Easther' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Easther'|'R. E. Behrend'|'R. E. Borcherds'|'R. Echols'|'R. E. Cutkosky'|'R. Edwards'|'R. Efraty'|'R. E. Gamboa'|'R. E. Kallosh'|'R. Ellis'|'R. Emparan' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Emparan'|'R. Endo'|'R. Englman'|'R. Entin'|'R. E. Peierls'|'R. E. Prange'|'R. Espinosa'|'R. Estrada'|'R. Evans'|'R. Fabbri'|'R. Fakir' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Fakir'|'R. F. Alvarez-Estrada'|'R. Fanchi'|'R. Farrar'|'R. Fazio'|'R. F. Dashen'|'R. Fedele'|'R. Fern'|'R. Fernandez'|'R. Fernandez-Pousa'|'R. Ferrari' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Ferrari'|'R. Ferraro'|'R. Feynman'|'R. Finkelstein'|'R. Fintushel'|'R. Fiore'|'R. Floreanini'|'R. Floyd'|'R. Flume'|'R. Foot'|'R. F. Ribeiro' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. F. Ribeiro'|'R. Friedberg'|'R. Friedman'|'R. F. Streater'|'R. Fukuda'|'R. Gaberdiel'|'R. Gade'|'R. Gambini'|'R. Gamboa'|'R. Gangolli'|'R. Garattini' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Garattini'|'R. Garousi'|'R. Gastmans'|'R. Gatto'|'R. Gavrilov'|'R. G. Cai'|'R. Geroch'|'R. Giachetti'|'R. Gianvittorio'|'R. Giles'|'R. Gilmore' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Gilmore'|'R. Glauber'|'R. G. Leigh'|'R. G. McLenaghan'|'R. G. Newton'|'R. Golestanian'|'R. Golner'|'R. Gompf'|'R. Gonz'|'R. Gonzalez'|'R. Gopakumar' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Gopakumar'|'R. Gott'|'R. Gover'|'R. Govindarajan'|'R. Graham'|'R. Greene'|'R. Gregory'|'R. Grigjanis'|'R. Grigore'|'R. Grimm'|'R. G. Root' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. G. Root'|'R. G. Teixeira'|'R. Gueven'|'R. Guida'|'R. Gupta'|'R. Guven'|'R. Haag'|'R. Hagedorn'|'R. Hagen'|'R. Halbersma'|'R. Hartshorne' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Hartshorne'|'R. Harvey'|'R. H. Brandenberger'|'R. H. Dicke'|'R. Heise'|'R. Helling'|'R. Herdeiro'|'R. Hermann'|'R. Hern'|'R. Hernandez'|'R. H. Good' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. H. Good'|'R. Hibbs'|'R. Hiller'|'R. Hinterding'|'R. Hippmann'|'R. Hirota'|'R. H. Kraichnan'|'R. Hobart'|'R. Hoegh-Krohn'|'R. Hofmann'|'R. Holland' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Holland'|'R. Holman'|'R. Holstein'|'R. Honkonen'|'R. Horan'|'R. Horsley'|'R. Howe'|'R. H. Price'|'R. H. Rietdijk'|'R. Hsu'|'R. H. Swendsen' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. H. Swendsen'|'R. H. Tucker'|'R. Hubel'|'R. Huiszoon'|'R. Hwa'|'R. H. Yue'|'R. I. Arshansky'|'R. Iba'|'R. Iengo'|'R. I. L. Guthrie'|'R. I. Nepomechie' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. I. Nepomechie'|'R. Ingermanson'|'R. Irish'|'R. Its'|'R. Jackiew'|'R.  Jackiw'|'R. Jackiw'|'R. J. Adler'|'R. Jaffe'|'R. Jagannathan'|'R. Janik' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Janik'|'R. J. Baxter'|'R. J. Duffin'|'R. J. Eden'|'R. Jengo'|'R. J. Glauber'|'R. J. Hemley'|'R. J. Henderson'|'R. J. Hughes'|'R. Ji'|'R. J. Needs' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. J. Needs'|'R. Johnson'|'R. Jones'|'R. Jost'|'R. J. Perry'|'R. J. Riegert'|'R. J. Rivers'|'R. J. Szabo'|'R. J. Zhang'|'R. Kaiser'|'R.  Kallosh' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R.  Kallosh'|'R. Kallosh'|'R. Kantowski'|'R. Karplus'|'R. Kaul'|'R. Kavalov'|'R. K. Bhaduri'|'R. Kedem'|'R. Kemmoku'|'R. Kerner'|'R. Khalilov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Khalilov'|'R. Khonkonen'|'R. Khuri'|'R. Kirby'|'R. Kirschner'|'R. K. Kaul'|'R. Klassen'|'R. Klauder'|'R.  Klebanov'|'R. Klebanov'|'R. Kleiss' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Kleiss'|'R. Klinkhamer'|'R. Koberle'|'R. Kobes'|'R. Konik'|'R. Koul'|'R. K. P. Zia'|'R. K. Sachs'|'R. K. Schaefer'|'R. K. Su'|'R. Kubo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Kubo'|'R. Kuriki'|'R. Lacaze'|'R. Laflamme'|'R. Lafrance'|'R. Lau'|'R. Laughlin'|'R. Lazarsfeld'|'R. Lazkoz'|'R. L. Bryant'|'R. Lebedev' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Lebedev'|'R. Leese'|'R. Lehnert'|'R. Leigh'|'R. Lemes'|'R. Letaw'|'R. Lickorish'|'R. Liddle'|'R. Linares'|'R. Link'|'R. Links' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Links'|'R. L. Jaffe'|'R. L. Kobes'|'R. L. Mkrtchyan'|'R. Loll'|'R. Longo'|'R. Lugo'|'R. Maartens'|'R. Mac'|'R. Mackenzie'|'R. Madden' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Madden'|'R. Mann'|'R. Mansouri'|'R. Manvelyan'|'R. Marnelius'|'R. Marotta'|'R. Mart'|'R. Martinez-Acosta'|'R. Martini'|'R. Matzner'|'R. M. Cavalcanti' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. M. Cavalcanti'|'R. McNees'|'R. Medina'|'R. Medrano'|'R. Menikoff'|'R. Metsaev'|'R. Meyers'|'R. Mignani'|'R. Mills'|'R. Minasian'|'R. Miranda' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Miranda'|'R. Miron'|'R. M. Kashaev'|'R. Mkrtchyan'|'R. M. Martin'|'R. M. Mir-Kasimov'|'R. Mohapatra'|'R. Mohayaee'|'R. Monteiro'|'R. Montemayor'|'R. Montgomery' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Montgomery'|'R. Morris'|'R. Morrison'|'R. M. Ricotta'|'R. M. Spector'|'R. Mu'|'R. Musto'|'R. M. Wald'|'R. M. Williams'|'R. Myers'|'R. Myerson' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Myerson'|'R. Nakayama'|'R. Nappi'|'R. Narayanan'|'R. Nayak'|'R. Nelson'|'R. Nepomechie'|'R. Nest'|'R. Neves'|'R. Niedermaier'|'R. Nisimov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Nisimov'|'R. Nissimov'|'R. N. Mohapatra'|'R. Nolte'|'R. Oeckl'|'R. Oehme'|'R. Oerter'|'R. Olea'|'R. Omn'|'R. Omnes'|'R. Oppenheimer' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Oppenheimer'|'R. O. Ramos'|'R. Osorio'|'R. Pandharipande'|'R. Parentani'|'R. Parthasarathy'|'R. Parwani'|'R. Paunov'|'R. Pausch'|'R. P. Dias'|'R. Peccei' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Peccei'|'R. Peierls'|'R. Penner'|'R. Pennington'|'R. Penrose'|'R. Percacci'|'R. Perry'|'R. Peschanski'|'R. Petronzio'|'R. Petryk'|'R. Pettorino' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Pettorino'|'R. P. Feynman'|'R. Philippe'|'R. Phillips'|'R. Pisarski'|'R. Pittau'|'R. Plesser'|'R. P. Malik'|'R. P. Manvelian'|'R. P. Mart'|'R. Poghossian' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Poghossian'|'R. Poppe'|'R. Portugues'|'R. Potting'|'R. Prange'|'R. Preitschopf'|'R. P. Soni'|'R. Pullirsch'|'R. Puzalowski'|'R. P. Woodard'|'R. Quinn' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Quinn'|'R. Rabad'|'R. Rabadan'|'R. Raczka'|'R. Rahimi'|'R. Rahimi-Tabar'|'R. Rajaraman'|'R. Ramadas'|'R. Rashkov'|'R. Rattazzi'|'R. Ray' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Ray'|'R. R. Caldwell'|'R. Reinbacher'|'R. Renan'|'R. Renken'|'R. Rhom'|'R. Ricci'|'R. Riegert'|'R. R. Khuri'|'R. R. Landim'|'R. R. Metsaev' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. R. Metsaev'|'R. R. Nayak'|'R. Rodriguez'|'R. Rohm'|'R. Roiban'|'R. Rosenfelder'|'R. Roskies'|'R. Ross'|'R. Roy'|'R. Roychoudhury'|'R. Ruffini' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Ruffini'|'R. Ruiz'|'R. Russo'|'R. Sachs'|'R. Sapirstein'|'R. Sasaki'|'R. Sauser'|'R. Savit'|'R. Schaeffer'|'R. Schiappa'|'R. Schimming' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Schimming'|'R. Schimmrigk'|'R. Schoen'|'R. Schrader'|'R. Schreyer'|'R. Schrieffer'|'R. S. Dunne'|'R. Seeley'|'R. Seiler'|'R. Sen'|'R. Setare' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Setare'|'R. Sexl'|'R. Seznec'|'R. Shafarevich'|'R. Shaisultanov'|'R. Shankar'|'R. Sharpe'|'R. Shrock'|'R. Sidenius'|'R. Siebelink'|'R. Sisto' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Sisto'|'R. Skyrme'|'R. Slansky'|'R. S. Mendes'|'R. Smith'|'R. Soc'|'R. Soldati'|'R. Sollacher'|'R. Sollie'|'R. Sommer'|'R. Sorkin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Sorkin'|'R. Speer'|'R. Stanley'|'R. Steif'|'R. Steinberg'|'R. Steinke'|'R. Stephens'|'R. Stewart'|'R. Stompor'|'R.  Stora'|'R. Stora' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Stora'|'R. Streater'|'R. Sturani'|'R. Su'|'R. Sugano'|'R. Sugar'|'R. Sundrum'|'R. Surguladze'|'R. S. Ward'|'R. S. Willey'|'R. Szabo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Szabo'|'R. Tabar'|'R. Tabensky'|'R. Tangherlini'|'R. Tarrach'|'R. Tatar'|'R. Tate'|'R. Tateo'|'R. Tavakol'|'R. Taylor'|'R. Thomas' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Thomas'|'R. Torrealba'|'R. Trinchero'|'R. Troncoso'|'R. Truax'|'R. T. Seeley'|'R. Tzani'|'R. Underwood'|'R. U. Sexl'|'R. Utiyama'|'R. Valluri' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Valluri'|'R. Vanstone'|'R. Varnhagen'|'R. Verch'|'R. V. Kadison'|'R. V. Moody'|'R. Wadia'|'R. Wald'|'R. Walet'|'R. Wallach'|'R. Wang' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Wang'|'R. Ward'|'R. Watkins'|'R. W. Brehme'|'R. Webber'|'R. Wei'|'R. Weixler'|'R. Wells'|'R. Wensley'|'R. Wentworth'|'R. W. Gebert' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. W. Gebert'|'R. White'|'R. Wijewardhana'|'R. Willey'|'R. Williams'|'R. Wilson'|'R. Wimmer'|'R. W. Tucker'|'R. Wulkenhaar'|'R. Xiu'|'R. Yahalom' => { printf("token: %sn", std::string(ts, te).c_str()); };
'R. Yahalom'|'R. Y. Chiao'|'R. Yennie'|'R. Zemba'|'R. Zhang'|'R. Zheng'|'R. Zhitnitsky'|'R. Zirnbauer'|'R. Zucchini'|'R. Zwicky'|'S. A. Abel' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. A. Abel'|'S. A. Bakuta'|'S. Abel'|'S. Abers'|'S. A. Breus'|'S. Accetta'|'S. Acharya'|'S. A. Cherkis'|'S. A. Dias'|'S. Adkins'|'S. Adler' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Adler'|'S. A. Frolov'|'S. A. Fulling'|'S. A. Hartnoll'|'S. A. Hayward'|'S. A. Larin'|'S. Albeverio'|'S. Alexander'|'S. Aminneborg'|'S. A. Naftulin'|'S. Ansoldi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Ansoldi'|'S. Aoki'|'S. A. Orszag'|'S. Aoyama'|'S. A. Pernice'|'S. Apps'|'S. Arnone'|'S. Artz'|'S. Aspinwall'|'S. A. Teukolsky'|'S. Aubry' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Aubry'|'S. Aulakh'|'S. Axelrod'|'S. A. Yost'|'S. Azadi'|'S. Babu'|'S. Baez'|'S. Bal'|'S. Balakrishna'|'S. Bali'|'S. Ball' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Ball'|'S. Bell'|'S. Bellucci'|'S. Berman'|'S. B. Giddings'|'S. Bhattacharyya'|'S. Bilke'|'S. Bir'|'S. Birman'|'S. B. Isakov'|'S. Blas' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Blas'|'S. Blau'|'S. B. Liao'|'S. Boettcher'|'S. Booth'|'S. Borchardt'|'S. Bornholdt'|'S. Bose'|'S. Bradlow'|'S. Bremer'|'S. Brodsky' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Brodsky'|'S. Brown'|'S. B. Treiman'|'S. Bunch'|'S. Cacciatori'|'S. Capozziello'|'S. Caracciolo'|'S. Carlip'|'S. Carneiro'|'S. Carroll'|'S. Cattaneo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Cattaneo'|'S. Catterall'|'S. Catto'|'S. Caudrey'|'S. Caux'|'S. Cecotti'|'S. Celenza'|'S. Chadha'|'S. Chakravarty'|'S. Chan'|'S. Chandrasekhar' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Chandrasekhar'|'S. Chandrasekharan'|'S. Chang'|'S. Chaturvedi'|'S. Chaudhuri'|'S. Chen'|'S. Cherkis'|'S. Chern'|'S. Chiku'|'S. Cho'|'S. Chowla' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Chowla'|'S. Christensen'|'S. Chu'|'S. Chung'|'S. Codriansky'|'S.  Coleman'|'S. Coleman'|'S. Cordes'|'S. Corley'|'S. Costa'|'S. Cotsakis' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Cotsakis'|'S. Craigie'|'S. Cucu'|'S. Cullen'|'S. Cunha'|'S. C. Zhang'|'S. Dalley'|'S. Dancer'|'S. Danilov'|'S. Das'|'S. Dasgupta' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Dasgupta'|'S. Dasmahapatra'|'S. Davis'|'S. Dawson'|'S. D. Drell'|'S. De'|'S. Deger'|'S. Deguchi'|'S. Dehesa'|'S. Della'|'S. D. Ellis' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. D. Ellis'|'S. Derbenev'|'S. Deser'|'S. Detweiler'|'S. D. Glazek'|'S. D. H. Hsu'|'S. Dietrich'|'S. Dimopolous'|'S. Dimopoulos'|'S. D. Joglekar'|'S. D. Majumdar' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. D. Majumdar'|'S. D. Mathur'|'S. Dodelson'|'S. D. Odinstov'|'S. D. Odintsov'|'S. Donaldson'|'S. Doplicher'|'S. Dopplicher'|'S. Doran'|'S. Dotsenko'|'S. Dowker' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Dowker'|'S. Drell'|'S. Duan'|'S. Duplij'|'S. Durand'|'S. Egorian'|'S. E. Hjelmeland'|'S. Eilenberg'|'S. El'|'S. Elitzur'|'S. Elizur' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Elizur'|'S. Elser'|'S. Emery'|'S. E. Parkhomenko'|'S. Eremin'|'S. Evans'|'S. Fadin'|'S. Fairhurst'|'S. Falkenberg'|'S. F. Edwards'|'S. Feng' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Feng'|'S. Fernando'|'S.  Ferrara'|'S. Ferrara'|'S. F. Hassan'|'S. Fine'|'S. Fischer'|'S. Fl'|'S. Foffa'|'S. Fokas'|'S. Forste' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Forste'|'S. Forte'|'S. Fradkin'|'S. Franco'|'S. Frautschi'|'S. Fredenhagen'|'S. Freed'|'S. Frolov'|'S. F. Ross'|'S. Fubini'|'S. Fulling' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Fulling'|'S. Galperin'|'S. Gandhi'|'S. Garc'|'S. Garcia'|'S. Gardner'|'S. Gasiorowicz'|'S. Gates'|'S. Gerbert'|'S. Ghosh'|'S. Ghoshal' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Ghoshal'|'S. Giddings'|'S. Giller'|'S. Girvin'|'S. Glashow'|'S. G. Mamayev'|'S. G. Matinyan'|'S. G. Naculich'|'S. Goldhaber'|'S. Goldstein'|'S. Goncharov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Goncharov'|'S. Gonorazky'|'S. Gorsky'|'S. Gosh'|'S. Goto'|'S. Gottlieb'|'S. Govindarajan'|'S. G. Petrova'|'S. Gradshtein'|'S. Gradshteyn'|'S. Graffi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Graffi'|'S. G. Rajeev'|'S. Gratton'|'S. Green'|'S. Griffies'|'S. Groot'|'S. Gubser'|'S. Guillen'|'S. Gukov'|'S. Gupta'|'S. Guralnik' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Guralnik'|'S. Guruswamy'|'S. Gutmann'|'S. Gutt'|'S. Habib'|'S. Hagelin'|'S. Halperin'|'S. Hamidi'|'S. Hanany'|'S. Hands'|'S. Hannestad' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Hannestad'|'S. Hartnoll'|'S. Hassan'|'S. Hassani'|'S. Hawking'|'S. Helgason'|'S. Hellerman'|'S. Hemming'|'S. Hewson'|'S. Heyl'|'S. H. Henry' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. H. Henry'|'S. H. H. Tye'|'S. Higuchi'|'S. Hikami'|'S. Hioki'|'S. Hirano'|'S. Hod'|'S. Hojman'|'S. Hollands'|'S. Holst'|'S. Horata' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Horata'|'S. Hosono'|'S. Hou'|'S. Howe'|'S. H. Park'|'S. H. S. Alexander'|'S. H. Shenker'|'S. Hsu'|'S. H. Tye'|'S. Huang'|'S. Hwang' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Hwang'|'S. Hyun'|'S. Ichinose'|'S. Iida'|'S. I. Kruglov'|'S. Ishihara'|'S. Iso'|'S. Jadach'|'S. Jaimungal'|'S. Jain'|'S. James' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. James'|'S. Jang'|'S. Jarvis'|'S. J. Avis'|'S. J. Brodsky'|'S. J. Chang'|'S. J. Clark'|'S. J. Gates'|'S. J. Hathrell'|'S. Jhingan'|'S. Jo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Jo'|'S. Jones'|'S. J. Poletti'|'S. J. Putterman'|'S. J. Rey'|'S. J. Summers'|'S. Judes'|'S. J. Yoon'|'S. Kachru'|'S. K.  Adhikari'|'S. Kalara' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Kalara'|'S. Kalitsyn'|'S.  Kalitzin'|'S. Kalitzin'|'S. Kalyana'|'S. Kamefuchi'|'S. Kanemura'|'S. Kanno'|'S. Kaplunovsky'|'S. Kar'|'S. Katz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Katz'|'S. Kawai'|'S. Kawamoto'|'S. Kay'|'S. Kaya'|'S. K. Blau'|'S. K. Donaldson'|'S. Kelley'|'S. Ketov'|'S. Kharchev'|'S. Khoroshkin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Khoroshkin'|'S. Kim'|'S. Kirkpatrick'|'S. Kitahara'|'S. Kitakado'|'S. Kiura'|'S. Kivelson'|'S. K. Kehrein'|'S. K. Kim'|'S. K. Lamoreaux'|'S. Klimek' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Klimek'|'S. Klishevich'|'S. K. Ma'|'S. Kobayashi'|'S. Kojima'|'S. Komata'|'S. Komineas'|'S. Konstein'|'S. Koshelev'|'S. Kovacs'|'S. Kovesi-Domokos' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Kovesi-Domokos'|'S. K. Paul'|'S. K. Rama'|'S. Krinsky'|'S. Krivonos'|'S. Kronfeld'|'S. Krusche'|'S. Kumar'|'S. Kuroki'|'S. Kurzepa'|'S. Kuzenko' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Kuzenko'|'S. K. Wong'|'S. K. Yang'|'S. Kyoto'|'S. K. You'|'S. La'|'S. L. Adler'|'S. Lam'|'S. Landweber'|'S. Lang'|'S. Langer' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Langer'|'S. Lavignac'|'S. Lazzarini'|'S. Lee'|'S. Lefschetz'|'S. Leibler'|'S. Lemos'|'S. Leseduarte'|'S. Letelier'|'S. Levi'|'S. Levit' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Levit'|'S. L. Glashow'|'S. Li'|'S. Liberati'|'S. Lim'|'S. Lin'|'S. Liu'|'S. L. Lebedev'|'S. L. Lukyanov'|'S. L. Lyakhovich'|'S. L. Lykyanov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. L. Lykyanov'|'S. Lola'|'S. Love'|'S. Lozano'|'S. L. Shatashvili'|'S. L. Sondhi'|'S. Lukianov'|'S. Lukyanov'|'S. L. Woronowicz'|'S. L. Zhang'|'S. Ma' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Manakov'|'S. Mandelstam'|'S. Manko'|'S. Manton'|'S. Marculescu'|'S. Marinov'|'S. Martin'|'S. Mashkevich'|'S. Massar'|'S. Matarrese'|'S. Mathur' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Ma'|'S. Mac'|'S. Machida'|'S. Maedan'|'S. Mahapatra'|'S. Majid'|'S. Major'|'S. Majumdar'|'S. Malin'|'S. Mallik'|'S. Manakov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Mathur'|'S. Matinyan'|'S. Matsubara'|'S. Matsuda'|'S. Matsumoto'|'S. Matsuura'|'S. M. Barnett'|'S. M. Barr'|'S. M. Carroll'|'S. M. Catterall'|'S. M. Christensen' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. M. Christensen'|'S. M. Dancoff'|'S. Meljanac'|'S. Mendes'|'S. Meshkov'|'S. Meyer'|'S. M. Girvin'|'S. Mignemi'|'S. Minakshisundaram'|'S. Minwalla'|'S. Miyake' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Miyake'|'S. Mizoguchi'|'S. Mizuno'|'S. M. Klishevich'|'S. M. Kuzenko'|'S. Moghimi-Araghi'|'S. Mohanty'|'S. Mokhtari'|'S. Montague'|'S. Moriyama'|'S. Morris' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Morris'|'S. Mouslopoulos'|'S. M. Plyushchay'|'S. Mrowka'|'S. M. Sergeev'|'S. M. Sibiryakov'|'S. Mukai'|'S. Mukaigawa'|'S. Mukherjee'|'S. Mukherji'|'S. Mukhi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Mukhi'|'S. Mukhopadhyay'|'S. Mukhoyama'|'S. Mukohyama'|'S.  Myung'|'S. Myung'|'S. Naculich'|'S. Nadkarni'|'S. Naftulin'|'S. Naik'|'S. Naka' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Naka'|'S. Nakamura'|'S. Nam'|'S. Narain'|'S. Narasimhan'|'S. Narison'|'S. Nascimento'|'S. Nergiz'|'S. Ng'|'S. N. Gupta'|'S. Nicolis' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Nicolis'|'S. Nirov'|'S. Nishigaki'|'S. N. M. Ruijsenaars'|'S. Nojiri'|'S. Norridge'|'S. Novikov'|'S. Nowak'|'S. N. Solodukhin'|'S. Nussinov'|'S. Odake' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Odake'|'S. Odintsov'|'S. Ogushi'|'S. Ohno'|'S. O. Krivonos'|'S. Okubo'|'S. Olejnik'|'S. O. Saliu'|'S. Ostaf'|'S. Ouvry'|'S. O. Warnaar' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. O. Warnaar'|'S. Paban'|'S. Pacheva'|'S. Pakis'|'S. Pakuliak'|'S. Pal'|'S. Pallua'|'S. Panda'|'S. Panzeri'|'S. Parasiuk'|'S. Park' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Park'|'S. Parke'|'S. Parkhomenko'|'S. Parvizi'|'S. Pascazio'|'S. Paul'|'S. Pavlov'|'S. P. De'|'S. Peign'|'S. Penati'|'S. Perlmutter' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Perlmutter'|'S. Pernice'|'S. Petropoulos'|'S. Piao'|'S. Pinsky'|'S. Pires'|'S. P. Khastgir'|'S. P. Kim'|'S. P. Klevansky'|'S. Plyushchay'|'S. P. Martin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. P. Martin'|'S. P. Misra'|'S. P. Novikov'|'S. Pokorski'|'S. Poletti'|'S. Poon'|'S. Popescu'|'S. Popov'|'S. Prokushkin'|'S. P. Sorella'|'S. P. Trivedi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. P. Trivedi'|'S. Q. Chen'|'S. Raby'|'S. Rajeev'|'S. Rajpoot'|'S. Ramanan'|'S. Ramanujan'|'S. Ramaswamy'|'S. Ramgoolam'|'S. Randjbar'|'S. Randjbar-Daemi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Randjbar-Daemi'|'S. Rangoolam'|'S. Rao'|'S. R. Beane'|'S. R. Das'|'S. Reall'|'S. Redner'|'S. Retakh'|'S. Reucroft'|'S. Rey'|'S. Reynaud' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Reynaud'|'S. Ribault'|'S. Rigolin'|'S. Roan'|'S. Roshchupkin'|'S. Ross'|'S. Rouhani'|'S. Roy'|'S. Rozowsky'|'S. Rudaz'|'S. Ruijsenaars' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Ruijsenaars'|'S. R. Wadia'|'S. Ryang'|'S. Sabharwal'|'S. Sachdev'|'S. Saito'|'S. Sakai'|'S. Sakakibara'|'S. Sakata'|'S. Sakoda'|'S. Salamon' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Salamon'|'S. Salopek'|'S. Samuel'|'S. Sanjay'|'S. Sannan'|'S. Sarandy'|'S. Sarkar'|'S. Sasaki'|'S. Sawin'|'S. Schelstraete'|'S. S. Chern' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. S. Chern'|'S. Schraml'|'S. Schrans'|'S. Schreckenberg'|'S. Schulman'|'S. Schwager'|'S. Schwartz'|'S. Schwarz'|'S. Schweber'|'S. Schwinger'|'S. Sciuto' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Sciuto'|'S. Seki'|'S. Sen'|'S. Sethi'|'S. S. Gubser'|'S. Shabanov'|'S. Shankaranarayanan'|'S. Sharatchandra'|'S. Sharpe'|'S. Shashoua'|'S. Shastry' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Shastry'|'S. Shatashvili'|'S. Shatashvilli'|'S. Shatasvili'|'S. Shei'|'S. Shelemy'|'S. Shellard'|'S.  Shenker'|'S. Shenker'|'S. Shinohara'|'S. Shkoller' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Shkoller'|'S. Shnider'|'S. Shtrikman'|'S. Shuto'|'S. Siklos'|'S. Silva'|'S. Singh'|'S. Sinha'|'S. Skagerstam'|'S. Skorik'|'S. Snyder' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Snyder'|'S. Sogami'|'S. Soh'|'S. Soibelman'|'S. Sokatchev'|'S. Solimeno'|'S. Solodukhin'|'S. Solomon'|'S. Sonego'|'S. Song'|'S. Sorella' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Sorella'|'S. Sorin'|'S. S. Pal'|'S. S. Pinsky'|'S. S. Roan'|'S. S. Schweber'|'S. Stanciu'|'S. Stanev'|'S. Stelle'|'S. Stepanenko'|'S. Sternberg' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Sternberg'|'S. Stieberger'|'S. Sugimoto'|'S. Sukiasian'|'S. Summers'|'S. Sur'|'S. Surovtsev'|'S. Surya'|'S. Swanson'|'S. Szpigel'|'S. Takagi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Takagi'|'S. Takemae'|'S. Tamaryan'|'S. Tamura'|'S. Tanaka'|'S. Tang'|'S. Tanimoto'|'S. Tanimura'|'S. Tate'|'S. Templeton'|'S. Teraguchi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Teraguchi'|'S. Terashima'|'S. Theisen'|'S. Thiesen'|'S. Thomas'|'S. Thorne'|'S. Thurner'|'S. T. Love'|'S. Tomonaga'|'S. Townsend'|'S. Treiman' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Treiman'|'S. Trivedi'|'S. Tsao'|'S. Tsujikawa'|'S. Tsujimaru'|'S. Turner'|'S. Twisk'|'S. T. Yau'|'S. Tye'|'S. Tyupkin'|'S. Uehara' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Uehara'|'S. Vacaru'|'S. Vaidya'|'S. Vandoren'|'S. Varadarajan'|'S. Varsted'|'S. Vaul'|'S. Vaula'|'S. Ventura'|'S. Vinti'|'S. Vishik' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Vishik'|'S. Viswanathan'|'S. V. Ketov'|'S. V. Khudyakov'|'S. Vladimirov'|'S. V. Lawande'|'S. V. Manakov'|'S. Vokos'|'S. Volkov'|'S. Vongehr'|'S. Voropaev' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Voropaev'|'S. V. Shabanov'|'S. Vshivtsev'|'S. V. Sushkov'|'S. Wada'|'S. Wadia'|'S. Waldmann'|'S. Walhout'|'S. Wallon'|'S. Wang'|'S. Ward' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Ward'|'S. Watamura'|'S. Watanabe'|'S. Weinberg'|'S. Wesson'|'S. W. Hawking'|'S. Wightman'|'S. Wiles'|'S. W. Mac'|'S. Wojciechowski'|'S. Wolf' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Wolf'|'S. Wolfram'|'S. Wolpert'|'S. Woronowicz'|'S. Wu'|'S. Xiong'|'S. Yahikozawa'|'S. Yajima'|'S. Yamaguchi'|'S. Yang'|'S. Yankielovicz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Yankielovicz'|'S. Yankielowicz'|'S. Yau'|'S. Yi'|'S. Ying'|'S. Yip'|'S. Y. Lee'|'S. Y. Lou'|'S. Yoon'|'S. Yost'|'S. Y. Pi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'S. Y. Pi'|'S. Yu'|'S. Zakrzewski'|'S. Zerbini'|'S. Zhukov'|'T. Ackermann'|'T. Adawi'|'T. Aida'|'T. A. Jacobson'|'T. Akhmedov'|'T. Akiba' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Akiba'|'T. Ali'|'T. Allenby'|'T. Altherr'|'T. A. Osborn'|'T. Appelquist'|'T. Asakawa'|'T. A. Tran'|'T. A. Vilgis'|'T. Azuma'|'T. Banin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Banin'|'T.  Banks'|'T. Banks'|'T. Banks et al,'|'T. Barnes'|'T. Barreiro'|'T. Bastin'|'T. Batchelor'|'T. Berger'|'T. Bhattacharya'|'T. Bodwin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Bodwin'|'T. Boehm'|'T. Br'|'T. Brandt'|'T. Branson'|'T. Brotz'|'T. Brzezi'|'T. Brzezinski'|'T. Burwick'|'T. Buscher'|'T. Cahill' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Cahill'|'T. Cai'|'T. Chan'|'T. Chang'|'T. Cheon'|'T. Chiang'|'T. Chiba'|'T. Christodoulakis'|'T. Chrusciel'|'T. C. Kraan'|'T. Cowan' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Cowan'|'T. Curtright'|'T. Damour'|'T. Dasgupta'|'T. De'|'T. Deguchi'|'T. Dereli'|'T. D. Imbo'|'T. D. Lee'|'T. Dole'|'T. Dolezel' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Dolezel'|'T. Dray'|'T. Drummond'|'T. Duchamp'|'T. Ebihara'|'T. Echevarria'|'T. E. Clark'|'T. E. Fradkina'|'T. Eguchi'|'T. Einarsson'|'T. Eller' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Eller'|'T. Elze'|'T. Ericson'|'T. Evans'|'T. F. Hammann'|'T. Filippov'|'T. Filk'|'T. Fomenko'|'T. Fradkina'|'T. Franco'|'T. Frederico' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Frederico'|'T. Friedmann'|'T. Friedrich'|'T. Fujita'|'T. Fujiwara'|'T. Fukui'|'T. Fukuyama'|'T. Fulton'|'T. Futamase'|'T. Gannon'|'T. Garcia' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Garcia'|'T. Ghergetta'|'T. Gherghetta'|'T. Giele'|'T. Gisiger'|'T. Goldman'|'T. Gomez'|'T. Goto'|'T. Graber'|'T. Grisaru'|'T. G. Rizzo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. G. Rizzo'|'T. Guhr'|'T. Hagiwara'|'T. Hahn'|'T. Hall'|'T. Han'|'T. Harada'|'T. Harano'|'T. Harko'|'T. Harmark'|'T. Hashimoto' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Hashimoto'|'T. Hatsuda'|'T. Hauer'|'T. Hayashi'|'T. H. Boyer'|'T. H. Buscher'|'T. Heinzl'|'T. Hermsen'|'T. Hertog'|'T. H. Hansson'|'T. Hill' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Hill'|'T. Hirayama'|'T. Hollowood'|'T. Holstein'|'T. Hong'|'T. Hori'|'T. Horiguchi'|'T.  Horowitz'|'T. Horowitz'|'T. Hotta'|'T. H. R. Skyrme' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. H. R. Skyrme'|'T. Hubsch'|'T. Hurth'|'T. Ichihara'|'T. Iida'|'T. Iizuka'|'T. Imai'|'T. Imbo'|'T. Inagaki'|'T. Inami'|'T. Inoue' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Inoue'|'T. Ioannidou'|'T. Ishikawa'|'T. Isono'|'T. Itoh'|'T. Ivanov'|'T. Iwai'|'T. Jach'|'T. Jacobson'|'T. Jaekel'|'T. J. Allen' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. J. Allen'|'T. Jaroszewicz'|'T. Jayaraman'|'T. Jaynes'|'T. J. Fields'|'T. J. Hollowood'|'T. Jolicoeur'|'T. Jones'|'T. Jonsson'|'T. Kadoyoshi'|'T. Kalkreuter' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Kalkreuter'|'T. Kaluza'|'T. Kashiwa'|'T. Kato'|'T. Kawai'|'T. Kawano'|'T. Kerler'|'T. Kim'|'T. Kimura'|'T. Kinoshita'|'T. Kitao' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Kitao'|'T. Kl'|'T. Klassen'|'T. Kobayashi'|'T. Kohno'|'T. Koikawa'|'T. Kojima'|'T. Kopf'|'T. Krajewski'|'T. Kubota'|'T. Kugo' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Kugo'|'T. Kunihiro'|'T. Kunimasa'|'T. Kuramoto'|'T. Kuroki'|'T. Lada'|'T. L. Curtright'|'T. Lee'|'T. Levi-Civita'|'T. Li'|'T. Liu' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Liu'|'T. Lopuszanski'|'T. Love'|'T. Magri'|'T. Mahanthappa'|'T. Maki'|'T. Marinucci'|'T. Maskawa'|'T. Masuda'|'T. Mateos'|'T. Matos' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Matos'|'T. Matsubara'|'T. Matsui'|'T. Matsuki'|'T. Matsuo'|'T. Matsuyama'|'T. Medeiros'|'T. Mehen'|'T. Miwa'|'T. Mogami'|'T. Mohaupt' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Mohaupt'|'T. Moroi'|'T. Morris'|'T. Mrowka'|'T. M. Samols'|'T. Murakami'|'T. Muramatsu'|'T. Muta'|'T. Muto'|'T. M. Yan'|'T. Nagao' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Nagao'|'T. Nakajima'|'T. Nakamura'|'T. Nakanishi'|'T. Nakashima'|'T. Nakatsu'|'T. Neuhaus'|'T. Newman'|'T. Nihei'|'T. N. Sherry'|'T. N. Tomaras' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. N. Tomaras'|'T. Oda'|'T. Ohtsuki'|'T. Okada'|'T. Okamoto'|'T. Okamura'|'T. Okuda'|'T. Onogi'|'T. Oota'|'T.  Ort'|'T. Ort' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Ort'|'T. Ortin'|'T. Osada'|'T. Ott'|'T. Padmanabhan'|'T. Palev'|'T. Pantev'|'T. Papenbrock'|'T. Parker'|'T. P. Cheng'|'T. Pengpan' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Pengpan'|'T. Piran'|'T. Popp'|'T. Pradhan'|'T. Press'|'T. Prokopec'|'T. P. Singh'|'T. Qureshi'|'T. Ratiu'|'T. Regge'|'T. Reisz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Reisz'|'T. R. Govindarajan'|'T. Rizzo'|'T. R. Klassen'|'T. R. Morris'|'T. Rothman'|'T. Roy'|'T. R. Taylor'|'T. Saito'|'T. Sakai'|'T. Samols' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Samols'|'T. Sano'|'T. Sarkar'|'T. Sasada'|'T. Sasaki'|'T. Sato'|'T. S. Bunch'|'T. Sch'|'T. Schafer'|'T. S. Chang'|'T. Schneider' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Schneider'|'T. Schucker'|'T. Schultz'|'T. Seeley'|'T. Shigehara'|'T. Shimada'|'T. Shimizu'|'T. Shinohara'|'T. Shiota'|'T. Shirafuji'|'T. Shiromizu' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Shiromizu'|'T. Sommer'|'T. Son'|'T. Souradeep'|'T. Spencer'|'T. S. Santhanam'|'T. Striker'|'T. Strobl'|'T. Sugihara'|'T. Suyama'|'T. Suzuki' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Suzuki'|'T. S. Walhout'|'T. Tabei'|'T. Tachizawa'|'T. Tada'|'T. Tajima'|'T. Takabayasi'|'T. Takahashi'|'T. Takayanagi'|'T. Takebe'|'T. Takeuchi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Takeuchi'|'T. Tamaki'|'T. Tanaka'|'T. Taylor'|'T. Thiemann'|'T. Tjin'|'T. Todorov'|'T. Toimela'|'T. Tok'|'T. Tokihiro'|'T. Tomaras' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Tomaras'|'T. Tomboulis'|'T. Torii'|'T. Torma'|'T. Tran'|'T. Truong'|'T. Tsou'|'T. Tsujishita'|'T. Tsukioka'|'T. T. Truong'|'T. Turgut' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Turgut'|'T. T. Wu'|'T. Uchino'|'T. Uematsu'|'T. Ueno'|'T. Uesugi'|'T. Vachaspati'|'T. Vaughn'|'T. Vetterling'|'T. Vuka'|'T. W. Appelquist' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. W. Appelquist'|'T. Watts'|'T. W. B. Kibble'|'T. Weber'|'T. Weidig'|'T. Wettig'|'T. Wheeler'|'T. Whittaker'|'T. Wilke'|'T. Wiseman'|'T. W. Kephart' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. W. Kephart'|'T. W. Kibble'|'T. Wu'|'T. Wynter'|'T. Yanagida'|'T. Yau'|'T. Yee'|'T. Yeh'|'T. Yokono'|'T. Yoneya'|'T. Yoshimura' => { printf("token: %sn", std::string(ts, te).c_str()); };
'T. Yoshimura'|'T. Yukawa'|'T. Zatsepin'|'U. Aglietti'|'U. Amaldi'|'U. A. Yajnik'|'U. Bleyer'|'U. Bonse'|'U. Bruzzo'|'U. Carow-Watamura'|'U. Danielsson' => { printf("token: %sn", std::string(ts, te).c_str()); };
'U. Danielsson'|'U. Dudley'|'U. Eden'|'U. Ellwanger'|'U. Feichtinger'|'U. Felderhof'|'U. Frisch'|'U. Gen'|'U. Gran'|'U. Grimm'|'U. Gursoy' => { printf("token: %sn", std::string(ts, te).c_str()); };
'U. Gursoy'|'U. Harder'|'U. H. Danielsson'|'U. Heinz'|'U. Heller'|'U. Jungnickel'|'U. Klimyk'|'U. Kraemmer'|'U. Leuven'|'U. Lindstr'|'U. Lindstrom' => { printf("token: %sn", std::string(ts, te).c_str()); };
'U. Lindstrom'|'U. Magnea'|'U. Mahanta'|'U. Manssur'|'U. Marquard'|'U. Martensson'|'U. Math'|'U. Meyer'|'U. M. Heller'|'U. Miyamoto'|'U. Mohideen' => { printf("token: %sn", std::string(ts, te).c_str()); };
'U. Mohideen'|'U. Moschella'|'U. M. Studer'|'U. Niederer'|'U. Nucamendi'|'U. Persson'|'U. Press'|'U. P. Sukhatme'|'U. Ritschel'|'U. Sexl'|'U. Sukhatme' => { printf("token: %sn", std::string(ts, te).c_str()); };
'U. Sukhatme'|'U. Theis'|'U. Trittmann'|'U. Varadarajan'|'U. Wiese'|'U. Wolff'|'U. Yurtsever'|'V. A. Belinskii'|'V. A. Berezin'|'V. A. Fateev'|'V. A. Fock' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. A. Fock'|'V. A. Franke'|'V. A. Gritsenko'|'V. Ahlfors'|'V. Ahluwalia'|'V. A. Karmanov'|'V. A. Kazakov'|'V. A. Kosteleck'|'V. A. Kostelecky'|'V. Akulov'|'V. A. Kuzmin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. A. Kuzmin'|'V. Alan'|'V. Aldaya'|'V. Alekseevskii'|'V. Alekseevsky'|'V. Alessandrini'|'V. Ambartzumian'|'V. A. Miransky'|'V. Andreev'|'V. A. Novikov'|'V. Antonov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Antonov'|'V. A. Ponomarev'|'V. Arnold'|'V. A. Rubakov'|'V. A. Soroka'|'V. Avdeev'|'V. Azcoiti'|'V. Balasubramanian'|'V. Baluni'|'V. Bardek'|'V. Barger' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Barger'|'V. Bargmann'|'V. Batyrev'|'V. Bazhanov'|'V. B. Berestetskii'|'V. B. Bezerra'|'V. Belinskii'|'V. Belitsky'|'V. Belvedere'|'V. Berezinsky'|'V. Berry' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Berry'|'V. B. Kopeliovich'|'V. B. Matveev'|'V. Bonservizi'|'V. Borisov'|'V. Bornyakov'|'V. Boulatov'|'V. Bozza'|'V. B. Petkova'|'V. Branchina'|'V. Braun' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Braun'|'V. Brazhnikov'|'V. Cardoso'|'V. Ch'|'V. Chari'|'V. Cherednik'|'V. Chibisov'|'V. Chikalov'|'V. Chudnovsky'|'V. Cort'|'V. Costa' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Costa'|'V. De'|'V. Della'|'V. D. Gershun'|'V. D. Ivashchuk'|'V. Dmitra'|'V. Dobrev'|'V. Dodonov'|'V. Dohm'|'V. Dolgachev'|'V. Dotsenko' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Dotsenko'|'V. D. Pershin'|'V. Drinfel'|'V. Drinfeld'|'V. D. Sandberg'|'V. Dunne'|'V. Dvoeglazov'|'V. Dyadichev'|'V. Dzhunushaliev'|'V. Efimov'|'V. Efremov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Efremov'|'V. E. Hubeny'|'V. E. Korepin'|'V. Elias'|'V. E. R. Lemes'|'V. Ermushev'|'V. E. Zakharov'|'V. Faraoni'|'V. Fateev'|'V. Fedosov'|'V. Ferrari' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Ferrari'|'V. Flambaum'|'V. F. Mukhanov'|'V. Fock'|'V. Freilikher'|'V. Frenkel'|'V. F. R. Jones'|'V. Frolov'|'V. Fursaev'|'V. Fyodorov'|'V. Gal' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Gal'|'V. Galajinsky'|'V. Gallas'|'V. Galt'|'V. Galtsov'|'V. G. Bagrov'|'V. G. Drinfel'|'V. G. Drinfeld'|'V. G. Ka'|'V. G. Kac'|'V. G. Kadyshevsky' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. G. Kadyshevsky'|'V. G. Knizhnik'|'V. Glaser'|'V. Gorbunov'|'V. Gorini'|'V. Grecchi'|'V. Gribov'|'V. Grigoryan'|'V. G. Turaev'|'V. Gubarev'|'V. Guillemin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Guillemin'|'V. Gurarie'|'V. Gusev'|'V. Gusynin'|'V. G. Zima'|'V. Hakim'|'V. Herscovitz'|'V. Hubeny'|'V. Husain'|'V. Hussin'|'V. I. Arnold' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. I. Arnold'|'V. I. Ginzburg'|'V. I. Man'|'V. Ioffe'|'V. I. Ogievetskii'|'V. I. Ogievetsky'|'V. I. Ritus'|'V. I. Strazhev'|'V. I. Tkach'|'V. Iyer'|'V. I. Zakharov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. I. Zakharov'|'V. Jain'|'V. Jejjala'|'V. J. Emery'|'V. John'|'V. Johnson'|'V. Jones'|'V. Ka'|'V. Kac'|'V. Kadison'|'V. Kalmeyer' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Kalmeyer'|'V.  Kanatchikov'|'V. Kanatchikov'|'V. Kanev'|'V. Kapitanski'|'V. Kaplunovsky'|'V. Karabegov'|'V. Karasev'|'V. Karimipour'|'V. Kazakov'|'V. K. Dobrev' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. K. Dobrev'|'V. Kechkin'|'V. Keldysh'|'V. Ketov'|'V. Khetselius'|'V. Khoze'|'V. Knizhnik'|'V. Korepin'|'V. Kotikov'|'V. Kozyrev'|'V. K. Patodi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. K. Patodi'|'V. Kraniotis'|'V. Krasnikov'|'V. Krive'|'V. Kuchar'|'V. Kurak'|'V. Kuzmin'|'V. Laliena'|'V. Landshoff'|'V. Lanyov'|'V. Lavrelashvili' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Lavrelashvili'|'V. Lavrinenko'|'V. L. Dolman'|'V. Lebedev'|'V. Lemes'|'V. Lerner'|'V. Leviant'|'V. L. Ginzburg'|'V. Libanov'|'V. L. Solozhenko'|'V. Lyubashenko' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Lyubashenko'|'V. Mallow'|'V. Man'|'V. Manakov'|'V. Mangazeev'|'V. Manias'|'V. Manohar'|'V. Marotta'|'V. Marshakov'|'V. Maslov'|'V. Mathai' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Mathai'|'V. Matveev'|'V. Matytsin'|'V. Medvedev'|'V. Mikhailov'|'V. Miransky'|'V. Mishakov'|'V. M. Mostepanenko'|'V. Moncrief'|'V. Moniz'|'V. Moody' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Moody'|'V. Moretti'|'V. Mukhanov'|'V. Nair'|'V. Nanopoulos'|'V. Narlikar'|'V. N. Baier'|'V. Nesterenko'|'V. N. Gribov'|'V. Niarchos'|'V. Nikulin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Nikulin'|'V. N. Marachevsky'|'V. N. Melnikov'|'V. Novikov'|'V. Novozhilov'|'V. N. Pervushin'|'V. N. Popov'|'V. N. Tolstoy'|'V. Ogievetsky'|'V. Olinto'|'V. O. Rivelles' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. O. Rivelles'|'V. O. Tarasov'|'V. P. Akulov'|'V. Pasquier'|'V. Patodi'|'V. Periwal'|'V. Pervushin'|'V. Petkova'|'V. Petrov'|'V. P. Frolov'|'V. P. Gusynin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. P. Gusynin'|'V. P. Nair'|'V. Polubarinov'|'V. Popov'|'V. Pravda'|'V. Privman'|'V. Proeyen'|'V. Prokhorov'|'V. Prokhvatilov'|'V. P. Spiridonov'|'V. Putz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Putz'|'V. P. Yurov'|'V. Raamsdonk'|'V. Radovanovi'|'V. Radovanovic'|'V. Ramallo'|'V. Razumov'|'V. Rezania'|'V. Rittenberg'|'V. Rivasseau'|'V. Rivelles' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Rivelles'|'V. Rubakov'|'V. Rubtsov'|'V. Saa'|'V. Sabinin'|'V. Sadov'|'V. Sahakian'|'V. Sahni'|'V. Sanadze'|'V. Saveliev'|'V. Schanbacher' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Schanbacher'|'V. Schechtman'|'V. Schomerus'|'V. Schroeder'|'V. Schulte-Frohlinde'|'V. S. Dotsenko'|'V. Serganova'|'V. Shabanov'|'V. Shaynkman'|'V. Shirkov'|'V. Shuryak' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Shuryak'|'V. Silveira'|'V. Singh'|'V. Skalozub'|'V. S. Kaplunovsky'|'V. Skarzhinski'|'V. Smilga'|'V. Sokolov'|'V. Soni'|'V. Soroka'|'V. Spiridonov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Spiridonov'|'V. S. Popov'|'V. Sreedhar'|'V. Srinivasan'|'V. Steele'|'V. Sukumar'|'V. Suneeta'|'V. Suryanarayana'|'V. S. Varadarajan'|'V. S. Vladimirov'|'V. Talamini' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Talamini'|'V. Tapia'|'V. Tarasov'|'V. Telegdi'|'V. Terras'|'V. Tkach'|'V. Tkachov'|'V. Tognetti'|'V. Trimble'|'V. Troitsky'|'V. Turaev' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Turaev'|'V. Turbiner'|'V.  Tyutin'|'V. Tyutin'|'V. T. Zanchin'|'V. Ulyanov'|'V. Unitarity'|'V. Vancea'|'V. Vassilevich'|'V. V. Batyrev'|'V. V. Bazhanov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. V. Bazhanov'|'V. V. Brazhkin'|'V. V. Dixit'|'V. V. Dodonov'|'V. V. Dvoeglazov'|'V. Vento'|'V. V. Fock'|'V. Vishveshwara'|'V. V. Khoze'|'V. Vlasov'|'V. V. Mangazeev' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. V. Mangazeev'|'V. V. Nesterenko'|'V. V. Nikulin'|'V. Voiculescu'|'V.  Volkov'|'V. Volkov'|'V.  Volovich'|'V. Volovich'|'V. V. Skalozub'|'V. V. Sokolov'|'V. V. Sreedhar' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. V. Sreedhar'|'V. V. Zhytnikov'|'V. Weisskopf'|'V. Wood'|'V. Ya'|'V. Yakhot'|'V. Yarevskaya'|'V. Yasnov'|'V. Yu'|'V. Yung'|'V. Zakharov' => { printf("token: %sn", std::string(ts, te).c_str()); };
'V. Zakharov'|'V. Zeitlin'|'V. Zelevinski'|'V. Zhytnikov'|'V. Zima'|'V. Zisis'|'W. A. Bardeen'|'W. A. Benjamin'|'W. Abramo'|'W. A. Hiscock'|'W. Alexander' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Alexander'|'W. A. McGhee'|'W. A. Moura-Melo'|'W. Anderson'|'W. Appelquist'|'W. A. Rodrigues'|'W. A. Sabra'|'W. Bardeen'|'W. Barnes'|'W. Barrett'|'W. Barth' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Barth'|'W. Beirl'|'W. Bernard'|'W. Bietenholz'|'W. Bonnor'|'W. Boucher'|'W. Braden'|'W. Brehme'|'W. B. Riesenfeld'|'W. Brinkmann'|'W. Brittin' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Brittin'|'W. Brown'|'W. B. Schmidke'|'W. Buchm'|'W. Burkhardt'|'W. Capel'|'W. Carter'|'W. Cassing'|'W. Celmaster'|'W. Chan'|'W. Chen' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Chen'|'W. Chiu'|'W. Choptuik'|'W. Chung'|'W. Crater'|'W. Davies'|'W. De'|'W. Delius'|'W. D. Goldberger'|'W. Diehl'|'W. Dietz' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Dietz'|'W. Dittrich'|'W. Driessler'|'W. D. Thacker'|'W. E. Caswell'|'W. Eholzer'|'W. F. Chen'|'W. Fischer'|'W. Fischler'|'W. Fishler'|'W. F. Kao' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. F. Kao'|'W. F. Lu'|'W. Ford'|'W. Fulton'|'W. Furmanski'|'W. F. Wreszinski'|'W. Garcia'|'W. Gebert'|'W.  Gibbons'|'W. Gibbons'|'W. Gl' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Gl'|'W. G. Laarakkers'|'W. Goldberger'|'W. Greenberg'|'W. Greiner'|'W. Greub'|'W. G. Unruh'|'W. Hamber'|'W. Hawking'|'W. Haymaker'|'W. Hehl' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Hehl'|'W. Heidenreich'|'W. Heisenberg'|'W. Heitler'|'W. Helfrich'|'W. H. Freeman'|'W. H. Huang'|'W. Higgs'|'W. H. Kinney'|'W. H. Lee'|'W. H. Louisell' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. H. Louisell'|'W. Hollik'|'W. H. Press'|'W. Huang'|'W. Huff'|'W. H. Zurek'|'W. Israel'|'W. I. Taylor'|'W. I. Weisberger'|'W. Janke'|'W. J. Marciano' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. J. Marciano'|'W. Johnson'|'W. Junker'|'W. J. Zakrzewski'|'W. Kainz'|'W. Kalau'|'W. Kephart'|'W. Kibble'|'W. Kim'|'W. Kinnersley'|'W. Kirkman' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Kirkman'|'W. Knapp'|'W. Kolb'|'W. Kondracki'|'W. Krauth'|'W. Krivan'|'W. Kummer'|'W. Kundt'|'W. Kwong'|'W. K. Wong'|'W. Lang' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Lang'|'W. Lawson'|'W. Lee'|'W. Lerche'|'W. Li'|'W. Liao'|'W. Liniger'|'W. Lucha'|'W. Ludwig'|'W. L. Yang'|'W. Mac' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Mac'|'W. Mackey'|'W. Magnus'|'W. Marciano'|'W. M. C. Foulkes'|'W. McLaughlin'|'W. M. Frank'|'W. Michor'|'W. Mielke'|'W. Miller'|'W. Milnor' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Milnor'|'W. Misner'|'W. Moffat'|'W. Moore'|'W. Morgan'|'W. M. Suen'|'W. Muck'|'W. Mueck'|'W. Muller-Kirsten'|'W. M. Zhang'|'W. Nahm' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Nahm'|'W. Namgung'|'W. Naylor'|'W. Negele'|'W. Nelson'|'W. Nijhoff'|'W. Nilsson'|'W. Oevel'|'W. Ogura'|'W. Oliveira'|'W. Orrick' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Orrick'|'W. Pauli'|'W. Peet'|'W. Perkins'|'W. Pfister'|'W. Pokorski'|'W. Pusz'|'W. Quispel'|'W. Rarita'|'W. Richardson'|'W. Rindler' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Rindler'|'W. Robinson'|'W. Rudin'|'W. Ruehl'|'W. Sabra'|'W. Sasin'|'W. S. Bae'|'W. Sch'|'W. Scheid'|'W. Scherer'|'W. Schmidke' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Schmidke'|'W. Schweiger'|'W. Sciama'|'W. Selke'|'W. Semenoff'|'W.  Siegel'|'W. Siegel'|'W. Skiba'|'W. Smith'|'W. Souma'|'W. Stecker' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Stecker'|'W. Stephenson'|'W. Strampp'|'W. Symes'|'W. Taylor'|'W. Thacker'|'W. Thirring'|'W. Threlfall'|'W. T. Kim'|'W. Troost'|'W. Tu' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Tu'|'W. Tucker'|'W. T. Vetterling'|'W. Tybor'|'W. Unruh'|'W. Van'|'W. Wang'|'W. Weich'|'W. Weir'|'W. Wetzel'|'W. Wiesbrock' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Wiesbrock'|'W. Wong'|'W. Wyld'|'W. Wyss'|'W. Xu'|'W. York'|'W. Zakrzewski'|'W. Zhang'|'W. Zimdahl'|'W. Zimmerman'|'W. Zimmermann' => { printf("token: %sn", std::string(ts, te).c_str()); };
'W. Zimmermann'|'W. Zurek'|'W. Zwerger'|'X. Artru'|'X. Bekaert'|'X. Calmet'|'X. Chen'|'X. De'|'X. Fustero'|'X. Gr'|'X. Gracia' => { printf("token: %sn", std::string(ts, te).c_str()); };
'X. Gracia'|'X. G. Wen'|'X. Hou'|'X. Kong'|'X. Li'|'X. Lu'|'X. Martin'|'X. Montes'|'X. Shen'|'X. Shi'|'X. Vilas' => { printf("token: %sn", std::string(ts, te).c_str()); };
'X. Vilas'|'X. Vilasis-Cardona'|'X. Wang'|'X. Zhang'|'X. Zhou'|'X. Z. Li'|'Y. Acad'|'Y. Aharanov'|'Y. Aharonov'|'Y. Akutsu'|'Y. Alekseev' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. Alekseev'|'Y. Alhassid'|'Y. Arakane'|'Y. Aref'|'Y. Brihaye'|'Y. B. Zeldovich'|'Y. Cai'|'Y. Casteill'|'Y. Chen'|'Y. Cheng'|'Y. Cheung' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. Cheung'|'Y. Chikashige'|'Y. Choquet-Bruhat'|'Y. Demasure'|'Y. Donagi'|'Y. Dothan'|'Y. Eisenberg'|'Y. Frishman'|'Y. Fujii'|'Y. Fujimoto'|'Y. Fujiwara' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. Fujiwara'|'Y. Fukuda'|'Y. Fyodorov'|'Y. Gao'|'Y. Georgelin'|'Y. Goldschmidt'|'Y. Grossman'|'Y. Guo'|'Y. Hassouni'|'Y. Hatsugai'|'Y. H. Chen' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. H. Chen'|'Y. He'|'Y. Hikida'|'Y. Himemoto'|'Y. Homma'|'Y. Hoshino'|'Y. Hosotani'|'Y. Hou'|'Y. Hu'|'Y. Huang'|'Y. Hyakutake' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. Hyakutake'|'Y. Hyun'|'Y. Igarashi'|'Y. Imaizumi'|'Y. Imamura'|'Y. I. Manin'|'Y. Imry'|'Y. Ishimoto'|'Y. Ito'|'Y. Iwasaki'|'Y. Jack' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. Jack'|'Y. Ji'|'Y. Jiang'|'Y. J. Ng'|'Y. J. Park'|'Y. Kanie'|'Y. Kanter'|'Y. Kantor'|'Y. Katsuki'|'Y. Kawahigashi'|'Y. Kawamura' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. Kawamura'|'Y. Kazama'|'Y. Keung'|'Y. Kiem'|'Y. Kikuchi'|'Y. Kikukawa'|'Y. Kim'|'Y. Kimura'|'Y. Kinar'|'Y. Kitazawa'|'Y. Kluger' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. Kluger'|'Y. Kobayashi'|'Y. Kodama'|'Y. Kogan'|'Y. Kosmann-Schwarzbach'|'Y. Kubyshin'|'Y. Kuramoto'|'Y. K. Zhou'|'Y. Lavie'|'Y. Leblanc'|'Y. Lee' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. Lee'|'Y. Liao'|'Y. Lin'|'Y. Linetsky'|'Y. Ling'|'Y. Liu'|'Y. Liu'|'Y. Lozano'|'Y. Lu'|'Y. Machida'|'Y. Makeenko' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. Makeenko'|'Y. Manin'|'Y. Matsubara'|'Y. Matsumura'|'Y. Matsuo'|'Y. M. Cho'|'Y. Meurice'|'Y. Michishita'|'Y. Mimura'|'Y. Miyamoto'|'Y. M. Makeenko' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. M. Makeenko'|'Y. Mori'|'Y. Morozov'|'Y. M. P. Lam'|'Y. Myung'|'Y. M. Zhang'|'Y. M. Zinovev'|'Y. Nakawaki'|'Y. Nambu'|'Y. Ne'|'Y. Neeman' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. Neeman'|'Y. Nir'|'Y. Nomura'|'Y. N. Srivastava'|'Y. Nutku'|'Y. Ohnuki'|'Y. Ohta'|'Y. Ohwashi'|'Y. Okada'|'Y. Okawa'|'Y. Okumura' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. Okumura'|'Y. Ono'|'Y. Ookouchi'|'Y. Oono'|'Y. Oz'|'Y. Pac'|'Y. Pang'|'Y. Park'|'Y. Parra'|'Y. Peleg'|'Y. Pi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. Pi'|'Y. Pugai'|'Y. P. Varshni'|'Y. Reshetikhin'|'Y. Ruan'|'Y. Saeki'|'Y. Saint-Aubin'|'Y. Saito'|'Y. Sato'|'Y. Satoh'|'Y. S. Choi' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. S. Choi'|'Y. S. Duan'|'Y. Sekino'|'Y. Shadmi'|'Y. Shamir'|'Y. Shen'|'Y. Shimizu'|'Y. Shirman'|'Y. Shtanov'|'Y. Simonov'|'Y. S. Kim' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. S. Kim'|'Y. S. Myung'|'Y. S. Stanev'|'Y. Stanev'|'Y. Sugawara'|'Y. Sumino'|'Y. S. Wu'|'Y. Tachikawa'|'Y. Taira'|'Y. Takahashi'|'Y. Takano' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. Takano'|'Y. Tanii'|'Y. Tyupkin'|'Y. Verbin'|'Y. Viro'|'Y. V. Sidorov'|'Y. Wang'|'Y. Watabiki'|'Y. Watanabe'|'Y. W. Kim'|'Y. W. Sun' => { printf("token: %sn", std::string(ts, te).c_str()); };
'Y. W. Sun'|'Y. Wu'|'Y. Yamada'|'Y. Yamanaka'|'Y. Yamasaki'|'Y. Yang'|'Y. Yasui'|'Y. Y. Goldschmidt'|'Y. Yoon'|'Y. Yoshida'|'Y. Yu' => { printf("token: %sn", std::string(ts, te).c_str()); };

	*|;
}%%

%% write data;

int scan(const std::string &in)
{
	int cs = 0, act = 0;
	const char *p = in.c_str();
	const char *pe = in.c_str() + in.length();
	const char *ts = nullptr, *te = nullptr;
	const char *eof = pe;

	%% write init;
	%% write exec;

	//printf("done\n");

	if (cs == part_token_error)
		printf("Error near %zd\n", p-in.data());
	else if(ts)
		printf("offsets: ts %zd te: %zd pe: %zd\n", ts-in.data(), te-in.data(), pe-in.data());
	else
		printf("\nts is null\n");

	return EXIT_SUCCESS;
}


int main(int argc, char **argv) {
  int cs, res = 0;
  struct stat s;
  void *buff;
  int fd;
  fd = open(argv[1], O_RDONLY);
  if (fd < 0)
    return EXIT_FAILURE;
  fstat(fd, &s);
  /* PROT_READ disallows writing to buff: will segv */
  buff = mmap(NULL, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buff != (void *)-1) {
    	scan((char*)buff);
	munmap(buff, s.st_size);
  }
  close(fd);
  return 0;
}

