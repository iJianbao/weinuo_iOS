//
//  Person.h
//  DBTool
//
//  Created by caodong on 16/5/20.
//  Copyright © 2016年 caodong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlueTouchDevice : NSObject

@property(nonatomic,copy)NSString *identifier;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *state;
@property(nonatomic,copy)NSString *type;

+(instancetype)initidentifier:(NSString*)identifier name:(NSString*)name nickname:(NSString*)nickname state:(NSString*)state type:(NSString*)type;

@end
