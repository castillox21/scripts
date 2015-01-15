#! /bin/bash

#This script launches a new ec2 instance using the input values.

clear

echo "Enter an instance type (t2.micro): "
read instance
echo "Your instance type is: $instance"

echo "Enter an image id (a8d369c0): "
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

aws ec2 run-instances --image-id ami-$imageid --count 1 --instance-type $instance --key-name $keypair --security-groups $group




