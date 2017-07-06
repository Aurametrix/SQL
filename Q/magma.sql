
service mysqld start
chkconfig mysqld on

echo "CREATE USER 'magma'@'localhost' IDENTIFIED BY 'volcano';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON *.* TO 'magma'@'localhost' WITH GRANT OPTION;" | mysql -u root
