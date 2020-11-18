docker run -v $(readlink -f host):/host -it --cap-add SYS_ADMIN --device /dev/fuse --security-opt apparmor:unconfined albert 

