#!/bin/bash

# NGINX
aptitude install -y nginx

# Create default website
mkdir -p /mnt/websites/DEFAULT_WEBSITE/errors
mkdir -p /mnt/websites/DEFAULT_WEBSITE/logs
mkdir -p /mnt/websites/DEFAULT_WEBSITE/html
cat > /mnt/websites/DEFAULT_WEBSITE/html/index.php << "EOF"
<?php
    phpinfo();
?>
EOF
chown -R www-data:www-data /mnt/websites/DEFAULT_WEBSITE
chmod 755 $(find /mnt/websites/DEFAULT_WEBSITE -type d)
chmod 644 $(find /mnt/websites/DEFAULT_WEBSITE -type f)

cat > /etc/nginx/sites-available/default << "EOF"
# Redirect to non-www
server {
    server_name *.DEFAULT_WEBSITE;
    return 301 $scheme://DEFAULT_WEBSITE$request_uri;
}
 
server {
 
    listen   80; ## listen for ipv4; this line is default and implied
    #listen   [::]:80 default ipv6only=on; ## listen for ipv6

    # Document root
    root /mnt/websites/DEFAULT_WEBSITE/html/public/;
 
    # Try php first, then  static files
    index index.php index.html index.htm;
 
    # Specific logs for this vhost
    access_log /mnt/websites/DEFAULT_WEBSITE/logs/access.log;
    error_log  /mnt/websites/DEFAULT_WEBSITE/logs/error.log error;
 
    # Make site accessible from http://localhost/
    server_name DEFAULT_WEBSITE;
 
    # Specify a character set
    charset utf-8;
    
    # Redirect needed to "hide" index.php
    
    location / {
            try_files $uri $uri/ /index.php?$query_string;
    }
 
    # Don't log robots.txt or favicon.ico files
    location = /favicon.ico { log_not_found off; access_log off; }
    location = /robots.txt  { access_log off; log_not_found off; }
 
    
    # 404 errors handled by our application, for instance Laravel or CodeIgniter
    error_page 404 /index.php;
 
	error_page 500 502 503 504 /50x.html;
	
	location = /50x.html {
		root /mnt/websites/DEFAULT_WEBSITE/errors;
	}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    location ~ \.php$ {
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            # NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini
 
            # With php5-cgi alone:
            # fastcgi_pass 127.0.0.1:9000;
            # With php5-fpm:
            fastcgi_pass unix:/var/run/php5-fpm.sock;
            fastcgi_index index.php;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;

    }
 
    # Deny access to .htaccess
    location ~ /\.ht {
            deny all;
    }
    
    include /etc/nginx/extras/siteDefaults;
}



# HTTPS server
#
#server {
#	listen 443;
#	server_name localhost;
#
#	root html;
#	index index.php index.html index.htm;
#
#	ssl on;
#	ssl_certificate cert.pem;
#	ssl_certificate_key cert.key;
#
#	ssl_session_timeout 5m;
#
#	ssl_protocols SSLv3 TLSv1 TLSv1.1 TLSv1.2;
#	ssl_ciphers "HIGH:!aNULL:!MD5 or HIGH:!aNULL:!MD5:!3DES";
#	ssl_prefer_server_ciphers on;
#
#	location / {
#		try_files $uri $uri/ =404;
#	}
#}
EOF

mkdir -p /etc/nginx/extras
cat > /etc/nginx/extras/siteDefaults << "EOF"
     
    ## Only allow these request methods ##
    if ($request_method !~ ^(GET|HEAD|POST)$ ) {
        return 444;
    }
    ##
EOF

cat > /etc/nginx/conf.d/added.conf << "EOF"
#don't send the nginx version number in error pages and Server header
server_tokens off;

### Directive describes the zone, in which the session states are stored i.e. store in slimits. ###
### 1m can handle 32000 sessions with 32 bytes/session, set to 5m x 32000 session ###
       limit_conn_zone $binary_remote_addr zone=slimits:5m;
 
### Control maximum number of simultaneous connections for one session i.e. ###
### restricts the amount of connections from a single ip address ###
        limit_conn slimits 11;

EOF


