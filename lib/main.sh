#!/bin/bash

# 导入库文件
source ./lib/system_info.sh
source ./lib/display.sh

# 主程序开始
display

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
        0) echo "感谢使用，再见！"; exit 0 ;;
        *) echo "无效选项，请重新输入。" ;;
    esac
    echo ""
    read -p "按任意键继续..." keypress
done