//
//  AppDelegate.h
//  ECSDKDemo_OC
//
//  Created by jiazy on 14/12/4.
//  Copyright (c) 2014年 ronglian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreBluetooth/CoreBluetooth.h>
#import "BLEManager.h"

// ----- 多语言设置
#define kNotificationLanguageChanged @"kNotificationLanguageChanged"
#define CHINESE @"zh-Hans"
#define ENGLISH @"en"
#define AppLanguage @"appLanguage"

// ----- 高度
#define Zuozi_value @"zuozigaodu"                   // 坐姿高度
#define Zhanzi_value @"zhanzigaodu"                 // 站姿高度

// ----- 坐姿时间
#define Long_time @"sitLongTime"                    // 坐姿时长
#define Long_time_close @"acloseSitTip"             // 是否关闭
#define Long_time_interval @"sitLongTimeInterval"   // 间隔10分钟开始
#define Long_time_notification @"localNotificationTime"  // 通知提醒时间

@class SendMsgToWeChatViewController;

@interface AppDelegate : UIResponder <BLEManagerDelegate,CBCentralManagerDelegate,UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *callid;
@property (nonatomic,copy) NSString *myMess;
@property (strong, nonatomic) SendMsgToWeChatViewController *viewController;

+(AppDelegate*)shareInstance;
-(void)updateSoftAlertViewShow:(NSString*)message isForceUpdate:(BOOL)isForce;
-(void)toast:(NSString*)message;

// 这里的单位都是 秒
@property (nonatomic, assign) int lastSitTipTimeCount;  // 剩余坐姿时长
@property (nonatomic, assign) BOOL isSitModel;          // 是否是坐姿状态
@property (nonatomic, assign) BOOL isEnterBackground;   // 是否在后台


- (int)showSitLongWarning;  // 是否显示久坐提醒
- (void)cancelLocalNotification;
- (void)registerLocalNotification;

@end

