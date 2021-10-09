//
//  UIView+Common.h
//  HuiWuYun
//
//  Created by zhaoweibing on 14-4-11.
//  Copyright (c) 2014年 oyxc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)

/**
 返回视图高度
 */
- (CGFloat)height;

/**
 返回视图宽度
 */
- (CGFloat)width;

/**
 返回视图横坐标起点位置 x
 */
- (CGFloat)x;

/**
 返回视图纵坐标 y
 */
- (CGFloat)y;

/**
 设置视图的边框和颜色
 cornerRadius   边框角度
 borderWidth    边框宽度
 borderColor    边框颜色
 masksToBounds  是否隐藏被截部分
 */
- (void)modifyWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor masksToBounds:(BOOL)masksToBounds;

- (void)defaultModify;

@end
