//
//  HexUtils.h
//  ChinaDream
//
//  Created by zhangfeng on 12-11-26.
//  Copyright (c) 2012年 eastedge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface HexUtils : NSObject

+ (NSString *)encodeHexData:(NSData *)data;

+ (NSString *)getShijianjiange_tian:(NSString *)beginTimestamp endTimestamp:(NSString *)endTimestamp;

+ (NSString *)getShijianjiange:(NSString *)beginTimestamp endTimestamp:(NSString *)endTimestamp;

+ (NSString *)getShijianjiange_seconds:(NSString *)beginTimestamp endTimestamp:(NSString *)endTimestamp;


+  (NSString *)getNianyueri:(NSString *)shijianchuo;

+ (NSString *)getDanweiCmd:(NSString *)height;

+ (NSString *)getZixuexiCmd:(NSString *)height;

+ (NSString *)getCrashDefendCmd:(NSString *)height;

+ (NSString *)getScreenTimeCmd:(int)height;

+ (NSString *)getHandlerBrightnessCmd:(NSString *)height;

+ (NSString *)getisBuzzerOpenedCmd:(NSString *)height;

+ (NSString *)hexToCompleteNum:(NSString *)paramString;
// 十六进制转换为普通字符串。
+ (NSNumber *) numberHexString:(NSString *)aHexString;

+ (NSString *)addToCompleteStr:(NSString *)paramString;

+ (NSString *)generateCheckCode:(NSString *)paramString;

+ (NSString *)getAutoLearnCmd;

+ (int)isOdd:(int) paramInt;

+(NSString *)ToHex:(long long int)tmpid;

+ (NSString *)getCheckSum2:(NSString *)byteStr;

+ (NSData *)getCheckSum:(NSData *)byteStr;


+ (NSString *)getSetHeightCmd:(CGFloat)height;

+(NSData*) HexToByteArr:(NSString *) inHex;

+ (NSData*) hexToBytes:(NSString *)paramString;

//- (NSData*)hexToBytes:(NSString *)str;

//路径
+ (NSString *)pathWithFile:(NSString *)file;
//是否存在文件
+ (BOOL)existsFile:(NSString *)file;
//把数组写入文件
+ (void)writeArrToFile:(NSArray *)arr fileName:(NSString *)file;
//把字典写入文件
+ (void)writeDicToFile:(NSDictionary *)dic fileName:(NSString *)file;
//解析文件得到数组
+ (NSArray *)parseArrFromFile:(NSString *)file;
//解析文件得到字典
+ (NSDictionary *)parseDicFromFile:(NSString *)file;
//存储数据
+ (BOOL)writerData:(NSData *)data toFile:(NSString *)file;
//读取数据
+ (NSData *)readDataWithFile:(NSString *)file;

#pragma mark 获取UUID
+ (NSString*) getUUID;

#pragma mark - 获取指定长度的纯数字随机码
+ (NSString *)getNumbersWithIndex:(NSInteger)index;

#pragma mark - 转化NSDate为字符串
+ (NSString *)encodeDate:(NSDate *)date;

#pragma mark - 转化NSDate为字符串 （自定义格式）
+ (NSString *)encodeDate:(NSDate *)date withFormatterString:(NSString *)fromatter;

#pragma mark - 检查是否为字符串
+ (NSString *)checkString:(NSString *)str;

#pragma mark 显示信息
+ (void)showAlertWithMessage:(NSString *)msg;

#pragma mark - 获取用户ID
+ (NSString *)getUserId;
+ (NSString *)getBfdUserId;

#pragma mark - 检测登陆状态
+ (BOOL)checkLoginStates;

#pragma mark - 检测时间间隔
+ (BOOL)checktimeinterval:(NSInteger)timeInterval;

#pragma mark - 检测网络
+ (NSInteger)checkNetWork;

#pragma mark - 验证价格 double
+ (NSString *)checkPrice:(CGFloat)price;

#pragma mark - 验证折扣 double
+ (NSString *)checkDiscount:(CGFloat)price;

#pragma mark - 请求更新Ptoken绑定用户
+ (void)requestUpDatePtokenAndUserToken;

#pragma mark - 请求更新购物车数量
+ (void)requestUpDateCarNums;

#pragma mark - 更新购物车数量
+ (void)upDateCarNumsWithDic:(NSDictionary *)dic isPushNotification:(BOOL)isPush;

#pragma mark - 加入购物车动画
//+ (void)addCarWithFrom:(UIButton *)from to:(UIButton *)to;
+ (void)addCarWithFrom:(UIButton *)from to:(UIButton *)to startImgView:(UIImageView *)startImgView;
+ (void)addCarWithFroms:(UIImageView *)from to:(UIButton *)to startImgView:(UIImageView *)startImgView;
#pragma mark - 添加异常日志
+ (void)addErrorTitle:(NSString *)errorTitle errorStr:(NSString *)errorStr
           requestStr:(NSString *)requestStr resPonseStr:(NSString *)resPonseStr;

#pragma mark - 加入购物车完毕时的抖动
+ (void)addAnimationsWithBtn:(UIButton *)sender;

#pragma mark - 检测URL
+ (NSURL *)urlWithStr:(NSString *)str;

#pragma mark - 展示一般的警告
+ (void)showAlertHUD:(NSString *)message;

+ (void)showAlertHUD:(NSString *)message timeOut:(NSInteger)timeOut;

+ (void)showStateBarBg;

+ (void)hideStateBarBg;

+ (NSString *)deviceVersion;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font size:(CGSize)size;

#pragma mark - 99click
+(void)countView:(NSString *)pageTitle;
+(void)countView:(NSString *)pageTitle andPageOzprm:(NSString *)pageOzprm;


+(void)countClick:(NSString *)pageTitle andClkObjName:(NSString *)clkObjName;



/*
 *  功能：点击监测
 *      参数：
 *          pageTitle：      点击对象所在的页面主题
 *          clkObjName：     点击对象名称
 *          pageOzprm：      页面客户自定义参数，格式如"search=351&ozsru=member20141211"
 **/
+(void) countClick: (NSString *) pageTitle
     andClkObjName: (NSString *) clkObjName
      andPageOzprm: (NSString *) pageOzprm;

/*
 *	功能：设置APP订单中一个产品的属性
 *		参数
 *			skuAttrDictionary：		内容为属性的“name-value”对，name需要和系统设置或提供的一致
 **/
+(void) setSku : (NSDictionary *) skuAttrDictionary;

/*
 *	功能：设置APP中一个订单的属性
 *		参数：
 *			orderAttrDictionary：	内容为属性的“name-value”对，name需要和系统设置或提供的一致
 **/
+(void) setOrder : (NSDictionary *) orderAttrDictionary;

@end






/*
//消去键盘
static void  ResignFirstResponder(int paramsCount,...)
{
    va_list args;// 定义一个 va_list 指针来访问参数表
    id obj;
    va_start(args, paramsCount);// 初始化 args，让它指向第一个变参,即参数paramsCount
    
    int tmpCount=0;
    do
    {
        obj = va_arg(args, id); // 获取一个 NSString 型参数，并且 args 指向下一个参数
        [obj resignFirstResponder];
        ++tmpCount;
    }while(tmpCount != paramsCount);
    va_end(args);//关闭指针，即 args == NULL
}
 */

