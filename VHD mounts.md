
# Fix VM bug 

export LIBGUESTFS_BACKEND_SETTINGS=force_tcg

# Test tool will end with a success message

libguestfs-test-tool


guestmount --add  x.vhd -m /dev/sda1 --ro /mnt/vhd/


https://medium.com/@klockw3rk/mounting-vhd-file-on-kali-linux-through-remote-share-f2f9542c1f25
