//*************************************************************
//* 创建者：陈胜  chensheng12330@qq.com
//* 创建时间： 2015.07.07
//* 修改时间： 2015.07.09
//* 当前版本： v2.0
//* 文档名称： VoIP视频通话Demo相关说明
//* 文档说明：  
//*************************************************************

1、引入库—Frameworks ，最低支持 IOS-6.0, 
————————————————————————
libz.dylib
libc++.1.dylib
libsqlite3.dylib
libstdc++.6.dylib
libresolv.dylib
AssetsLibrary.framework
AudioToolbox.framework
AVFoundation.framework
CFNetwork.framework
CoreAudio.framework
CoreGraphics.framework
CoreMedia.framework
CoreTelephony.framework
CoreVideo.framework 
Foundation.framework
MediaPlayer.framework
MessageUI.framework 
MobileCoreServices.framework
OpenGLES.framework
QuartzCore.framework
SystemConfiguration.framework

libtmbVoIPMob.a  （SIP音视频通话SDK,支持 base64,arm7,x86-64）
————————————————————————

2、基本说明
基于Liphone 开源项目来搭建的 SDK.
其中SIP底层协议层库的配置分在了 tvmCommon类里，经过实验，可以正常的运行，
@select(getlinphonercFilePath)         基本的SIP配置，初使化时加入.
@select(getlinphonerc_factoryFilePath) 不同工厂类的配置载入，可以忽略这个配置
@select(getlinphonerc_WizardFilePath)  一些特殊的配置.

解决了 ice的呼叫IP地址跳到国外IP问题，
另外，使用视频编解码格式为vp8,mp4.


3、遗留的问题
当前编辑时间： 2015.11.10  版本号：v2.0

//********************************
//*a.音频/视频通话互转.
//*b.多人呼叫通话处理.
//*c.sip消息能力添加.
//********************************