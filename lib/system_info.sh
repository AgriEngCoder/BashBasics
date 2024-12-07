#!/bin/bash

# 定义功能函数
get_hostname() {
    echo "主机名: $(hostname)"
}

get_os_version() {
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        echo "操作系统版本: $PRETTY_NAME"
    else
        echo "无法确定操作系统版本。"
    fi
}

get_kernel_version() {
    echo "内核版本: $(uname -r)"
}

get_cpu_info() {
    cpu_info=$(lscpu | grep "Model name" | awk -F': *' '{print $2}')
    if [ -z "$cpu_info" ]; then
        cpu_info=$(lscpu | grep "CPU(s)" | head -n 1 | awk -F': *' '{print $2}' ORS=' ' \
                   $(lscpu | grep "Model name" | awk -F': *' '{print $2}'))
    fi
    echo "CPU 信息: $cpu_info"
}

get_memory_info() {
    memory_info=$(free -h | awk '/^Mem:/ {printf "总内存: %s, 已用内存: %s, 空闲内存: %s\n", $2, $3, $4}')
    echo "$memory_info"
}

get_disk_info() {
    disk_info=$(df -h --total | awk 'END{print "磁盘使用情况: 总计: " $2 ", 已用: " $3 ", 可用: " $4}')
    echo "$disk_info"
}

get_all_info() {
    get_hostname
    get_os_version
    get_kernel_version
    get_cpu_info
    get_memory_info
    get_disk_info
}