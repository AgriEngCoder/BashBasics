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
    echo "1. 获取系统基本信息"
    echo "2. 更新脚本"
    echo "3. 卸载脚本"
    echo "0. 退出"
    echo ""
    read -p "请输入选项 [0-3]: " option
}

# 系统基本信息函数
server_information() {
    # 获取主机名
    echo "主机名: $(hostname)"
    # 当前登录用户
    echo "当前登录用户: $(whoami)"
    # 获取网口信息
    echo "网口信息: $(ip a)"
    # 运行时间
    echo "运行时间: $(uptime | awk -F'up ' '{print $2}')"
    # 获取操作系统版本
    echo "操作系统版本: $(cat /etc/os-release | grep "PRETTY_NAME" | awk -F'=' '{print $2}' | sed 's/"//g')"
    # 获取内核版本
    echo "内核版本: $(uname -r)"
    # 获取CPU信息
    echo "CPU信息: $(lscpu | grep "Model name" | awk -F':' '{print $2}' | sed 's/^ *//')"
    # 获取内存使用情况
    echo "内存使用情况: $(free -h | awk '/^Mem:/ {printf "总内存: %s, 已用内存: %s, 空闲内存: %s\n", $2, $3, $4}')"
    # 获取磁盘使用情况
    echo "磁盘使用情况: $(df -h | awk '$NF=="/"{printf "总磁盘空间: %s, 已用磁盘空间: %s, 空闲磁盘空间: %s\n", $2, $3, $4}')"
    # 系统负载
    echo "系统负载: $(top -bn1 | grep "load average" | awk '{print $10 $11 $12}')"
    # 防火墙状态
    echo "防火墙状态: $(ufw status)"
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
        exit 0  # 立即退出脚本
    else
        echo "卸载失败，请手动删除脚本文件。"
    fi
}

# 主程序开始
welcome

while true; do
    show_menu
    case $option in
        1) server_information ;;
        2) update_script ;;
        3) uninstall_script ;;
        0) echo "感谢使用，再见！"; exit 0 ;;
        *) echo "无效选项，请重新输入。" ;;
    esac
    echo ""
    read -p "按任意键继续..." keypress
done