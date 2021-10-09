//
//  Person.m
//  DBTool
//
//  Created by caodong on 16/5/20.
//  Copyright © 2016年 caodong. All rights reserved.
//

#import "Gaodu.h"

@implementation Gaodu

+ (instancetype)initName:(NSString*)name
                  height:(CGFloat)height
                    isIn:(NSString *)isIn
                deviceId:(NSString *)deviceId
                   strid:(NSString*)strid; {
    Gaodu *gaodu =[[Gaodu alloc]init];
    gaodu.name = name;
    gaodu.height = height;
    gaodu.isIn = isIn;
    gaodu.deviceId = deviceId;
    gaodu.strid = strid;
    
    return gaodu;
    
}
-(NSString *)description {
    return [NSString stringWithFormat:@"[name='%@',height='%f',isIn=%@,deviceId=%@,strid='%@']",_name, _height, _isIn, _deviceId, _strid];
}
@end
