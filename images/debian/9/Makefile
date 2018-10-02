# harry h. haller @ hades inc.
# telemaco230@gmail.com
# 
# script para la actualización de repositorios

ARGS=--build-arg equipo=${COMPUTERNAME} --build-arg usuario=${USER} --build-arg http_proxy=   #http://proxy.yggdrasil.inf:3128

all: core ssh ionic httpd mysql squid redmine postfix subversion postfix ionic laravel python2_7

core:
	clear
	docker build $(ARGS) --pull --tag debian9_core:stable --tag debian9_core:1 -f DockerFile-core .
ssh: core
	clear
	docker build $(ARGS) --tag debian9_ssh:stable --tag debian9_ssh:1 -f DockerFile-ssh .
httpd: ssh
	clear
	docker build $(ARGS) --tag debian9_httpd:stable --tag debian9_httpd:1 -f DockerFile-httpd .
mysql: ssh
	clear
	docker build $(ARGS) --tag debian9_mysql:stable --tag debian9_mysql:1 -f DockerFile-mysql .
squid: ssh
	clear
	docker build $(ARGS) --tag debian9_squid:stable --tag debian9_squid:1 -f DockerFile-squid .
redmine: ssh
	clear
	docker build $(ARGS) --tag debian9_redmine:stable --tag debian9_redmine:1 -f DockerFile-redmine .
subversion: ssh
	clear
	docker build $(ARGS) --tag debian9_subversion:stable --tag debian9_subversion:1 -f DockerFile-subversion .
postfix: ssh
	clear
	docker build $(ARGS) --tag debian9_postfix:stable --tag debian9_postfix:1 -f DockerFile-postfix .
ionic: ssh
	clear
	docker build $(ARGS) --tag debian9_ionic:stable --tag debian9_ionic:1 -f DockerFile-ionic .
laravel: ssh
	clear
	docker build $(ARGS) --tag debian9_laravel:stable --tag debian9_laravel:1 -f DockerFile-laravel .

python2_7: ssh
	clear
	docker build $(ARGS) --tag debian9_python2_7:stable --tag debian9_python2_7:1 -f DockerFile-python2_7 .

clean: clean_core clean_ssh clean_ionic clean_httpd clean_mysql clean_squid clean_redmine clean_postfix clean_subversion clean_postfix clean_ionic clean_laravel

clean_core:
	clear
	docker rmi --force debian9_core:stable debian9_core:1 
clean_ssh: clean_ionic clean_httpd clean_mysql clean_squid clean_redmine clean_postfix clean_subversion clean_postfix clean_ionic clean_laravel
	clear
	docker rmi --force debian9_ssh:stable debian9_ssh:1 
clean_ionic:
	clear
	docker rmi --force debian9_ionic:stable debian9_ionic:1 
clean_httpd: clean_laravel
	clear
	docker rmi --force debian9_httpd:stable debian9_httpd:1 
clean_mysql:
	clear
	docker rmi --force debian9_mysql:stable debian9_mysql:1 
clean_squid:
	clear
	docker rmi --force debian9_squid:stable debian9_squid:1 
clean_redmine:
	clear
	docker rmi --force debian9_redmine:stable debian9_redmine:1 
clean_postfix:
	clear
	docker rmi --force debian9_postfix:stable debian9_postfix:1 
clean_subversion:
	clear
	docker rmi --force debian9_subversion:stable debian9_subversion:1 
clean_postfix:
	clear
	docker rmi --force debian9_postfix:stable debian9_postfix:1 
clean_ionic:
	clear
	docker rmi --force debian9_ionic:stable debian9_ionic:1 
clean_laravel: 
	clear
	docker rmi --force debian9_laravel:stable debian9_laravel:1 
clean_python2_7:
	clear
	docker rmi --force debian9_python2_7:stable debian9_python2_7:1
