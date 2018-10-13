#!/bin/bash

read -p "VM Name: " VM
read -p "ISO file: " OS_ISO
read -p "Memory(In MB): " MEMORY
read -p "HDD size(In MB): " DISK_SIZE
read -p "VRAM size(In MB): " VRAM_SIZE


vboxmanage createhd --filename $VM.vdi --size $DISK_SIZE
vboxmanage createvm --name $VM --ostype "Linux_64" --register
vboxmanage storagectl $VM --name "SATA Controller" --add sata --controller IntelAHCI
vboxmanage storageattach $VM --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $VM.vdi
vboxmanage storagectl $VM --name "IDE Controller" --add ide
vboxmanage storageattach $VM --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium $OS_ISO
vboxmanage modifyvm $VM --ioapic on 
vboxmanage modifyvm $VM --boot1 dvd --boot2 disk --boot3 none --boot4 none
vboxmanage modifyvm $VM --memory $MEMORY --vram $VRAM_SIZE
vboxmanage modifyvm $VM --nic1 bridged --bridgeadapter1 eno2

mv $VM.vdi $VM/
