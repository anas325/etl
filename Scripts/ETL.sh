cd /var/lib/mysql-files/sql/

echo "====bronze layer====="
echo "create.sql"
mysql -u root -proot sys < Bronze/create.sql 
echo "load.sql"
mysql -u root -proot ecommerce_bronze < Bronze/load.sql


echo "=====silver layer====="
echo "create.sql"
mysql -u root -proot sys < Silver/create.sql 
echo "load.sql"
mysql -u root -proot ecommerce_silver < Silver/load.sql

echo "=====gold layer====="
echo "create.sql"
mysql -u root -proot sys < Gold/create.sql 
echo "load.sql"
mysql -u root -proot ecommerce_gold < Gold/load.sql
