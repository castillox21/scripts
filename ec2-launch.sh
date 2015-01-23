#!/bin/bash

#This script launches a new ec2 instance using the input values.

clear

# Ask for instance type
echo "Enter an instance type (t2.micro): "
read instance
echo "Your instance type is: $instance"

# Ask for image id
echo "Enter an image id (a8d369c0): "
read imageid
echo "Your AMI ID is: $imageid"

# Show keypairs
aws ec2 describe-key-pairs

# Ask for key pair
echo " "
echo "Enter one of your available keypairs (name): "
read keypair
echo "Your selected keypair is: $keypair"

# Ask for security group
echo "Enter a security group (default): "
read  group
echo "Your selected group is: $group" 

# Remove any previous files
rm ./.instance-id.txt 2> /dev/null

# Create the AWS EC2 instance and output it to instance-id.txt
aws ec2 run-instances --image-id ami-$imageid --count 1 --instance-type $instance --key-name $keypair --security-groups $group >> ./.instance-id.txt

# Get the instance ID just created
INSTANCE_ID="$(cat ./.instance-id.txt | grep InstanceId | cut -d '"' -f4)"

echo $INSTANCE_ID

# Get your IP address
IP_ADD="$(curl -s icanhazip.com)"

echo $IP_ADD

# Add a rule for SSH to $group security group
aws ec2 authorize-security-group-ingress --group-name $group --protocol tcp --port 22 --cidr 0.0.0.0/0

