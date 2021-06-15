#include <kore/kore.h>
#include <kore/http.h>
#include "assets.h"

int		page(struct http_request *);

int
page(struct http_request *req)
{
    
	http_response_header(req, "content-type", "text/html");
	http_response(req, 200, asset_index_html, asset_len_index_html);
	return (KORE_RESULT_OK);


}
