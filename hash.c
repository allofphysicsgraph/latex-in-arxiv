#include "hashmap.h"
#include <stdio.h>
#include <stdlib.h>


int main(){
	
	const unsigned initial_size = 65536;
	struct hashmap_s hashmap;
	
	if (0 != hashmap_create(initial_size, &hashmap)) {
	  puts("failed to create hashmap");
	  return -1;
	}

	int meaning_of_life = 42;
	char question = 6 * 8;

	if (0 != hashmap_put(&hashmap, "life", strlen("life"), &meaning_of_life)) {
	  puts("failed hashmap_put");
	  return -1;
	}


	void* const element = hashmap_get(&hashmap, "life", strlen("life"));
	if (NULL == element) {
	  puts("failed hashmap_get");
	  return -1;
	
	}

	if (0 != hashmap_remove(&hashmap, "life", strlen("life"))) {
	  puts("failed hashmap_remove");
	  return -1;

	}





	hashmap_destroy(&hashmap);
	unsigned num_entries = hashmap_num_entries(&hashmap);
	printf("%d",num_entries);
	

}
