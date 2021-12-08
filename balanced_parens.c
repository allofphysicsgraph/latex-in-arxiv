#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <errno.h>
#include <err.h>
#include <string.h>
#include <stdlib.h>

//https://rosettacode.org/wiki/Read_a_file_line_by_line#Using_mmap.28.29
//
//

int balanced_parens(const char * fname, char* start_pattern,char l_delimiter,char r_delimiter,int start_position)
{
        int fd = open(fname, O_RDONLY);
        struct stat fs;
        char *buf ;
	int start_index=0;
	int i = start_position;
	
	int balanced=0;

        if (fd == -1) {
                err(1, "open: %s", fname);
                return 0;
        }
 
        if (fstat(fd, &fs) == -1) {
                err(1, "stat: %s", fname);
                return 0;
        }

	char tmp_data[fs.st_size];
	char result_data[fs.st_size];
	memset(tmp_data,'\0',fs.st_size);	
	memset(result_data,'\0',fs.st_size);	
	

	/* fs.st_size could have been 0 actually */
        buf = mmap(0, fs.st_size, PROT_READ, MAP_SHARED, fd, 0);
        if (buf == (void*) -1) {
                err(1, "mmap: %s", fname);
                close(fd);
                return 0;
        }
	for(i;i<fs.st_size;i++){
		strncpy(tmp_data,&buf[i],strlen(start_pattern));
	 	if(strcmp(tmp_data,start_pattern)==0){
			start_index=i;
			break;	
		}	
	}
	for(i;i<fs.st_size;i++){
		if(buf[i]==r_delimiter){
			balanced++;
			if(balanced==0){
				strncpy(result_data,&buf[start_index],i-start_index+1);
				printf("(%d,%d):%s\n",start_index,i,result_data);
				munmap(buf, fs.st_size);
				close(fd);
        			balanced_parens(fname, start_pattern,l_delimiter,r_delimiter,i+1);
				break;
			}
		}

		if(buf[i]==l_delimiter){
			balanced--;
		}
	}

        munmap(buf, fs.st_size);
        close(fd);
        return 1;
}

 
int main(int argc, char ** argv)
{
	if(argc!=3) { printf("filename, seek_position"); return -1; }
	balanced_parens(argv[1], "\\usepackage{",'{','}',atoi(argv[2]));
	balanced_parens(argv[1], "\\title{",'{','}',atoi(argv[2]));
	balanced_parens(argv[1], "\\cite{",'{','}',atoi(argv[2]));
	balanced_parens(argv[1], "\\section{",'{','}',atoi(argv[2]));
	balanced_parens(argv[1], "\\textit{",'{','}',atoi(argv[2]));
	balanced_parens(argv[1], "\\textbf{",'{','}',atoi(argv[2]));
	return 0;
}
 
