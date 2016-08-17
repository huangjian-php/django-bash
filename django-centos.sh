#!/bin/bash

echo "安装将花费一定时间，请耐心等待直到安装完成......"
echo "......"
echo "卸载旧版本git......"
yum remove -y git
echo "卸载完成"

yum install -y tk zlib-devel openssl-devel perl cpio expat-devel gettext-devel asciidoc xmlto libcurl-devel
wget -c http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz
cd libiconv-1.14
./configure --prefix=/usr/local/libiconv && make && make install
ln -s /usr/local/lib/libiconv.so /usr/lib
ln -s /usr/local/lib/libiconv.so.2 /usr/lib

wget -c https://www.kernel.org/pub/software/scm/git/git-2.9.3.tar.xz
tar xf git-2.9.3.tar.xz
cd git-2.9.3
./configure --prefix=/usr/local --with-gitconfig=/etc/gitconfig --with-iconv=/usr/local/libiconv --with-curl=/usr/bin/curl && make

make install
PATH=$PATH:/usr/local/libexec/git-core

#sudo yum install -y gcc vim git ctags xclip astyle python-setuptools python-devel
git clone git://github.com/huangjian-php/django-bash.git ~/django-bash
mkdir -p /data/nginx
mkdir -p /var/www/static
cd ~/django-bash
cp nginx.repo /etc/yum.repos.d/nginx.repo
yum install -y nginx
cp nginx.conf /etc/nginx/nginx.conf
mkdir /etc/nginx/sites-available
mkdir /etc/nginx/sites-enabled
cp django-nginx.conf /etc/nginx/sites-available/django
ln -s /etc/nginx/sites-available/django /etc/nginx/sites-enabled/
rm -f /etc/nginx/conf.d/default.conf

wget -c http://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz
tar -xvf Python-2.7.10.tgz
mkdir /usr/local/python2.7
cd Python-2.7.10
./configure --prefix=/usr/local/python2.7
make && make install
mv /usr/bin/python /usr/bin/python2.6
ln -s /usr/local/python2.7 /usr/bin/python
#echo "export PATH="/usr/local/python2.7/bin:$PATH"" >> /etc/profile
#source /etc/profile

wget -c --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-1.4.2.tar.gz
tar -xvf setuptools-1.4.2.tar.gz
cd setuptools-1.4.2
python2.7 setup.py install

wget -c https://pypi.python.org/packages/source/p/pip/pip-8.1.1.tar.gz
tar -xzvf pip-8.1.1.tar.gz
cd pip-8.1.1
python2.7 setup.py install

sed -i '1s/.*/#!\/usr\/bin\/python2.6/' /usr/bin/yum
#sed -i '1s/.*/#!\/usr\/bin\/python2.6 -tt/' /usr/bin/yum-builddep
#sed -i '1s/.*/#!\/usr\/bin\/python2.6 -tt/' /usr/bin/yum-config-manager
#sed -i '1s/.*/#!\/usr\/bin\/python2.6 -tt/' /usr/bin/yum-debug-dump
#sed -i '1s/.*/#!\/usr\/bin\/python2.6 -tt/' /usr/bin/yum-debug-restore
#sed -i '1s/.*/#!\/usr\/bin\/python2.6/' /usr/bin/yumdownloader 
#sed -i '1s/.*/#!\/usr\/bin\/python2.6 -tt/' /usr/bin/yum-groups-manager