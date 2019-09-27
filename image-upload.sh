#!/usr/bin/env bash

UUID=`uuidgen`
dir='/root/libaoshan/'
pool="images"
qemu-img convert -O raw $dir/$1.qcow2 $dir/$1.raw
rbd import -c /etc/ceph/ceph.conf $dir/$1.raw $pool/$UUID
rbd snap create -c /etc/ceph/ceph.conf $pool/$UUID@snap
rbd snap protect -c /etc/ceph/ceph.conf $pool/$UUID@snap
FSID=`ceph -c /etc/ceph/ceph.conf fsid`
MD5_ID=`md5sum $dir/$1.raw | awk '{print $1}'`
#glance --os-image-api-version 1 image-create --id $UUID --name $1 --location rbd://$FSID/$pool/$UUID/snap --checksum $MD5_ID --disk-format raw --container-format bare --is-public True --is-protected false --property hw_scsi_model=virtio-scsi --property hw_disk_bus=scsi --property hw_qemu_guest_agent=yes --property os_require_quiesce=yes --property os_type=windows --property hypervisor_type=QEMU --property hw_video_model=vga --property hw_cpu_max_sockets=64
#glance --os-image-api-version 1 image-create --id $UUID --name $1 --location rbd://$FSID/$pool/$UUID/snap --checksum $MD5_ID --disk-format raw --container-format bare --is-public True --is-protected false --property hw_scsi_model=virtio-scsi --property hw_disk_bus=scsi --property hw_qemu_guest_agent=yes --property os_require_quiesce=yes --property os_type=windows --property hypervisor_type=QEMU --property hw_video_model=vga --property hw_cpu_max_sockets=8
#glance --os-image-api-version 1 image-create --id $UUID --name $1 --location rbd://$FSID/$pool/$UUID/snap --checksum $MD5_ID --disk-format raw --container-format bare --is-public True --is-protected false --property hw_scsi_model=virtio-scsi --property hw_disk_bus=scsi --property hw_qemu_guest_agent=yes --property os_require_quiesce=yes --property os_type=windows --property hypervisor_type=QEMU --property hw_video_model=vga --property hw_cpu_max_sockets=4
glance --os-image-api-version 1 image-create --id $UUID --name $1 --location rbd://$FSID/$pool/$UUID/snap --checksum $MD5_ID --disk-format raw --container-format bare --is-public True --is-protected false --property hw_scsi_model=virtio-scsi --property hw_disk_bus=scsi --property hw_qemu_guest_agent=yes --property os_require_quiesce=yes --property os_type=windows --property hypervisor_type=QEMU --property hw_video_model=vga
#glance --os-image-api-version 1 image-create --id $UUID --name $1 --location rbd://$FSID/$pool/$UUID/snap --checksum $MD5_ID --disk-format raw --container-format bare --is-public True --is-protected true  --property hw_qemu_guest_agent=yes --property os_require_quiesce=yes --property os_type=linux --property hypervisor_type=QEMU --property hw_video_model=vga
#glance --os-image-api-version 1 image-create --id $UUID --name $1 --location rbd://$FSID/$pool/$UUID/snap --checksum $MD5_ID --disk-format raw --container-format bare --is-public True --is-protected false --property hw_disk_bus=ide --property os_require_quiesce=yes --property os_type=linux --property hypervisor_type=QEMU --property hw_video_model=vga
