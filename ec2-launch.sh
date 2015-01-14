#! /bin/bash

#This script launches a new ec2 instance using the input values.

clear

echo "Enter your image ID (starting after ami-): "
read image
echo "Your AMI ID is: $image"

#Ran to show keypairs
ec2-describe-keypairs

echo " "
echo "Enter one of your available keypairs (name): "
read keypair
echo "Your selected keypair is: $keypair"

echo "Enter a security group (default): "
read  group
echo "Your selected group is: $group" 

aws ec2 run-instances --image-id ami-$image --count 1 --instance-type t1.micro --key-name $keypair --security-groups $group




