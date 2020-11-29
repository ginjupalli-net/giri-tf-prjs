#! /bin/bash
sudo yum update -y
sudo yum install curl wget unzip -y
sudo yum install httpd -y
sudo systemctl enable httpd.service
sudo systemctl start httpd.service
echo "<h1>This is nexus Server..Deployed via Terraform</h1>" | sudo tee -a /var/www/html/index.html
echo "<h1>This is Redhat linux Server. Java version </h1>" | sudo tee -a /var/www/html/index.html
# Install Open Java 1.8
echo "Install Open Java 1.8" >/tmp/install-devops-tools.log
cd /opt
sudo wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm
sudo yum install jdk-8u131-linux-x64.rpm -y >/tmp/install-java.log
sudo java -version >>/tmp/install-devops-tools.log

# Update AWS CLI
cd /tmp
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/bin --install-dir /usr/aws --update

#Install Tomcat
echo "Install Tomcat" >>/tmp/install-devops-tools.log
cd /opt
sudo wget https://mirrors.estointernet.in/apache/tomcat/tomcat-9/v9.0.40/bin/apache-tomcat-9.0.40.zip
sudo unzip apache-tomcat-9.0.40.zip
cd /opt/apache-tomcat-9.0.40/bin
chmod u+x *.sh
#sh /opt/apache-tomcat-9.0.40/bin/startup.sh
# ln -s /opt/apache-tomcat-9.0.40/bin/startup.sh /usr/bin/startTomcat
# ln -s /opt/apache-tomcat-9.0.40/bin/shutdown.sh /usr/bin/stopTomcat
sudo aws s3 cp s3://vg-devops/tomcat-users.xml /opt/apache-tomcat-9.0.40/conf/tomcat-users.xml
sudo aws s3 cp s3://vg-devops/server.xml /opt/apache-tomcat-9.0.40/conf/server.xml
sudo aws s3 cp s3://vg-devops/context.xml.mgrapp /opt/apache-tomcat-9.0.40/webapps/manager/META-INF/context.xml
sudo aws s3 cp s3://vg-devops/context.xml.hostapp  /opt/apache-tomcat-9.0.40/webapps/host-manager/META-INF/context.xml
# Creating Tomcat Service
# https://help.talend.com/reader/mup8qWz8cQ9XKNTAAN4~Tg/b_qVBTTIBMSa9YR0uV91pgls -
sudo aws s3 cp s3://vg-devops/tomcat.service /etc/systemd/system/tomcat.service
sudo chmod 664 /etc/systemd/system/tomcat.service
sudo systemctl enable tomcat.service
sudo systemctl start tomcat.service
sudo systemctl status tomcat.service

# Install SonarQube Server
cd /opt
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.8.zip
sudo unzip sonarqube-7.8.zip
sudo useradd sonar
sudo cp /etc/sudoers /etc/sudoers.0
sudo echo "sonar   ALL=(ALL)       NOPASSWD: ALL" >>/etc/sudoers
sudo chown -R sonar:sonar /opt/sonarqube-7.8/
sudo chmod -R 775 /opt/sonarqube-7.8/
#su - sonar /opt/sonarqube-7.8/bin/linux-x86-64/sonar.sh start
sudo aws s3 cp s3://vg-devops/sonarqube.service /etc/systemd/system/sonarqube.service
sudo chmod 664 /etc/systemd/system/sonarqube.service
sudo systemctl enable sonarqube.service
sudo systemctl start sonarqube.service
sudo systemctl status sonarqube.service

# Install Nexus Server
cd /opt
sudo wget http://download.sonatype.com/nexus/3/nexus-3.28.1-01-unix.tar.gz
sudo tar -zxvf nexus-3.28.1-01-unix.tar.gz
mv /opt/nexus-3.28.1-01 /opt/nexus
sudo useradd nexus
sudo cp /etc/sudoers /etc/sudoers.0
sudo echo "nexus ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work
sudo chmod -R 775 /opt/nexus
sudo chmod -R 775 /opt/sonatype-work
sudo echo "run_as_user="nexus"" > /opt/nexus/bin/nexus.rc
ln -s /opt/nexus/bin/nexus /etc/init.d/nexus
sudo systemctl enable nexus
sudo systemctl start nexus

# # Install Maven -- Not requried. Maven is installed through jenkins tools
# # https://linuxhint.com/install_apache_maven_ubuntu/
# echo "Install Maven" >>/tmp/install-devops-tools.log
# sudo yum install maven -y
# sudo mvn -version >>//tmp/install-devops-tools.log

# Install Git
# https://www.atlassian.com/git/tutorials/install-git#linux
sudo sudo yum install git -y

# Install Terraform
# https://learn.hashicorp.com/tutorials/terraform/install-cli
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform

# Install Jenkins server
# https://www.jenkins.io/doc/book/installing/linux/
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade
sudo yum install jenkins java-1.8.0-openjdk-devel -y
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl status jenkins
