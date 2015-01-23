#! /bin/bash

#This script launches a new ec2 instance using the input values.

clear

echo -e "Enter an instance type (t2.micro): \c"
read instance
if [ -z "$instance" ]; then
   instance=t2.micro
fi  
echo "Your instance type is: $instance"

echo -e "Enter an image id (a8d369c0): \c"
read imageid
if [ -z "$imageid" ]; then
   imageid=a8d369c0
fi   
echo "Your AMI ID is: $imageid"

aws ec2 describe-key-pairs #Command to show keypairs. 

echo " "
echo -e "Enter one of your available keypairs (name): \c"
read keypair
if [ -z "$keypair" ]; then
   echo "Aborting, You must enter a valid keypair!"
   exit 0
fi
echo "Your selected keypair is: $keypair"

echo -e "Enter a security group (default): \c"
read  group
if [ -z "$group" ]; then
   group=default
fi
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




