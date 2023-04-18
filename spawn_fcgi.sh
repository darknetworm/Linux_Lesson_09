#Add line to spawn-fcgi
echo "SOCKET=/var/run/php-fcgi.sock" >> /etc/sysconfig/spawn-fcgi
echo 'OPTIONS="-u apache -g apache -s \$SOCKET -S -M 0600 -C 32 -F 1 -- /usr/bin/php-cgi"' >> /etc/sysconfig/spawn-fcgi
#Create spawn-fcgi unit
touch /etc/systemd/system/spawn-fcgi.service
echo "{Unit]" > /etc/systemd/system/spawn-fcgi.service
echo "Description=Spawn-fcgi startup service by Otus" >> /etc/systemd/system/spawn-fcgi.service
echo "After=network.target" >> /etc/systemd/system/spawn-fcgi.service
echo "[Service]" >> /etc/systemd/system/spawn-fcgi.service
echo "Type=simple" >> /etc/systemd/system/spawn-fcgi.service
echo "PIDFile=/var/run/spawn-fcgi.pid" >> /etc/systemd/system/spawn-fcgi.service
echo "EnvironmentFile=/etc/sysconfig/spawn-fcgi" >> /etc/systemd/system/spawn-fcgi.service
echo "ExecStart=/usr/bin/spawn-fcgi -n \$OPTIONS" >> /etc/systemd/system/spawn-fcgi.service
echo "KillMode=process" >> /etc/systemd/system/spawn-fcgi.service
echo "[Install]" >> /etc/systemd/system/spawn-fcgi.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/spawn-fcgi.service
#Reload units and start service
systemctl daemon-reload
systemctl start spawn-fcgi
