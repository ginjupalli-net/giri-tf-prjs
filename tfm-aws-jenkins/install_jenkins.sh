#! /bin/bash
sudo yum update -y
sudo yum install curl wget unzip -y
sudo yum install httpd -y
sudo systemctl enable httpd.service
sudo systemctl start httpd.service
echo "<h1>This is Jenkins Server..Deployed via Terraform</h1>" | sudo tee -a /var/www/html/index.html
echo "<h1>This is Redhat linux Server. Java version </h1>" | sudo tee -a /var/www/html/index.html

# Install Open Java 1.8
# echo "Install Open Java 1.8" >/tmp/install-devops-tools.log
# cd /opt
# sudo wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm
# sudo yum install jdk-8u131-linux-x64.rpm -y >/tmp/install-java.log
# sudo java -version >>/tmp/install-devops-tools.log



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

# Install Maven
# https://linuxhint.com/install_apache_maven_ubuntu/
echo "Install Maven" >>/tmp/install-devops-tools.log
sudo yum install maven -y
sudo mvn -version >>//tmp/install-devops-tools.log

# Install AWS CLI
cd /tmp
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/bin --install-dir /usr/aws --update


# Install Git
# https://www.atlassian.com/git/tutorials/install-git#linux
sudo sudo yum install git -y
# Install Terraform
# https://learn.hashicorp.com/tutorials/terraform/install-cli
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform

