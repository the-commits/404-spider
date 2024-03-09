# 404 SPIDER                                                                                                                                

Just a bash script that use wget, grep and awk to find 404 on a site.

usage: 
   `./spider.sh --url https://www.tjenamors.se/x --output tjenamors.se.log`
   
   `./spider.sh --url https://www.tjenamors.se/x --output tjenamors.se.log --response-code 500`

404 is the default response code if no --response-code flag is provided.