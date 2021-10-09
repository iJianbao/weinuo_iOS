//
//  Person.m
//  DBTool
//
//  Created by caodong on 16/5/20.
//  Copyright © 2016年 caodong. All rights reserved.
//

#import "BlueTouchDevice.h"

@implementation BlueTouchDevice

+(instancetype)initidentifier:(NSString*)identifier name:(NSString*)name nickname:(NSString*)nickname state:(NSString*)state type:(NSString*)type
{
    BlueTouchDevice *person =[[BlueTouchDevice alloc]init];
    person.identifier = identifier;
    person.name = name;
    person.nickname = nickname;
    person.state= state;
    person.type= type;
    
    return person;
    
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"[identifier='%@',name='%@',nickname='%@',state='%@',type='%@']",_identifier,_name,_nickname,_state,_type];
}
@end
