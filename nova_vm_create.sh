#!/usr/bin/env bash

#如果你想openstack创建windows或者linux的虚拟机，可以选择使用该脚本。

glance image-list

read -p "please input the iamge name that you creat vm needed : " name1
#bash image-upload.sh $name1

image_id=`glance image-list | grep $name1 | awk '{print $2}'`

read -p "please input the virtual machine name that you want to create : " name2
#read -p "please input the virtual machine Size that you want to create [ windows = 80 linux = 40] (Unit G) : " size
while true;do
read -r -p "windows or linux? [w/l]" input
    case $input in
        [Ww][Ii][Nn][Dd][Oo][Ww][Ss]|[Ww]*) nova boot --flavor ecs.c2.large  --nic net-id=03fd90b7-6804-4290-9aef-ca1233041089 --image ${image_id}  --availability-zone nova --security-group default  --user-data /root/libaoshan/userdata/windows/userdata_win_05140953 --meta admin_user=Administrator --meta admin_pass=Y0v0le.com  --config-drive true  ${name2}; break;;
      [Ll][Ii][Nn][Uu][Xx][Ss]|[Ll]*)nova boot --flavor ecs.c1.large --nic net-id=03fd90b7-6804-4290-9aef-ca1233041089 --block-device source=image,id=$image_id,dest=volume,shutdown=remove,size=$size,bootindex=0 --availability-zone nova --security-group default --user-data /root/user_data  --config-drive true ${name2}; break;;
          *) echo "please answer windows or linux";;
esac
done

echo "vm creating ...."
sleep 10
nova list | grep $name1

vm_id=`nova list | grep $name2 |awk '{print $2}'`
nova get-vnc-console $vm_id novnc

