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


/*! (主持人)
 @method
 @brief      会议主持人收到某音/视频会议里的某成员返回的 指定成为音/视频广播的应答状态码
 @discussion 某成员以接受，或拒绝，表示是否愿意成为音视频广播端
 @param      strRoomNum 音视频聊天室房间号.（已做confi过滤处理）
 @param      bYesNo  YES，表示愿意加入， NO,表示拒绝
 @param      forMem  某成员的callNum 值(即 MemID值)
 @result     无返回值
 */
- (void) callRoom:(NSString*) strRoomNum
didReceivedBroadcastMediaACK:(BOOL)bYesNo
           forMem:(NSString*)memPhoneNum
    broadcastType:(TMBVoIPBroadcastType )broadTyep
{
    NSLog(@"xxxxxxxxxxxxxxxdidReceivedBroadcastMediaACK-----> ");
}

/*! (会与人员)
 @method
 @brief      收到音/视频会议中的主持人指定成员广播本地音/视频的邀请
 @discussion 询问被指定为音/视频广播端者是否同意广播本地音/视频。某成员可以接受，或拒绝，表示是否愿意成为音/视频广播端
 @param      strRoomNum 音/视频聊天室房间号.（已做confi过滤处理）
 @param      bYesNo  YES，表示愿意加入， NO,表示拒绝
 @result     无返回值
 */
- (void) callRoom:(NSString*) strRoomNum
didReceivedBroadcastMediaInvitation:(NSString*)masterPhoneNum
    broadcastType:(TMBVoIPBroadcastType )broadTyep
{
    
}


/*! (主持人)
 @method
 @brief      收到会议里的某成员 音/视频 广播端的申请
 @discussion 收到申请通知后，可以接受，或拒绝，表示是否愿意让该成员成为音/视频广播端
 @param      strRoomNum  音视频聊天室房间号.（已做confi过滤处理）
 @param      memPhoneNum 某成员的memPhoneNum 值(即 MemID值)
 @result     无返回值
 */
- (void) callRoom:(NSString*) strRoomNum
didReceivedMemApplyForBroadcastMedia:(NSString*)memPhoneNum
    broadcastType:(TMBVoIPBroadcastType )broadTyep
{
    
}


/*! (会与人员)
 @method
 @brief      收到会议中的主持人对某成员音/视频广播端的申请应答
 @discussion
 @param      strRoomNum  音视频聊天室房间号.（已做confi过滤处理）
 @param     bYesNo  YES，表示接受成员成为视频广播端的请求， NO,表示拒绝
 @param
 @result     无返回值
 */
- (void) callRoom:(NSString*) strRoomNum
didReceivedMemApplyForBroadcastMediaACK:(BOOL)bYesNo
    broadcastType:(TMBVoIPBroadcastType )broadTyep
{
    
}

/////////////////会议视频直播地址///////
/*! (参与人员)
 @method
 @brief      收到会议中的直播地址的广播信息
 @discussion
 @param      strRoomNum   音/视频聊天室房间号.（已做confi过滤处理）
 @param      urlStringAr  包含直播地址的数组，url为不同视频解码的链接.可通过判断后缀.m3u8  .mp4 判断.
 @param
 @result     无返回值
 */
- (void) callRoom:(NSString*) strRoomNum
didReceivedBroadcastUrlList:(NSArray*) urlStringAr
{
    NSLog(@"+++++++++++++++++didReceivedBroadcastUrlList++++strRoomNum-> [%@]  urlStringAr->【%@】",strRoomNum,urlStringAr);
}

/*! (参与人员)
 @method
 @brief      获取/收到会议中的人员更新回调
 @discussion
 @param      strRoomNum   音/视频聊天室房间号.（已做confi过滤处理）
 @param      memberList   会议成员列表.
 @param
 @result     无返回值
 */
- (void) callRoom:(NSString*) strRoomNum
didRoomMemberUpdate:(NSArray*) memberList
{
    NSLog(@"++++++++++++++++didRoomMemberUpdate+++++strRoomNum-> [%@]  urlStringAr->【%@】",strRoomNum,memberList);
}

@end
