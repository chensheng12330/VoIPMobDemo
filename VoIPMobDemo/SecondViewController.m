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

//@property (nonatomic, strong) UIView *remoteView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.remoteView = [[UIView alloc] initWithFrame:self.view.frame];
    SH_VOIP.delegate = self;

    [self.view insertSubview:self.remoteView atIndex:0];
}

-(void) viewSwitch
{
    SH_VOIP.delegate = self;
    [SH_VOIP setRemoteVideoView:self.remoteView loctionVideoView:self.locationView];
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
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
        {
            //[SH_VOIP setRemoteVideoView:self.remoteView loctionVideoView:self.locationView];
            
            info = @"通话已连接,可进行音视频通话.";
            break;
        }
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
    
    [SH_VOIP call:@"conf666110" displayName:@"a" callType:TMBVoIPCallSessionTypeVideoRoom];
    
    return;
}

- (IBAction)joinVideoRoom:(id)sender {
    
    [SH_VOIP call:@"conf666110" displayName:@"a" callType:TMBVoIPCallSessionTypeVideoRoom];
    
    //[SH_VOIP broadcastVideoMem:@"13548583222"];
}

- (IBAction)quitVideoRoom:(id)sender {
    [SH_VOIP declineCall:@"conf66600"];
}

- (IBAction)relayVideoToUser:(id)sender {
    [SH_VOIP broadcastVideoMem:@"13548583222"];
}
- (IBAction)outVideoToUser:(id)sender {
    
    [SH_VOIP cancelMemSpeaker:@"13548583222"];
    
}
- (IBAction)kickVideoToUser:(id)sender {
    
    [SH_VOIP makeMemKickOut:@"13548583222"];
    return;
}

- (IBAction)ISpeak:(id)sender {
    
}

- (IBAction)openMyVideo:(id)sender {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@""];
    
    return cell;
}

@end
