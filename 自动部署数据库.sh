
# ���ñ���
mysql_user="mysql"   # MySQLʹ�õ��û���
mysql_group="mysql"  # MySQLʹ�õ��û���
mysql_root_password="123456"  # MySQL root�û�������
mysql_tar_file="/path/to/mysql-8.0.28-linux-glibc2.12-x86_64.tar.gz"  # MySQL�����ư���·��
mysql_install_dir="/usr/local/mysql"  # MySQL�İ�װĿ¼

# ����MySQL�û����û���
groupadd $mysql_group
useradd -r -g $mysql_group -s /bin/false $mysql_user

# ��ѹMySQL�����ư���ָ��Ŀ¼
tar -zxf $mysql_tar_file -C /usr/local/

# ����Ŀ¼����Ȩ��Ȩ��
chown -R $mysql_user:$mysql_group $mysql_install_dir
chmod -R 755 $mysql_install_dir

# ����MySQL��������
echo 'export PATH=$PATH:/usr/local/mysql/bin' >> /etc/profile
source /etc/profile

# ��ʼ��MySQL
$mysql_install_dir/bin/mysqld --initialize --user=$mysql_user --basedir=$mysql_install_dir --datadir=$mysql_install_dir/data

# ����MySQL
$mysql_install_dir/support-files/mysql.server start

# �޸�MySQL root����
$mysql_install_dir/bin/mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$mysql_root_password';"
