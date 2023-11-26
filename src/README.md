virtualenv venv -p python3
pip install -r requirements.txt
python decompress_model.py
python nltk_downloads.py  
python get_symbol_defs.py

Expected output 

$\alpha$ {'the fine structure constant $\\alpha$'}
$c$ {'where $c$ is the speed of light in vacuum .'}
$m_e$ {'in terms of electron mass $m_e$', 'where $e$ and $m_e$ are electron charge and mass'}
$e$ {'where $e$ and $m_e$ are electron charge and mass'}
$\hbar$ {'and Planck constant $\\hbar$'}
$E$ {'in g energy $E$ \\'}
$a$ {'where $a$ is the inter atomic ( inter - m o l e c u l e ) separation , gives \\ begin { equation } v = \\ f r a c { 1 } { \\ p i } \\ omega _ { \\ r m D } a .'}
$f$ {'and $f$ is the proportionality coefficient'}
$m$ {'where $m$ is the mass of the atom .', 'where $m$ is the mass of the atom or m o l e c u l e , and we used $m=\\rho a^3$ .'}
$m=\rho a^3$ {'where $m$ is the mass of the atom or m o l e c u l e , and we used $m=\\rho a^3$ .'}
$\alpha=\frac{1}{4\pi\epsilon_0}\frac{e^2}{\hbar c}$ {'where $\\alpha=\\frac{1}{4\\pi\\epsilon_0}\\frac{e^2}{\\hbar c}$ is the fine structure'}
$A$ {'where $A$ is the atomic mass'}
$A=1$ {'We similarly set $A=1$'}
$400$ {'the pressure range $400$'}
$250$ {'the pressure range $250$'}
$T_m$ {'and a characteristic value of $T_m$ of $10^3$'}
$10^3$ {'and a characteristic value of $T_m$ of $10^3$'}
$u$ {'where $u$ is the average speed'}


Some combination of dependency parsing, pos tags, and regex might yield acceptable results. 

