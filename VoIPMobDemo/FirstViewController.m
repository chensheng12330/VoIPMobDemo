//
//  FirstViewController.m
//  VoIPMobDemo
//
//  Created by sherwin on 15-6-15.
//  Copyright (c) 2015年 sherwin. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<TMBVoIPMobDelegate,NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *userList;
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
    
    //[self parser];
    
    //[self getCallPhoneFormEntityStr:@"sip:6000@115.28.41.212"];
    return;
}

-(NSString*)getCallPhoneFormEntityStr:(NSString*)entity
{
    //"sip:6000@115.28.41.212"
    
    NSRange firstRang = [entity rangeOfString:@":"];
    NSRange endRang   = [entity rangeOfString:@"@" options:NSBackwardsSearch];
    
    if (firstRang.location == NSNotFound  || endRang.location == NSNotFound) {
        return nil;
    }
    
    NSRange subRange = NSUnionRange(firstRang, endRang);
    subRange.length -= 2;
    subRange.location++;
    NSString *result= [entity substringWithRange:subRange];
    
    return nil;
}


-(void)parser
{
    
    NSString *messageBody = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"xml" ofType:@""] encoding:4 error:nil];
    
    NSXMLParser *m_parser = [[NSXMLParser alloc] initWithData:[messageBody dataUsingEncoding:NSUTF8StringEncoding]];
    [m_parser setDelegate:self];
    [m_parser setShouldProcessNamespaces:NO];
    [m_parser setShouldReportNamespacePrefixes:NO];
    [m_parser setShouldResolveExternalEntities:NO];
    BOOL flag = [m_parser parse]; //开始解析
}


- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.userList = [NSMutableArray new];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
}

-(void)parser:(NSXMLParser*)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary*)attributeDict
{
    
    NSLog(@"startName:%@",elementName);//节点的名称
    
    NSLog(@"attributeDict:%@",[attributeDict description]);//节点的属性集合，传入属性名便可方便获得属性值了
    
    
    if ([elementName isEqualToString:@"user"]) {
        [self.userList addObject:attributeDict];
    }
    
    return;
}

-(void)parser:(NSXMLParser*)parser foundCharacters:(NSString *)string{
    
    NSLog(@"Value:%@",string);
}

-(void)parser:(NSXMLParser*)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName

{
    NSLog(@"endName:%@",elementName);
}




//////////////////////////////////////
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
    
    //SH_VOIP.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)voipLoginAction:(id)sender {
    
    if (self.tfActPwd.text.length<1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请先输入账号@密码,格式以@进行分割." delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    
        return;
    }
    
    NSArray *ar = [self.tfActPwd.text componentsSeparatedByString:@"@"];
    
    if (ar.count<1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请先输入账号@密码,格式以@进行分割." delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    }
    
    [SH_VOIP loginVoIPWithUserName:[ar firstObject] password:[ar lastObject]];
    return;
}

- (void) tmbVoIPMob:(TMBVoIPMob*)tmbVoIPMob
   loginStateUpdate:(TMBLoginState)  callState
           stateStr:(NSString*) stateStr
{
    NSString *message=stateStr;
    
    switch (callState) {
        case TMBLoginOk:
        {
            message = @"--->SIP服务器登陆成功.";
            [SH_VOIP setRemoteVideoView:self.remoteView loctionVideoView:self.locationView];
            break;
        }
            
        case TMBLoginNone:
            message = @"--->未知状态.";break;
        case TMBLoginCleared:
            message =  @"--->SIP服务器登出成功."; break;
        case TMBLoginFailed:
            message =  @"--->SIP服务器登陆失败."; break;
        case TMBLoginProgress:
            message =  @"--->正在登陆中..."; break;
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
        {
            //
            
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.tfActPwd resignFirstResponder];
    return YES;
}

- (IBAction)viewClick:(id)sender {
    [self.tfActPwd resignFirstResponder];
}

- (IBAction)callAction:(id)sender {
    //SH_VOIP cal
    
    //[SH_VOIP call:@"15074865225" displayName:@"huying"];
    //[SH_VOIP call:@"15074865225" displayName:@"huying" callType:TMBVoIPCallSessionTypeVideo];
    [SH_VOIP setRemoteVideoView:self.remoteView loctionVideoView:self.locationView];
    
    [SH_VOIP call:@"18767111668" displayName:@"18767111667" callType:TMBVoIPCallSessionTypeVideo];
    
    return;
}

- (IBAction)audioCall:(id)sender {
    [SH_VOIP call:@"18767111668" displayName:@"18767111667" callType:TMBVoIPCallSessionTypeAudio];
}


- (IBAction)acceptAction:(id)sender {
    [SH_VOIP acceptCall:@"18767111668"];
}

- (IBAction)rejectAction:(id)sender {
    [SH_VOIP declineCall:@"18767111668"];
}

- (IBAction)SpeakerSwitchAction:(UIButton*)sender {
    BOOL isSel = sender.selected;
    
    [SH_VOIP setSpeakerEnabled:isSel];
    
    sender.selected = !isSel;
}

- (IBAction)MicSwitchAction:(UIButton*)sender {
    
    BOOL isSel = sender.selected;
    
    [SH_VOIP setMicroEnable:isSel];
    
    sender.selected = !isSel;
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

- (IBAction)logout:(id)sender {
    [SH_VOIP logoutForVoIP];
}
@end
