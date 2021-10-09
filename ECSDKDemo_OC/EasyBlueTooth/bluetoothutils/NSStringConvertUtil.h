//
//  NSStringConvertUtil.h
//  TestSocket
//
//  Created by gj on 2017/4/27.
//  Copyright © 2017年 juis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStringConvertUtil : NSObject

//计算字节长度
+(NSInteger) computeStringLength:(NSString *) string;

//普通字符串转换为二进制。
+(NSString *)StingToBinary:(NSString *)string;

//二进制转字符串
+ (NSString *)BinaryToNSString:(NSData *)data;


//普通字符串转换为十六进制。
+ (NSString *)hexStringFromString:(NSString *)string;

// 十六进制转换为普通字符串。
+ (NSString *)convertHexStrToString:(NSString *)hexString;

// 十六进制转二进制
+ (NSString *)getBinaryByhex:(NSString *)hex;

// 二进制转十六进制
+ (NSString *)BinaryToHex:(NSData *)data;


//十进制转十六进制
+ (NSString *)ToHex:(uint16_t)tmpid;

//  十进制转二进制
+ (NSString *)toBinarySystemWithDecimalSystem:(NSString *)decimal;

//  二进制转十进制
+ (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary;
@end
