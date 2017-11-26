#!/bin/bash -v
# Install & Configure Tomcat
sudo apt-get update
sudo apt-get -y dist-upgrade
sudo apt-get install -y default-jdk
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
cd /tmp
curl -O curl -O http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.23/bin/apache-tomcat-8.5.23.tar.gz
sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1
cd /opt/tomcat
sudo chgrp -R tomcat /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R tomcat webapps/ work/ temp/ logs/
echo "[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/jre
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target" | sudo tee -ai /etc/systemd/system/tomcat.service
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl status tomcat
sudo ufw allow 8080
#sudo systemctl enable tomcat

# Install & Configure Apache
sudo apt-get install -y apache2
sudo apache2ctl configtest
echo "ServerName 0.0.0.0" | sudo tee -ai /etc/apache2/apache2.conf
sudo apache2ctl configtest
sudo systemctl restart apache2
ufw allow in "Apache Full"

# Configure AJP
sudo apt-get install -y libapache2-mod-jk
sudo sed -i 's/^workers.tomcat_home.*/workers.tomcat_home=\/opt\/tomcat/g' /etc/libapache2-mod-jk/workers.properties
sudo sed -i '/^.*VirtualHost \*\:80.*/a \        JKMount \/* ajp13_worker' /etc/apache2/sites-enabled/000-default.conf
sudo apache2ctl configtest
sudo systemctl restart apache2
