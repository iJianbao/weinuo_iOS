//
//  Person.h
//  DBTool
//
//  Created by caodong on 16/5/20.
//  Copyright © 2016年 caodong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Health : NSObject

@property(nonatomic,copy)NSString *riqi;
@property(nonatomic,copy)NSString *riqi2;
@property(nonatomic,assign)float zuozishijian;
@property(nonatomic,assign)float zhanzishijian;
@property(nonatomic,assign)float zuozhanbi;
+(instancetype)initName:(NSString*)riqi riqi2:(NSString*)riqi2 zuozishijian:(float)zuozishijian zhanzishijian:(float)zhanzishijian zuozhanbi:(float)zuozhanbi;

@end
