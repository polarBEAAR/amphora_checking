#!/bin/bash

#touch list-amphora-lb.txt 
echo "" > list-amphora-lb.txt
echo "" > list-lb.txt
rm pr_*


openstack loadbalancer amphora list >> list-amphora-lb.txt
openstack loadbalancer list >> list-lb.txt


host='cmp007'
for host in cmp007 cmp008 cmp009 cmp010 cmp011 cmp012 cmp013 cmp014
do
for amphora_id in $(openstack server list --all --host $host -c 'ID' -c 'Name' | grep amphora | awk '{print $4}' | awk -F 'amphora-' '{print $2}' ) 
do 
lb_id=$(cat list-amphora-lb.txt | grep $amphora_id | awk '{print $4}')
lb_pr_id=$(cat list-lb.txt | grep $lb_id | awk '{print  $6}')
#touch pr_"${lb_pr_id}".txt
echo "$lb_id" >> pr_"${lb_pr_id}".txt
done
done



for filename in $(ls -la . | grep 'pr_' | grep -v 'pr_.txt' |  awk '{print $9}')
do 
pr_id=$(echo $filename | awk -F 'pr_' '{print $2}' | awk -F '.txt' '{print $1}')
pr_name=$(openstack project show $pr_id | grep name | awk '{print $4}')
#echo $pr_id  $pr_name
old_name="pr_${pr_id}.txt"
new_name="/root/amphoras/pr_${pr_name}.txt"
echo $old_name $new_name
mv $old_name $new_name
done
