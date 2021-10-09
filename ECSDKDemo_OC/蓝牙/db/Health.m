//
//  Person.m
//  DBTool
//
//  Created by caodong on 16/5/20.
//  Copyright © 2016年 caodong. All rights reserved.
//

#import "Health.h"

@implementation Health

+(instancetype)initName:(NSString*)riqi riqi2:(NSString*)riqi2 zuozishijian:(float)zuozishijian zhanzishijian:(float)zhanzishijian zuozhanbi:(float)zuozhanbi
{
    Health *person =[[Health alloc]init];
    person.riqi = riqi;
    person.riqi2 = riqi2;
    person.zuozishijian= zuozishijian;
    person.zhanzishijian= zhanzishijian;
    person.zuozhanbi= zuozhanbi;
    
    return person;
    
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"[riqi='%@',riqi2='%@',zuozishijian='%f',zhanzishijian='%f',zuozhanbi='%f']",_riqi,_riqi2,_zuozishijian,_zhanzishijian,_zuozhanbi];
}
@end
