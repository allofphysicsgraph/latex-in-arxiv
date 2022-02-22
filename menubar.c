//https://github.com/wkoszek/ncurses_guide.git

#include <ncurses.h>

#define MENUMAX 8

void drawmenu(int item)
{
	int c;
	char mainmenu[] = "Main Menu";
	char menu[MENUMAX][90] = {		/* items for MENUMAX */
		"install dependencies",		// texlive, codesearch, python3, nltk, flex, golang for codesearch, re2 for fast regex matching  
		"working directory",		// set current working directory 
		"find files",			// find . -type f 
		"index files",			// codesearch
		"choose lexer",			// mix and match lexers for parsing data
		"sentence tokenizer",		// nltk for sent_tokenize
		"expand TeX Macros",		// newcommand for resolving commong newcommands in latex files 
		"compile latex file"
		};

	clear();
	addstr(mainmenu);
	for(c=0;c<MENUMAX;c++)
	{
		if( c==item )
			attron(A_REVERSE);	/* highlight selection */
		mvaddstr(3+(c*2),20,menu[c]);
		attroff(A_REVERSE);		/* remove highlight */
	}
	mvaddstr(17,25,"Use arrow keys to move; Enter to select:");
	refresh();
}

int main(void)
{
	FILE * FIND_PTR,  * INSTALL_PTR, * FILE_PTR, * LEXER_PTR ;
	int key,menuitem;
	enum { INSTALL, WORKING_DIR, FIND, INDEX, LEXER, SENT_TOKENIZE, EXPAND_TEX_MACROS, COMPILE_TEX_TO_PDF, EXIT};	
	char  working_dir[256];
	menuitem = 0;
	
	initscr();

	drawmenu(menuitem);
	keypad(stdscr,TRUE);
	noecho();			/* Disable echo */
	do
	{
		key = getch();
		switch(key)
		{
			case KEY_DOWN:
				menuitem++;
				if(menuitem > MENUMAX-1) menuitem = 0;
				break;
			case KEY_UP:
				menuitem--;
				if(menuitem < 0) menuitem = MENUMAX-1;
				break;
			default:
				break;
		}
		drawmenu(menuitem);
	} while(key != '\n');

	echo();				/* re-enable echo */



	switch ( menuitem ) {
	
		case INSTALL:	
			INSTALL_PTR = popen("sudo apt install -y git vim flex texinfo virtualenv","r"); 	
			pclose(INSTALL_PTR);
			INSTALL_PTR = popen("virtualenv /dev/shm/venv -p python3","r");
			INSTALL_PTR = popen("/bin/bash libbloom.sh","r"); 	
			pclose(INSTALL_PTR);
			break;
	
		case WORKING_DIR:
			printw("\ninput working dir:\tmax chars 256:\n");	
			scanw("%s",&working_dir);
			printw("%s",working_dir);
			getch();
			break;

		case FIND:
			FIND_PTR = popen("find . -type f > /dev/shm/current_file_list","r"); 	
			printf("file list in /dev/shm/current_file_list");
			pclose(FIND_PTR);
			break;
	
		case INIT: //basic setup 
						
			FILE	*english_vocab;										/* input-file pointer */
			char	*english_vocab_file_name = "";		/* input-file name    */

			english_vocab	= fopen( english_vocab_file_name, "r" );
			if ( english_vocab == NULL ) {
				fprintf ( stderr, "couldn't open file '%s'; %s\n",
						english_vocab_file_name, strerror(errno) );
				exit (EXIT_FAILURE);
			}
			{-continue_here-}
			if( fclose(english_vocab) == EOF ) {			/* close input file   */
				fprintf ( stderr, "couldn't close file '%s'; %s\n",
						english_vocab_file_name, strerror(errno) );
				exit (EXIT_FAILURE);
			}





			FILE	*latex_vocab;										/* input-file pointer */
			char	*latex_vocab_file_name = "";		/* input-file name    */

			latex_vocab	= fopen( latex_vocab_file_name, "r" );
			if ( latex_vocab == NULL ) {
				fprintf ( stderr, "couldn't open file '%s'; %s\n",
						latex_vocab_file_name, strerror(errno) );
				exit (EXIT_FAILURE);
			}
			{-continue_here-}
			if( fclose(latex_vocab) == EOF ) {			/* close input file   */
				fprintf ( stderr, "couldn't close file '%s'; %s\n",
						latex_vocab_file_name, strerror(errno) );
				exit (EXIT_FAILURE);
			}




		case INDEX:	
			break;

		case LEXER:
			break;

		case SENT_TOKENIZE:	
			break;

		case EXPAND_TEX_MACROS:	
			break;

		case COMPILE_TEX_TO_PDF:	
			break;
		

		default:	
			break;
	}				/* -----  end switch  ----- */




	endwin();
	return 0;
}

