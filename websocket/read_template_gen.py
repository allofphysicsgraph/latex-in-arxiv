from sys import argv

upper = argv[1].upper()
resp = f'''if (({argv[1]}_ptr = kore_mem_lookup(MEM_TAG_{upper})) == NULL) {{
  /* Failed, grab a new chunk of memory and tag it. */
  fd = open("{argv[1]}", O_RDONLY);
  fstat(fd, &s);
  /* PROT_READ disallows writing to buffer: will segv */
  buffer = mmap(0, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buffer != (void *)-1) {{
    printf("  allocating title_ptr for the first time\n");
    {argv[1]}_ptr = kore_malloc_tagged(strlen(buffer) + 1, MEM_TAG_{upper});
    kore_strlcpy({argv[1]}_ptr, buffer, strlen(buffer) + 1);
    {argv[1]}_line_count = kore_split_string({argv[1]}_ptr, "\n", {argv[1]}_test, MAX_TITLES);
    kore_log(LOG_NOTICE, ":::::%i: connected", {argv[1]}_line_count);
    kore_log(LOG_NOTICE, ":::::%s: connected", {argv[1]}_test[0]);
    for (int i = 0; i < {argv[1]}_line_count; i++) {{
      if ({argv[1]}_test[i] != NULL) {{
	memset({argv[1]}[i],'\0',MAX_TITLES_LEN);
        //kore_log(LOG_NOTICE, "%s: connected", {argv[1]}[i]);
        sprintf({argv[1]}[i], "<tr><td>%s</td></tr>", {argv[1]}_test[i]);
	
      }}
    }}
    close(fd);
    munmap(buffer, s.st_size);
  }}}} else {{
	  printf("  fixed_ptr address resolved\n");
   }}'''

print(resp)
