find ../ -type f -exec sha256sum "{}" \; > /dev/shm/chksm_files ;
#./a.out hello |grep -P "\t" |tr -d '\t .' |cut -d '/' -f4|xargs -i find x/latex-in-arxiv/data/training_data/ -type f -name "{}" -exec rm x/latex-in-arxiv/data/training_data/"{}" \;
