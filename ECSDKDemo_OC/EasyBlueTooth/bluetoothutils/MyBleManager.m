//
//  MyBleManager.m
//  ChinaDream
//
//  Created by zhangfeng on 12-11-26.
//  Copyright (c) 2012年 eastedge. All rights reserved.
//

#import "MyBleManager.h"
//#import "Reachability.h"
#import "AppDelegate.h"
#import "sys/utsname.h"
#import <AVFoundation/AVFoundation.h>
//#import "NSString+URLEncoding.h"


#import "HexUtils.h"


@implementation MyBleManager



+ (NSString *)addToCompleteStr:(NSString *)paramString
{
    return [NSString stringWithFormat:@"%@%@%@",@"1B",paramString,@"05"];

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



//发送数据
//[self.peripheral writeValue:[self hexToBytes:@"1B9901"] forCharacteristic:self.write type:CBCharacteristicWriteWithoutResponse];



+ (void)sendVariableToDevice:(int )paramInt
{
    NSString *strcmd = [HexUtils getSetHeightCmd:paramInt];
    
    NSString *number=@"1B43573230313030323030303430303030343305";
    
   [HexUtils hexToBytes:strcmd];
    
    NSData *data_cmd= [HexUtils hexToBytes:strcmd];
    NSLog(@"发送的命令是%@",strcmd);
    NSLog(@"发送的命令是%@",data_cmd);
    
    
    ///// 将16进制数据转化成Byte 数组
    
//    NSString *hexString = @"1B43573230313030323030303332373130344305"; //16进制字符串
//    
//    int j=0;
//    
//    Byte bytes[128];  ///3ds key的Byte 数组， 128位
//    
//    for(int i=0;i<[hexString length];i++)
//        
//    {
//        
//        int int_ch;  /// 两位16进制数转化后的10进制数
//        
//        
//        
//        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
//        
//        int int_ch1;
//        
//        if(hex_char1 >= '0' && hex_char1 <='9')
//            
//            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
//        
//        else if(hex_char1 >= 'A' && hex_char1 <='F')
//            
//            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
//        
//        else
//            
//            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
//        
//        i++;
//        
//        
//        
//        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
//        
//        int int_ch2;
//        
//        if(hex_char2 >= '0' && hex_char2 <='9')
//            
//            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
//        
//        else if(hex_char1 >= 'A' && hex_char1 <='F')
//            
//            int_ch2 = hex_char2-55; //// A 的Ascll - 65
//        
//        else 
//            
//            int_ch2 = hex_char2-87; //// a 的Ascll - 97
//        
//        
//        
//        int_ch = int_ch1+int_ch2;
//        
//        NSLog(@"int_ch=%d",int_ch);
//        
//        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
//        
//        j++;
//        
//    }
//    
//    NSData *newData = [[NSData alloc] initWithBytes:bytes length:128];
//    
//    NSLog(@"newData=%@",newData);

  
}





@end

