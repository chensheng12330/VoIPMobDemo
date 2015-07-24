//
//  FirstViewController.m
//  VoIPMobDemo
//
//  Created by sherwin on 15-6-15.
//  Copyright (c) 2015年 sherwin. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<TMBVoIPMobDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.remoteView = [[UIView alloc] initWithFrame:self.view.frame];
    
    [self.view insertSubview:self.remoteView atIndex:0];
    
    
    SH_VOIP.delegate = self;
    
    //[SH_VOIP setMicroEnable:YES];
    //[SH_VOIP setSpeakerEnabled:YES];
    
    return;
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    SH_VOIP.delegate = self;
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    SH_VOIP.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)voipLoginAction:(id)sender {
    
    [SH_VOIP loginVoIPWithUserName:@"13548583222" password:@"123456"];
}


- (void) tmbVoIPMob:(TMBVoIPMob*)tmbVoIPMob
   loginStateUpdate:(TMBLoginState)  callState
           stateStr:(NSString*) stateStr
{
    NSString *message=stateStr;
    
    switch (callState) {
        case TMBLoginOk:
        {
            message = @"SIP服务器登陆成功.";
            
            [SH_VOIP setRemoteVideoView:self.remoteView loctionVideoView:self.locationView];
            
            break;
        }
            
        case TMBLoginNone:
            message = @"";break;
        case TMBLoginCleared:
            message =  @"与SIP服务器失去连接."; break;
        case TMBLoginFailed:
            message =  @"SIP服务器登陆失败."; break;
        case TMBLoginProgress:
            message =  @"正在登陆中..."; break;
        default: break;
    }
    
    [self.lbCallStatus setText:message];
    
    NSLog(@"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<%@", message);
}

//! 呼出状态回调
- (void) tmbVoIPMob:(TMBVoIPMob*)tmbVoIPMob
callOutgoingStateUpdate:(TMBCallState) callState
       callPhoneNum:(NSString*)callPhoneNum
{
    NSString *info = @"未知状态,忽略掉.";
    switch (callState) {
        case TMBCallOutgoingInit:
            info = @"正在拨出通话...";
            break;
        case TMBCallOutgoingRinging:
            info = @"对方收到拨号请求，响铃中,等待对方接听...";
            break;
        case TMBCallConnected:
            info = @"通话已连接,可进行音视频通话.";
            break;
        case TMBCallError:
            info = @"呼叫失败.";
            break;
        case TMBCallEnd:
            info = @"通话中断，或已结束.断开通话连接. 可做相关的处理工作。";
            break;
            
        case TMBCallNone:
        default:
            break;
    }
     NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>%@", info);
    
    [self.lbLog setText:info];
    return;
}


//! 有新的呼入
- (void) tmbVoIPMob:(TMBVoIPMob*)tmbVoIPMob
callIncomingReceived:(NSString*)callPhoneNum
           nickName:(NSString*)callNickName
    callSessionType:(TMBVoIPCallSessionType)callSessionType
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"有新电话呼入" delegate:self cancelButtonTitle:@"拒绝" otherButtonTitles:@"接听", nil];
    
    [alertView show];
    
    return;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        [self rejectAction:nil];
    }
    else
    {
        [self acceptAction:nil];
    }
}


- (IBAction)callAction:(id)sender {
    //SH_VOIP cal
    
    //[SH_VOIP call:@"15074865225" displayName:@"huying"];
    //[SH_VOIP call:@"15074865225" displayName:@"huying" callType:TMBVoIPCallSessionTypeVideo];
    
    [SH_VOIP call:@"13548583211" displayName:@"huying" callType:TMBVoIPCallSessionTypeVideo];
    
    return;
}

- (IBAction)acceptAction:(id)sender {
    [SH_VOIP acceptCall:@"15074865225"];
}

- (IBAction)rejectAction:(id)sender {
    [SH_VOIP declineCall:@"15074865225"];
}

- (IBAction)SpeakerSwitchAction:(id)sender {
    //SH_VOIP setSpeakerEnabled:<#(BOOL)#>
}

- (IBAction)MicSwitchAction:(id)sender {
}

bool bV = YES;
- (IBAction)VideoSwitchAction:(id)sender {
    bV = !bV;
    
    [SH_VOIP setVideoEnabled:bV];
    
    if (bV) {
        [SH_VOIP setRemoteVideoView:self.remoteView loctionVideoView:self.locationView];
    }
}

- (IBAction)CallTypeChange:(id)sender {
}

- (IBAction)camSwitch:(id)sender {
}

- (IBAction)openRoomVideo:(id)sender {
    
    [SH_VOIP call:@"6000" displayName:@"huying" callType:TMBVoIPCallSessionTypeVideo];
}
@end
