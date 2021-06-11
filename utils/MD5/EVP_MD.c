/*-
 * Copyright 2019-2021 The OpenSSL Project Authors. All Rights Reserved.
 *
 * Licensed under the Apache License 2.0 (the "License").  You may not use
 * this file except in compliance with the License.  You can obtain a copy
 * in the file LICENSE in the source distribution or at
 * https://www.openssl.org/source/license.html
 */


#include <string.h>
#include <stdio.h>
#include <openssl/err.h>
#include <openssl/evp.h>


int main(int argc, char* argv[])
{
        BIO *bio, *mdtmp;
        char buf[1024];
        int rdlen;
	FILE *file;
	if (argc != 2){
		printf("requires a file name\n");
		return -1;
	}

        bio = BIO_new_file(argv[1], "rb");
        mdtmp = BIO_new(BIO_f_md());
        BIO_set_md(mdtmp, EVP_md5());
        bio = BIO_push(mdtmp, bio);
        do {
            rdlen = BIO_read(bio, buf, sizeof(buf));
            /* Might want to do something with the data here */
        } while (rdlen > 0);

        unsigned char mdbuf[EVP_MAX_MD_SIZE];
        int mdlen;
        int i;

        mdtmp = bio;   /* Assume bio has previously been set up */
        do {
            EVP_MD *md;

            mdtmp = BIO_find_type(mdtmp, BIO_TYPE_MD);
            if (!mdtmp)
                break;
            BIO_get_md(mdtmp, &md);
            printf("%s digest:", OBJ_nid2sn(EVP_MD_get_type(md)));
            mdlen = BIO_gets(mdtmp, mdbuf, EVP_MAX_MD_SIZE);
            for (i = 0; i < mdlen; i++) printf("%02x", mdbuf[i]);
            printf("\n");
            mdtmp = BIO_next(mdtmp);
        } while (mdtmp);

        BIO_free_all(bio);


}
