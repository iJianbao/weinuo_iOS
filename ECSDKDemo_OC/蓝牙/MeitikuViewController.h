//
//  MyOrderViewController.h
//  天天网
//
//  Created by ios on 14-1-3.
//  Copyright (c) 2014年 Ios. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "GCUIViewController.h"

@class ControlViewController;
@interface MeitikuViewController : GCUIViewController

@property (weak, nonatomic) IBOutlet UIView *viewAbout;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;//天天网图标
@property (weak, nonatomic) IBOutlet UILabel *labelVersion;//当前版本
@property (weak, nonatomic) IBOutlet UIButton *btnUpdata;//版本更新
@property (weak, nonatomic) IBOutlet UIButton *btnService;//服务条款

@property (weak, nonatomic) IBOutlet UILabel *labelVersion1;//当前版本
@property (weak, nonatomic) IBOutlet UILabel *labelVersion2;//当前版本
@property (weak, nonatomic) IBOutlet UILabel *labelVersion3;//当前版本

@property (weak, nonatomic) IBOutlet UIImageView *imgLine;//天天网图标

@property (nonatomic, strong) ControlViewController *controlVc;


@end
