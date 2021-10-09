//
//  Person.h
//  DBTool
//
//  Created by caodong on 16/5/20.
//  Copyright © 2016年 caodong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gaodu : NSObject

@property (nonatomic, copy) NSString *strid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) NSString *isIn;   // 是否为英尺 @"1" 是
@property (nonatomic, copy) NSString *deviceId; // 蓝牙设备地址

+ (instancetype)initName:(NSString*)name
                  height:(CGFloat)height
                    isIn:(NSString *)isIn
                deviceId:(NSString *)deviceId
                   strid:(NSString*)strid;

@end
