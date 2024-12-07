#!/bin/bash

# 欢迎界面函数
welcome_screen() {
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
    echo "0. 退出"
    echo ""
    read -p "请输入选项 [0-7]: " option
}