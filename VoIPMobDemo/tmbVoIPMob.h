//
//  tmbVoIPMob.h
//  tmbVoIPMob
//
//  Created by sherwin on 15-6-12.
//  Copyright (c) 2015年 sherwin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SH_VOIP [TMBVoIPMob shareInstance]

typedef enum : NSUInteger {
    TMBCallOutgoingInit,     //呼出初使化完成
    TMBCallOutgoingRinging,  //呼出响铃中,等待对方接通
    TMBCallConnected,        //通话线路建立连接,可进行语音或视频通话
    TMBCallPausedByRemote,   //暂停通话
    TMBCallError,            //呼叫失败
    TMBCallEnd,              //通话结束
    TMBCallNone              //无状态
}TMBCallState;

typedef enum : NSUInteger {
    TMBLoginNone,     //无状态
    TMBLoginProgress, //正在登陆处理中
    TMBLoginOk,       //成功登陆SIP服务器
    TMBLoginCleared,  //登出SIP服务器
    TMBLoginFailed,   //登陆SIP服务器失败
    TMBLoginVerify    //SIP账号验证通过
}TMBLoginState;

typedef NS_ENUM(NSInteger, TMBVoIPCallSessionType){
    TMBVoIPCallSessionTypeAudio       = 0,
    TMBVoIPCallSessionTypeVideo,
    TMBVoIPCallSessionTypeVideoRoom,
    TMBVoIPCallSessionTypeContent,
};

@class TMBVoIPMob;


/*!
 @class
 @brief 本代理主要声明实时通话的回调操作以及状态信息。
 @discussion
 */
@protocol TMBVoIPMobDelegate <NSObject>

/*!
 @method
 @brief      登陆状态更新,包括登陆后，各种状态的回调信息
 @param tmbVoIPMob  实时通话VoIP单例
 @param callState   登陆过程中的回调状态,可参考 @(TMBLoginState)
 @param stateStr    登陆状态附属说明
 @discussion
 @result
 */
- (void) tmbVoIPMob:(TMBVoIPMob*) tmbVoIPMob
   loginStateUpdate:(TMBLoginState) loginState
           stateStr:(NSString*) stateStr;

//! 呼出状态回调
- (void) tmbVoIPMob:(TMBVoIPMob*)tmbVoIPMob
callOutgoingStateUpdate:(TMBCallState) callState
       callPhoneNum:(NSString*)callPhoneNum;

//! 有新的呼入
- (void) tmbVoIPMob:(TMBVoIPMob*)tmbVoIPMob
callIncomingReceived:(NSString*)callPhoneNum
           nickName:(NSString*)callNickName
    callSessionType:(TMBVoIPCallSessionType)callSessionType;

//! 视频接通显示
- (void) didCallForRemoteVideoConnected;

@end

/*
 @class
 @brief 本类为lib的主接口类声明，功能包括库的管理(启动，消毁，验证)/ 实时通话、音视频通话操作等功能。
 @discussion SDK集成进工程后, 最先使用的类, 所有的类对象, 均是通过这个单实例来获取, 示例代码如下:[TMBVoIPMob shareInstance]，也可使用宏头 [SH_VOIP] 一键操作.
 */
@interface TMBVoIPMob : NSObject

//@property (nonatomic, assign,setter=setSpeakerEnabled:) BOOL speakerEnabled;
//@property (nonatomic, assign,setter=setVideoEnabled:) BOOL videoEnabled;
@property (nonatomic, assign) id<TMBVoIPMobDelegate> delegate;

+ (TMBVoIPMob*)shareInstance;

-(void) startLibVoIPMob;
-(void) destroyLibVoIPMob;

/*
 @method
 @brief      使用用户账号,登陆VoIP服务器.可在 @select(tmbVoIPMob:loginStateUpdate:stateStr:) 代理中收到状态更新消息
 @discussion 登陆成功后，将会保护与服务器的长连接.同时会有状态消息更新。使用该方法前，请先调用 startLibVoIPMob 方法.
 @param      username 消息接收方
 @param      password 消息体列表
 @result     无返回值，可在TMBVoIPMobDelegate 监听回调 @select(tmbVoIPMob:loginStateUpdate:stateStr:)
 */
-(void) loginVoIPWithUserName:(NSString*)username
                     password:(NSString*)password;

//! 音视呼叫
- (void) call:(NSString *)callPhone displayName:(NSString*)displayName callType:(TMBVoIPCallSessionType) callType;


//! 接受呼入
- (void) acceptCall:(NSString*) callPhoneNum;

//! 拒绝呼入
- (void) declineCall:(NSString*) callPhoneNum;


/*
 @method
 @brief      设置视频通话的视频展示视图
 @discussion 视频通话时的远程和本地视频显示视图,函数采取指针弱引用,注意释放问题.
 @param      remoteView  远程视频显示视图(即对方的设备摄像头视频)
 @param      loctionView 设备本地摄像头采集的视频,可调用 @select(switchVideoCamera) 方法进行前后摄向头的切换
 @result     无返回值，注意  remoteView，loctionView 内存释放问题,tmbVoIPMob只对其进行弱引用。
 */
- (void) setRemoteVideoView:(UIView*) remoteView loctionVideoView:(UIView*) loctionView;


/*
 @method
 @brief      判断当前是否有正在运行中的通话
 @discussion 状态可为，接通、等待、呼叫.
 @result     如果有运行中的通话则返回YES, 否则返回NO.
 */
- (BOOL) isRunCallForCurrent;
- (TMBCallState) getCallStateWithCall:(NSString*)callPhoneNum;

- (void) setSpeakerEnabled:(BOOL)enable;
- (void) setVideoEnabled:(BOOL)enable;
- (void) setMicroEnable:(BOOL)enable;

/*
 @method
 @brief      获取当前使用摄像头设备是前置还是后置
 @discussion 前置为 Front, 后置为 Back
 @result     如果为后置(Back),则返回YES 如果为前置(Front),则返回NO.
 */
- (BOOL) isVideoCameraBackOrFront;

/*
 @method
 @brief      切换当前所使用的摄像头设备.
 @discussion 如需判断当前所使用的摄像头设备，可使用 @select(isVideoCameraBackOrFront) 进行获取
 @result     无返回值,切换过程中，需要等待.
 */
- (void) switchVideoCamera;



@end




