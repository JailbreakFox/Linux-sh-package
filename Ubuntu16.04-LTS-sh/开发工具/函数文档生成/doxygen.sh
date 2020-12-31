# doxygen是一种从源代码生成文档的工具

#===========doxygen安装============
sudo apt install doxygen

# 使用方法
# 1.生成doxygen配置文件，默认名称为Doxyfile
# -s为simple，-g为generate
doxygen -g -s
# 2.根据配置文件生成文档
doxygen '配置文件名称'

# 常用配置
# DOXYFILE_ENCODING = UTF-8，默认编码为UTF-8，这样可以支持中文。
# PROJECT_NAME = “SerialPort”，项目名称，多个单词需要使用引号(“”)。
# PROJECT_NUMBER = “1.0 beta”，项目版本号。
# OUTPUT_DIRECTORY = serialport-html，输出文档的目录，如果为空，表示在当前目录，建议写上表示本工程的有意义的目录名称，比如我们就指定目录名称为serialport-html。
# OUTPUT_LANGUAGE = English，文档语言，可以指定为Chinese。
# IMAGE_PATH = image_dir，指定图片存放的目录，我们将图片放到当前目录下的image_dir目录中，因为我们的文档会出现测试图片示例。
# HTML_OUTPUT= . ，html输出目录名称，默认为html目录，如果为“.”则表明为上述OUTPUT_DIRECTORY目录。
# GENERATE_LATEX = NO，是否生成LaTeX，默认生成的，但我们不想生成。
# INPUT =xxx，代码文件或目录，多个文件(目录)需要以空格隔开，如果不指定，表示当前目录，但是，如果指定目录且当前目录有代码文件的话，需要使用点号(“.”)表示当前目录。
# FILE_PATTERNS=xxx，指定各种文件，我们常用为*.cpp *.c *.h，等等。