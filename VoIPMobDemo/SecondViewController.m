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
    
    NSString *roomid =@"conf66611110";
    if (self.tfRoomID.text.length>0) {
        roomid = self.tfRoomID.text;
    }
    [SH_VOIP call:roomid displayName:@"a" callType:TMBVoIPCallSessionTypeVideoRoom];
    
    return;
}

- (IBAction)joinVideoRoom:(id)sender {
    
    [SH_VOIP call:@"6000" displayName:@"a" callType:TMBVoIPCallSessionTypeVideoRoom];
    
    //[SH_VOIP broadcastVideoMem:@"13548583222"];
}

- (IBAction)quitVideoRoom:(id)sender {
    [SH_VOIP declineCall:@"conf66600"];
}


//! 转播用户视频
- (IBAction)relayVideoToUser:(id)sender {
    [SH_VOIP broadcastVideoWithMem:@"13548583222"];
}

//! 停止视频转播
- (IBAction)outVideoToUser:(id)sender {
    [SH_VOIP cancelBroadcastVideoWithMem:@"13548583222"];
    //[SH_VOIP cancelMemSpeaker:@"13548583222"];
    
}

//! 主持人踢出某人
- (IBAction)kickVideoToUser:(id)sender {
    
    [SH_VOIP makeMemKickOut:@"13548583222"];
    return;
}

// 成员申请成为视频广播端
- (IBAction)applyMakeMeBroadcast:(id)sender {
    [SH_VOIP applyMakeMeBroadcast:@"13548583222"];
}

/////////////////////////////////////

//!  主持人接受某成员申请成为视频广播端
-(IBAction) acceptMemberForBroadcastVideoApply:(id)sender
{
    [SH_VOIP acceptMemberForBroadcastVideoApply:@"13548583222"];
}

//!  主持人拒绝 某成员申请成为视频广播端
-(IBAction) rejectMemberForBroadcastVideoApply:(id)sender
{
    [SH_VOIP rejectMemberForBroadcastVideoApply:@"13548583222"];
}

////////////////////

//成员同意广播本地视频
- (IBAction)acceptBroadcastVideo:(id)sender {
    [SH_VOIP acceptBroadcastVideo];
}


//成员拒绝广播本地视频
- (IBAction)rejectBroadcastVideo:(id)sender {
    [SH_VOIP rejectBroadcastVideo];
}





//
- (IBAction)ISpeak:(id)sender {
    
}

- (IBAction)openMyVideo:(id)sender {
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
    NSLog(@"xxxxxxxxxxxxxxxdidReceivedBroadcastMediaACK-----> %@",bYesNo?@"YES":@"NO");
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
    UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"广播端的申请通知." message:[NSString stringWithFormat:@"是否愿意成为音/视频广播端？ ->主持人[%@]",masterPhoneNum] delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    alrt.tag = 1002;
    
    [alrt show];
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
    UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"广播端的申请通知." message:[NSString stringWithFormat:@"是否愿意让该成员[%@]成为音/视频广播端。",memPhoneNum] delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    alrt.tag = 1001;
    
    [alrt show];
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
    NSLog(@"xxxxxxxxxxxxxxxdidReceivedMemApplyForBroadcastMediaACK-----> %@",bYesNo?@"YES":@"NO");
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
    NSString * urllog = [NSString stringWithFormat:@"+++++++++++++++++didReceivedBroadcastUrlList++++strRoomNum-> [%@]  urlStringAr->【%@】",strRoomNum,urlStringAr];
    NSLog(@"%@",urllog);
    
    NSString *txt = self.lblogoView.text;
    
    [self.lblogoView setText:[NSString stringWithFormat:@"%@%@",txt,urllog]];
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
    NSString * urllog = [NSString stringWithFormat:@"++++++++++++++++didRoomMemberUpdate+++++strRoomNum-> [%@]  urlStringAr->【%@】",strRoomNum,memberList];
    NSLog(@"%@",urllog);
    
    NSString *txt = self.lblogoView.text;
    
    [self.lblogoView setText:[NSString stringWithFormat:@"%@%@",txt,urllog]];
}


/////////////////////++++++++++++++++++++++++++++++++++++++++++++++++++
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001) { //收到会议里的某成员 音/视频 广播端的申请
        
        if (buttonIndex==1) {
            [self acceptMemberForBroadcastVideoApply:nil];
        }
        else{
            [self rejectMemberForBroadcastVideoApply:nil];
        }
    }
    else if(alertView.tag == 1002)
    {
        if (buttonIndex==1) {
            [self acceptBroadcastVideo:self];
        }
        else{
            [self rejectBroadcastVideo:self];
        }
    }
}
@end
