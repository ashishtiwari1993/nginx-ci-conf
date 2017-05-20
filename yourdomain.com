server {
	listen 80;
	listen [::]:80;


	root /var/www/html/ci;

        autoindex on;
	index index.php index.html index.htm index.nginx-debian.html;

	server_name yourdomain.com;

	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files $uri $uri/ /index.php;
	}

	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/run/php/php7.0-fpm.sock;
	}

	location ~ /\.ht {
		deny all;
	}
}


