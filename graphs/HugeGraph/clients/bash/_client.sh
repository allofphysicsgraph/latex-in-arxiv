#compdef 

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !
# ! Note:
# !
# ! THIS SCRIPT HAS BEEN AUTOMATICALLY GENERATED USING
# ! openapi-generator (https://openapi-generator.tech)
# ! FROM OPENAPI SPECIFICATION IN JSON.
# !
# ! Based on: https://github.com/Valodim/zsh-curl-completion/blob/master/_curl
# !
# ! Generator version: 7.10.0
# !
# !
# ! Installation:
# !
# ! Copy the _ file to any directory under FPATH
# ! environment variable (echo $FPATH)
# !
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


local curcontext="$curcontext" state line ret=1
typeset -A opt_args

typeset -A mime_type_abbreviations
# text/*
mime_type_abbreviations[text]="text/plain"
mime_type_abbreviations[html]="text/html"
mime_type_abbreviations[md]="text/x-markdown"
mime_type_abbreviations[csv]="text/csv"
mime_type_abbreviations[css]="text/css"
mime_type_abbreviations[rtf]="text/rtf"
# application/*
mime_type_abbreviations[json]="application/json"
mime_type_abbreviations[xml]="application/xml"
mime_type_abbreviations[yaml]="application/yaml"
mime_type_abbreviations[js]="application/javascript"
mime_type_abbreviations[bin]="application/octet-stream"
mime_type_abbreviations[rdf]="application/rdf+xml"
# image/*
mime_type_abbreviations[jpg]="image/jpeg"
mime_type_abbreviations[png]="image/png"
mime_type_abbreviations[gif]="image/gif"
mime_type_abbreviations[bmp]="image/bmp"
mime_type_abbreviations[tiff]="image/tiff"

#
# Generate zsh completion string list for abbreviated mime types
#
get_mime_type_completions() {
    typeset -a result
    result=()
    for k in "${(@k)mime_type_abbreviations}"; do
        value=$mime_type_abbreviations[${k}]
        #echo $value
        result+=( "${k}[${value}]" )
        #echo $result
    done
    echo "$result"
}

#
# cURL crypto engines completion function
#
_curl_crypto_engine() {
    local vals
    vals=( ${${(f)"$(curl --engine list)":gs/ /}[2,$]} )
    _describe -t outputs 'engines' vals && return 0
}

#
# cURL post data completion functions=
#
_curl_post_data() {

    # don't do anything further if this is raw content
    compset -P '=' && _message 'raw content' && return 0

    # complete filename or stdin for @ syntax
    compset -P '*@' && {
        local expl
        _description files expl stdin
        compadd "$expl[@]" - "-"
        _files
        return 0
    }

    # got a name already? expecting data.
    compset -P '*=' && _message 'data value' && return 0

    # otherwise, name (or @ or =) should be specified
    _message 'data name' && return 0

}


local arg_http arg_ftp arg_other arg_proxy arg_crypto arg_connection arg_auth arg_input arg_output

# HTTP Arguments
arg_http=(''\
  {-0,--http1.0}'[force use of use http 1.0 instead of 1.1]' \
  {-b,--cookie}'[pass data to http server as cookie]:data or file' \
  {-c,--cookie-jar}'[specify cookie file]:file name:_files' \
  {-d,--data}'[send specified data as HTTP POST data]:data:{_curl_post_data}' \
  '--data-binary[post HTTP POST data without any processing]:data:{_curl_post_data}' \
  '--data-urlencode[post HTTP POST data, with url encoding]:data:{_curl_post_data}' \
  {-f,--fail}'[enable failfast behavior for server errors]' \
  '*'{-F,--form}'[add POST form data]:name=content' \
  {-G,--get}'[use HTTP GET even with data (-d, --data, --data-binary)]' \
  '*'{-H,--header}'[specify an extra header]:header' \
  '--ignore-content-length[ignore Content-Length header]' \
  {-i,--include}'[include HTTP header in the output]' \
  {-j,--junk-session-cookies}'[discard all session cookies]' \
  {-e,--referer}'[send url as referer]:referer url:_urls' \
  {-L,--location}'[follow Location headers on http 3XX response]' \
  '--location-trusted[like --location, but allows sending of auth data to redirected hosts]' \
  '--max-redirs[set maximum number of redirection followings allowed]:number' \
  {-J,--remote-header-name}'[use Content-Disposition for output file name]' \
  {-O,--remote-name}'[write to filename parsed from url instead of stdout]' \
  '--post301[do not convert POST to GET after following 301 Location response (follow RFC 2616/10.3.2)]' \
  '--post302[do not convert POST to GET after following 302 Location response (follow RFC 2616/10.3.2)]' \
  )

# FTP arguments
arg_ftp=(\
  {-a,--append}'[append to target file instead of overwriting (FTP/SFTP)]' \
  '--crlf[convert LF to CRLF in upload]' \
  '--disable-eprt[disable use of EPRT and LPRT for active FTP transfers]' \
  '--disable-epsv[disable use of EPSV for passive FTP transfers]' \
  '--ftp-account[account data (FTP)]:data' \
  '--ftp-alternative-to-user[command to send when USER and PASS commands fail (FTP)]:command' \
  '--ftp-create-dirs[create paths remotely if it does not exist]' \
  '--ftp-method[ftp method to use to reach a file (FTP)]:method:(multicwd ocwd singlecwd)' \
  '--ftp-pasv[use passive mode for the data connection (FTP)]' \
  '--ftp-skip-pasv-ip[do not use the ip the server suggests for PASV]' \
  '--form-string[like --form, but do not parse content]:name=string' \
  '--ftp-pret[send PRET before PASV]' \
  '--ftp-ssl-ccc[use clear command channel (CCC) after authentication (FTP)]' \
  '--ftp-ssl-ccc-mode[sets the CCC mode (FTP)]:mode:(active passive)' \
  '--ftp-ssl-control[require SSL/TLS for FTP login, clear for transfer]' \
  {-l,--list-only}'[list names only when listing directories (FTP)]' \
  {-P,--ftp-port}'[use active mode, tell server to connect to specified address or interface (FTP]:address' \
  '*'{-Q,--quote}'[send arbitrary command to the remote server before transfer (FTP/SFTP)]:command' \
  )

# Other Protocol arguments
arg_other=(\
  '--mail-from[specify From: address]:address' \
  '--mail-rcpt[specify email recipient for SMTP, may be given multiple times]:address' \
  {-t,--telnet-option}'[pass options to telnet protocol]:opt=val' \
  '--tftp-blksize[set tftp BLKSIZE option]:value' \
  )

# Proxy arguments
arg_proxy=(\
  '--noproxy[list of hosts to connect directly to instead of through proxy]:no-proxy-list' \
  {-p,--proxytunnel}'[tunnel non-http protocols through http proxy]' \
  {-U,--proxy-user}'[specify the user name and password to use for proxy authentication]:user:password' \
  '--proxy-anyauth[use any authentication method for proxy, default to most secure]' \
  '--proxy-basic[use HTTP Basic authentication for proxy]' \
  '--proxy-digest[use http digest authentication for proxy]' \
  '--proxy-negotiate[enable GSS-Negotiate authentication for proxy]' \
  '--proxy-ntlm[enable ntlm authentication for proxy]' \
  '--proxy1.0[use http 1.0 proxy]:proxy url' \
  {-x,--proxy}'[use specified proxy]:proxy url' \
  '--socks5-gssapi-service[change service name for socks server]:servicename' \
  '--socks5-gssapi-nec[allow unprotected exchange of protection mode negotiation]' \
  )

# Crypto arguments
arg_crypto=(\
  {-1,--tlsv1}'[Forces curl to use TLS version 1 when negotiating with a remote TLS server.]' \
  {-2,--sslv2}'[Forces curl to use SSL version 2 when negotiating with a remote SSL server.]' \
  {-3,--sslv3}'[Forces curl to use SSL version 3 when negotiating with a remote SSL server.]' \
  '--ciphers[specifies which cipher to use for the ssl connection]:list of ciphers' \
  '--crlfile[specify file with revoked certificates]:file' \
  '--delegation[set delegation policy to use with GSS/kerberos]:delegation policy:(none policy always)' \
  {-E,--cert}'[use specified client certificate]:certificate file:_files' \
  '--engine[use selected OpenSSL crypto engine]:ssl crypto engine:{_curl_crypto_engine}' \
  '--egd-file[set ssl entropy gathering daemon socket]:entropy socket:_files' \
  '--cert-type[specify certificate type (PEM, DER, ENG)]:certificate type:(PEM DER ENG)' \
  '--cacert[specify certificate file to verify the peer with]:CA certificate:_files' \
  '--capath[specify a search path for certificate files]:CA certificate directory:_directories' \
  '--hostpubmd5[check remote hosts public key]:md5 hash' \
  {-k,--insecure}'[allow ssl to perform insecure ssl connections (ie, ignore certificate)]' \
  '--key[ssl/ssh private key file name]:key file:_files' \
  '--key-type[ssl/ssh private key file type]:file type:(PEM DER ENG)' \
  '--pubkey[ssh public key file]:pubkey file:_files' \
  '--random-file[set source of random data for ssl]:random source:_files' \
  '--no-sessionid[disable caching of ssl session ids]' \
  '--pass:phrase[passphrase for ssl/ssh private key]' \
  '--ssl[try to use ssl/tls for connection, if available]' \
  '--ssl-reqd[try to use ssl/tls for connection, fail if unavailable]' \
  '--tlsauthtype[set TLS authentication type (only SRP supported!)]:authtype' \
  '--tlsuser[set username for TLS authentication]:user' \
  '--tlspassword[set password for TLS authentication]:password' \
  )

# Connection arguments
arg_connection=(\
  {-4,--ipv4}'[prefer ipv4]' \
  {-6,--ipv6}'[prefer ipv6, if available]' \
  {-B,--use-ascii}'[use ascii mode]' \
  '--compressed[request a compressed transfer]' \
  '--connect-timeout[timeout for connection phase]:seconds' \
  {-I,--head}'[fetch http HEAD only (HTTP/FTP/FILE]' \
  '--interface[work on a specific interface]:name' \
  '--keepalive-time[set time to wait before sending keepalive probes]:seconds' \
  '--limit-rate[specify maximum transfer rate]:speed' \
  '--local-port[set preferred number or range of local ports to use]:num' \
  {-N,--no-buffer}'[disable buffering of the output stream]' \
  '--no-keepalive[disable use of keepalive messages in TCP connections]' \
  '--raw[disable all http decoding and pass raw data]' \
  '--resolve[provide a custom address for a specific host and port pair]:host\:port\:address' \
  '--retry[specify maximum number of retries for transient errors]:num' \
  '--retry-delay[specify delay between retries]:seconds' \
  '--retry-max-time[maximum time to spend on retries]:seconds' \
  '--tcp-nodelay[turn on TCP_NODELAY option]' \
  {-y,--speed-time}'[specify time to abort after if download is slower than speed-limit]:time' \
  {-Y,--speed-limit}'[specify minimum speed for --speed-time]:speed' \
  )

# Authentication arguments
arg_auth=(\
  '--anyauth[use any authentication method, default to most secure]' \
  '--basic[use HTTP Basic authentication]' \
  '--ntlm[enable ntlm authentication]' \
  '--digest[use http digest authentication]' \
  '--krb[use kerberos authentication]:auth:(clear safe confidential private)' \
  '--negotiate[enable GSS-Negotiate authentication]' \
  {-n,--netrc}'[scan ~/.netrc for login data]' \
  '--netrc-optional[like --netrc, but does not make .netrc usage mandatory]' \
  '--netrc-file[like --netrc, but specify file to use]:netrc file:_files' \
  '--tr-encoding[request compressed transfer-encoding]' \
  {-u,--user}'[specify user name and password for server authentication]:user\:password' \
  )

# Input arguments
arg_input=(\
  {-C,--continue-at}'[resume at offset ]:offset' \
  {-g,--globoff}'[do not glob {}\[\] letters]' \
  '--max-filesize[maximum filesize to download, fail for bigger files]:bytes' \
  '--proto[specify allowed protocols for transfer]:protocols' \
  '--proto-redir[specify allowed protocols for transfer after a redirect]:protocols' \
  {-r,--range}'[set range of bytes to request (HTTP/FTP/SFTP/FILE)]:range' \
  {-R,--remote-time}'[use timestamp of remote file for local file]' \
  {-T,--upload-file}'[transfer file to remote url (using PUT for HTTP)]:file to upload:_files' \
  '--url[specify a URL to fetch (multi)]:url:_urls' \
  {-z,--time-cond}'[request downloaded file to be newer than date or given reference file]:date expression' \
  )

# Output arguments
arg_output=(\
  '--create-dirs[create local directory hierarchy as needed]' \
  {-D,--dump-header}'[write protocol headers to file]:dump file:_files' \
  {-o,--output}'[write to specified file instead of stdout]:output file:_files' \
  {--progress-bar,-\#}'[display progress as a simple progress bar]' \
  {-\#,--progress-bar}'[Make curl display progress as a simple progress bar instead of the standard, more informational, meter.]' \
  {-R,--remote-time}'[use timestamp of remote file for local file]' \
  '--raw[disable all http decoding and pass raw data]' \
  {-s,--silent}'[silent mode, do not show progress meter or error messages]' \
  {-S,--show-error}'[show errors in silent mode]' \
  '--stderr[redirect stderr to specified file]:output file:_files' \
  '--trace[enable full trace dump of all incoming and outgoing data]:trace file:_files' \
  '--trace-ascii[enable full trace dump of all incoming and outgoing data, without hex data]:trace file:_files' \
  '--trace-time[prepends a time stamp to each trace or verbose line that curl displays]' \
  {-v,--verbose}'[output debug info]' \
  {-w,--write-out}'[specify message to output on successful operation]:format string' \
  '--xattr[store some file metadata in extended file attributes]' \
  {-X,--request}'[specifies request method for HTTP server]:method:(GET POST PUT DELETE HEAD OPTIONS TRACE CONNECT PATCH LINK UNLINK)' \
  )

_arguments -C -s $arg_http $arg_ftp $arg_other $arg_crypto $arg_connection $arg_auth $arg_input $arg_output \
  {-M,--manual}'[Print manual]' \
  '*'{-K,--config}'[Use other config file to read arguments from]:config file:_files' \
  '--libcurl[output libcurl code for the operation to file]:output file:_files' \
  {-m,--max-time}'[Limit total time of operation]:seconds' \
  {-s,--silent}'[Silent mode, do not show progress meter or error messages]' \
  {-S,--show-error}'[Show errors in silent mode]' \
  '--stderr[Redirect stderr to specified file]:output file:_files' \
  '-q[Do not read settings from .curlrc (must be first option)]' \
  {-h,--help}'[Print help and list of operations]' \
  {-V,--version}'[Print service API version]' \
  '--about[Print the information about service]' \
  '--host[Specify the host URL]':URL:_urls \
  '--dry-run[Print out the cURL command without executing it]' \
  {-ac,--accept}'[Set the Accept header in the request]: :{_values "Accept mime type" $(get_mime_type_completions)}' \
  {-ct,--content-type}'[Set the Content-type header in request]: :{_values "Content mime type" $(get_mime_type_completions)}' \
  '1: :->ops' \
  '*:: :->args' \
  && ret=0


case $state in
  ops)
    # Operations
    _values "Operations" \
            "create[]" \
            "delete[]" \
            "get[]" \
            "list[]" \
            "update[]"             "get16[]"             "post2[]"             "get17[]"             "startArthas[start arthas agent]"             "create1[]" \
            "delete1[]" \
            "get1[]" \
            "list1[]" \
            "update1[]"             "post3[]"             "post5[]"             "get18[]"             "post6[]"             "post7[]"             "post[]" \
            "query[]"             "getExternalGrammar[]" \
            "getWadl[]"             "create6[]" \
            "create7[]" \
            "delete6[]" \
            "get7[]" \
            "list6[]" \
            "update6[]" \
            "update7[]"             "get19[get edges from 'source' to 'target' vertex]"             "create11[]" \
            "delete9[]" \
            "get12[]" \
            "list12[]" \
            "update11[]"             "list17[]" \
            "scan[]" \
            "shards[]"             "post8[]"             "clear[]" \
            "compact[]" \
            "create10[]" \
            "createSnapshot[]" \
            "drop[]" \
            "get11[]" \
            "getConf[]" \
            "graphReadMode[]" \
            "graphReadMode1[]" \
            "list9[]" \
            "mode[]" \
            "mode1[]" \
            "resumeSnapshot[]"             "get9[]" \
            "post1[]" \
            "post4[]"             "create2[]" \
            "delete2[]" \
            "get2[]" \
            "list2[]" \
            "update2[]"             "create12[]" \
            "delete10[]" \
            "get13[]" \
            "list13[]" \
            "update12[]"             "get20[]" \
            "post9[]"             "get21[]" \
            "post10[]"             "get22[]" \
            "post11[]"             "login[]" \
            "logout[]" \
            "verifyToken[]"             "all[get all base metrics]" \
            "backend[get the backend metrics]" \
            "counters[get the counters metrics]" \
            "gauges[get the gauges metrics]" \
            "histograms[get the histograms metrics]" \
            "meters[get the meters metrics]" \
            "statistics[get all statistics metrics]" \
            "system[get the system metrics]" \
            "timers[get the timers metrics]"             "post12[]"             "neighborRank[]"             "get23[]" \
            "post13[]"             "personalRank[]"             "getProfile[]" \
            "showAllAPIs[]"             "create3[]" \
            "delete3[]" \
            "get3[]" \
            "list3[]" \
            "update3[]"             "create13[]" \
            "delete11[]" \
            "get14[]" \
            "list14[]" \
            "update13[]"             "addPeer[]" \
            "getLeader[]" \
            "listPeers[]" \
            "removePeer[]" \
            "setLeader[]" \
            "transferLeader[]"             "get24[]"             "edgeLabelRebuild[]" \
            "indexLabelRebuild[]" \
            "vertexLabelRebuild[]"             "create15[]"             "get25[]"             "get26[]" \
            "sameNeighbors[]"             "list15[]"             "get27[]"             "get28[]"             "create4[]" \
            "delete4[]" \
            "get4[]" \
            "list4[]" \
            "update4[]"             "delete8[]" \
            "get10[]" \
            "list8[]" \
            "update10[]"             "post14[]"             "get6[]" \
            "trace[]"             "create5[]" \
            "delete5[]" \
            "get5[]" \
            "list5[]" \
            "role[]" \
            "update5[]"             "delete13[]" \
            "get30[]" \
            "list19[]" \
            "update15[]"             "list10[]"             "create8[]" \
            "create9[]" \
            "delete7[]" \
            "get8[]" \
            "list7[]" \
            "update8[]" \
            "update9[]"             "create14[]" \
            "delete12[]" \
            "get15[]" \
            "list16[]" \
            "update14[]"             "list18[]" \
            "scan1[]" \
            "shards1[]"             "get29[]"             "list11[list white ips]" \
            "updateStatus[enable/disable the white ip list]" \
            "updateWhiteIPs[update white ip list]" \

    _arguments "(--help)--help[Print information about operation]"

    ret=0
    ;;
  args)
    case $line[1] in
      create)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      delete)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "group=:[QUERY] "
"target=:[QUERY] "
"limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      update)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get16)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "vertex=:[QUERY] "
"other=:[QUERY] "
"direction=:[QUERY] "
"label=:[QUERY] "
"max_degree=:[QUERY] "
"limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      post2)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get17)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "source=:[QUERY] "
"target=:[QUERY] "
"direction=:[QUERY] "
"label=:[QUERY] "
"max_depth=:[QUERY] "
"max_degree=:[QUERY] "
"skip_degree=:[QUERY] "
"with_vertex=true:[QUERY] "
          "with_vertex=false:[QUERY] "
"with_edge=true:[QUERY] "
          "with_edge=false:[QUERY] "
"capacity=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      startArthas)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      create1)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      delete1)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get1)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list1)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "user=:[QUERY] "
"group=:[QUERY] "
"limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      update1)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      post3)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      post5)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get18)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "source=:[QUERY] "
"target=:[QUERY] "
"direction=:[QUERY] "
"label=:[QUERY] "
"max_depth=:[QUERY] "
"max_degree=:[QUERY] "
"capacity=:[QUERY] "
"limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      post6)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      post7)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      post)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      query)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "cypher=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      getExternalGrammar)
        local -a _op_arguments
        _op_arguments=(
          "path=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      getWadl)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      create6)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      create7)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "check_vertex=true:[QUERY] "
          "check_vertex=false:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      delete6)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
          "label=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get7)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list6)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "vertex_id=:[QUERY] "
"direction=:[QUERY] "
"label=:[QUERY] "
"properties=:[QUERY] "
"keep_start_p=true:[QUERY] "
          "keep_start_p=false:[QUERY] "
"offset=:[QUERY] "
"page=:[QUERY] "
"limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      update6)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      update7)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
          "action=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get19)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "source=:[QUERY] "
"target=:[QUERY] "
"label=:[QUERY] "
"sort_values=:[QUERY] "
"limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      create11)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      delete9)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get12)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list12)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "names=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      update11)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"name=:[PATH] "
          "action=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list17)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "ids=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      scan)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "start=:[QUERY] "
"end=:[QUERY] "
"page=:[QUERY] "
"page_limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      shards)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "split_size=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      post8)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      clear)
        local -a _op_arguments
        _op_arguments=(
          "name=:[PATH] "
          "confirm_message=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      compact)
        local -a _op_arguments
        _op_arguments=(
          "name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      create10)
        local -a _op_arguments
        _op_arguments=(
          "name=:[PATH] "
          "clone_graph_name=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      createSnapshot)
        local -a _op_arguments
        _op_arguments=(
          "name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      drop)
        local -a _op_arguments
        _op_arguments=(
          "name=:[PATH] "
          "confirm_message=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get11)
        local -a _op_arguments
        _op_arguments=(
          "name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      getConf)
        local -a _op_arguments
        _op_arguments=(
          "name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      graphReadMode)
        local -a _op_arguments
        _op_arguments=(
          "name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      graphReadMode1)
        local -a _op_arguments
        _op_arguments=(
          "name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list9)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      mode)
        local -a _op_arguments
        _op_arguments=(
          "name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      mode1)
        local -a _op_arguments
        _op_arguments=(
          "name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      resumeSnapshot)
        local -a _op_arguments
        _op_arguments=(
          "name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get9)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      post1)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      post4)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      create2)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      delete2)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get2)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list2)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      update2)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      create12)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      delete10)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get13)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list13)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "names=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      update12)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"name=:[PATH] "
          "action=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get20)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "vertex=:[QUERY] "
"other=:[QUERY] "
"direction=:[QUERY] "
"label=:[QUERY] "
"max_degree=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      post9)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get21)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "source=:[QUERY] "
"direction=:[QUERY] "
"label=:[QUERY] "
"max_depth=:[QUERY] "
"count_only=true:[QUERY] "
          "count_only=false:[QUERY] "
"max_degree=:[QUERY] "
"limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      post10)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get22)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "source=:[QUERY] "
"direction=:[QUERY] "
"label=:[QUERY] "
"max_depth=:[QUERY] "
"nearest=true:[QUERY] "
          "nearest=false:[QUERY] "
"count_only=true:[QUERY] "
          "count_only=false:[QUERY] "
"max_degree=:[QUERY] "
"capacity=:[QUERY] "
"limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      post11)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      login)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      logout)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    "Authorization\::[HEADER] "
)
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      verifyToken)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    "Authorization\::[HEADER] "
)
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      all)
        local -a _op_arguments
        _op_arguments=(
                    "type=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      backend)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      counters)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      gauges)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      histograms)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      meters)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      statistics)
        local -a _op_arguments
        _op_arguments=(
                    "type=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      system)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      timers)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      post12)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      neighborRank)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get23)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "source=:[QUERY] "
"target=:[QUERY] "
"direction=:[QUERY] "
"label=:[QUERY] "
"max_depth=:[QUERY] "
"max_degree=:[QUERY] "
"capacity=:[QUERY] "
"limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      post13)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      personalRank)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      getProfile)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      showAllAPIs)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      create3)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      delete3)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get3)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list3)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      update3)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
          "action=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      create13)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      delete11)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get14)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list14)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "names=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      update13)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"name=:[PATH] "
          "action=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      addPeer)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "group=:[QUERY] "
"endpoint=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      getLeader)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "group=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      listPeers)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "group=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      removePeer)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "group=:[QUERY] "
"endpoint=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      setLeader)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "group=:[QUERY] "
"endpoint=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      transferLeader)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "group=:[QUERY] "
"endpoint=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get24)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "source=:[QUERY] "
"direction=:[QUERY] "
"label=:[QUERY] "
"max_depth=:[QUERY] "
"max_degree=:[QUERY] "
"capacity=:[QUERY] "
"limit=:[QUERY] "
"with_vertex=true:[QUERY] "
          "with_vertex=false:[QUERY] "
"with_edge=true:[QUERY] "
          "with_edge=false:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      edgeLabelRebuild)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      indexLabelRebuild)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      vertexLabelRebuild)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      create15)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "vertex=:[QUERY] "
"other=:[QUERY] "
"direction=:[QUERY] "
"label=:[QUERY] "
"max_degree=:[QUERY] "
"limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get25)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "source=:[QUERY] "
"direction=:[QUERY] "
"label=:[QUERY] "
"max_depth=:[QUERY] "
"source_in_ring=true:[QUERY] "
          "source_in_ring=false:[QUERY] "
"max_degree=:[QUERY] "
"capacity=:[QUERY] "
"limit=:[QUERY] "
"with_vertex=true:[QUERY] "
          "with_vertex=false:[QUERY] "
"with_edge=true:[QUERY] "
          "with_edge=false:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get26)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "vertex=:[QUERY] "
"other=:[QUERY] "
"direction=:[QUERY] "
"label=:[QUERY] "
"max_degree=:[QUERY] "
"limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      sameNeighbors)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list15)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get27)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "source=:[QUERY] "
"target=:[QUERY] "
"direction=:[QUERY] "
"label=:[QUERY] "
"max_depth=:[QUERY] "
"max_degree=:[QUERY] "
"skip_degree=:[QUERY] "
"with_vertex=true:[QUERY] "
          "with_vertex=false:[QUERY] "
"with_edge=true:[QUERY] "
          "with_edge=false:[QUERY] "
"capacity=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get28)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "source=:[QUERY] "
"direction=:[QUERY] "
"label=:[QUERY] "
"weight=:[QUERY] "
"max_degree=:[QUERY] "
"skip_degree=:[QUERY] "
"with_vertex=true:[QUERY] "
          "with_vertex=false:[QUERY] "
"with_edge=true:[QUERY] "
          "with_edge=false:[QUERY] "
"capacity=:[QUERY] "
"limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      create4)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      delete4)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get4)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list4)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      update4)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      delete8)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
          "force=true:[QUERY] "
          "force=false:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get10)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list8)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "status=:[QUERY] "
"ids=:[QUERY] "
"limit=:[QUERY] "
"page=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      update10)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
          "action=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      post14)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get6)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      trace)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      create5)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      delete5)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get5)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list5)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      role)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      update5)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      delete13)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"key=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get30)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"key=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list19)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      update15)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"key=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list10)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      create8)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      create9)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      delete7)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
          "label=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get8)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list7)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "label=:[QUERY] "
"properties=:[QUERY] "
"keep_start_p=true:[QUERY] "
          "keep_start_p=false:[QUERY] "
"offset=:[QUERY] "
"page=:[QUERY] "
"limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      update8)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      update9)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"id=:[PATH] "
          "action=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      create14)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      delete12)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get15)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"name=:[PATH] "
                    )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list16)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "names=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      update14)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
"name=:[PATH] "
          "action=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list18)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "ids=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      scan1)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "start=:[QUERY] "
"end=:[QUERY] "
"page=:[QUERY] "
"page_limit=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      shards1)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "split_size=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      get29)
        local -a _op_arguments
        _op_arguments=(
          "graph=:[PATH] "
          "source=:[QUERY] "
"target=:[QUERY] "
"direction=:[QUERY] "
"label=:[QUERY] "
"weight=:[QUERY] "
"max_degree=:[QUERY] "
"skip_degree=:[QUERY] "
"with_vertex=true:[QUERY] "
          "with_vertex=false:[QUERY] "
"with_edge=true:[QUERY] "
          "with_edge=false:[QUERY] "
"capacity=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      list11)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      updateStatus)
        local -a _op_arguments
        _op_arguments=(
                    "status=:[QUERY] "
          )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
      updateWhiteIPs)
        local -a _op_arguments
        _op_arguments=(
                              )
        _describe -t actions 'operations' _op_arguments -S '' && ret=0
        ;;
    esac
    ;;

esac

return ret
