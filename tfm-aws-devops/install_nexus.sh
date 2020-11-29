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



