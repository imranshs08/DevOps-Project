# Course : Maven and SonarQube for DevOps Engineers - Beginners Guide

ssh root@172.105.57.90

# Java Installation
```
sudo apt update
sudo apt install fontconfig openjdk-17-jre -y
java -version
```
# Jenkins Installation 2

```
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
sudo systemctl enable jenkins
```
Jenkins Username : admin

# Maven Installation Guide
```
wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
tar xvf apache-maven-3.9.6-bin.tar.gz 
sudo mv apache-maven-3.9.6 /opt/maven
```
Set Environment Variables:

Open your shell profile file (e.g., ~/.bashrc or ~/.zshrc ) in a text editor.

Add the following lines, replacing /opt/maven if you chose a different installation location:

```
export M2_HOME=/opt/maven 
export PATH=$M2_HOME/bin:$PATH

```
source ~/.bashrc  # Or source ~/.zshrc

```
```
mvn -version
Apache Maven 3.9.6 (bc0240f3c744dd6b6ec2920b3cd08dcc295161ae)
Maven home: /opt/maven
Java version: 17.0.10, vendor: Debian, runtime: /usr/lib/jvm/java-17-openjdk-amd64
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "5.10.0-28-amd64", arch: "amd64", family: "unix"
```

# SonarQube Installation Guide