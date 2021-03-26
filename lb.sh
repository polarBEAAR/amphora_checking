#!/bin/bash

sum=0

for i in cmp007 cmp008 cmp009 cmp010 cmp011 cmp012 cmp013 cmp014
do 
value=$(openstack server list --all --host $i -c 'ID' -c 'Name' | grep amphora | wc -l)
let "sum = sum + value"
echo $value $sum
done

echo "sum = $sum"
