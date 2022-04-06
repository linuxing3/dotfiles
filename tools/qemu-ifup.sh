#!/bin/sh
 
echo sudo tunctl -u $(id -un) -t $1
 
sudo tunctl -u $(id -un) -t $1
echo sudo ifconfig $1 0.0.0.0 promisc up
sudo ifconfig $1 0.0.0.0 promisc up
echo sudo brctl addif br0 $1
sudo brctl addif br0 $1
echo brctl show
brctl show
 
sudo ifconfig br0 192.168.76.241

# （首先确定你的机器支持 TAP/TUN 虚拟设备）
# 
# 既然要搭桥，先把工具准备好，安装如下软件
# 
# apt-get install bridge-utils        # 虚拟网桥工具
# apt-get install uml-utilities       # UML（User-mode linux）工具

# 然后新建一座桥(添加网桥，大部分操作都需要 root 权限)：

# ifconfig enp125s0f0 down           # 首先关闭宿主机网卡接口
# brctl addbr br0                    # 添加一座名为 br0 的网桥
# brctl addif br0 enp125s0f0         # 在 br0 中添加一个接口
# brctl stp br0 off                  # 如果只有一个网桥，则关闭生成树协议
# brctl setfd br0 1                  # 设置 br0 的转发延迟
# brctl sethello br0 1               # 设置 br0 的 hello 时间
# ifconfig br0 0.0.0.0 promisc up    # 启用 br0 接口
# ifconfig enp125s0f0 0.0.0.0 promisc up    # 启用网卡接口
# dhclient br0                        # 从 dhcp 服务器获得 br0 的 IP 地址
# brctl show br0                      # 查看虚拟网桥列表
# brctl showstp br0                   # 查看 br0 的各接口信息

# 创建一个 TAP 设备，作为 QEMU 一端的接口：

# tunctl -t kvm0 -u root              # 创建一个 kvm0 接口，只允许 root 用户访问
# brctl addif br0 kvm0                # 在虚拟网桥中增加一个 kvm0 接口
# ifconfig kvm0 0.0.0.0 promisc up    # 启用 kvm0 接口
# brctl showstp br0                   # 显示 br0 的各个接口