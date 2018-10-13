!#/bin/bash

read -p "VM Name: " VM
read -p "Path to ISO: " OS_ISO
read -p "Memory(In MB): " MEMORY

#VM='CentOS-Server'
#OS_ISO='/home/daniel/ISOs/centOS.iso'
#MEMORY=4096

vboxmanage createhd --filename $VM.vdi --size 32768
vboxmanage createvm --name $VM --ostype "Linux_64" --register
vboxmanage storagectl $VM --name "SATA Controller" --add sata --controller IntelAHCI
vboxmanage storageattach $VM --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $VM.vdi
vboxmanage storagectl $VM --name "IDE Controller" --add ide
vboxmanage storageattach $VM --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium $OS_ISO
vboxmanage modifyvm $VM --ioapic on 
vboxmanage modifyvm $VM --boot1 dvd --boot2 disk --boot3 none --boot4 none
vboxmanage modifyvm $VM --memory $MEMORY --vram 16
vboxmanage modifyvm $VM --nic1 bridged --bridgeadapter1 eno2


