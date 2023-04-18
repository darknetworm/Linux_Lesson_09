# Add line to httpd.service
echo "EnvironmentFile=/etc/sysconfig/httpd-%I" >> /usr/lib/systemd/system/httpd.service
# Add environment files
touch /etc/sysconfig/httpd-first
echo "OPTIONS=-f conf/first.conf" > /etc/sysconfig/httpd-first
touch /etc/sysconfig/httpd-second
echo "OPTIONS=-f conf/second.conf" > /etc/sysconfig/httpd-second
#Copy httpd config files
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/first.conf
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/second.conf
# Change options in second httpd config files
echo "PidFile /var/run/httpd-second.pid" >> /etc/httpd/conf/second.conf
sed -i 's/80/8080/g' /etc/httpd/conf/second.conf
# Reload units and start 2 instances of httpd service
systemctl daemon-reload
systemctl start httpd@first httpd@second
