//
//  SecondViewController.m
//  VoIPMobDemo
//
//  Created by sherwin on 15-6-15.
//  Copyright (c) 2015年 sherwin. All rights reserved.
//
#import "tmbVoIPMob.h"
#import "SecondViewController.h"

@interface SecondViewController ()<TMBVoIPMobDelegate>

@property (nonatomic, strong) UIView *remoteView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.remoteView = [[UIView alloc] initWithFrame:self.view.frame];

    [self.view insertSubview:self.remoteView atIndex:0];

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
    
    [self.lbCallStatus setText:info];
    return;
}

- (IBAction)createVideoRoom:(id)sender {
    
}

- (IBAction)joinVideoRoom:(id)sender {
}

- (IBAction)quitVideoRoom:(id)sender {
}

- (IBAction)relayVideoToUser:(id)sender {
}
- (IBAction)outVideoToUser:(id)sender {
}
- (IBAction)kickVideoToUser:(id)sender {
}

- (IBAction)ISpeak:(id)sender {
}

- (IBAction)openMyVideo:(id)sender {
}
@end
