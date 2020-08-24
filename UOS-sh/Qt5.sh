#运行方式
#sh Qt5.sh

#===========Qt5安装==========
sudo apt install qtcreator qt5-default qtcreator-template-dtk g++ gdb openssh-server cmake astyle

# 打开qt——帮助——关于插件——搜beautifier——勾选后重启qt
# 打开qt——工具——选项——Kit——桌面（默认）
#    编译器：gcc 8(c x86 64bit /usr/bin);gcc 8(c++ x86 64bit /usr/bin)
#    qt版本：从下拉列表选择
#    CMake Tool: /usr/bin/cmake    如果没有选项，点Manager自己添加

# 打开qt——工具——选项——beautifier
#    General：不要钩
#    Artistic Style——Artistic sytle command:  /usr/bin/astyle
#    Artistic Style——use customized style: Add 添加，复制以下内容
#indent=spaces=4
#style=kr
#indent-labels
#pad-oper
#unpad-paren
#pad-header
#keep-one-line-statements
#convert-tabs
#indent-preprocessor
#align-pointer=name
#align-reference=name
#keep-one-line-blocks
#keep-one-line-statements
#attach-namespaces
#max-instatement-indent=120
