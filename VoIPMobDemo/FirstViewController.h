//
//  FirstViewController.h
//  VoIPMobDemo
//
//  Created by sherwin on 15-6-15.
//  Copyright (c) 2015年 sherwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tmbVoIPMob.h"

@interface FirstViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) UIView *remoteView;
@property (weak, nonatomic) IBOutlet UIView *locationView;
@property (weak, nonatomic) IBOutlet UILabel *lbLog;
@property (weak, nonatomic) IBOutlet UILabel *lbCallStatus;

@property (weak, nonatomic) IBOutlet UITextField *tfActPwd;
- (IBAction)viewClick:(id)sender;


- (IBAction)callAction:(id)sender;
- (IBAction)acceptAction:(id)sender;
- (IBAction)rejectAction:(id)sender;


- (IBAction)SpeakerSwitchAction:(id)sender;

- (IBAction)MicSwitchAction:(id)sender;

- (IBAction)VideoSwitchAction:(id)sender;

//呼叫类型开关
- (IBAction)CallTypeChange:(id)sender;

//摄像头切换
- (IBAction)camSwitch:(id)sender;

- (IBAction)openRoomVideo:(id)sender;


- (IBAction)logout:(id)sender;

-(void) viewSwitch;

- (IBAction)audioCall:(id)sender;


@end

