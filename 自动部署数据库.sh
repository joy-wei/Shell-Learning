
# 设置变量
mysql_user="mysql"   # MySQL使用的用户名
mysql_group="mysql"  # MySQL使用的用户组
mysql_root_password="123456"  # MySQL root用户的密码
mysql_tar_file="/path/to/mysql-8.0.28-linux-glibc2.12-x86_64.tar.gz"  # MySQL二进制包的路径
mysql_install_dir="/usr/local/mysql"  # MySQL的安装目录

# 创建MySQL用户和用户组
groupadd $mysql_group
useradd -r -g $mysql_group -s /bin/false $mysql_user

# 解压MySQL二进制包到指定目录
tar -zxf $mysql_tar_file -C /usr/local/

# 更改目录所有权和权限
chown -R $mysql_user:$mysql_group $mysql_install_dir
chmod -R 755 $mysql_install_dir

# 配置MySQL环境变量
echo 'export PATH=$PATH:/usr/local/mysql/bin' >> /etc/profile
source /etc/profile

# 初始化MySQL
$mysql_install_dir/bin/mysqld --initialize --user=$mysql_user --basedir=$mysql_install_dir --datadir=$mysql_install_dir/data

# 启动MySQL
$mysql_install_dir/support-files/mysql.server start

# 修改MySQL root密码
$mysql_install_dir/bin/mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$mysql_root_password';"
