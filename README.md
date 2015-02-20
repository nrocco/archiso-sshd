# archiso-sshd

The archlinux live cd modified for remote installations over ssh


## building

Modify `airootfs/root/.ssh/authorized_keys` with your ssh public keys.

Now you can build the image using:

    make build
    
Or if you need to rebuild it:

    make rebuild


## using

To netboot this live image using pxe you can use the following kernel and initrd:

    work/iso/arch/boot/x86_64/vmlinuz
    work/iso/arch/boot/x86_64/archiso.img

and the arch linux installer root file system:

    work/iso/arch/x86_64/airootfs.sfs

An example ipxe boot file using http could like like this:

    #!ipxe
    dhcp
    kernel http://${gateway}/archiso/boot/x86_64/vmlinuz archisobasedir=archiso archiso_http_srv=http://${gateway}/ ip=:::::eth0:dhcp
    initrd http://${gateway}/archiso/boot/x86_64/archiso.img
    boot

More information on ipxe can be found on their website here
http://ipxe.org/scripting
