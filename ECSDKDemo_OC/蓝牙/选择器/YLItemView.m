//
//  YLItemView.m
//  弹框demo
//
//  Created by 谢贤 on 2017/9/25.
//  Copyright © 2017年 包燕龙. All rights reserved.
//

#import "YLItemView.h"

@implementation YLItemView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor =[Common2 colorWithHexString:@"#2B2B73"];
       // 1.imageview
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(15, 7, 30, 30);
        self.imageView = imageView;
        [self addSubview:imageView];
        
        // 2.label
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.frame = CGRectMake( 5, 7, 300, 30);
        self.titleLabel = titleLabel;
        [self addSubview:titleLabel];
        
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        
        
        // 2.label
        UILabel *titleLabel2 = [[UILabel alloc]init];
        titleLabel2.frame = CGRectMake( 5+200, 7, 300, 30);
        self.titleLabel2 = titleLabel2;
        [self addSubview:titleLabel2];
        
        titleLabel2.textColor = [UIColor whiteColor];
        titleLabel2.font = [UIFont systemFontOfSize:15];
        
        // 3.分割线
        UIView *line = [[UIView alloc]init];
        line.frame = CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 1);
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
    }
    return self;
}

@end
