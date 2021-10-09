//
//  CCommon2.h
//  waimaidan
//
//  Created by 国洪 徐 on 12-12-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "Global.h"



@interface MLNavigationController : UINavigationController

@property (nonatomic, assign) UIImage *m_image;

- (UIViewController *)popViewControllerAnimated:(BOOL)animated;

@end


@class AppDelegate;
@interface Common2 : NSObject

+ (CGRect)rectWithOrigin:(CGRect)rect x:(CGFloat)x y:(CGFloat)y;

//#009900
+ (UIColor *)colorWithHexString:(NSString*)stringToConvert;
+ (NSString *)compareCurrentTime:(NSDate *)date;

+ (NSString *)descriptionForDistance:(NSInteger)d;

+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;
+ (NSString *)genRandStringLength:(int)len;
+(float)distanceFrom:(CLLocationCoordinate2D)posA to:(CLLocationCoordinate2D)posB;

+ (NSString *)curDateParam;
+ (NSString *)dateDescWithDate:(NSDate*)date;

+ (float)heightForString:(NSString*)title Width:(int)width Font:(UIFont*)font;

+ (BOOL)isValidateEmail:(NSString *)email;

+ (UIImage *)imageWithView:(UIView *)view;

//将屏幕区域截图 生成：
+ (UIImage *)imageWithView:(UIView *)view forSize:(CGSize)size;

//把UIColor对象转化成UIImage对象
+ (UIImage*)createImageWithColor:(UIColor *)color;

+ (long)getLongTime;

+ (BOOL)checkNetworkIsValid;

//服务器返回时间戳进行转换
+ (NSString *)getServerTime:(long)timeLine type:(int)type;

+ (NSString*)getYearMonthDay;

+ (int)getJingYi:(int)chusu BeiChuShu:(int)beichushu;

+ (NSString *)getDeviceUUId;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (BOOL)digistJudge:(NSString *)strInfo count:(int)count;

+ (void)changeArray:(NSMutableArray *)dicArray orderWithKey:(NSString *)key ascending:(BOOL)yesOrNo;

//+ (UILabel*)createLabel:(CGRect)rect TextColor:(NSString*)color Font:(UIFont*)font textAlignment:(UITextAlignment)alignment labTitle:(NSString*)title;

+ (NSString*)datePath;

+ (NSString*)getPicPath;

//店铺图标路径
+ (NSString*)shopIconPath;

+ (UILabel*)createLabel:(CGRect)rect;

+ (UIView*)createTableFooter;



//提示对话框
+ (void)TipDialog:(NSString*)aInfo;

+ (UIBarButtonItem*)CreateNavBarButton:(id)target setEvent:(SEL)sel background:(NSString*)imageName setTitle:(NSString*)title;

//获得text的字节数
+ (int)unicodeLengthOfString:(NSString*)text;

+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize Image:(UIImage*)image;

+ (BOOL)isTheSameData:(long)timeLine1 :(long)timeLine2;

+ (AppDelegate*)getAppDelegate;

@end



