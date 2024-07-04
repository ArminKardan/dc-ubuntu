#!/bin/sh
URL="https://download.docker.com/linux/ubuntu/gpg"
STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" "$URL")
if [ "$STATUS" -eq 200 ]; then
sudo https_proxy=$(echo "$https_proxy") apt update
sudo apt install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo https_proxy=$(echo "$https_proxy") curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo https_proxy=$(echo "$https_proxy") apt-get update
sudo https_proxy=$(echo "$https_proxy") apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
else
  echo "The website is not reachable (Status: $STATUS)."
  echo "Network is dirty (Status: $STATUS)."
fi
