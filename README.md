# Linux_Lesson_09
System initialization, Systemd

В Vagrant-файле используется ОС CentOS 8. В процессе инициализации встроенными скриптами отключается SELinux и устанавливаются необходимые пакеты (для spawn-fcgi и httpd-инстансов). Подключаемыми в Vagrant-файле внешними скриптами создаются, модифицируются и запускаются модули:


watchlog.sh - сервис, который раз в 30 секунд мониторит лог (/var/log/watchlog.log) на предмет наличия ключевого слова, которое задается в /etc/sysconfig/watchlog. Состоит из непосредственно сервиса (watchlog.service) и таймера  срабатывания (watchlog.timer). Сервис запускает скрипт /opt/watchlog.sh.

spawn_fcgi.sh - создает сервис (spawn-fcgi.service), для запуска удаленных и локальных процессов FastCGI.


multi_httpd.sh - дополняет юнит-файл httpd возможностью запустить и запускает 2 инстанса сервера (httpd@first и  httpd@second) с разными конфигурациями (first.conf - порт 80 и second.conf - порт 8080).
