#!/bin/bash
cd /System/LSW-VM
qemu-system-x86_64										\
-enable-kvm											\
-cpu host,hv_relaxed,hv_vapic,hv_spinlocks=0x1fff,hv_time					\
-smp 2,sockets=1,cores=2,threads=1,maxcpus=2							\
-m 3G												\
-object iothread,id=io0										\
-device virtio-blk-pci,drive=disk0,iothread=io0							\
-drive if=none,id=disk0,cache=none,format=raw,aio=threads,file=disk.img				\
-nic user,id=eth0,model=virtio-net-pci,smb=/System/LSW-VM/Shared/				\
-device virtio-keyboard-pci									\
-device virtio-tablet-pci									\
-device virtio-balloon										\
-display gtk,gl=on										\
-vga virtio											\
-audiodev pipewire,id=audio0									\
-audio driver=pipewire,model=virtio								\
#-device qemu-xhci 										\
#-drive file=windows.iso,if=ide,index=1,media=cdrom						\
#-drive file=virtio.iso,if=ide,index=2,media=cdrom   	        				\
