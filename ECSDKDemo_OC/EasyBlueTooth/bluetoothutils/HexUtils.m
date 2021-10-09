//
//  HexUtils.m
//  ChinaDream
//
//  Created by zhangfeng on 12-11-26.
//  Copyright (c) 2012年 eastedge. All rights reserved.
//

#import "HexUtils.h"
//#import "Reachability.h"
#import "AppDelegate.h"
#import "sys/utsname.h"
#import <AVFoundation/AVFoundation.h>
//#import "NSString+URLEncoding.h"

#import "BleCmdUtil.h"
#import "NSStringConvertUtil.h"

@implementation HexUtils


static char DIGITS_UPPER[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
static char *encodeHex(const char *data, int size, char hexTable[]) {
    char *output = malloc(size * 2);
    return encodeHexInternal(output, data, size, hexTable);
}

static char *encodeHexInternal(char *output_buf, const char *data, int size, char hexTable[]) {
    for (int i = 0, j = 0; i < size; i++) {
        output_buf[j++] = hexTable[((0XF0 & data[i]) >> 4) & 0X0F];
        output_buf[j++] = hexTable[((0X0F & data[i])) & 0X0F];
    }
    return output_buf;
}

+ (NSString *)encodeHexData:(NSData *)data {
    char *e = encodeHex(data.bytes, (int)data.length, DIGITS_UPPER);
    NSString *str = [[NSString alloc] initWithBytes:e length:data.length * 2 encoding:NSASCIIStringEncoding];
    free(e);
    return str;
}



+ (NSString *)hexToCompleteNum:(NSString *)paramString
{
//    NSString *paramString =@"31413034";
    //    NSString *theString2 = [NSString stringWithFormat:@"%C", bbb];
    
    NSString *str_one = [paramString substringToIndex:2];
    NSString *str_one2= [paramString substringFromIndex:2];
    
    NSString *str_two = [str_one2 substringToIndex:2];
    NSString *str_two2= [str_one2 substringFromIndex:2];
    
    NSString *str_three = [str_two2 substringToIndex:2];
    NSString *str_three2= [str_two2 substringFromIndex:2];
    
    NSString *str_four = [str_three2 substringToIndex:2];
    NSString *str_four2= [str_three2 substringFromIndex:2];
    
    
    NSNumber *asciiCode1 =[HexUtils numberHexString:str_one];
    NSString *str_asciiCode1 = [NSString stringWithFormat:@"%C", (unichar)asciiCode1.intValue]; // A
    
    NSNumber *asciiCode2 =[HexUtils numberHexString:str_two];
    NSString *str_asciiCode2 = [NSString stringWithFormat:@"%C", (unichar)asciiCode2.intValue];
    
    NSNumber *asciiCode3 =[HexUtils numberHexString:str_three];
    NSString *str_asciiCode3 = [NSString stringWithFormat:@"%C", (unichar)asciiCode3.intValue];
    
    NSNumber *asciiCode4 =[HexUtils numberHexString:str_four];
    NSString *str_asciiCode4 = [NSString stringWithFormat:@"%C", (unichar)asciiCode4.intValue];
    
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
    if ([str_gaodu isEqualToString:@"0"]) {
        str_gaodu = @"0.0";
    }else if (str_gaodu.length == 2) {
        str_gaodu = [NSString stringWithFormat:@"0.%@", [str_gaodu substringToIndex:2]];
    }else if (str_gaodu.length == 3) {
        str_gaodu = [NSString stringWithFormat:@"%@.%@",[str_gaodu substringToIndex:1], [[str_gaodu substringFromIndex:1]  substringToIndex:1]];
    }else if(str_gaodu.length == 4) {
        str_gaodu = [NSString stringWithFormat:@"%@.%@",[str_gaodu substringToIndex:2], [[str_gaodu substringFromIndex:2]  substringToIndex:1]];
    }else if(str_gaodu.length == 5) {
        str_gaodu = [NSString stringWithFormat:@"%@.%@",[str_gaodu substringToIndex:3], [[str_gaodu substringFromIndex:3]  substringToIndex:1]];
    }
    
    NSLog(@"收到返回的单位-高度数据 = %@",str_gaodu);
    return str_gaodu;
    
}

// 十六进制转换为普通字符串。
+ (NSNumber *) numberHexString:(NSString *)aHexString

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

+ (NSString *)addToCompleteStr:(NSString *)paramString
{
    return [NSString stringWithFormat:@"%@%@%@",@"1B",paramString,@"05"];

}


/**
 *
 *ascii码 ---> HexStr
 *
 */

+ (NSString *)asciiStringToHex:(NSString *)str
{
    
//    char[] chars = str.toCharArray();
//    
//    StringBuffer hex = new StringBuffer();
//    for(int i = 0; i < chars.length; i++){
//        hex.append(Integer.toHexString((int)chars[i]));
//    }
//    
//    return hex.toString();
    
    return@"";
}


+ (NSString *)getCheckSum2:(NSString *)byteStr{
    int length = (int)byteStr.length;
    
//    NSString *testString = @"1234567890";
    
    NSData *testData = [byteStr dataUsingEncoding: NSUTF8StringEncoding];
    
    Byte *bytes = (Byte *)[testData bytes];
    
 
    
    // NSData *data = [self hexToBytes:byteStr];
//    Byte *bytes = (unsigned char *)[byteStr bytes];
    Byte sum = 0;
    for (int i = 0; i<length; i++) {
        sum += bytes[i];
    }
    int sumT = sum;
    int at = 256 -  sumT;
    
    printf("校验和：%d\n",at);
    printf("累加和：%d\n",sumT);
    if (at == 256) {
        at = 0;
    }
    NSString *str = [NSString stringWithFormat:@"%@",[NSStringConvertUtil ToHex:sumT]];
    return str;
}

+ (NSData *)getCheckSum:(NSData *)byteStr{
    int length = (int)byteStr.length;
    // NSData *data = [self hexToBytes:byteStr];
    Byte *bytes = (unsigned char *)[byteStr bytes];
    Byte sum = 0;
    for (int i = 0; i<length; i++) {
        sum += bytes[i];
    }
    int sumT = sum;
    int at = 256 -  sumT;
    
    printf("校验和：%d\n",at);
    printf("累加和：%d\n",sumT);
    if (at == 256) {
        at = 0;
    }
    NSString *str = [NSString stringWithFormat:@"%@",[NSStringConvertUtil ToHex:sumT]];
    return [self hexToBytes:str];
}

+ (NSString *)generateCheckCode:(NSString *)paramString
{
    
//    String ascStr = hexToAscii(asciiStringToHex(str));
//    
//    int cs = 0 ;
//    char[] chars = ascStr.toCharArray();
//    for(char c:chars){
//        cs = cs + c;
//    }
//    return asciiStringToHex(str)+asciiStringToHex(Integer.toHexString(cs % 256).toUpperCase());
    
    
//    NSString *ascStr = hexToAscii(asciiStringToHex(str));
//    
//    int cs = 0 ;
//    char[] chars = ascStr.toCharArray();
//    for(char c:chars){
//        cs = cs + c;
//    }
//    return asciiStringToHex(str)+asciiStringToHex(Integer.toHexString(cs % 256).toUpperCase());
//    return [NSString stringWithFormat:@"%@%@%@",@"1B",paramString,@"05"];
//    return paramString;
    
    int length = (int)paramString.length;
    
    //    NSString *testString = @"1234567890";
    
    NSData *testData = [paramString dataUsingEncoding: NSUTF8StringEncoding];
    
    Byte *bytes = (Byte *)[testData bytes];
    
    
    
//     NSData *data = [self hexToBytes:byteStr];
//        Byte *bytes = (unsigned char *)[byteStr bytes];
    
    
    Byte sum = 0;
    for (int i = 0; i<length; i++) {
        sum += bytes[i];
    }
    int sumT = sum;
    int at = 256 -  sumT;
    
    printf("校验和：%d\n",at);
    printf("累加和：%d\n",sumT);
    if (at == 256) {
        at = 0;
    }
    
    NSString *strparamString = [NSStringConvertUtil hexStringFromString:paramString];
    NSString *strsumT = [[NSStringConvertUtil ToHex:sumT] uppercaseString];
    
   NSString *strsumT_HEX = [NSStringConvertUtil hexStringFromString:strsumT];
    
    NSString *str = [NSString stringWithFormat:@"%@%@",[NSStringConvertUtil hexStringFromString:paramString],[NSStringConvertUtil hexStringFromString:[NSStringConvertUtil ToHex:sumT]]];
    return str;

}

//+ (NSString *)getAutoLearnCmd
//{
//
//    return [self addToCompleteStr:[self generateCheckCode:@"PW2002010001"]];
//
//}

+ (int)isOdd:(int) paramInt
{
    return paramInt & 0x1;
    
}


// NSString 转 NSData

+(NSData*) HexToByteArr:(NSString *) inHex {
    
    NSMutableData *data = [NSMutableData data];
    
    int idx;
    
    for (idx = 0; idx+2 <= inHex.length; idx+=2) {
        
        NSRange range = NSMakeRange(idx, 2);
        
        NSString* hexStr = [inHex substringWithRange:range];
        
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        
        unsigned int intValue;
        
        [scanner scanHexInt:&intValue];
        
        [data appendBytes:&intValue length:1];
        
    }
    
    return data;
    
}

//字符串转data
- (NSData*)hexToBytes:(NSString *)str
{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= str.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [str substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}


+ (NSString *)toHexString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr]; 
    } 
    return hexStr; 
}

+ (NSString *)toHexData:(int)num {
    NSString *hex = [[NSStringConvertUtil ToHex:num] uppercaseString];
    if(hex.length == 1){
        hex = [NSString stringWithFormat:@"000%@",hex];
    }else if (hex.length == 2){
        hex = [NSString stringWithFormat:@"00%@",hex];
    }else if (hex.length == 3){
        hex = [NSString stringWithFormat:@"0%@",hex];
    }
    return hex;
}


//字符串转data
+ (NSData*)hexToBytes:(NSString *)paramString {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= paramString.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [paramString substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}


//+ (NSData*) hexToBytes:(NSString *)paramString
//{
//    NSMutableData *data =[NSMutableData data];
//    
//    int idx;
//    
//    for (idx = 0; idx+2 <= paramString.length; idx+=2) {
//        
//        NSRange range = NSMakeRange(idx, 2);
//        
//        NSString* hexStr = [paramString substringWithRange:range];
//        
//        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
//        
//        unsigned int intValue;
//        
//        [scanner scanHexInt:&intValue];
//        
//        [data appendBytes:&intValue length:1];
//        
//        
//    }
//    
//    return data;
//    
//}


////转hex字符串转字节数组
//+  (byte[]) HexToByteArr:(NSString *)inHex {
//    inHex = inHex.replaceAll(" ", "");
//    byte[] result;
//    int hexLen = inHex.length();
//    if (isOdd(hexLen) == 1) {
//        hexLen++;
//        result = new byte[(hexLen / 2)];
//        inHex = @"0" + inHex;
//    } else {
//        result = new byte[(hexLen / 2)];
//    }
//    int j = 0;
//    for (int i = 0; i < hexLen; i += 2) {
//        result[j] = HexToByte(inHex.substring(i, i + 2));
//        j++;
//    }
//    return result;
//}

+ (NSString *)getShijianjiange:(NSString *)beginTimestamp endTimestamp:(NSString *)endTimestamp
{
    //时间戳
//    NSString *beginTimestamp = @"1520842123";
//    NSString *endTimestamp = @"1520846323";
    
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:MM:ss"];//@"yyyy-MM-dd-HHMMss"
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[beginTimestamp doubleValue]];
    NSString *dateString = [formatter stringFromDate:date];
    NSLog(@"开始时间: %@", dateString);
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[endTimestamp doubleValue]];
    NSString *dateString2 = [formatter stringFromDate:date2];
    NSLog(@"结束时间: %@", dateString2);
    NSTimeInterval seconds = [date2 timeIntervalSinceDate:date];
    NSLog(@"两个时间相隔：%.f", seconds);
    
    NSString *str_hour = [NSString stringWithFormat:@"%.6f",seconds/3600];
    
    return str_hour;
}

+ (NSString *)getShijianjiange_seconds:(NSString *)beginTimestamp endTimestamp:(NSString *)endTimestamp {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:MM:ss"];//@"yyyy-MM-dd-HHMMss"
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[beginTimestamp doubleValue]];
    NSString *dateString = [formatter stringFromDate:date];
    NSLog(@"开始时间: %@", dateString);
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[endTimestamp doubleValue]];
    NSString *dateString2 = [formatter stringFromDate:date2];
    NSLog(@"结束时间: %@", dateString2);
    NSTimeInterval seconds = [date2 timeIntervalSinceDate:date];
    NSLog(@"两个时间相隔：%.f", seconds);
    
    return [NSString stringWithFormat:@"%d", (int)seconds / 60];
}

+ (NSString *)getShijianjiange_tian:(NSString *)beginTimestamp endTimestamp:(NSString *)endTimestamp
{
    //时间戳
    //    NSString *beginTimestamp = @"1520842123";
    //    NSString *endTimestamp = @"1520846323";
    
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:MM:ss"];//@"yyyy-MM-dd-HHMMss"
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[beginTimestamp doubleValue]];
    NSString *dateString = [formatter stringFromDate:date];
    NSLog(@"开始时间: %@", dateString);
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[endTimestamp doubleValue]];
    NSString *dateString2 = [formatter stringFromDate:date2];
    NSLog(@"结束时间: %@", dateString2);
    NSTimeInterval seconds = [date2 timeIntervalSinceDate:date];
    NSLog(@"两个时间相隔：%.f", seconds);
    
    NSString *str_hour = [NSString stringWithFormat:@"%.6f",seconds/3600/24];
    
    return str_hour;
    
    
}

+  (NSString *)getNianyueri:(NSString *)shijianchuo
{
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[shijianchuo doubleValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:date];
    NSLog(@"年月日: %@", dateTime);
    return dateTime;
    
}

+ (NSString *)getDanweiCmd:(NSString *)height
{
    
    NSString * strHeightCmdCode = CODE_DISPLAY_UNIT;
    
    //    NSString *strHexData = [self toHexData:(height * 100)];
    //
    //    NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@%@",strHeightCmdCode,strHexData];
    
    NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@%@",strHeightCmdCode,height];
    NSLog(@"发送的命令是%@",strHeightCmdCode_strHexData);
    NSString *strCheckCode = [self generateCheckCode:strHeightCmdCode_strHexData];
    
    //    strCheckCode =1BCW201002000327104C05
    //                    CW20100200032710
    
    NSString * strHeightCmd = [self addToCompleteStr:strCheckCode];
    
    //self addToCompleteStr(HexUtils.generateCheckCode(CODE_RUN_SET_HEIGHT + HexUtils.toHexData(height * 100);
    //public static String getSetHeightCmd(int height) {
    //    return addToCompleteStr(HexUtils.generateCheckCode(CODE_RUN_SET_HEIGHT + HexUtils.toHexData(height * 100)));
    return strHeightCmd;
}

+ (NSString *)getZixuexiCmd:(NSString *)height
{
    
    NSString * strHeightCmdCode = CODE_AUTO_LEARN;
    
    //    NSString *strHexData = [self toHexData:(height * 100)];
    //
    //    NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@%@",strHeightCmdCode,strHexData];
    
    NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@%@",strHeightCmdCode,height];
    NSString *strCheckCode = [self generateCheckCode:strHeightCmdCode_strHexData];
    
    //    strCheckCode =1BCW201002000327104C05
    //                    CW20100200032710
    
    NSString * strHeightCmd = [self addToCompleteStr:strCheckCode];
    
    //self addToCompleteStr(HexUtils.generateCheckCode(CODE_RUN_SET_HEIGHT + HexUtils.toHexData(height * 100);
    //public static String getSetHeightCmd(int height) {
    //    return addToCompleteStr(HexUtils.generateCheckCode(CODE_RUN_SET_HEIGHT + HexUtils.toHexData(height * 100)));
    return strHeightCmd;
}

+ (NSString *)getCrashDefendCmd:(NSString *)height
{
    
    NSString * strHeightCmdCode = CODE_CRASH_DEFEND;
    
    //    NSString *strHexData = [self toHexData:(height * 100)];
    //
    //    NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@%@",strHeightCmdCode,strHexData];
    
    NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@%@",strHeightCmdCode,height];
    NSString *strCheckCode = [self generateCheckCode:strHeightCmdCode_strHexData];
    
    //    strCheckCode =1BCW201002000327104C05
    //                    CW20100200032710
    
    NSString * strHeightCmd = [self addToCompleteStr:strCheckCode];
    
    //self addToCompleteStr(HexUtils.generateCheckCode(CODE_RUN_SET_HEIGHT + HexUtils.toHexData(height * 100);
    //public static String getSetHeightCmd(int height) {
    //    return addToCompleteStr(HexUtils.generateCheckCode(CODE_RUN_SET_HEIGHT + HexUtils.toHexData(height * 100)));
    return strHeightCmd;
}

+ (NSString *)getScreenTimeCmd:(int)height
{
    NSString * strHeightCmdCode = CODE_SCREEN_TIME;
    
    NSString *hexHeight = [NSStringConvertUtil ToHex:height];
    
    NSString *strHexData =@"";//  = [NSString stringWithFormat:@"00%@",[NSStringConvertUtil ToHex:height]];
    
    if(hexHeight.length == 1)
    {
        strHexData  = [NSString stringWithFormat:@"000%@", hexHeight];
    }
    else if(hexHeight.length == 2)
    {
        strHexData  = [NSString stringWithFormat:@"00%@", hexHeight];
    }
    else if(hexHeight.length == 3)
    {
        strHexData  = [NSString stringWithFormat:@"0%@", hexHeight];
    }
        
    
    NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@%@",strHeightCmdCode, strHexData];
    
    NSString *strCheckCode = [self generateCheckCode:strHeightCmdCode_strHexData];
    
    //    strCheckCode =1BCW201002000327104C05
    //                    CW20100200032710
    
    NSString * strHeightCmd = [self addToCompleteStr:strCheckCode];
    
    
//    NSString * strHeightCmdCode = CODE_SCREEN_TIME;
//    
//    //    NSString *strHexData = [self toHexData:(height * 100)];
//    //
//    //    NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@%@",strHeightCmdCode,strHexData];
//    
//    NSString *strCheckCode = [self generateCheckCode:strHeightCmdCode];
//    
//    //    strCheckCode =1BCW201002000327104C05
//    //                    CW20100200032710
//    
//    NSString * strHeightCmd = [self addToCompleteStr:strCheckCode];
    
    //self addToCompleteStr(HexUtils.generateCheckCode(CODE_RUN_SET_HEIGHT + HexUtils.toHexData(height * 100);
    //public static String getSetHeightCmd(int height) {
    //    return addToCompleteStr(HexUtils.generateCheckCode(CODE_RUN_SET_HEIGHT + HexUtils.toHexData(height * 100)));
    return strHeightCmd;
}

+ (NSString *)getHandlerBrightnessCmd:(NSString *)height
{
    
    NSString * strHeightCmdCode = CODE_HANDLER_BRIGHTNESS;
    
    
    //    NSString *strHexData = [self toHexData:(height * 100)];
    //
    //    NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@%@",strHeightCmdCode,strHexData];
    NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@%@",strHeightCmdCode,height];
    NSString *strCheckCode = [self generateCheckCode:strHeightCmdCode_strHexData];
    
    //    strCheckCode =1BCW201002000327104C05
    //                    CW20100200032710
    
    NSString * strHeightCmd = [self addToCompleteStr:strCheckCode];
    
    //self addToCompleteStr(HexUtils.generateCheckCode(CODE_RUN_SET_HEIGHT + HexUtils.toHexData(height * 100);
    //public static String getSetHeightCmd(int height) {
    //    return addToCompleteStr(HexUtils.generateCheckCode(CODE_RUN_SET_HEIGHT + HexUtils.toHexData(height * 100)));
    return strHeightCmd;
}

+ (NSString *)getisBuzzerOpenedCmd:(NSString *)height
{
    
    NSString * strHeightCmdCode = CODE_BUZZER;
    
    //    NSString *strHexData = [self toHexData:(height * 100)];
    //
    //    NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@%@",strHeightCmdCode,strHexData];
    NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@%@",strHeightCmdCode,height];
    NSString *strCheckCode = [self generateCheckCode:strHeightCmdCode_strHexData];
    
    //    strCheckCode =1BCW201002000327104C05
    //                    CW20100200032710
    
    NSString * strHeightCmd = [self addToCompleteStr:strCheckCode];
    
    //self addToCompleteStr(HexUtils.generateCheckCode(CODE_RUN_SET_HEIGHT + HexUtils.toHexData(height * 100);
    //public static String getSetHeightCmd(int height) {
    //    return addToCompleteStr(HexUtils.generateCheckCode(CODE_RUN_SET_HEIGHT + HexUtils.toHexData(height * 100)));
    return strHeightCmd;
}


+ (NSString *)getSetHeightCmd:(CGFloat)height {
    height += 0.00001;
    NSString * strHeightCmdCode = CODE_RUN_SET_HEIGHT;
    
    int hhhhhh = floorf(height * 100);
    NSString *strHexData = [self toHexData:hhhhhh];
    
    NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@%@",strHeightCmdCode,strHexData];
    
    NSString *strCheckCode = [self generateCheckCode:strHeightCmdCode_strHexData];
    
//    strCheckCode =1BCW201002000327104C05
//                    CW20100200032710
    
    NSString * strHeightCmd = [self addToCompleteStr:strCheckCode];
    
    //self addToCompleteStr(HexUtils.generateCheckCode(CODE_RUN_SET_HEIGHT + HexUtils.toHexData(height * 100);
//public static String getSetHeightCmd(int height) {
//    return addToCompleteStr(HexUtils.generateCheckCode(CODE_RUN_SET_HEIGHT + HexUtils.toHexData(height * 100)));
    return strHeightCmd;
}


+ (NSString *)getAutoLearnCmd
{

    NSString * strHeightCmdCode = CODE_AUTO_LEARN;

//    NSString *strHexData = [self toHexData:(height * 100)];
//
//    NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@%@",strHeightCmdCode,strHexData];

    NSString *strCheckCode = [self generateCheckCode:strHeightCmdCode];

    //    strCheckCode =1BCW201002000327104C05
    //                    CW20100200032710

    NSString * strHeightCmd = [self addToCompleteStr:strCheckCode];

    //self addToCompleteStr(HexUtils.generateCheckCode(CODE_RUN_SET_HEIGHT + HexUtils.toHexData(height * 100);
    //public static String getSetHeightCmd(int height) {
    //    return addToCompleteStr(HexUtils.generateCheckCode(CODE_RUN_SET_HEIGHT + HexUtils.toHexData(height * 100)));
    return strHeightCmd;
}


//public static String getSetHeightCmd(int height) {
//    return addToCompleteStr(HexUtils.generateCheckCode(CODE_RUN_SET_HEIGHT + HexUtils.toHexData(height * 100)));
//}


////NSData 转 NSString
//
//-(NSString*) hexToBytes:(NSData*)KeyData {
//    
//    NSString *hexStr=@"";
//    
//    for(int i=0;i<[KeyData length];i++)
//    
//    {
//        
//        NSString *newHexStr = [NSString stringWithFormat:@"%x",mimabyte[i]&0xff];///16进制数
//        
//        if([newHexStr length]==1)
//        
//        hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
//        
//        else
//        
//        hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
//        
//    }
//    
//    return hexStr;
//    
//}






#pragma mark -
#pragma mark 文件的读写
//路径
+ (NSString *)pathWithFile:(NSString *)file
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    NSString *filename = [path stringByAppendingPathComponent:file];
    path = nil;
    
    return filename;
}

//是否存在文件
+ (BOOL)existsFile:(NSString *)file
{
    NSString *filename = [self pathWithFile:file];
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filename];
    filename = nil;
    
    return isExist;
}

//把数组写入文件
+ (void)writeArrToFile:(NSArray *)arr fileName:(NSString *)file
{
    NSString *filename = [self pathWithFile:file];
    [arr writeToFile:filename  atomically:YES];
    filename = nil;
}

//把字典写入文件
+ (void)writeDicToFile:(NSDictionary *)dic fileName:(NSString *)file
{
    @autoreleasepool {
        NSString *filename = [self pathWithFile:file];
        [dic writeToFile:filename  atomically:YES];
        filename = nil;
    }
}

//解析文件得到数组
+ (NSArray *)parseArrFromFile:(NSString *)file
{
	NSString *filename = [self pathWithFile:file];
	NSMutableArray *array=[[NSMutableArray alloc] initWithContentsOfFile:filename];
    filename = nil;
    
	return array;
}

//解析文件得到字典
+ (NSDictionary *)parseDicFromFile:(NSString *)file
{
	//	读操作
	NSString *filename = [self pathWithFile:file];
	NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    filename = nil;
    
	return dic;
}

//存储数据
+ (BOOL)writerData:(NSData *)data toFile:(NSString *)file
{
    NSString *filename = [self pathWithFile:file];
    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filename]) {
//        [[NSFileManager defaultManager] removeItemAtPath:filename error:NULL];
//    }
    
    BOOL isFinished = [[NSFileManager defaultManager] createFileAtPath:filename contents:data attributes:nil];
    filename = nil;
    
    return isFinished;
}

//读取数据
+ (NSData *)readDataWithFile:(NSString *)file
{
    NSString *filename = [self pathWithFile:file];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    filename = nil;
    
    return data;
}

#pragma mark 获取UUID 
+ (NSString*) getUUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    
    return result;
}

#pragma mark - 获取指定长度的纯数字随机码
+ (NSString *)getNumbersWithIndex:(NSInteger)index
{
    NSString *str = @"1234567890qwertyuiopasdfghjklzxcvbnm";
    
    for (int i = 0; i < index; ++i) {
        @autoreleasepool {
            NSInteger code = arc4random()%10;
            str = [str stringByAppendingFormat:@"%ld",(long)code];
        }
    }
    
    return str;
}

#pragma mark - 转化NSDate为字符串
+ (NSString *)encodeDate:(NSDate *)date
{
    return [HexUtils encodeDate:date withFormatterString:@"yyyy-MM-dd HH:mm:ss"];
}

#pragma mark - 转化NSDate为字符串 （自定义格式）
+ (NSString *)encodeDate:(NSDate *)date withFormatterString:(NSString *)fromatter
{
    NSDateFormatter *tmpFormatter = [[NSDateFormatter alloc] init];
    [tmpFormatter setDateFormat:fromatter];
    return [tmpFormatter stringFromDate:date];
}

#pragma mark - 检查是否为字符串
+ (NSString *)checkString:(NSString *)str
{
    if ([str isKindOfClass:[NSString  class]]) {
        return str;
    }
    
    return @"";
}

#pragma mark 显示信息
+ (void)showAlertWithMessage:(NSString *)msg
{
    UIAlertView *alertMsg = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alertMsg show];
}

//#pragma mark - 获取用户ID
//+ (NSString *)getUserId
//{
//    //已登录
//    if ([self checkLoginStates]) {
//        return [UserDefaults objectForKey:oyxc_userName];
//    }
//    //未登录
//    return [UserDefaults objectForKey:oyxc_uuid];
//}
//+ (NSString *)getBfdUserId
//{
////    //已登录
////    if ([UserDefaults objectForKey:bfd_userName]) {
////        return [UserDefaults objectForKey:bfd_userName];
////    }
////    //未登录
////    return @"";
//    
//    if ([UserDefaults objectForKey:bfd_userName] && [[UserDefaults objectForKey:bfd_userName] isKindOfClass:[NSString class]]) {
//        return [UserDefaults objectForKey:bfd_userName];
//    }
//    else
//    {
//        return @"";
//    }
//}
//
//#pragma mark - 检测登陆状态
//+ (BOOL)checkLoginStates
//{
//    if ([UserDefaults objectForKey:oyxc_userName]) {
//        return YES;
//    }
//    
//    return NO;
//}

#pragma mark - 检测时间间隔
+ (BOOL)checktimeinterval:(NSInteger)timeInterval
{
    NSDate *lastDate;
    if (lastDate) {
        
    }else{
        
        NSTimeInterval secondsPerDay1 = 24*60*60;
        NSDate *now1 = [NSDate date];
        lastDate = [now1 dateByAddingTimeInterval:-secondsPerDay1];
    }
    
   
    
    NSDate *nowDate = [NSDate date];
    
    if (fabs([lastDate timeIntervalSinceDate:nowDate]) < timeInterval)
    {
        lastDate = nowDate;
        return NO;    
    }else
    {
        lastDate = nowDate;
        return YES;
       
    }

    
}
#pragma mark - 检测网络
+ (NSInteger)checkNetWork
{
    NSInteger state = 0;//默认 无网络
    /*
    Reachability *r=[Reachability reachabilityForInternetConnection];
    switch ([r currentReachabilityStatus]) {
        case NotReachable: // 没有网络连接 netstate=@"没有网络";
            state = 0;
            //NSLog(@"无网络");
            break;
        case ReachableViaWWAN:{ // 使用3G网络
            state = 1;
            //NSLog(@"3G");
        }
            break;
        case ReachableViaWiFi:{ // 使用WiFi网络
            state = 2;
            //NSLog(@"wifi");
        }
            break;
    }*/
    
    return state;
}

#pragma mark - 验证价格 double
+ (NSString *)checkPrice:(CGFloat)price
{
    NSString *price_1 = [NSString stringWithFormat:@"%.1f",price];
    NSString *price_2 = [NSString stringWithFormat:@"%.2f",price];

    if (price_1.doubleValue == price_2.doubleValue) {
        price_2 = nil;
        return price_1;
    }
    
    price_1 = nil;
    return price_2;
}

#pragma mark - 验证折扣 double
+ (NSString *)checkDiscount:(CGFloat)price
{
    NSString *price_1 = [NSString stringWithFormat:@"%.0f",price];
    NSString *price_2 = [NSString stringWithFormat:@"%.1f",price];
    
    if (price_1.doubleValue == price_2.doubleValue) {
        price_2 = nil;
        return price_1;
    }
    
    price_1 = nil;
    return price_2;
}

//#pragma mark - 请求更新Ptoken绑定用户
//+ (void)requestUpDatePtokenAndUserToken
//{
//    [[GlobalData sharedInstance].mainVC netRequestWithTag:10];//上次Ptoken绑定用户
//}
//
//#pragma mark - 请求更新购物车数量
//+ (void)requestUpDateCarNums
//{
//    [[GlobalData sharedInstance].mainVC netRequestWithTag:11];//获取购物车数量
//}
//
//#pragma mark - 更新购物车数量
//+ (void)upDateCarNumsWithDic:(NSDictionary *)dic isPushNotification:(BOOL)isPush
//{
//    newshopcartAll *modelAll = [newshopcartAll modelObjectWithDictionary:dic];
//    NSArray *arrSource = [NSMutableArray arrayWithArray:modelAll.cartCacheObject];
//    //购买数量
//    NSInteger totalNum = 0;
//    for (int i =0; i<arrSource.count; i++) {
//        newshopcartCartCacheObject *model = arrSource[i];
//        NSArray *array = model.cartCacheBaselist;
//        for (newshopcartCartCacheBaselist *modelcell in array) {
//          
//                totalNum += modelcell.num.intValue;
//            
//            
//        }
//    }

    
//    //获取购物车数量
//    ModelCarAll *modelCar = [ModelCarAll modelObjectWithDictionary:dic];
//    NSArray *arrSource = modelCar.cartCacheObject.cartCacheBaselist;
//    
//    //购买数量
//    NSInteger totalNum = 0;
//    for (ModelCarCartCacheBaselist *modelCell in arrSource) {
//        totalNum += modelCell.num.intValue;
//    }
//    arrSource = nil;
//    modelCar = nil;
    
//    [UserDefaults setInteger:totalNum forKey:oyxc_carNum];
//    [UserDefaults synchronize];
//    
//    if (isPush) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:oyxc_carNum object:nil];
//    }
//}

#pragma mark - 加入购物车动画
+ (void)addCarWithFrom:(UIButton *)from to:(UIButton *)to startImgView:(UIImageView *)startImgView
{
    @autoreleasepool {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:startImgView.image];
        imgView.backgroundColor = [UIColor clearColor];
        imgView.frame = CGRectMake(from.frame.origin.x, from.frame.origin.y, 30, 30);
        imgView.center = from.center;
        
        //加入购物车动画效果
        CALayer *transitionLayer = [[CALayer alloc] init];
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        transitionLayer.opacity = 1.0;
        transitionLayer.contents = (id)imgView.layer.contents;
        transitionLayer.masksToBounds = YES;
        transitionLayer.cornerRadius = 20;
        transitionLayer.frame = [[UIApplication sharedApplication].keyWindow convertRect:from.imageView.bounds fromView:from.imageView];
        [[UIApplication sharedApplication].keyWindow.layer addSublayer:transitionLayer];
        [CATransaction commit];
        
        
        CGRect rectCar = [[UIApplication sharedApplication].keyWindow convertRect:to.imageView.bounds fromView:to.imageView];
        //路径曲线
        UIBezierPath *movePath = [UIBezierPath bezierPath];
        [movePath moveToPoint:transitionLayer.position];
        //    CGPoint toPoint = CGPointMake(rectCar.origin.x+64/2, rectCar.origin.y+49/2);
        CGPoint toPoint = CGPointMake(rectCar.origin.x+to.frame.size.width/2, rectCar.origin.y+to.frame.size.height/2);
        [movePath addQuadCurveToPoint:toPoint
                         controlPoint:CGPointMake(rectCar.origin.x+64/2,transitionLayer.position.y-130)];
        //关键帧
        CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        positionAnimation.path = movePath.CGPath;
        positionAnimation.removedOnCompletion = YES;
        
        //////////////// 新加
        CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        CATransform3D transform = CATransform3DMakeScale(0.5, 0.5, 0.5);  //x,y,z放大缩小倍数
        NSValue *value = [NSValue valueWithCATransform3D:transform];
        [theAnimation setToValue:value];
        
        transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
        value = [NSValue valueWithCATransform3D:transform];
        [theAnimation setFromValue:value];
        //    theAnimation.duration = 1.5f;
        ////////////
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.beginTime = CACurrentMediaTime();
        group.duration = 1.5f;
        group.animations = [NSArray arrayWithObjects:positionAnimation,theAnimation,nil];
        group.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        group.delegate = self;
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = YES;
        group.autoreverses= NO;
        
        //    //////////////// 新加
        //    CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        //    CATransform3D transform = CATransform3DMakeScale(0.5, 0.2, 1.0);  //x,y,z放大缩小倍数
        //    NSValue *value = [NSValue valueWithCATransform3D:transform];
        //    [theAnimation setToValue:value];
        //
        //    transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
        //    value = [NSValue valueWithCATransform3D:transform];
        //    [theAnimation setFromValue:value];
        //    theAnimation.duration = 1.5f;
        //    [transitionLayer addAnimation:theAnimation forKey:@"transform"];
        //    ////////////
        
        
        [transitionLayer addAnimation:group forKey:@"opacity"];
        [self performSelector:@selector(addShopFinished:) withObject:transitionLayer afterDelay:1.5f];
    }
}
+ (void)addCarWithFroms:(UIImageView *)from to:(UIButton *)to startImgView:(UIImageView *)startImgView
{
    @autoreleasepool {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:startImgView.image];
        imgView.backgroundColor = [UIColor clearColor];
        imgView.frame = CGRectMake(from.frame.origin.x, from.frame.origin.y, 30, 30);
        imgView.center = from.center;

        //加入购物车动画效果
        CALayer *transitionLayer = [[CALayer alloc] init];
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        transitionLayer.opacity = 1.0;
        transitionLayer.contents = (id)imgView.layer.contents;
        transitionLayer.masksToBounds = YES;
        transitionLayer.cornerRadius = 20;
        transitionLayer.frame = [[UIApplication sharedApplication].keyWindow convertRect:from.bounds fromView:from];
        [[UIApplication sharedApplication].keyWindow.layer addSublayer:transitionLayer];
        [CATransaction commit];
        
//        [imgView removeFromSuperview];
//        imgView = nil;
        
        CGRect rectCar = [[UIApplication sharedApplication].keyWindow convertRect:to.imageView.bounds fromView:to.imageView];
        //路径曲线
        UIBezierPath *movePath = [UIBezierPath bezierPath];
        [movePath moveToPoint:transitionLayer.position];
        //    CGPoint toPoint = CGPointMake(rectCar.origin.x+64/2, rectCar.origin.y+49/2);
        CGPoint toPoint = CGPointMake(rectCar.origin.x+to.frame.size.width/2, rectCar.origin.y+to.frame.size.height/2);
        [movePath addQuadCurveToPoint:toPoint
                         controlPoint:CGPointMake(rectCar.origin.x+64/2,transitionLayer.position.y-130)];
        //关键帧
        CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        positionAnimation.path = movePath.CGPath;
        positionAnimation.removedOnCompletion = YES;
        
        //////////////// 新加
        CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        CATransform3D transform = CATransform3DMakeScale(0.5, 0.5, 0.5);  //x,y,z放大缩小倍数
        NSValue *value = [NSValue valueWithCATransform3D:transform];
        [theAnimation setToValue:value];
        
        transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
        value = [NSValue valueWithCATransform3D:transform];
        [theAnimation setFromValue:value];
        //    theAnimation.duration = 1.5f;
        ////////////
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.beginTime = CACurrentMediaTime();
        group.duration = 1.5f;
        group.animations = [NSArray arrayWithObjects:positionAnimation,theAnimation,nil];
        group.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        group.delegate = self;
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = YES;
        group.autoreverses= NO;
        
        //    //////////////// 新加
        //    CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        //    CATransform3D transform = CATransform3DMakeScale(0.5, 0.2, 1.0);  //x,y,z放大缩小倍数
        //    NSValue *value = [NSValue valueWithCATransform3D:transform];
        //    [theAnimation setToValue:value];
        //
        //    transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
        //    value = [NSValue valueWithCATransform3D:transform];
        //    [theAnimation setFromValue:value];
        //    theAnimation.duration = 1.5f;
        //    [transitionLayer addAnimation:theAnimation forKey:@"transform"];
        //    ////////////
        
        
        [transitionLayer addAnimation:group forKey:@"opacity"];
       
        [self performSelector:@selector(addShopFinished:) withObject:transitionLayer afterDelay:1.5f];
    
    }
}

//加入购物车 步骤2
+ (void)addShopFinished:(CALayer*)transitionLayer{
    
    [transitionLayer removeFromSuperlayer];
    transitionLayer = nil;
}

#pragma mark - 加入购物车完毕时的抖动
+ (void)addAnimationsWithBtn:(UIButton *)sender
{
    CALayer*viewLayer=[sender layer];
    
    CABasicAnimation*animation=[CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.duration=0.2;
    
    animation.repeatCount = 2;
    
    animation.autoreverses=YES;
    
    animation.fromValue=[NSValue valueWithCATransform3D:CATransform3DRotate(viewLayer.transform, -0.1, 0.0, 0.0, 0.1)];
    
    animation.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate(viewLayer.transform, 0.1, 0.0, 0.0, 0.1)];
    
    [viewLayer addAnimation:animation forKey:@"wiggle"];
    
}

//#pragma mark - 添加异常日志
//+ (void)addErrorTitle:(NSString *)errorTitle errorStr:(NSString *)errorStr
//           requestStr:(NSString *)requestStr resPonseStr:(NSString *)resPonseStr
//{
//    [[GlobalData sharedInstance].mainVC netRequestWithTag:16 errorTitle:errorTitle errorStr:errorStr requestStr:requestStr resPonseStr:resPonseStr];
//}
//
#pragma mark - 检测URL
+ (NSURL *)urlWithStr:(NSString *)str
{
    //NSLog(@"str:%@",str);
    if ([str isKindOfClass:[NSString class]]) {
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        for (int i=0; i<str.length; i++) {
            @autoreleasepool {
                NSString *subStr = [str substringWithRange:NSMakeRange(i, 1)];
                NSInteger c = [subStr lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
                if (c > 1) {
                    //NSLog(@"subStr:%@",subStr);
//                    str = [str stringByReplacingOccurrencesOfString:subStr withString:[subStr urlEncodedString]];
                }
            }
        }
        
        return [NSURL URLWithString:str];
    }
    return nil;
}

//#pragma mark - 展示一般的警告
//+ (void)showAlertHUD:(NSString *)message
//{
//    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:[[[UIApplication sharedApplication] delegate] window]];
//    [[[[UIApplication sharedApplication] delegate] window] addSubview:HUD];
//    HUD.mode = MBProgressHUDModeText;
//    HUD.detailsLabelText = message;
//    HUD.yOffset = -15.0f;
//    [HUD show:YES];
//    [HUD hide:YES afterDelay:1.5f];
//}

//+ (void)showAlertHUD:(NSString *)message timeOut:(NSInteger)timeOut
//{
//    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:[[[UIApplication sharedApplication] delegate] window]];
//    [[[[UIApplication sharedApplication] delegate] window] addSubview:HUD];
//    HUD.mode = MBProgressHUDModeText;
//    HUD.detailsLabelText = message;
//    HUD.yOffset = -15.0f;
//    [HUD show:YES];
//    [HUD hide:YES afterDelay:timeOut];
//}

//+ (void)showStateBarBg
//{
//    if (IsIos7) {
////    [[UIApplication sharedApplication] setStatusBarHidden:NO
////                                            withAnimation:UIStatusBarAnimationFade];
//        AppDelegate *app = [AppDelegate shareApp];
//        [app.window bringSubviewToFront:app.statusBg];
//    }
//}
//
//+ (void)hideStateBarBg
//{
//    if (IsIos7) {
////        [[UIApplication sharedApplication] setStatusBarHidden:YES
////                                                withAnimation:UIStatusBarAnimationFade];
//        
//        AppDelegate *app = [AppDelegate shareApp];
//        [app.window sendSubviewToBack:app.statusBg];
//    }
//}

+ (NSString *)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //NSLog(@"deviceString:%@",deviceString);
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator i386";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator x86_64";
    //NSLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font size:(CGSize)size
{
    NSAttributedString * attributeString = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:font}];
    CGRect rect =[attributeString boundingRectWithSize:size  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    attributeString = nil;
    
    return rect.size;
}

+ (BOOL)checkCameraAuthorization
{
    BOOL isAvalible = YES;
    //ios 7.0以上的系统新增加摄像头权限检测
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        //获取对摄像头的访问权限。
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (authStatus) {
            case AVAuthorizationStatusRestricted://此应用程序没有被授权访问的照片数据。可能是家长控制权限。
                NSLog(@"Restricted");
                break;
            case AVAuthorizationStatusDenied://用户已经明确否认了这一照片数据的应用程序访问.
                NSLog(@"Denied");
                isAvalible = NO;
                break;
            case AVAuthorizationStatusAuthorized://用户已授权应用访问照片数据.
                NSLog(@"Authorized");
                break;
            case AVAuthorizationStatusNotDetermined://用户尚未做出了选择这个应用程序的问候
                isAvalible =[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
                break;
            default:
                break;
        }
    }
    if (!isAvalible) {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"您关闭了搜狐社区的相机权限，无法进行拍照。可以在手机 > 设置 > 隐私 > 相机中开启权限。" delegate:nil cancelButtonTitle:LocationLanguage(@"yes", @"确定") otherButtonTitles:nil];
        [errorAlert show];
        errorAlert = nil;
    }
    
    return isAvalible;
}

//#pragma mark - 99click
//+(void)countView:(NSString *)pageTitle
//{
//    if ([UserDefaults objectForKey:oyxc_click_99]) {
//        [AppTrack countView:pageTitle];
//    }
//}
//
//+(void)countView:(NSString *)pageTitle andPageOzprm:(NSString *)pageOzprm
//{
//    if ([UserDefaults objectForKey:oyxc_click_99]) {
//        [AppTrack countView:pageTitle andPageOzprm:pageOzprm];
//    }
//}
//+(void)countClick:(NSString *)pageTitle andClkObjName:(NSString *)clkObjName
//{
//    if ([UserDefaults objectForKey:oyxc_click_99]) {
//        [AppTrack countClick:pageTitle andClkObjName:clkObjName];
//    }
//}
//
//
/////*
//// *  功能：点击监测
//// *      参数：
//// *          pageTitle：      点击对象所在的页面主题
//// *          clkObjName：     点击对象名称
//// *          pageOzprm：      页面客户自定义参数，格式如"search=351&ozsru=member20141211"
//// **/
//+(void) countClick: (NSString *) pageTitle
//     andClkObjName: (NSString *) clkObjName
//      andPageOzprm: (NSString *) pageOzprm
//{
//    if ([UserDefaults objectForKey:oyxc_click_99]) {
//        [AppTrack countClick:pageTitle
//         andClkObjName:clkObjName
//         andPageOzprm:pageOzprm];
//    }
//}


///*
// *	功能：设置APP订单中一个产品的属性
// *		参数
// *			skuAttrDictionary：		内容为属性的“name-value”对，name需要和系统设置或提供的一致
// **/
//+(void) setSku : (NSDictionary *) skuAttrDictionary
//{
//    if ([UserDefaults objectForKey:oyxc_click_99]) {
//        [AppTrack setSku:skuAttrDictionary];
//    }
//}
//
///*
// *	功能：设置APP中一个订单的属性
// *		参数：
// *			orderAttrDictionary：	内容为属性的“name-value”对，name需要和系统设置或提供的一致
// **/
//+(void) setOrder : (NSDictionary *) orderAttrDictionary
//{
//    if ([UserDefaults objectForKey:oyxc_click_99]) {
//        [AppTrack setOrder:orderAttrDictionary];
//    }
//}

@end

