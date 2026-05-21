#!/bin/bash
# Ye IP ab kabhi nahi badlegi
TARGET_IP="13.232.171.125"

echo "Deploying to Permanent IP: $TARGET_IP..."

ssh -i ~/Downloads/rishi-aws-key.pem ubuntu@$TARGET_IP << EOF
  cd three-tier-web-applications
  git pull
  sudo docker-compose up -d --build
EOF

echo "Project is live at: http://$TARGET_IP"
