# !/bin/bash
echo "tunneling..."
/usr/bin/ssh -N -v -p 443 -c 3des root@192.168.1.1 -L 3389/192.168.1.1/3389 -L 12345/192.168.1.1/12345 -L 12346/192.168.1.1/12346 -L 49200/192.168.1.1/49200 -L 8888/192.168.1.1/8888 -L 1337/192.168.1.1/1337
/usr/bin/ssh -N -v -p 443 -g -C -c aes256-ctr -D 3128 root@45.76.221.144 -R 7777/192.168.1.1/22 -R 7778/192.168.1.1/443 -R 7779/192.168.1.145/22 -R 7780/192.168.1.1/80 -R 5900/192.168.1.145/5900 -R 7721/192.168.1.1/21 -R 6801:192.168.1.145:6800
echo "Done!"
