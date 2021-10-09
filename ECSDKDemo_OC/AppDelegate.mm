//
//  AppDelegate.m
//  ECSDKDemo_OC
//
//  Created by jiazy on 14/12/4.
//  Copyright (c) 2014年 ronglian. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
//#import "ECDeviceHeaders.h"
//#import "LoginViewController2.h"
//#import "MainViewController.h"
//#import "SKTabBarController.h"
//#import "AddressBookManager.h"
//#import "CustomEmojiView.h"
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
//#import "WXApi.h"

//#import "Person.h"
#import "DBTool.h"

//#import "GuideViewController.h"

//#import "WXApiManager.h"
//#import "SendMsgToWeChatViewController.h"

#import "MeitikuViewController.h"

#import "Health.h"

//新浪微博SDK头文件
//#import "WeiboSDK.h"
#import "HexUtils.h"

#import "MBProgressHUD.h"
//#import "GlobalFunc.h"

//#import "LoginVC.h"
//#import "DXSoundStore.h"

#import "NSStringConvertUtil.h"

#define LOG_OPEN 0


#import "MainBlueTouchViewController.h"
#import "BlueTouchDevice.h"

//#import <SMS_SDK/SMSSDK.h>
//#import <SMS_SDK/Extend/SMSSDK+AddressBookMethods.h>
//SMSSDK官网公共key
#define appkey @"161c483e4570e"
#define app_secrect @"6856847bc9ba61c94853e4309a87c1ab"

////＝＝＝＝＝＝＝＝＝＝ShareSDK头文件＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
////以下是ShareSDK必须添加的依赖库：
////1、libicucore.dylib
////2、libz.dylib
////3、libstdc++.dylib
////4、JavaScriptCore.framework
//
////＝＝＝＝＝＝＝＝＝＝以下是各个平台SDK的头文件，根据需要继承的平台添加＝＝＝
//////腾讯开放平台（对应QQ和QQ空间）SDK头文件
////#import <TencentOpenAPI/TencentOAuth.h>
////#import <TencentOpenAPI/QQApiInterface.h>
//////以下是腾讯SDK的依赖库：
//////libsqlite3.dylib
//
////微信SDK头文件
//#import "WXApi.h"
////以下是微信SDK的依赖库：
////libsqlite3.dylib
//
////新浪微博SDK头文件
//#import "WeiboSDK.h"
////新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
////以下是新浪微博SDK的依赖库：
////ImageIO.framework
////libsqlite3.dylib
////AdSupport.framework
//
//////人人SDK头文件
////#import <RennSDK/RennSDK.h>
////
//////Kakao SDK头文件
////#import <KakaoOpenSDK/KakaoOpenSDK.h>
////
//////支付宝SDK
////#import "APOpenAPI.h"
////
//////易信SDK头文件
////#import "YXApi.h"
////
//////Facebook Messenger SDK
////#import <FBSDKMessengerShareKit/FBSDKMessengerSharer.h>


@interface AppDelegate ()

//@property (nonatomic, strong) LoginViewController2 *loginView;
//@property (nonatomic, strong) LoginVC *loginView2;
//@property (nonatomic, strong) MainViewController *mainView;
//@property (nonatomic, strong) MainViewController2 *mainView2;
@property (nonatomic, strong) NSDateFormatter *dataformater;
//@property (nonatomic, strong) SKTabBarController *sktab;

// 蓝牙检测
@property (nonatomic,strong)CBCentralManager *centralManager;


@end

@implementation AppDelegate




- (void)redirectNSLogToDocumentFolder {
    
#if LOG_OPEN
    if(isatty(STDOUT_FILENO)){
        return;
    }
    
    UIDevice *device = [UIDevice currentDevice];
    if([[device model] hasSuffix:@"Simulator"]){ //在模拟器不保存到文件中
        return;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName =[NSString stringWithFormat:@"%@.log", [self.dataformater stringFromDate:[NSDate date]]];
    NSString *logFilePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
#endif
    
}

- (void)playSound:(NSString *)fileName
{
//    [[DXSoundStore sharedStore] playSound:fileName];
}

#pragma mark - CLLocationManagerDelegate
-(void)centralManagerDidUpdateState:(CBCentralManager *)central {
    //第一次打开或者每次蓝牙状态改变都会调用这个函数
    if(central.state == CBCentralManagerStatePoweredOn) {
        NSLog(@"蓝牙设备开着");
//        self.blueToothOpen = YES;
        
    }else {
        NSLog(@"蓝牙设备关着");
//        self.blueToothOpen = NO;
        MainBlueTouchViewController *appStartController = [[MainBlueTouchViewController alloc] init];
        appStartController.navigationController.navigationBarHidden = YES;
        [AppDelegate shareInstance] .window.rootViewController = [[UINavigationController alloc] initWithRootViewController:appStartController];// appStartController;
        
    }
    
}



#pragma mark -通知有关的代理方法
/** App在后台,程序未被杀死,用户点击了本地通知后的操作 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    // 一定要判断App是否在后台
    if (!(application.applicationState==UIApplicationStateActive)) { // App在后台且用户点击了通知后的操作)
        application.applicationIconBadgeNumber=0;
        NSString *strValue=notification.userInfo[@"detailMess"]; // 这里的 userInfo 对应通知的设置信息 userInfo
        //        self.myMess=[NSString stringWithFormat:@"%@(App在后台且用户点击了通知后,这里是具体的通知信息详情)",strValue];
        self.myMess=notification.soundName;//[NSString stringWithFormat:@"%@(App在后台且用户点击了通知后,这里是具体的通知信息详情)",strValue];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"bgckMess" object:nil userInfo:nil];
        NSLog(@"App还在后台,点击了本地通知后,进入这个方法.得到的本地其他信息:%@",notification.userInfo);
    }
    else{
        //        [[NSNotificationCenter defaultCenter]postNotificationName:@"bgckMess" object:nil userInfo:nil];
        NSLog(@"App在前台,不用做任何操作");
    }
}

#pragma mark --- 获取系统语言
- (void)setCurrentLanguage {
    NSString *language = [NSLocale preferredLanguages].firstObject;
    if ([language hasPrefix:@"en"]) {
        language = @"en";
    } else if ([language hasPrefix:@"zh"]) {
        language = @"zh-Hans"; // 简体中文
    } else if ([language hasPrefix:@"ru"]) {
        language = @"ru";
    } else if ([language hasPrefix:@"nl-CN"] || [language hasPrefix:@"nl-NL"]) {
        language = @"nl";
    } else {
        language = @"zh-Hans";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"当前语言" message:language preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:AppLanguage];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark 注册用户通知
-(void)registerNotification {
    // iOS 10 使用 UNUserNotificationCenter
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        //请求获取通知权限（角标，声音，弹框）
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge |
                                                 UNAuthorizationOptionSound |
                                                 UNAuthorizationOptionAlert)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                //获取用户是否同意开启通知
                NSLog(@"开启通知成功!");

            }
        }];
    }else {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}


#pragma mark - getter
- (int)showSitLongWarning {
    id longTimeNotfication = [[NSUserDefaults standardUserDefaults] objectForKey:Long_time_notification];
    if (longTimeNotfication == nil || [longTimeNotfication intValue] == 0 || self.isEnterBackground) {
        return -2;
    }
    [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:Long_time_notification];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSTimeInterval currentTimeSince = [[NSDate date] timeIntervalSince1970];
    if ([longTimeNotfication doubleValue] < currentTimeSince) {
        // 已经通知过了
        return -1;
    }
    // 返回剩余通知时间
    return [longTimeNotfication doubleValue] - currentTimeSince;
}

- (void)cancelLocalNotification {
    NSLog(@"取消通知");
    if (@available(iOS 10.0, *)) {
//        NSArray<NSString *> *ids = @[@"UNNotificationRequest-1", @"UNNotificationRequest-2"];
//        [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:ids];
        [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    }else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

- (void)registerLocalNotification {
    
    NSLog(@"注册通知：剩余时间%d", _lastSitTipTimeCount);
    
    // 1：记录通知提醒的时间
    NSDate *curDate = [NSDate date];
    NSTimeInterval currentTimeSince = [curDate timeIntervalSince1970];
    NSTimeInterval notifiTimeSince = _lastSitTipTimeCount + currentTimeSince;
    [[NSUserDefaults standardUserDefaults] setDouble:notifiTimeSince forKey:Long_time_notification];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *title = LocationLanguage(@"setting_longtime", @"久坐提醒");
//    NSString *longTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"sitLongTime"];
//    if (longTime.length == 0) {
//        longTime = @"120";
//    }
//    int min = [longTime intValue];
//    int hour = min / 60;
//    min = min - hour * 60;
//    NSString *s1 = [NSString stringWithFormat:@" %d %@ %d %@", hour, LocationLanguage(@"hours", @"小时"), min, LocationLanguage(@"minutes", @"分钟")];
//    NSString *body = [NSString stringWithFormat:LocationLanguage(@"overHours", @"超过时间"), s1];
    NSString *body = LocationLanguage(@"localNotifiContent", @"时间到了，该站起来了");
     for (int i = 1; i < 3; i++) {
         if (@available(iOS 10.0, *)) {
             UNUserNotificationCenter *notiCenter = [UNUserNotificationCenter currentNotificationCenter];
             
             UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
             content.title = title;
             content.body = body;
             content.sound = [UNNotificationSound soundNamed:@"ppppp.mp3"];
             
             UNTimeIntervalNotificationTrigger *trigger;
             if (i == 1) {
                 trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:_lastSitTipTimeCount repeats:NO];
             }else {
                 trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:_lastSitTipTimeCount+10*60 repeats:NO];
             }
             UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:[NSString stringWithFormat:@"UNNotificationRequest-%d", i] content:content trigger:trigger];
             
             [notiCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                 NSLog(@"注册本地通知 Errro: %@", error);
             }];
         }else {
             UILocalNotification *notification = [[UILocalNotification alloc] init];
             NSDate *fireDate;
             if (i == 0) {
                 fireDate = [curDate dateByAddingTimeInterval:_lastSitTipTimeCount];
             }else {
                 fireDate = [curDate dateByAddingTimeInterval:_lastSitTipTimeCount+10*60];
             }
             notification.fireDate = fireDate;
             // 时区
             notification.timeZone = [NSTimeZone defaultTimeZone];
             notification.repeatInterval = 0;
             notification.alertTitle = title;
             notification.alertBody = body;
             // 通知被触发时播放的声音
             notification.soundName = @"ppppp.mp3";
             // 执行通知注册
             [[UIApplication sharedApplication] scheduleLocalNotification:notification];
         }
     }
}

// 十六进制转换为普通字符串。
- (NSNumber *) numberHexString:(NSString *)aHexString

{
    
    // 为空,直接返回.
    
    if (nil == aHexString)
        
    {
        
        return nil;
        
    }
    
    
    
    NSScanner * scanner = [NSScanner scannerWithString:aHexString];
    
    unsigned long long longlongValue;
    
    [scanner scanHexLongLong:&longlongValue];
    
    
    
    //将整数转换为NSNumber,存储到数组中,并返回.
    
    NSNumber * hexNumber = [NSNumber numberWithLongLong:longlongValue];

    return hexNumber;
    
    
    
}

- (NSString *)getCurrentTime_month {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
    
}


- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
    
}

- (NSString *)getCurrentTime1 {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [NSDate date];//当前时间
    NSDate *date_last = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天
    NSString *dateTime = [formatter stringFromDate:date_last];
    return dateTime;

}
- (NSString *)getCurrentTime2 {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [NSDate date];//当前时间
    NSDate *date_last = [NSDate dateWithTimeInterval:-48*60*60 sinceDate:date];//前一天
    NSString *dateTime = [formatter stringFromDate:date_last];
    return dateTime;
    
}
- (NSString *)getCurrentTime3 {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [NSDate date];//当前时间
    NSDate *date_last = [NSDate dateWithTimeInterval:-72*60*60 sinceDate:date];//前一天
    NSString *dateTime = [formatter stringFromDate:date_last];
    return dateTime;
    
}
- (NSString *)getCurrentTime4 {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [NSDate date];//当前时间
    NSDate *date_last = [NSDate dateWithTimeInterval:-96*60*60 sinceDate:date];//前一天
    NSString *dateTime = [formatter stringFromDate:date_last];
    return dateTime;
    
}
- (NSString *)getCurrentTime5{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [NSDate date];//当前时间
    NSDate *date_last = [NSDate dateWithTimeInterval:-120*60*60 sinceDate:date];//前一天
    NSString *dateTime = [formatter stringFromDate:date_last];
    return dateTime;
    
}
- (NSString *)getCurrentTime6 {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [NSDate date];//当前时间
    NSDate *date_last = [NSDate dateWithTimeInterval:-144*60*60 sinceDate:date];//前一天
    NSString *dateTime = [formatter stringFromDate:date_last];
    return dateTime;
    
}


- (NSString *)getCurrentTime00 {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM.dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
    
}

- (NSString *)getCurrentTime11 {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM.dd"];
    NSDate * date = [NSDate date];//当前时间
    NSDate *date_last = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天
    NSString *dateTime = [formatter stringFromDate:date_last];
    return dateTime;
    
}
- (NSString *)getCurrentTime22 {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM.dd"];
    NSDate * date = [NSDate date];//当前时间
    NSDate *date_last = [NSDate dateWithTimeInterval:-48*60*60 sinceDate:date];//前一天
    NSString *dateTime = [formatter stringFromDate:date_last];
    return dateTime;
    
}
- (NSString *)getCurrentTime33 {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM.dd"];
    NSDate * date = [NSDate date];//当前时间
    NSDate *date_last = [NSDate dateWithTimeInterval:-72*60*60 sinceDate:date];//前一天
    NSString *dateTime = [formatter stringFromDate:date_last];
    return dateTime;
    
}
- (NSString *)getCurrentTime44 {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM.dd"];
    NSDate * date = [NSDate date];//当前时间
    NSDate *date_last = [NSDate dateWithTimeInterval:-96*60*60 sinceDate:date];//前一天
    NSString *dateTime = [formatter stringFromDate:date_last];
    return dateTime;
    
}
- (NSString *)getCurrentTime55{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM.dd"];
    NSDate * date = [NSDate date];//当前时间
    NSDate *date_last = [NSDate dateWithTimeInterval:-120*60*60 sinceDate:date];//前一天
    NSString *dateTime = [formatter stringFromDate:date_last];
    return dateTime;
    
}
- (NSString *)getCurrentTime66 {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM.dd"];
    NSDate * date = [NSDate date];//当前时间
    NSDate *date_last = [NSDate dateWithTimeInterval:-144*60*60 sinceDate:date];//前一天
    NSString *dateTime = [formatter stringFromDate:date_last];
    return dateTime;
    
}

-(NSString *)getNowTimeTimestamp2{
    
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型

    
    return timeString;
    
}


        /**
         * 获取字节（有8bit）所在位（第num bit处）的数值
         * 为0还是1
         * 为1时返回true
         * @param by 字节
         * @param index 位置
         * @return
         */
//- (BOOL) getBitOnIndexIsTrue:(NSString *)by index:(int)index
//{
////            StringBuffer sb = new StringBuffer();
////            sb.append((by>>index)&0x1);
////            return sb.toString().equals("1");
//
//
////    [string1 stringByAppendingString:string2];
//    NSString *aaa =@"";
//    aaa = [NSString stringWithFormat:@"%@%c",aaa,(by>>index)&0x1];
//
//    if([aaa isEqualToString:@"1"])
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    
    NSString *strWarning =@"1B413030303030303430433505";
//    NSNumber *number_gaodu = [HexUtils numberHexString:str_asciiCode_all];
    if(strWarning.length==26)
    {
        strWarning = [strWarning substringFromIndex:4];
        strWarning = [strWarning substringToIndex:16];
        
//        NSString *str_gaodu = [HexUtils hexToCompleteNum:str_receve];

        NSLog(@"receve value : %@",strWarning);
//        NSNumber *number_gaodu = [HexUtils numberHexString:strWarning];
        
        
        NSString *str_one = [strWarning substringToIndex:2];
        NSString *str_one2= [strWarning substringFromIndex:2];
        
        NSString *str_two = [str_one2 substringToIndex:2];
        NSString *str_two2= [str_one2 substringFromIndex:2];
        
        NSString *str_three = [str_two2 substringToIndex:2];
        NSString *str_three2= [str_two2 substringFromIndex:2];
        
        NSString *str_four = [str_three2 substringToIndex:2];
        NSString *str_four2= [str_three2 substringFromIndex:2];
        
        NSString *str_five = [str_four2 substringToIndex:2];
        NSString *str_five2= [str_four2 substringFromIndex:2];
        
        NSString *str_six = [str_five2 substringToIndex:2];
        NSString *str_six2= [str_five2 substringFromIndex:2];
        
        NSString *str_seven = [str_six2 substringToIndex:2];
        NSString *str_seven2= [str_six2 substringFromIndex:2];
        
        NSString *str_eight = [str_seven2 substringToIndex:2];
        NSString *str_eight2= [str_seven2 substringFromIndex:2];
        
        
        NSNumber *asciiCode1 =[HexUtils numberHexString:str_one];
        NSString *str_asciiCode1 = [NSString stringWithFormat:@"%C", asciiCode1.intValue]; // A
        
        NSNumber *asciiCode2 =[HexUtils numberHexString:str_two];
        NSString *str_asciiCode2 = [NSString stringWithFormat:@"%C", asciiCode2.intValue];
        
        NSNumber *asciiCode3 =[HexUtils numberHexString:str_three];
        NSString *str_asciiCode3 = [NSString stringWithFormat:@"%C", asciiCode3.intValue];
        
        NSNumber *asciiCode4 =[HexUtils numberHexString:str_four];
        NSString *str_asciiCode4 = [NSString stringWithFormat:@"%C", asciiCode4.intValue];
        
        NSNumber *asciiCode5 =[HexUtils numberHexString:str_five];
        NSString *str_asciiCode5 = [NSString stringWithFormat:@"%C", asciiCode5.intValue];
        
        NSNumber *asciiCode6 =[HexUtils numberHexString:str_six];
        NSString *str_asciiCode6 = [NSString stringWithFormat:@"%C", asciiCode6.intValue];
        
        NSNumber *asciiCode7=[HexUtils numberHexString:str_seven];
        NSString *str_asciiCode7 = [NSString stringWithFormat:@"%C", asciiCode7.intValue];
        
        NSNumber *asciiCode8 =[HexUtils numberHexString:str_eight];
        NSString *str_asciiCode8 = [NSString stringWithFormat:@"%C", asciiCode8.intValue];
        
        NSString *str_asciiCode_all = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@", str_asciiCode1,str_asciiCode2,str_asciiCode3,str_asciiCode4,str_asciiCode5,str_asciiCode6,str_asciiCode7,str_asciiCode8];
        NSLog(@"receve value : %@",str_asciiCode_all);
        NSLog(@"receve value : %@",str_asciiCode_all);
        if(![str_asciiCode_all isEqualToString:@"00000000"])
        {
           NSData *data_all = [HexUtils HexToByteArr:strWarning];

            NSLog(@"receve value : %@",data_all);
            NSLog(@"receve value : %@",data_all);
        }
        
//        NSString *str = @"40";
//        NSData  *data = [str  dataUsingEncoding:4]; // UTF-8编码
//        Byte        *bytes  = (Byte *)[data bytes];
//        int           length  = data.length;
        
        NSData *data_all = [HexUtils hexToBytes:@"00000040"];
        NSData *data_all2 = [HexUtils hexToBytes:@"00000040"];
        
        
//        NSString *testString = @"00000040";
//        NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
//        Byte *testByte = (Byte *)[testData bytes];
//        for(int i=0;i<[testData length];i++)
//            printf("testByte = %d\n",testByte[i]);
        
//        NSString *str = @"00000040";
//        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(NSUTF16BigEndianStringEncoding);
//        NSData *data = [str dataUsingEncoding:enc];
//        Byte *byte = (Byte *)[data bytes];
//        for (int i=0 ; i<[data length]; i++) {
//            NSLog(@"byte = %d",byte[i]);
//        }
        
        NSString *strBit1 = [NSStringConvertUtil getBinaryByhex:str_asciiCode1];
        NSString *strBit2 = [NSStringConvertUtil getBinaryByhex:str_asciiCode2];
        NSString *strBit3 = [NSStringConvertUtil getBinaryByhex:str_asciiCode3];
        NSString *strBit4 = [NSStringConvertUtil getBinaryByhex:str_asciiCode4];
        NSString *strBit5 = [NSStringConvertUtil getBinaryByhex:str_asciiCode5];
        NSString *strBit6 = [NSStringConvertUtil getBinaryByhex:str_asciiCode6];
        NSString *strBit7 = [NSStringConvertUtil getBinaryByhex:str_asciiCode7];
        NSString *strBit8 = [NSStringConvertUtil getBinaryByhex:str_asciiCode8];
        
        NSLog(@"strBit7 = %@",strBit7);
        NSLog(@"strBit8 = %@",strBit8);
        
        NSString *strBit33 =[NSString stringWithFormat:@"%@%@", strBit7,strBit8];
        NSString *strBit22 =[NSString stringWithFormat:@"%@%@", strBit5,strBit5];
        NSString *strBit11 =[NSString stringWithFormat:@"%@%@", strBit3,strBit4];
        NSString *strBit00 =[NSString stringWithFormat:@"%@%@", strBit1,strBit2];
        
//        if([[[strBit33 substringToIndex:2] substringFromIndex:1] isEqualToString:@"1"])
//        {
//            NSLog(@"strBit8 = %@",@"1");
//        }
        strBit33 =@"00000001";
        if([[strBit33 substringFromIndex:7] isEqualToString:@"1"])
        {
            NSLog(@"strBit8 = %@",@"1");
        }
        strBit33 =@"00000010";
        if([[[strBit33 substringFromIndex:6] substringToIndex:1] isEqualToString:@"1"])
        {
            NSLog(@"strBit8 = %@",@"1");
        }
        strBit33 =@"01000000";
        if([[[strBit33 substringToIndex:2] substringFromIndex:1] isEqualToString:@"1"])
        {
            NSLog(@"strBit8 = %@",@"1");
        }
        
        strBit22 =@"00001000";
        if([[[strBit22 substringFromIndex:4] substringToIndex:1] isEqualToString:@"1"])
        {
            NSLog(@"strBit8 = %@",@"1");
        }
        strBit11 =@"00000001";
        if([[strBit11 substringFromIndex:7] isEqualToString:@"1"])
        {
            NSLog(@"strBit8 = %@",@"1");
        }
        strBit11 =@"01000000";
        if([[[strBit11 substringToIndex:2] substringFromIndex:1] isEqualToString:@"1"])
        {
            NSLog(@"strBit8 = %@",@"1");
        }
        strBit11 =@"00000010";
        if([[[strBit11 substringFromIndex:6] substringToIndex:1] isEqualToString:@"1"])
        {
            NSLog(@"strBit8 = %@",@"1");
        }
        
//        NSString *str_five222 = [[strBit33 substringToIndex:2] substringFromIndex:1];
//        NSString *str_five2333= [str_five222 substringFromIndex:1];
//
//        NSLog(@"strBit8 = %@",str_five2333);
//        [self getBitOnIndexIsTrue:strBit4 index:7]
        
//        /**
//         * 获取字节（有8bit）所在位（第num bit处）的数值
//         * 为0还是1
//         * 为1时返回true
//         * @param by 字节
//         * @param index 位置
//         * @return
//         */
//        public static boolean getBitOnIndexIsTrue(byte by,int index){
//            StringBuffer sb = new StringBuffer();
//            sb.append((by>>index)&0x1);
//            return sb.toString().equals("1");
//        }
 
    }
    
    
    
    
//    NSString *beginTimestamp2 = [self getCurrentTime_month];
//    if([beginTimestamp2 isEqualToString:@"2018-05"]||[beginTimestamp2 isEqualToString:@"2018-06"] ||[beginTimestamp2 isEqualToString:@"2018-07"]||[beginTimestamp2 isEqualToString:@"2018-08"]||[beginTimestamp2 isEqualToString:@"2018-09"]||[beginTimestamp2 isEqualToString:@"2018-10"])
//    {
//        return  YES;
//    }
    
    
        NSString *beginTimestamp = @"1525581589";
        NSString *endTimestamp = @"1525667869";
    NSString *str_shijiancha = [HexUtils getShijianjiange_tian:beginTimestamp endTimestamp:endTimestamp];
    if(str_shijiancha.doubleValue>1)
    {
        float zuozishijian=0;
         zuozishijian=0;
    }
    else
    {
        float zuozishijian=0;
    }
    
    float zuozishijian=0;
    
    zuozishijian = zuozishijian + str_shijiancha.floatValue;
    
//    NSLog(@"receve value : %@",@"1b4130303031303205");
//    NSString *backString = [[NSString alloc]initWithData:value encoding:NSUTF8StringEncoding];
    
    //    NSLog(@"receve value : %@",backString);
    //    notifyLabel.text = backString;
    
    
    NSString *str_receve = @"1B4130303145313705";// [HexUtils encodeHexData:value];
    NSLog(@"receve value : %@",str_receve);
    if ([str_receve containsString:@"1B41"]) {
        if(str_receve.length>12)
        {
            str_receve = [str_receve substringFromIndex:4];
            str_receve = [str_receve substringToIndex:8];
            
            NSString *str_gaodu = [HexUtils hexToCompleteNum:str_receve];
            
            NSLog(@"receve value str_gaodu: %@",str_gaodu);
        }
    }
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.f", a];
   
    
    
    bool bool_first = [[NSUserDefaults standardUserDefaults] boolForKey:@"bool_first"];
    if(!bool_first)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"bool_first"];
        [BLEManager sharedManager].yy_zuoziInfo = @"70";
        [BLEManager sharedManager].yy_zhanziInfo = @"100";
    }
    
    NSString *bbb =@"31413034";
//    NSString *theString2 = [NSString stringWithFormat:@"%C", bbb];
    
    NSString *str_one = [bbb substringToIndex:2];
    NSString *str_one2= [bbb substringFromIndex:2];
    
    NSString *str_two = [str_one2 substringToIndex:2];
    NSString *str_two2= [str_one2 substringFromIndex:2];
    
    NSString *str_three = [str_two2 substringToIndex:2];
    NSString *str_three2= [str_two2 substringFromIndex:2];
    
    NSString *str_four = [str_three2 substringToIndex:2];
    NSString *str_four2= [str_three2 substringFromIndex:2];
    
    
    NSNumber *asciiCode1 =[HexUtils numberHexString:str_one];
    NSString *str_asciiCode1 = [NSString stringWithFormat:@"%C", asciiCode1.intValue]; // A
    
    NSNumber *asciiCode2 =[HexUtils numberHexString:str_two];
    NSString *str_asciiCode2 = [NSString stringWithFormat:@"%C", asciiCode2.intValue];
    
    NSNumber *asciiCode3 =[HexUtils numberHexString:str_three];
    NSString *str_asciiCode3 = [NSString stringWithFormat:@"%C", asciiCode3.intValue];
    
    NSNumber *asciiCode4 =[HexUtils numberHexString:str_four];
    NSString *str_asciiCode4 = [NSString stringWithFormat:@"%C", asciiCode4.intValue];
    
    NSString *str_asciiCode_all = [NSString stringWithFormat:@"%@%@%@%@", str_asciiCode1,str_asciiCode2,str_asciiCode3,str_asciiCode4];
    
//    int   aaa= 31;
//    NSString *string1 = [NSString stringWithFormat:@"%C",aaa]; // A
//
//    int asciiCode = 41;
//    NSString *string2 = [NSString stringWithFormat:@"%C", asciiCode]; // A
//
//    int asciiCode = 41;
//    NSString *string3 = [NSString stringWithFormat:@"%C", asciiCode]; // A
//
//    int asciiCode = 65;
//    NSString *string2 = [NSString stringWithFormat:@"%C", asciiCode]; // A
    NSNumber *number_gaodu = [HexUtils numberHexString:str_asciiCode_all];
//    NSNumber *aa = [HexUtils numberHexString:@"1A04"];
    NSLog(@"%@",number_gaodu);
    NSString *str_gaodu = number_gaodu.stringValue;
    str_gaodu = [NSString stringWithFormat:@"%@.%@",[str_gaodu substringToIndex:2],[[str_gaodu substringFromIndex:2]  substringToIndex:1]];
    NSLog(@"%@",str_gaodu);
    
    DBTool *tool = [DBTool sharedDBTool];
    
    [tool createTableWithClass:[Health class]];
    [tool createTableWithClass:[BlueTouchDevice class]];
    
    
//    BlueTouchDevice *device = [BlueTouchDevice initidentifier:@"0425D00D-366B-4990-91A6-CDF596B459D6" name:@"BT05-A1" state:@"disconnected" type:@"1"];
//    [tool insertWithObj:device];
//    
//    
//    BlueTouchDevice *device2 = [BlueTouchDevice initidentifier:@"0425D00D-366B-4990-91A6-CDF596B459D6" name:@"BT05-A2" state:@"disconnected" type:@"2"];
//    [tool insertWithObj:device2];
//    
//    
//    BlueTouchDevice *device3 = [BlueTouchDevice initidentifier:@"0425D00D-366B-4990-91A6-CDF596B459D6" name:@"BT05-A3" state:@"disconnected" type:@"3"];
//    [tool insertWithObj:device3];
    
//    [tool createTableWithClass:[Person class]];
//    Person *p = [Person initName:@"小明" age:19];
//    [tool insertWithObj:p];
//    Person *p1 = [Person initName:@"小红" age:10];
//    [tool insertWithObj:p1];
//    Person *p2 = [Person initName:@"小小" age:12];
//    [tool insertWithObj:p2];
//    Person *p3 = [Person initName:@"小黑" age:23];
//    [tool insertWithObj:p3];
    
    
    NSString *str_nianyueri=[self getCurrentTime];
    NSString *str_nianyueri1 = [self getCurrentTime1];//前一天
    NSString *str_nianyueri2 = [self getCurrentTime2];//前一天
    NSString *str_nianyueri3 = [self getCurrentTime3];//前一天
    NSString *str_nianyueri4 = [self getCurrentTime4];//前一天
    NSString *str_nianyueri5 = [self getCurrentTime5];//前一天
    NSString *str_nianyueri6 = [self getCurrentTime6];//前一天
    
    NSString *str_nianyueri00=[self getCurrentTime00];
    NSString *str_nianyueri11 = [self getCurrentTime11];//前一天
    NSString *str_nianyueri22 = [self getCurrentTime22];//前一天
    NSString *str_nianyueri33 = [self getCurrentTime33];//前一天
    NSString *str_nianyueri44 = [self getCurrentTime44];//前一天
    NSString *str_nianyueri55 = [self getCurrentTime55];//前一天
    NSString *str_nianyueri66 = [self getCurrentTime66];//前一天

    
    NSString *params6 =[NSString stringWithFormat:@"_riqi='%@'",str_nianyueri6];
    NSArray *data6 = [tool selectWithClass:[Health class] params:params6];
    if(data6.count==0)
    {
            Health *h1 = [Health initName:str_nianyueri6 riqi2:str_nianyueri66 zuozishijian:0.00 zhanzishijian:0.00 zuozhanbi:0.00];
            [tool insertWithObj:h1];
    }
    NSString *params5 =[NSString stringWithFormat:@"_riqi='%@'",str_nianyueri5];
    NSArray *data5 = [tool selectWithClass:[Health class] params:params5];
    if(data5.count==0)
    {
        Health *h1 = [Health initName:str_nianyueri5 riqi2:str_nianyueri55 zuozishijian:0.00 zhanzishijian:0.00 zuozhanbi:0.00];
        [tool insertWithObj:h1];
    }
    NSString *params4 =[NSString stringWithFormat:@"_riqi='%@'",str_nianyueri4];
    NSArray *data4 = [tool selectWithClass:[Health class] params:params4];
    if(data4.count==0)
    {
        Health *h1 = [Health initName:str_nianyueri4 riqi2:str_nianyueri44 zuozishijian:0.00 zhanzishijian:0.00 zuozhanbi:0.00];
        [tool insertWithObj:h1];
    }
    NSString *params3 =[NSString stringWithFormat:@"_riqi='%@'",str_nianyueri3];
    NSArray *data3 = [tool selectWithClass:[Health class] params:params3];
    if(data3.count==0)
    {
        Health *h1 = [Health initName:str_nianyueri3 riqi2:str_nianyueri33 zuozishijian:0.00 zhanzishijian:0.00 zuozhanbi:0.00];
        [tool insertWithObj:h1];
    }
    NSString *params2 =[NSString stringWithFormat:@"_riqi='%@'",str_nianyueri2];
    NSArray *data2 = [tool selectWithClass:[Health class] params:params2];
    if(data2.count==0)
    {
        Health *h1 = [Health initName:str_nianyueri2 riqi2:str_nianyueri22 zuozishijian:0.00 zhanzishijian:0.00 zuozhanbi:0.00];
        [tool insertWithObj:h1];
    }
    NSString *params1 =[NSString stringWithFormat:@"_riqi='%@'",str_nianyueri1];
    NSArray *data1 = [tool selectWithClass:[Health class] params:params1];
    if(data1.count==0)
    {
        Health *h1 = [Health initName:str_nianyueri1 riqi2:str_nianyueri11 zuozishijian:0.00 zhanzishijian:0.00 zuozhanbi:0.00];
        [tool insertWithObj:h1];
    }
    NSString *params0 =[NSString stringWithFormat:@"_riqi='%@'",str_nianyueri];
    NSArray *data0 = [tool selectWithClass:[Health class] params:params0];
    if(data0.count==0)
    {
        Health *h1 = [Health initName:str_nianyueri riqi2:str_nianyueri00 zuozishijian:0.00 zhanzishijian:0.00 zuozhanbi:0.00];
        [tool insertWithObj:h1];
    }
        
//    //判断是否是第一次启动
//    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
    //设置本地语言
    [self setCurrentLanguage];
    
    [self registerNotification]; // 注册通知
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
#if !TARGET_IPHONE_SIMULATOR
    self.dataformater = [[NSDateFormatter alloc] init];
    [self.dataformater setDateFormat:@"yyyyMMddHH"];
    
#endif
    
    [self redirectNSLogToDocumentFolder];
    
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    MainBlueTouchViewController *appStartController = [[MainBlueTouchViewController alloc] init];
    appStartController.navigationController.navigationBarHidden = YES;
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:appStartController];// appStartController;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    UINavigationBar *appearance =[UINavigationBar appearance];
     [appearance setBarTintColor:[Common2 colorWithHexString:@"#0B0088"]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setFrame:CGRectMake(0, 120, 320, 500)];
    
//    [UINavigationBar appearance].frame = CGRectMake(0, 20, 320, 200);
    
    if(isPadYES)
    {
         [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:22],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    }
    //    self.window.rootViewController = rootView;
    
    [self.window makeKeyAndVisible];
    
    NSLog(@"测试 application didFinishLaunchingWithOptions");
    
    return YES;
}

-(void)toast:(NSString*)message {
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

-(void)updateSoftAlertViewShow:(NSString*)message isForceUpdate:(BOOL)isForce {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"新版本发布" message:message delegate:self cancelButtonTitle:isForce?nil:@"下次更新" otherButtonTitles:@"更新", nil];
    alert.tag = 100;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        if (alertView.tag == 100) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://dwz.cn/F8pPd"]];
            exit(0);
        }
    }
}

+(AppDelegate*)shareInstance {
    return [[UIApplication sharedApplication] delegate];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    NSLog(@"推送的内容：%@",notificationSettings);
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    
    self.callid = nil;
    NSString *userdata = [userInfo objectForKey:@"c"];
    NSLog(@"远程推送userdata:%@",userdata);
    if (userdata) {
        NSDictionary*callidobj = [NSJSONSerialization JSONObjectWithData:[userdata dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"远程推送callidobj:%@",callidobj);
        if ([callidobj isKindOfClass:[NSDictionary class]]) {
            self.callid = [callidobj objectForKey:@"callid"];
        }
    }
    
    NSLog(@"远程推送 callid=%@",self.callid);
}

// 进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    self.isEnterBackground = YES;
    // 先取消所有通知
    [self cancelLocalNotification];
    
    id aCloseSitTip = [[NSUserDefaults standardUserDefaults] objectForKey:Long_time_close];
    BOOL isCloseSitTip = aCloseSitTip != nil ? [aCloseSitTip boolValue] : NO;
    if (isCloseSitTip) {
        NSLog(@"关闭久坐提醒");
        return;
    }
    if (!_isSitModel) {
        NSLog(@"非坐姿模式");
        return;
    }
    if (_lastSitTipTimeCount <= 10) {
        id aSitLongTimeInterval = [[NSUserDefaults standardUserDefaults] objectForKey:Long_time_interval];
        BOOL isSitLongTimeInterval = aSitLongTimeInterval != nil ? [aSitLongTimeInterval boolValue] : NO;
        if (isSitLongTimeInterval) {
            _lastSitTipTimeCount = 10 * 60;
        }else {
            NSString *longTime = [[NSUserDefaults standardUserDefaults] objectForKey:Long_time];
            longTime = longTime ? longTime : @"120";
            _lastSitTipTimeCount = [longTime intValue] * 60;
        }
    }
    [self registerLocalNotification];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"" object:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 进入前台
    self.isEnterBackground = NO;
}

#pragma mark --蓝牙连接完成
- (void)BLEManagerDidConnectPeripheral:(CBPeripheral *)peripheral {
    
    [SVProgressHUD dismiss];
    
    CBPeripheral *connctedPeripheral = peripheral;//当前连接成功的设备
    [SVProgressHUD showSuccessWithStatus:LocationLanguage(@"successfulConnection", @"连接成功")];
    
    
    //扫描当前连接的蓝牙设备的所有服务
    [[BLEManager sharedManager] scanningForServicesWithPeripheral:connctedPeripheral];
    
}

- (void)BLEManagerReceiveAllService:(CBService *)service
{
    //    [thisServices addObject:service];
    //    [thisServiceTableView reloadData];
}


# pragma mark - BLEManager Methods
- (void)BLEManagerDisabledDelegate {
    
}



#pragma mark --接收到扫描到得所有设备
- (void)BLEManagerReceiveAllPeripherals:(NSMutableArray *) peripherals andAdvertisements:(NSMutableArray *)advertisements {
    
    [SVProgressHUD dismiss];//结束转圈
    //    [dataSource addObjectsFromArray:peripherals];//加入数据源
    //    [advertisementsDataSource addObjectsFromArray:advertisements];
    //    [blueListTableview reloadData];
    
}

#pragma mark --蓝牙连接失败
- (void)BLEManagerDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"蓝牙连接失败，请重新连接");
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"zhanzigaodulasttime"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"zuozigaodulasttime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark --接受数据返回的信息及广播
- (void)BLEManagerReceiveData:(NSData *)value fromPeripheral:(CBPeripheral *)peripheral andServiceUUID:(NSString *)serviceUUID andCharacteristicUUID:(NSString *)charUUID
{
    
    NSLog(@"receve value : %@",value);
    NSString *backString = [[NSString alloc]initWithData:value encoding:NSUTF8StringEncoding];
    
    //    NSLog(@"receve value : %@",backString);
    //    notifyLabel.text = backString;
    
}



@end
