# 404 SPIDER                                                                                                                                

Just a bash script that use wget, grep and awk to find 404 on a site.

### usage: 
  ##### To spider the site and by default looking for 404's
   `./spider.sh --url https://www.tjenamors.se/x --output tjenamors.se.log`
   
  ##### To change response-code and spider the site
   `./spider.sh --url https://www.tjenamors.se/x --output tjenamors.se.log --response-code 500`
   
  ##### To change response-code without to spider the site again
   `./spider.sh --output tjenamors.se.log --response-code 500`

404 is the default response code if no --response-code flag is provided.
