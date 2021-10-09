//
//  UIView+Common.m
//  HuiWuYun
//
//  Created by zhaoweibing on 14-4-11.
//  Copyright (c) 2014年 oyxc. All rights reserved.
//

#import "UIView+Common.h"

@implementation UIView (Common)

/**
 返回视图高度
 */
- (CGFloat)height
{
    return self.frame.size.height;
}

/**
 返回视图宽度
 */
- (CGFloat)width
{
    return self.frame.size.width;
}

/**
 返回视图横坐标起点位置 x
 */
- (CGFloat)x
{
    return self.frame.origin.x;
}

/**
 返回视图纵坐标 y
 */
- (CGFloat)y
{
    return self.frame.origin.y;
}

/**
 设置视图的边框和颜色
 cornerRadius   边框角度
 borderWidth    边框宽度
 borderColor    边框颜色
 masksToBounds  是否隐藏被截部分
 */
- (void)modifyWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor masksToBounds:(BOOL)masksToBounds
{
    self.layer.masksToBounds = masksToBounds;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)defaultModify
{
    self.backgroundColor = [UIColor whiteColor];
    [self modifyWithCornerRadius:4 borderWidth:0.3 borderColor:[UIColor lightGrayColor] masksToBounds:YES];
}

@end
