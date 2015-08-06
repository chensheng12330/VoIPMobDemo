//
//  SecondViewController.h
//  VoIPMobDemo
//
//  Created by sherwin on 15-6-15.
//  Copyright (c) 2015年 sherwin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tfRoomID;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UILabel *lbCallStatus;


@property (nonatomic, strong) UIView *remoteView;
@property (weak, nonatomic) IBOutlet UIView *locationView;


- (IBAction)createVideoRoom:(id)sender;
- (IBAction)joinVideoRoom:(id)sender;
- (IBAction)quitVideoRoom:(id)sender;

//! 转播
- (IBAction)relayVideoToUser:(id)sender;

//! 请离开发言
- (IBAction)outVideoToUser:(id)sender;


//! 踢人
- (IBAction)kickVideoToUser:(id)sender;

//! 我要发言
- (IBAction)ISpeak:(id)sender;

//! 开启我的视频
- (IBAction)openMyVideo:(id)sender;


-(void) viewSwitch;

@end

