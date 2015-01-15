#! /bin/bash

#This script launches a new ec2 instance using the input values.

clear

echo "Is this an HVM image (y or n): "
read imagetype

if [ "$imagetype" = "y" ]; then
	imagetype="m3.medium"
else
	imagetype="t1.micro"
fi

echo "Enter your image ID (starting after ami-): "
read imageid
echo "Your AMI ID is: $imageid"

#Ran to show keypairs

aws ec2 describe-key-pairs

echo " "
echo "Enter one of your available keypairs (name): "
read keypair
echo "Your selected keypair is: $keypair"

echo "Enter a security group (default): "
read  group
echo "Your selected group is: $group" 

aws ec2 run-instances --image-id ami-$imageid --count 1 --instance-type $imagetype --key-name $keypair --security-groups $group




