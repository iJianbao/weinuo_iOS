//
//  AboutViewController.m
//  ECSDKDemo_OC
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 ronglian. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [Common2 colorWithHexString:@"#ffffff"];

    self.title = LocationLanguage(@"about", @"关于");
    
    UIBarButtonItem *item;
    if ([UIDevice currentDevice].systemVersion.integerValue>7.0) {
        self.edgesForExtendedLayout = UIRectEdgeTop;
        item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(returnClick)];
    } else {
        item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(returnClick)];
    }
    self.navigationItem.leftBarButtonItem = item;
    
    [self buildUI];
}

- (void)buildUI {
    
    UIView *view_bg = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenWidth*0/320, ScreenWidth*320/320, ScreenWidth*180/320)];
    view_bg.backgroundColor =[Common2 colorWithHexString:@"#B2DDBC"];
    [self.view addSubview:view_bg];
    
    
    
    UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-80.0f)/2, 74.0f, 80.0f, 80.0f);
    [imageBtn setImage:[UIImage imageNamed:@"icon_app.png"] forState:UIControlStateNormal];
    [self.view addSubview:imageBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, CGRectGetMaxY(imageBtn.frame), [UIScreen mainScreen].bounds.size.width-80.0f*2, 60.0f)];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMdd"];
    NSString *dateMMddStr = [dateFormatter stringFromDate:[NSDate date]];
    dateMMddStr = @"1123";
    NSString *versionStr = [NSString stringWithFormat:@"%@%@%@09", LocationLanguage(@"version", @"版本号"), @"  v2.3.0.20", dateMMddStr];
    label.text = versionStr;
    
    label.font = [UIFont systemFontOfSize:14.0f];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), [UIScreen mainScreen].bounds.size.width, 60.0f)];
    label2.text = LocationLanguage(@"technicalSupport", @"技术支持   为诺智驱");
    label2.font = [UIFont systemFontOfSize:14.0f];
    label2.numberOfLines = 0;
    label2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label2];
    
    
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
////    CFShow(infoDictionary);
//    // app名称
//    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
//    // app版本
//    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    // app build版本
//    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
//    
//    label.text = [NSString stringWithFormat:@"%@ v%@",LocationLanguage(@"version", @"版本号"), app_Version];;
    
    if(isPadYES)
    {
        view_bg.frame = CGRectMake(0, ScreenWidth*0/320, ScreenWidth*320/320, ScreenWidth*90/320);
        label.font = [UIFont systemFontOfSize:24.0f];
        label2.font = [UIFont systemFontOfSize:24.0f];
        
    }
    

}

- (void)dowloadBtnClicked {
    id viewController = [[NSClassFromString(@"DownloadViewController") alloc] init];
    [self.navigationController pushViewController:viewController animated:NO];
}

- (void)returnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
