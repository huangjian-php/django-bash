#!/bin/bash

echo "Please wait......"
yum -y groupinstall "Development tools"
yum install -y tk zlib-devel openssl-devel perl cpio expat-devel gettext-devel asciidoc xmlto libcurl-devel bzip2-devel ncurses-devel sqlite-devel

# nginx 1.10
git clone https://github.com/huangjian-php/django-bash.git ~/django-bash
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

# python 2.7.10
wget -c http://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz
tar -xvf Python-2.7.10.tgz
mkdir /usr/local/python2.7
cd Python-2.7.10
./configure --prefix=/usr/local/python2.7
make && make install
mv /usr/bin/python /usr/bin/python2.6
ln -s /usr/local/python2.7/bin/python2.7 /usr/bin/python
sed -i '1s/.*/#!\/usr\/bin\/python2.6/' /usr/bin/yum

# pip 8.1
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

ln -sf /usr/local/python2.7/bin/pip /usr/bin/pip
ln -sf /usr/local/python2.7/bin/easy_install /usr/bin/easy_install

# django 1.8.5 & uWSGI 2.0.12
pip install Django==1.8.5 uWSGI==2.0.12 supervisor

# uWSGI 2.0.1
wget http://projects.unbit.it/downloads/uwsgi-2.0.1.tar.gz
tar zxf uwsgi-2.0.1.tar.gz
cd uwsgi-2.0.1
python uwsgiconfig.py --build
python uwsgiconfig.py --clean
cd ..
cp -R ./uwsgi-2.0.1 /usr/local/uwsgi
ln -s /usr/local/uwsgi/uwsgi /usr/bin/uwsgi

# supervisor
mkdir -p /etc/supervisor/conf.d
mkdir -p /data/supervisor
yum install -y supervisor
chkconfig supervisord on
cp ~/django-bash/supervisord.conf /etc/supervisord.conf
cp ~/django-bash/django-supervisord.conf /etc/supervisor/conf.d/

# git 2.9
yum remove -y git
wget -c https://www.kernel.org/pub/software/scm/git/git-2.9.3.tar.xz
tar xf git-2.9.3.tar.xz
cd git-2.9.3
make prefix=/usr/local/git all
make prefix=/usr/local/git install
echo "export PATH=$PATH:/usr/local/git/bin" >> /etc/bashrc
source /etc/bashrc
ln -s /usr/local/git/bin/git /usr/bin/git

# test
cp ~/django-bash/django_test /var/www/ -R
/etc/init.d/supervisord restart
