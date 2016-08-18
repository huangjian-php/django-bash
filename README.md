# CentOS 配置django
+ 安装内容:
    + Nginx 1.10
    + Python 2.7.10
    + pip 8.1
    + django 1.8.5
    + uWSGI 2.0
    + supervisor 2.x
    + git 2.9
+ 安装方法:
    <pre>
    # 连接服务器终端, 直接复制以下命令并执行, 然后等待完成:
    git clone https://github.com/huangjian-php/django-bash.git ~/django-bash && bash ~/django-bash/django-centos.sh

    # 完成后直接访问服务器ip, 出现django默认界面即配置成功
    </pre>
+ 部署项目:
    <pre>
    # 设置好你的项目后, 进入到django项目下的uwsgi.py所在目录, 复制以下命令并执行即可:
    bash ~/django-bash/django-deploy.sh $PWD $(dirname $PWD)
    </pre>
+ 重启Nginx与uWSGI
    <pre>
    # 直接执行以下命令：
    supervisorctl restart all
    </pre>
