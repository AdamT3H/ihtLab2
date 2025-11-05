#!/bin/bash

# === Конфігурація ===
AMI_ID="ami-0360c520857e3138f"
INSTANCE_TYPE="t3.micro"
KEY_NAME="iht-key-pair"
SECURITY_GROUP_ID="sg-01a6b8a9bb5bd52b9"
USER_DATA_PATH="/user-data.sh*"
REGION="us-east-1"

echo "=== Створення EC2 інстансу ==="

aws ec2 run-instances \
  --image-id $AMI_ID \
  --count 1 \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --security-group-ids $SECURITY_GROUP_ID \
  --user-data $USER_DATA_PATH \
  --region $REGION \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=iht-instance}]'

echo "=== Очікування запуску інстансу... ==="

INSTANCE_ID=$(aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=iht-instance" \
  --query "Reservations[].Instances[?State.Name=='pending' || State.Name=='running'].InstanceId" \
  --output text | head -n 1 | tr -d '\r')

aws ec2 wait instance-running --instance-ids $INSTANCE_ID --region $REGION

echo "=== Отримання публічної IP адреси ==="
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --query "Reservations[*].Instances[*].PublicIpAddress" \
  --output text)

echo "Інстанс успішно запущено!"
echo "Instance ID: $INSTANCE_ID"
echo "Public IP: $PUBLIC_IP"
echo
echo "Для підключення виконай:"
echo "ssh -i ~/Desktop/iht-default/iht-key-pair.pem ubuntu@$PUBLIC_IP"
echo
echo "Або відкрий у браузері:"
echo "http://$PUBLIC_IP/"

ssh -i ~/Desktop/iht-default/iht-key-pair.pem ubuntu@$PUBLIC_IP
