DuerOS Python 版本客户端(app+sdk)，使用百度的DCS服务

## Python运行环境变量设置
        # export PYTHONPATH=xxx/MyAssistant:$PYTHONPATH

## 认证授权
        # python app/auth.py
## 按键[Enter]触发运行
        # python app/enter_main.py       
## 唤醒词[小度小度]触发运行
        ＃ python app/wakeup_main.py

## 唤醒模型更新
更换app/snowboy/xiaoduxiaodu.pmdl文件(当前的唤醒模型因为训练样板较少，唤醒率较低)