
#******************************
# find variable definitions

# find single-character latex variable definitions
# include adjacent lines for context
find_variable_definitions:
	egrep -B2 -A2 'where \$[A-Za-z]\$ is' hep-th/2003/*

#******************************
# find named constants
# misspelling and variations are typical


hubble_constant:
	egrep -B2 -A2 -i 'hubble constant' hep-th/2003/*

planck_constant:
	egrep -B2 -A2 -i 'planck constant' hep-th/2003/*
	egrep -B2 -A2 -i "planck's constant" hep-th/2003/*

boltzmann_constant:
	egrep -B2 -A2 -i 'boltzmann constant' hep-th/2003/*
	egrep -B2 -A2 -i "boltzmann's constant" hep-th/2003/*

boltzmann_constant:
	egrep -B2 -A2 -i 'fine structure constant' hep-th/2003/*
	egrep -B2 -A2 -i "fine-structure constant" hep-th/2003/*

lorentz_factor:
	egrep -B2 -A2 -i 'lorentz factor' hep-th/2003/*

