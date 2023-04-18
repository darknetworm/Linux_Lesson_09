#Create watchlog file
touch /etc/sysconfig/watchlog
echo "# Configuration file for my watchlog service" > /etc/sysconfig/watchlog
echo "# Place it to /etc/sysconfig" >> /etc/sysconfig/watchlog
echo "# File and word in that file that we will be monit" >> /etc/sysconfig/watchlog
echo "WORD='ALERT'" >> /etc/sysconfig/watchlog
echo "LOG=/var/log/watchlog.log" >> /etc/sysconfig/watchlog
#Create watchlog.log file
touch /var/log/watchlog.log
echo "WARNING MESSAGE HELLO ALERT ERROR" > /var/log/watchlog.log
#create watchlog.sh script
touch /opt/watchlog.sh
echo "#!/bin/bash" > /opt/watchlog.sh
echo "WORD=\$1" >> /opt/watchlog.sh
echo "LOG=\$2" >> /opt/watchlog.sh
echo "DATE=\`date\`" >> /opt/watchlog.sh
echo "if grep \$WORD \$LOG &> /dev/null" >> /opt/watchlog.sh
echo "then" >> /opt/watchlog.sh
echo "logger \$DATE': I found word, Master!'" >> /opt/watchlog.sh
echo "else" >> /opt/watchlog.sh
echo "exit 0" >> /opt/watchlog.sh
echo "fi" >> /opt/watchlog.sh
#Chenge privelege for watchlog.sh
chmod +x /opt/watchlog.sh
#Create Watchlog service unit
touch /etc/systemd/system/watchlog.service
echo "[Unit]" > /etc/systemd/system/watchlog.service
echo "Description=My watchlog service" >> /etc/systemd/system/watchlog.service
echo "[Service]" >> /etc/systemd/system/watchlog.service
echo "Type=oneshot" >> /etc/systemd/system/watchlog.service
echo "EnvironmentFile=/etc/sysconfig/watchlog" >> /etc/systemd/system/watchlog.service
echo "ExecStart=/opt/watchlog.sh \$WORD \$LOG" >> /etc/systemd/system/watchlog.service
#Create Watchlog service timer
touch /etc/systemd/system/watchlog.timer
echo "[Unit]" > /etc/systemd/system/watchlog.timer
echo "Description=Run watchlog script every 30 second" >> /etc/systemd/system/watchlog.timer
echo "[Timer]" >> /etc/systemd/system/watchlog.timer
echo "# Run every 30 second" >> /etc/systemd/system/watchlog.timer
echo "OnUnitActiveSec=30" >> /etc/systemd/system/watchlog.timer
echo "Unit=watchlog.service" >> /etc/systemd/system/watchlog.timer
echo "[Install]" >> /etc/systemd/system/watchlog.timer
echo "WantedBy=multi-user.target" >> /etc/systemd/system/watchlog.timer
#Reload units and start timer
systemctl daemon-reload
systemctl start watchlog.timer watchlog.service
