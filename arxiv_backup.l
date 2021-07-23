	//Max file count
	char *array[MAX_FILE_COUNT];
	int i = 0;
	int array_index=0;
	memset(array,0,sizeof(array));
	int r = walk_dir(".", "\\.tex$", WS_DEFAULT|WS_MATCHDIRS,array,array_index);
	switch(r) {
	case WALK_OK:		break;
	case WALK_BADIO:	err(1, "IO error");
	case WALK_BADPATTERN:	err(1, "Bad pattern");
	case WALK_NAMETOOLONG:	err(1, "Filename too long");
	default:
		err(1, "Unknown error?");
	}

	
	//print file matches
	for(i=0;i<MAX_FILE_COUNT;i++){	
		if(array[i] != 0){
			fileCount++;
			yyin=fopen(array[i],"r");
			yylex();
			printf("\nfile_match:%s\n",array[i]);
			file_md5(array[i]);
		}
	}
	

        if (argc < 3){
		printf("arg1: filename\narg2: word lookup\n");
		return 0;
		}


	if (argc > 1) {
		FILE *file;
		file = fopen(argv[1], "r");
		if (!file) {
			fprintf(stderr,"could not open %s\n",argv[1]);
			exit(1);
		}
		yyin = file;
	}
	lookup_word(argv[2],1);
	printf("\nfileCount:%d:\n",fileCount);
	return 0;
}







