%%{ 
	machine context;
	derivation = "derivation" | "Derivation"; 
	inline = "$" (any - "$"){1,80} "$" ;
}%%
