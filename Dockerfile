web:
 image: wordpress
 links:
  - mysql
 environment:
  - WORDPRESS_DB_PASSWORD=password
 ports:
  - "127.0.0.3:8080:80"
mysql:
 image: mysql:5.7
 environment:
  - MYSQL_ROOT_PASSWORD=password
  - MYSQL_DATABASE=my-wpdb
