#! /bin/bash
sudo apt-get update
sudo apt install curl wget unzip -y
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>This servers hosts apache, maven,tomcat and sonarqube..Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
# Install Open Java 1.8
echo "Install Open Java 1.8" >/tmp/install-devops-tools.log
sudo apt-get install openjdk-8-jdk -y >/tmp/install-java.log
sudo java -version >>/tmp/install-devops-tools.log
# Install Maven
# https://linuxhint.com/install_apache_maven_ubuntu/
echo "Install Maven" >>/tmp/install-devops-tools.log
sudo apt install maven -y
sudo mvn -version >>//tmp/install-devops-tools.log
#Install Tomcat
echo "Install Tomcat" >>/tmp/install-devops-tools.log
cd /opt
sudo wget https://mirrors.estointernet.in/apache/tomcat/tomcat-9/v9.0.39/bin/apache-tomcat-9.0.39.zip
sudo unzip apache-tomcat-9.0.39.zip
cd /opt/apache-tomcat-9.0.39/bin
chmod u+x *.sh
#sh /opt/apache-tomcat-9.0.39/bin/startup.sh
ln -s /opt/apache-tomcat-9.0.39/bin/startup.sh /usr/bin/startTomcat
ln -s /opt/apache-tomcat-9.0.39/bin/shutdown.sh /usr/bin/stopTomcat

# Install AWS CLI
cd /tmp
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
sudo aws s3 cp s3://vg-devops/tomcat-users.xml /opt/apache-tomcat-9.0.39/conf/tomcat-users.xml
sudo aws s3 cp s3://vg-devops/context.xml.mgrapp /opt/apache-tomcat-9.0.39/webapps/manager/META-INF/context.xml
sudo aws s3 cp s3://vg-devops/context.xml.hostapp  /opt/apache-tomcat-9.0.39/webapps/host-manager/META-INF/context.xml
sudo startTomcat

# Install SonarQube Server
# Install SonarCube Server
cd /opt
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.8.zip
sudo unzip sonarqube-7.8.zip
sudo useradd sonar
sudo cp /etc/sudoers /etc/sudoers.0
sudo echo "sonar   ALL=(ALL)       NOPASSWD: ALL" >>/etc/sudoers
sudo chown -R sonar:sonar /opt/sonarqube-7.8/
sudo chmod -R 775 /opt/sonarqube-7.8/
su - sonar /opt/sonarqube-7.8/bin/linux-x86-64/sonar.sh start
