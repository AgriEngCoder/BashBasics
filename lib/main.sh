#!/bin/bash

# 欢迎界面函数
welcome() {
    clear
    echo "=================================="
    echo "  欢迎来到系统信息获取工具  "
    echo "=================================="
    echo "此工具可以帮助您轻松获取系统的各种信息。"
    echo ""
}

# 显示菜单函数
show_menu() {
    echo "请选择一个选项:"
    echo "1. 获取主机名"
    echo "2. 获取操作系统版本"
    echo "3. 获取内核版本"
    echo "4. 获取CPU信息"
    echo "5. 获取内存使用情况"
    echo "6. 获取磁盘使用情况"
    echo "7. 获取所有信息"
    echo "8. 更新脚本"
    echo "9. 卸载脚本"
    echo "0. 退出"
    echo ""
    read -p "请输入选项 [0-9]: " option
}

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

# 更新脚本
update_script() {
    echo "正在检查更新..."
    # 使用 wget 或 curl 命令下载更新脚本
    wget -O temp_main.sh https://raw.githubusercontent.com/AgriEngCoder/BashBasics/main/lib/main.sh
    # 检查下载是否成功
    if [ $? -eq 0 ]; then
        echo "更新脚本下载成功，正在执行更新..."
        chmod +x temp_main.sh
        ./temp_main.sh
        rm temp_main.sh
    else
        echo "更新失败，请检查网络连接。"
    fi
}

# 卸载脚本
uninstall_script() {
    echo "正在卸载脚本..."
    # 使用 rm 命令删除脚本文件
    rm -rf main.sh
    # 检查删除是否成功
    if [ $? -eq 0 ]; then
        echo "脚本卸载成功！"
    else
        echo "卸载失败，请手动删除脚本文件。"
    fi
}

# 主程序开始
welcome

while true; do
    show_menu
    case $option in
        1) get_hostname ;;
        2) get_os_version ;;
        3) get_kernel_version ;;
        4) get_cpu_info ;;
        5) get_memory_info ;;
        6) get_disk_info ;;
        7) get_all_info ;;
        8) update_script ;;
        9) uninstall_script ;;
        0) echo "感谢使用，再见！"; exit 0 ;;
        *) echo "无效选项，请重新输入。" ;;
    esac
    echo ""
    read -p "按任意键继续..." keypress
done