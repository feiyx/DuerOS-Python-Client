#!/bin/bash
#@author：feiyuanxing 【既然笨到家，就要努力到家】
#@date：2017-01-05
#@E-Mail：feiyuanxing@gmail.com
#@TARGET:一键安装hadoop 2.7.1 centos 64位 
#@CopyRight:本脚本遵守 未来星开源协议（http://feiyuanxing.com/kaiyuanxieyi/kaiyuanxieyi.html）


#DuerOS Python SDK
#1.暂停镜像版小度的服务，不然占用麦克风资源

#（个人觉得不必要取消小度自启动服务，因为每次开机都可以直接用小度。）
sudo systemctl stop duer
echo "已暂停镜像版小度的服务"

#2.安装所有需要的依赖
echo "开始安装所需要的依赖，有点慢，可以切换一下镜像源"
sudo apt-get install -y python-dateutil gir1.2-gstreamer-1.0 python-pyaudio libatlas-base-dev python-dev
sudo pip install tornado hyper
#3.下载安装OpenSSL和Python2.7.14

#  OpenSSL：链接: https://pan.baidu.com/s/1skAP6WH 密码: wknz

#  Python2.7.14：链接: https://pan.baidu.com/s/1o8MHkzK 密码: ngx4

sudo tar -zxvf openssl1.1.tar.gz -C /usr



sudo tar -zxvf python2.7.14.tar.gz -C /usr/local/
sudo rm -rf /usr/bin/python
sudo ln -s /usr/local/python2.7.14/bin/python /usr/bin/python
4.下载安装DuerOS Python SDK

git clone https://github.com/MyDuerOS/DuerOS-Python-Client.git
cd DuerOS-Python-Client
git checkout raspberry-dev
#5.创建自定义产品



#6.设置授权回调页

echo " 百度开发者中心：http://developer.baidu.com/"
# http://127.0.0.1:3000/authresponse
#7.合成音
#8.聊天定制（系统画像）
#注意：系统画像是更改一天后才生效。
#9.设置开发者ID和SECRET
#10.首次授权与唤醒
cd /home/pi/DuerOS-Python-Client/
#授权：（需要用到浏览器登录你的百度开发者账户）
 ./auth.sh
blob.png
echo "语音唤醒：
./wakeup_trigger_start.sh "
echo "回车唤醒：

./enter_trigger_start.sh "
echo "至此，你就可以使用DuerOS Python SDK 了！快喊小度小度吧！"

echo "11.修改唤醒词

    Snowboy的官方地址：https://snowboy.kitt.ai/
创建和训练自己的模型很简单，我这里直接使用已经有的“小白”。
下载地址：小白.pmdl"

cd /home/pi
#下载Snowboy Python

git clone https://github.com/Kitt-AI/snowboy.git
#下载、安装和配置swig-3.0.12

#下载地址：http://www.swig.org/download.html

#安装配置swig

sudo apt-get install g++//安装g++
sudo apt-get install libpcre3 libpcre3-dev //安装pcre
sudo tar -xzvf swig-3.0.12.tar.gz //解压swig
cd swig-3.0.12 //进入swig目录
echo "安装swig"
./configure --prefix=/usr/local/swig3.0.12
make
sudo make install
#//配置path
#sudo vim /etc/profile
#//在最后添加一行：PATH=/usr/local/swig3.0.12/bin:$PATH
#构建Snowboy
sudo echo "PATH=/usr/local/swig3.0.12/bin:$PATH" >> /etc/profile

cd /home/pi/snowboy/swig/Python
make
#获得Snowboy Python 的接口组件

cd /home/pi/snowboy/examples
#将examples文件夹下的Python文件夹改名为 snowboy

mv Python snowboy
#删除Python SDK 的app文件夹下的snowboy文件夹（建议先备份）

sudo rm -r /home/pi/DuerOS-Python-Client/app/snowboy
#将home/pi/Snowboy/examples/snowboy 复制或者移动到SDK的app文件夹下

sudo mv /home/pi/snowboy/examples/sonwboy /home/pi/DuerOS-Python-Client/app/
#建议使用指令移动文件(这样文件不会出现感叹号)，如果遇到感叹号，先删除文件夹，然后新建一个同名文件夹，再将文件夹里的东西全部复制过来。

#注意：如果有感叹号，表示是软链接文件，并且链接找不到真正的文件，继续运行会报错误：ImportError: No module named _snowboydetect

sudo rm -r /home/pi/DuerOS-Python-Client/app/sonwboy/resources
sudo rm /home/pi/DuerOS-Python-Client/app/sonwboy/snowboydetect.py
sudo rm /home/pi/DuerOS-Python-Client/app/sonwboy/_snowboydetect.so
sudo mkdir /home/pi/DuerOS-Python-Client/app/sonwboy/resources
sudo mv /home/pi/snowboy/examples/sonwboy/resources/* /home/pi/DuerOS-Python-Client/app/sonwboy/resources/
sudo mv /home/pi/snowboy/examples/sonwboy/snowboydetect.py /home/pi/DuerOS-Python-Client/app/sonwboy/
sudo mv /home/pi/snowboy/examples/sonwboy/_snowboydetect.so /home/pi/DuerOS-Python-Client/app/sonwboy/
image.png

#接下来就是修改Python SDK的代码了！

#（1）更换唤醒模型

#修改app/snowboy/snowboydecoder.py模块的__ init __（）函数

#（2）注释self.audio和self.stream_in


#（3）添加feed_data()方法


echo "（4）修改terminate()方法
重新授权，执行语音唤醒shell脚本( ./wakeup_trigger_start.sh )，即可喊“小白”唤醒！
大功告成！"