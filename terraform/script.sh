#!/bin/bash
sudo yum update -y 
sudo yum install -y docker  
sudo systemctl enable docker 
sudo systemctl start docker  
sudo usermod -aG docker ec2-user 
username="dG9taXdhOTc6aiFxSzVGanYhVlpreG43"
password="dG9taXdhOTc6aiFxSzVGanYhVlpreG43"
sudo docker login -u "$username" -p "$password"

# install docker compose 
sudo curl -SL https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose 