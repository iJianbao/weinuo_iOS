//
//  YLTanKuangView.m
//  弹框demo
//
//  Created by 谢贤 on 2017/8/15.
//  Copyright © 2017年 包燕龙. All rights reserved.
//

#import "YLTanKuangView.h"
#import "YLItemView.h"
#import "Gaodu.h"
#import "BLEManager.h"

#define YLColorA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define YLScreenH [[UIScreen mainScreen] bounds].size.height
#define YLScreenW  [[UIScreen mainScreen] bounds].size.width
#define YLColor(r, g, b) YLColorA((r), (g), (b), 255)
#define YLRandomColor YLColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@interface YLTanKuangView()
/// 遮盖
@property (nonatomic,strong) UIView *coverView;
/// 列表数据
@property (nonatomic,strong) NSArray *modelArray;
/// 首尾标题数据
@property (nonatomic,strong) NSArray *titleArray;
/// 图片数据
@property (nonatomic,strong) NSArray *imageArray;
@end
@implementation YLTanKuangView


// 初始化数据
- (void)initWithModelArray:(NSArray *)modelArray titleArray:(NSArray *)titleArray andImageArray:(NSArray *)imageArray
{
    self.modelArray = modelArray;
    self.titleArray = titleArray;
    self.imageArray = imageArray;
    
    // 创建scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 44, YLScreenW, self.frame.size.height - 44 - 44);
    scrollView.contentSize = CGSizeMake(YLScreenW, 44*modelArray.count+100);
    scrollView.backgroundColor =[Common2 colorWithHexString:@"#0B0088"];// [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self addSubview:scrollView];
    
    for (int i = 0; i < modelArray.count + 2; i++) {
        
        YLItemView *itemView = [[YLItemView alloc]init];
        itemView.backgroundColor =[Common2 colorWithHexString:@"#0B0088"];// [UIColor whiteColor];
        itemView.tag = i + 100000;
        
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView:)];
        [itemView addGestureRecognizer:tap];
        
        // 标题
        if (i == 0) {
            itemView.frame = CGRectMake(0, i * 44, ScreenWidth, 44);
            itemView.backgroundColor = [Common2 colorWithHexString:@"#2B2B73"];;// [UIColor whiteColor];
            [self addSubview:itemView];
            itemView.titleLabel.frame = CGRectMake((ScreenWidth-220)/2, i * 44, 220, 44);
            itemView.titleLabel.textAlignment = NSTextAlignmentCenter;
            itemView.titleLabel.text = self.titleArray[0];
            if(isPadYES)
            {
                itemView.titleLabel.font =[UIFont systemFontOfSize:24.0f];
            }
            continue;
        }
        // 取消
        if (i == modelArray.count+1) {
            itemView.frame = CGRectMake(0, self.frame.size.height-44, ScreenWidth, 44);
            [self addSubview:itemView];
            itemView.titleLabel.frame = CGRectMake((ScreenWidth-220)/2, 0, 220, 44);
            itemView.imageView.hidden = YES;
            itemView.titleLabel.textAlignment = NSTextAlignmentCenter;
            itemView.titleLabel.text = self.titleArray[1];
            if(isPadYES)
            {
                itemView.titleLabel.font =[UIFont systemFontOfSize:24.0f];
            }
            continue;
        }
        if (i != 0 & i != modelArray.count+1) {
            itemView.frame = CGRectMake(0, (i - 1) * 44, ScreenWidth, 44);
            [scrollView addSubview:itemView];
//            itemView.imageView.image = [UIImage imageNamed:self.imageArray[i - 1]];
            Gaodu *dic = self.modelArray[i - 1];
            NSString *showStr = [BLEManager floatHeight:[BLEManager autoInOrCm:dic.height
                                                                          isIn:dic.isIn
                                                                        needCm:[BLEManager sharedManager].is_CM]
                                                 needCm:[BLEManager sharedManager].is_CM];
            itemView.titleLabel.text = dic.name;
            itemView.titleLabel2.text = [NSString stringWithFormat:@"%@ %@",showStr, [BLEManager sharedManager].is_CM ? @"cm" : @"IN"]; // self.modelArray[i - 1];
            itemView.titleLabel2.frame = CGRectMake((ScreenWidth-ScreenWidth*120/320), 0, ScreenWidth*120/320, 44);
            itemView.tag = i;
            if(isPadYES)
            {
                itemView.titleLabel2.font =[UIFont systemFontOfSize:24.0f];
                itemView.titleLabel2.frame = CGRectMake((ScreenWidth-ScreenWidth*120/320), 0, ScreenWidth*120/320, 44);
            }
            else
            {
                itemView.titleLabel2.frame = CGRectMake((ScreenWidth-ScreenWidth*120/320), 0, ScreenWidth*120/320, 44);
            }
        }
        
    }


}

/// 显示弹框
- (void)showTanKuangView
{
    // 弹出view前加遮盖
    UIView *coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    coverView.backgroundColor = YLColorA(120, 120, 122, 0.8);
    [self.superview addSubview:coverView];
    self.coverView = coverView;
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverViewClick)];
    [coverView addGestureRecognizer:tap];
    
    
    
    // 动画弹出选择支付view
    __block typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.superview bringSubviewToFront:weakSelf];
        weakSelf.frame = CGRectMake(0, YLScreenH -0.45*YLScreenH - DEVICE_SAFE_BOTTOM, YLScreenW, 0.45*YLScreenH);
    }];
}

/// 销毁弹框
- (void)destroyTanKuangView
{
    // 动画退出选择支付view
    __block typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.frame = CGRectMake(0, YLScreenH , YLScreenW, 0.45*YLScreenH);
        
    }];
    // 移除弹框
    [self removeFromSuperview];
    // 移除遮盖
    [self.coverView removeFromSuperview];
}

/// 遮盖点击事件
- (void)coverViewClick
{
    [self destroyTanKuangView];
}

// 点击事件
- (void)clickView:(UITapGestureRecognizer *)tap {
    NSLog(@"clickView:(UITapGestureRecognizer *)tap");
    if (tap.view.tag == 100000 ) {// 点击头部标题
        
    }else if (tap.view.tag == 100000 + self.modelArray.count + 1 ) {// 点击尾部取消
         [self destroyTanKuangView];
    }else {
        NSInteger tag = tap.view.tag;
        Gaodu *dic = self.modelArray[tag - 1];
        self.clickBlock(tap.view, dic.isIn, dic.height);
    }
}
@end
