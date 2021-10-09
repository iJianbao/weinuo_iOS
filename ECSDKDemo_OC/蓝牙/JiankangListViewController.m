//
//  WebjsViewController.m
//  天天网
//
//  Created by zhaoweibing on 14-9-5.
//  Copyright (c) 2014年 oyxc. All rights reserved.
//

#import "JiankangListViewController.h"

#import "Common2.h"
#import "Global.h"
#import "HealthCell.h"
//#import "UITableViewRowAction+JZExtension.h"
#import "MJRefresh.h"
//@import MJRefresh;
//#import "ShangchengRcommandDataTool.h"

//#import "ZiliaokuDetailsViewController.h"
//#import "ShangchengViewController.h"

//#import "ZiliaokuTwoViewController.h"
//#import "LoadingAnimation.h"
//#import "TixinglingAddViewController.h"
//#import "DXSoundViewController.h"



//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKExtension/SSEShareHelper.h>
//#import <ShareSDKUI/ShareSDK+SSUI.h>
//#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
//#import <ShareSDK/ShareSDK+Base.h>
//
//#import <ShareSDKExtension/ShareSDK+Extension.h>
//#import <MOBFoundation/MOBFoundation.h>


//#import "Bianwu2ViewController.h"

//#import "Bianwu2ViewController.h"
//#import "QZTopTextView.h"
//#import "IQKeyboardManager.h"
//#import "PPNumberButton.h"

//#import "DanceModel.h"
//#import "DanceModelDBTool.h"

//#import "LoobotDanceListViewController.h"

//#import "LoobotModel.h"
//#import "LoobotModelDBTool.h"
//#import "HcdDateTimePickerView.h"

//#import "MacroDefinition.h"
//#import "UIView+RGSize.h"
//#import "DQconstellationView.h"
//#import "HttpTools.h"

#import "DBTool.h"
#import "Health.h"

@interface JiankangListViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource,UITableViewDelegate>
{
//    QZTopTextView * _textView;
    
//    HcdDateTimePickerView * dateTimePickerView;
    
    int _currentYear;
    int _currentMonth;
    int _currentDay;
    int _currentHour;
    int _currentMin;
    int _currentSec;
    
    int _selectedYear;
    int _selectedMonth;
    int _selectedDay;
    int _selectedHour;
    int _selectedMin;
    int _selectedSec;
}


@property (strong, nonatomic) NSIndexPath *selectIndexPath;
@property (strong, nonatomic) UIImageView *imgState;
@property (strong, nonatomic) UIView *viewFoot;

@property (nonatomic, strong) NSMutableArray *arrData;//数据源
@property (nonatomic, strong) UITableView *tableViewDefault;
@property (nonatomic, assign) NSInteger pageindex;
@property (nonatomic, assign) NSInteger pagesize;
//@property (nonatomic,strong) ShangchengRcommandDataTool *tool;

//@property (strong, nonatomic) LoadingAnimation *loadView;

/**
 *  面板
 */
@property (nonatomic, strong) UIView *panelView;

/**
 *  加载视图
 */
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
//@property (nonatomic, strong) AVAudioPlayer *audioPlay;
@property (nonatomic, strong) NSString *datetimeStr;

@property (nonatomic, strong) NSDate       *date;
@property (nonatomic, strong) UIView       *backgroundView;
@property (nonatomic, strong) UIView       *maskView;
@property (nonatomic, strong) UIPickerView *timePickerView;


@property (nonatomic, strong) NSString *strurl;

//@property (nonatomic, strong) DQconstellationView *DQconstellationView;



@end

@implementation JiankangListViewController

//- (ShangchengRcommandDataTool *)tool{
//    if (_tool == nil) {
//        _tool = [[ShangchengRcommandDataTool alloc]init];
//
//    }
//    return _tool;
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"编舞分享"];
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable = NO;
//    manager.shouldResignOnTouchOutside = NO;
//    manager.shouldToolbarUsesTextFieldTintColor = NO;
//    manager.enableAutoToolbar = NO;
    
    
    
    self.navigationController.navigationBarHidden = NO;
//    [self layoutNavigation];
//    [self example1];
}

//默认状态
- (void)example1
{
//    PPNumberButton *numberButton = [[PPNumberButton alloc] initWithFrame:CGRectMake(100, 100, 110, 30)];
//    //开启抖动动画
//    numberButton.shakeAnimation = YES;
//    numberButton.numberBlock = ^(NSString *num){
//        NSLog(@"%@",num);
//    };
//
//    [self.view addSubview:numberButton];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"编舞分享"];
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable = YES;
//    manager.shouldResignOnTouchOutside = YES;
//    manager.shouldToolbarUsesTextFieldTintColor = YES;
//    manager.enableAutoToolbar = YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = LocationLanguage(@"healthData", @"健康数据");
        self.hidesBottomBarWhenPushed = NO;
        
        UIBarButtonItem *buttonLeft = [Common2 CreateNavBarButton:self setEvent:@selector(leftBarClicked:) background:@"btn_back.png" setTitle:nil];
        self.navigationItem.leftBarButtonItem = buttonLeft;
        
        
//        UIBarButtonItem *buttonRight = [Common2 CreateNavBarButton:self setEvent:@selector(rightBarClicked:) background:nil setTitle:@"集体表演"];
//        self.navigationItem.rightBarButtonItem = buttonRight;
        
        
        
        
    }
    return self;
}

//- (void)layoutNavigation {
//    
//    UIView *viewNavigation = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 64)];
//    viewNavigation.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:viewNavigation];
//    
//    
//    UIButton *btn_left = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn_left.frame = CGRectMake(5,10, 40, 40);
//    [btn_left setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
//    [btn_left setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateHighlighted];
//    btn_left.showsTouchWhenHighlighted=YES;
//    [btn_left addTarget:self action:@selector(leftBarClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [viewNavigation addSubview:btn_left];
//    
//    UILabel * labelcenter = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-90,10, 180, 40)];
//    labelcenter.backgroundColor =[UIColor clearColor];
//    labelcenter.font = [UIFont boldSystemFontOfSize:18];
//    labelcenter.textColor =[Common2 colorWithHexString:@"#ffffff"];
//    labelcenter.text = @"编剧列表";
//    labelcenter.textAlignment= NSTextAlignmentCenter;
//    [viewNavigation addSubview:labelcenter];
//    
//    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn_right.frame = CGRectMake(ScreenWidth-80-5,10, 80, 40);
////    [btn_right setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
////    [btn_right setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateHighlighted];
//    [btn_right setTitle:@"集体表演" forState:UIControlStateNormal];
//    btn_right.showsTouchWhenHighlighted=YES;
//    [btn_right addTarget:self action:@selector(rightBarClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [viewNavigation addSubview:btn_right];
//    
//}


//- (void)leftBarClicked:(UIButton *)sender
//{
//
//    [self.navigationController popViewControllerAnimated:YES];
//}

#pragma mark - 导航条按钮点击事件


- (void)leftBarClicked:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)rightBarClicked:(UIButton *)sender
{
    
//    LoobotDanceListViewController *videoRender = [[LoobotDanceListViewController alloc] init];
//    videoRender.navigationController.navigationBarHidden = YES;
//    [self.navigationController pushViewController:videoRender animated:YES];
//
//     [_textView.lpTextView becomeFirstResponder];
    
}

- (void)sendComment
{
    /*
    [_textView resignFirstResponder];
    //接口请求
    
    NSString *strText =_textView.lpTextView.text;
    //    NSString *struserName =[DemoGlobalClass sharedInstance].userName;
    
    NSString *sessionId =@"";
    if([SFHFKeychain getPasswordForUsername:@"UDID" andServiceName:KEY_UUID error:nil].length>0)
    {
        sessionId = [SFHFKeychain getPasswordForUsername:@"UDID" andServiceName:KEY_UUID error:nil];
        
    }
    

    
//    DanceModelDBTool *noticeDBTool = [DanceModelDBTool shareInstance];
//    [noticeDBTool createTable];
//    
//
//    NSDictionary *noticeDic = @{@"username":sessionId,@"title":strText,@"url":@"",@"created_at":sessionId};
//    DanceModel *noticeModel =[[DanceModel alloc]initWithDictionary:noticeDic];
//    [noticeDBTool insertModel:noticeModel];
//    
//    
//    
//    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
//    
//    [self headerRereshing];
    
    
    [self.tool AddBianlulistData:sessionId StrTitle:strText block:^(id json) {
        
        [self headerRereshing];
        
        [SVProgressHUD showSuccessWithStatus:LocationLanguage(@"saveSuccessfully", @"保存成功")];
        
//        NSDictionary *dic = json[@"item"];
//        _strid =[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
//        _strName =[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
//        
//        
//        _textView.lpTextView.text=@"";
//        
//        BianwuEditViewController *videoRender = [[BianwuEditViewController alloc] init];
//        videoRender.strid =[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
//        videoRender.strName =[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
//        videoRender.navigationController.navigationBarHidden = YES;
//        [self.navigationController pushViewController:videoRender animated:YES];
        
        
        
        
        
        
    }];
    
    
    */
}


/**
 *  显示加载动画
 *
 *  @param flag YES 显示，NO 不显示
 */
- (void)showLoadingView:(BOOL)flag
{
    if (flag)
    {
        [self.view addSubview:self.panelView];
        [self.loadingView startAnimating];
    }
    else
    {
        [self.panelView removeFromSuperview];
    }
}
#pragma mark 显示分享菜单

/**
 *  显示分享菜单
 *
 *  @param view 容器视图
 */
- (void)showShareActionSheet:(UIView *)view
{
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
    __weak JiankangListViewController *theController = self;
    /*
    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:imageArray
                                        url:[NSURL URLWithString:@"http://www.mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeImage];
    
    //1.2、自定义分享平台（非必要）
    NSMutableArray *activePlatforms = [NSMutableArray arrayWithArray:[ShareSDK activePlatforms]];
    //添加一个自定义的平台（非必要）
    SSUIShareActionSheetCustomItem *item = [SSUIShareActionSheetCustomItem itemWithIcon:[UIImage imageNamed:@"Icon.png"]
                                                                                  label:@"自定义"
                                                                                onClick:^{
                                                                                    
                                                                                    //自定义item被点击的处理逻辑
                                                                                    NSLog(@"=== 自定义item被点击 ===");
                                                                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"自定义item被点击"
                                                                                                                                        message:nil
                                                                                                                                       delegate:nil
                                                                                                                              cancelButtonTitle:LocationLanguage(@"yes", @"确定")
                                                                                                                              otherButtonTitles:nil];
                                                                                    [alertView show];
                                                                                }];
    [activePlatforms addObject:item];
    
    //设置分享菜单栏样式（非必要）
    //        [SSUIShareActionSheetStyle setActionSheetBackgroundColor:[UIColor colorWithRed:249/255.0 green:0/255.0 blue:12/255.0 alpha:0.5]];
    //        [SSUIShareActionSheetStyle setActionSheetColor:[UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0]];
    //        [SSUIShareActionSheetStyle setCancelButtonBackgroundColor:[UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0]];
    //        [SSUIShareActionSheetStyle setCancelButtonLabelColor:[UIColor whiteColor]];
    //        [SSUIShareActionSheetStyle setItemNameColor:[UIColor whiteColor]];
    //        [SSUIShareActionSheetStyle setItemNameFont:[UIFont systemFontOfSize:10]];
    //        [SSUIShareActionSheetStyle setCurrentPageIndicatorTintColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0]];
    //        [SSUIShareActionSheetStyle setPageIndicatorTintColor:[UIColor colorWithRed:62/255.0 green:62/255.0 blue:62/255.0 alpha:1.0]];
    
    //2、分享
    [ShareSDK showShareActionSheet:view
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                           
                       case SSDKResponseStateBegin:
                       {
                           [theController showLoadingView:YES];
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           //Facebook Messenger、WhatsApp等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
                           if (platformType == SSDKPlatformTypeFacebookMessenger)
                           {
                               break;
                           }
                           
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:LocationLanguage(@"yes", @"确定")
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:LocationLanguage(@"yes", @"确定")
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
                   
                   if (state != SSDKResponseStateBegin)
                   {
                       [theController showLoadingView:NO];
                       //                       [theController.tableView reloadData];
                   }
                   
               }];
    
    //另附：设置跳过分享编辑页面，直接分享的平台。
    //        SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:view
    //                                                                         items:nil
    //                                                                   shareParams:shareParams
    //                                                           onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
    //                                                           }];
    //
    //        //删除和添加平台示例
    //        [sheet.directSharePlatforms removeObject:@(SSDKPlatformTypeWechat)];
    //        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    */
}


//-(void)viewWillAppear:(BOOL)animated
//{
//    //    [GlobalFunc countView:@"web内嵌页"];
//    self.navigationController.navigationBarHidden = YES;
//    [self layoutNavigation];
//}

-(void)viewDidAppear:(BOOL)animated
{
    _tableViewDefault.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [_tableViewDefault.mj_header beginRefreshing];
    
//    loadView = [[LoadingAnimation alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, self.view.frame.size.height)];
//    [self.view addSubview:loadView];
    //    [loadView release];
}


//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    
//    
//}

- (IBAction)DetailsClicked:(UIButton *)sender
{
    
//    ZiliaokuDetailsViewController *videoRender = [[ZiliaokuDetailsViewController alloc] init];
//    videoRender.navigationController.navigationBarHidden = YES;
//    [self.navigationController pushViewController:videoRender animated:YES];
    
}

- (IBAction)ShangchengClicked:(UIButton *)sender
{
    
//    ShangchengViewController *videoRender = [[ShangchengViewController alloc] init];
//    videoRender.navigationController.navigationBarHidden = YES;
//    [self.navigationController pushViewController:videoRender animated:YES];
    
}


- (void)viewDidLoad
{

 if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    [super viewDidLoad];
    self.view.backgroundColor = [Common2 colorWithHexString:@"#ffffff"];
    
    
    UIView *lineViewFoot =[[UIView alloc]init];
    lineViewFoot.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth*1/320);
    lineViewFoot.backgroundColor=[Common2 colorWithHexString:@"#efefef"];
    
    [self.view addSubview:lineViewFoot];
    
    NSString *languStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"];
    BOOL isRu = [languStr isEqualToString:@"ru"];
    CGFloat ruHeight = isRu ? 40 : 10;
    
    CGFloat itemWidth = ScreenWidth / 4.0f;
    
    UIView *lineView =[[UIView alloc]init];
    lineView.frame = CGRectMake(0, 40 + ruHeight, ScreenWidth, 1);
    lineView.backgroundColor=[Common2 colorWithHexString:@"#0B7DED"];

    [self.view addSubview:lineView];
    
    
    UILabel *label_riqi = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*4/320, itemWidth, 40 + ruHeight)];
    label_riqi.text = LocationLanguage(@"date", @"日期");
    label_riqi.textColor = [Common2 colorWithHexString:@"#000000"];
    label_riqi.tintColor = [Common2 colorWithHexString:@"#000000"];
    label_riqi.font = [UIFont systemFontOfSize:14.0f];
    label_riqi.numberOfLines = 0;
    label_riqi.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label_riqi];
    
    UILabel *label_zuozi = [[UILabel alloc] initWithFrame:CGRectMake(itemWidth, ScreenWidth*4/320, itemWidth, 40 + ruHeight)];
    label_zuozi.text = LocationLanguage(@"sittingTimeHours", @"坐姿时间(时)");
    label_zuozi.textColor = [Common2 colorWithHexString:@"#000000"];
    label_zuozi.tintColor = [Common2 colorWithHexString:@"#000000"];
    label_zuozi.font = [UIFont systemFontOfSize:14.0f];
    label_zuozi.numberOfLines = 0;
    label_zuozi.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label_zuozi];
    
    UILabel *label_zhanzi = [[UILabel alloc] initWithFrame:CGRectMake(itemWidth * 2, ScreenWidth*4/320, itemWidth, 40 + ruHeight)];
    label_zhanzi.text = LocationLanguage(@"standingTimeHours", @"站姿时间(时)");
    label_zhanzi.textColor = [Common2 colorWithHexString:@"#000000"];
    label_zhanzi.tintColor = [Common2 colorWithHexString:@"#000000"];
    label_zhanzi.font = [UIFont systemFontOfSize:14.0f];
    label_zhanzi.numberOfLines = 0;
    label_zhanzi.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label_zhanzi];
    
    UILabel *label_zuozhanbi = [[UILabel alloc] initWithFrame:CGRectMake(itemWidth * 3, ScreenWidth*4/320, itemWidth, 40 + ruHeight)];
    label_zuozhanbi.text = LocationLanguage(@"sitStandRatio", @"坐站比");
    label_zuozhanbi.textColor = [Common2 colorWithHexString:@"#000000"];
    label_zuozhanbi.tintColor = [Common2 colorWithHexString:@"#000000"];
    label_zuozhanbi.font = [UIFont systemFontOfSize:14.0f];
    label_zuozhanbi.numberOfLines = 0;
    label_zuozhanbi.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label_zuozhanbi];
    
    
    if(isPadYES)
    {
        label_riqi.font = [UIFont systemFontOfSize:24.0f];
        label_zuozi.font = [UIFont systemFontOfSize:24.0f];
        label_zhanzi.font = [UIFont systemFontOfSize:24.0f];
        label_zuozhanbi.font = [UIFont systemFontOfSize:24.0f];

    }


    
    self.arrData = [[NSMutableArray alloc] init];
    self.pagesize =100;
    self.pageindex =0;
    
    CGFloat or = label_zuozhanbi.frame.origin.y + label_zuozhanbi.frame.size.height;
    _tableViewDefault = [[UITableView alloc] initWithFrame:CGRectMake(0, or, ScreenWidth, ScreenHeight - or - NavHeight)
                                                     style:UITableViewStylePlain];
    _tableViewDefault.dataSource = self;
    _tableViewDefault.delegate = self;
    [_tableViewDefault setBackgroundColor:[UIColor whiteColor]];
    //    [_listTable setShowsHorizontalScrollIndicator:NO];
    //    [_listTable setShowsVerticalScrollIndicator:NO];
    _tableViewDefault.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //      tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_tableViewDefault];
    
//    _tableViewDefault.allowsSelectionDuringEditing = YES;
//    [_tableViewDefault setEditing:YES animated:YES];
    
    //    _listTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    //
    //    [_listTable.mj_header beginRefreshing];
    

    
    
    CGRect frame = _tableViewDefault.tableHeaderView.frame;
    frame.size.height = 0.00001;
    UIView *headerView = [[UIView alloc] initWithFrame:frame];
    [_tableViewDefault setTableHeaderView:headerView];
    
//    UIView *tableHeaderView = [self createTableHeader];
//    _tableViewDefault.tableHeaderView = tableHeaderView;
    /*
    _textView =[QZTopTextView topTextView];
    _textView.delegate = self;
    [self.view addSubview:_textView];
    
    self.DQconstellationView = [DQconstellationView new];
    self.DQconstellationView.delegate = self;
    
    if(isPadYES)
    {
        lineViewFoot.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth*1/320);
        lineView.frame = CGRectMake(0, ScreenWidth*31/320, ScreenWidth, ScreenWidth*1/320);
        label_riqi.frame = CGRectMake(ScreenWidth*20/320, ScreenWidth*2/320, ScreenWidth*90/320, ScreenWidth*30/320);
        label_zuozi.frame = CGRectMake(ScreenWidth*80/320, ScreenWidth*2/320, ScreenWidth*90/320, ScreenWidth*30/320);
        label_zhanzi.frame = CGRectMake(ScreenWidth*160/320, ScreenWidth*2/320, ScreenWidth*90/320, ScreenWidth*30/320);
        label_zuozhanbi.frame = CGRectMake(ScreenWidth*260/320, ScreenWidth*2/320, ScreenWidth*90/320, ScreenWidth*30/320);
        _tableViewDefault.frame =CGRectMake(0, ScreenWidth*32/320, ScreenWidth, ScreenHeight-NavHeight -ScreenWidth*32/320 );
    }
    */
    
    
}

- (UIView*)createTableHeader
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
    
    view.backgroundColor = [UIColor whiteColor];// [Common2 colorWithHexString:@"#2B2B73"];
    
    
    
    
    
    //    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    exitButton.frame = CGRectMake((kDeviceWidth-100)/2-70, 20, 100, 38);
    //    //    exitButton.backgroundColor =RGBCOLOR(226, 86, 89);
    //
    //    //[exitButton setTitle:@"添加" forState:UIControlStateNormal];
    //    //    [exitButton setTitle:@"退出" forState:UIControlStateHighlighted];
    //    //    [exitButton setBackgroundImage:[UIImage imageNamed:@"img.bundle/common/red_btn@2x.png"] forState:UIControlStateNormal];
    //    [exitButton setImage:[UIImage imageNamed:@"tixinglingadd.png"] forState:UIControlStateNormal];
    //    //    exitButton.backgroundColor =[UIColor colorWithRed:253/255.0 green:156/255.0 blue:39/255.0 alpha:1.0];
    //    exitButton.layer.masksToBounds = YES;
    //    exitButton.layer.cornerRadius = 3;
    //    exitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    //    exitButton.titleLabel.textColor = [UIColor whiteColor];
    //    [exitButton addTarget:self action:@selector(VoiceSelect) forControlEvents:UIControlEventTouchUpInside];
    //    [view addSubview:exitButton];
    
    UIButton *btn_selectvoice = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_selectvoice.frame = CGRectMake((kDeviceWidth-100)*2/5, 10, 100, 38);
    //    exitButton.backgroundColor =RGBCOLOR(226, 86, 89);
    
    //[exitButton setTitle:@"添加" forState:UIControlStateNormal];
    //    [exitButton setTitle:@"退出" forState:UIControlStateHighlighted];
    //    [exitButton setBackgroundImage:[UIImage imageNamed:@"img.bundle/common/red_btn@2x.png"] forState:UIControlStateNormal];
    [btn_selectvoice setImage:[UIImage imageNamed:@"tixinglingadd.png"] forState:UIControlStateNormal];
    //    exitButton.backgroundColor =[UIColor colorWithRed:253/255.0 green:156/255.0 blue:39/255.0 alpha:1.0];
    btn_selectvoice.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 60);
    [btn_selectvoice setTitle:@"南瓜瓜" forState:UIControlStateNormal];
    //button标题的偏移量，这个偏移量是相对于图片的
    btn_selectvoice.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    //设置button正常状态下的标题颜色
    [btn_selectvoice setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn_selectvoice.layer.masksToBounds = YES;
    btn_selectvoice.layer.cornerRadius = 3;
    btn_selectvoice.titleLabel.font = [UIFont systemFontOfSize:14];
    btn_selectvoice.titleLabel.textColor = [UIColor whiteColor];
    [btn_selectvoice addTarget:self action:@selector(TixinglingAdd) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn_selectvoice];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 10, 100, 50);
    button.backgroundColor = [UIColor clearColor];
    //设置button正常状态下的图片
    [button setImage:[UIImage imageNamed:@"tixinglingadd.png"] forState:UIControlStateNormal];
    //设置button高亮状态下的图片
    [button setImage:[UIImage imageNamed:@"tixinglingadd.png"] forState:UIControlStateHighlighted];
//    //设置button正常状态下的背景图
//    [button setBackgroundImage:[UIImage imageNamed:@"_normal.png"] forState:UIControlStateNormal];
//    //设置button高亮状态下的背景图
//    [button setBackgroundImage:[UIImage imageNamed:@"_highlighted.png"] forState:UIControlStateHighlighted];
    //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
    button.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 60);
    [button setTitle:@"南瓜瓜" forState:UIControlStateNormal];
    //button标题的偏移量，这个偏移量是相对于图片的
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    //设置button正常状态下的标题颜色
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //设置button高亮状态下的标题颜色
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:button];
    
    
    
    UIButton *btn_share = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_share.frame = CGRectMake((kDeviceWidth-100)*3/5, 10, 100, 38);
    //    exitButton.backgroundColor =RGBCOLOR(226, 86, 89);
    
    //[exitButton setTitle:@"添加" forState:UIControlStateNormal];
        [btn_share setTitle:@"共享列表" forState:UIControlStateHighlighted];
    //    [exitButton setBackgroundImage:[UIImage imageNamed:@"img.bundle/common/red_btn@2x.png"] forState:UIControlStateNormal];
//    [btn_share setImage:[UIImage imageNamed:@"tixinglingadd.png"] forState:UIControlStateNormal];
    //    exitButton.backgroundColor =[UIColor colorWithRed:253/255.0 green:156/255.0 blue:39/255.0 alpha:1.0];
    btn_share.layer.masksToBounds = YES;
    btn_share.layer.cornerRadius = 3;
    btn_share.titleLabel.font = [UIFont systemFontOfSize:14];
    btn_share.titleLabel.textColor = [UIColor whiteColor];
    [btn_share addTarget:self action:@selector(ShareList) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn_share];
    
    
    
    return view;
}


- (void)ShareList
{
    //    TixinglingAddViewController *videoRender = [[TixinglingAddViewController alloc] init];
    //    videoRender.navigationController.navigationBarHidden = YES;
    //    [self.navigationController pushViewController:videoRender animated:YES];
    

    
}


- (void)TixinglingAdd
{
//    TixinglingAddViewController *videoRender = [[TixinglingAddViewController alloc] init];
//    videoRender.navigationController.navigationBarHidden = YES;
//    [self.navigationController pushViewController:videoRender animated:YES];
    
//    [_textView.lpTextView becomeFirstResponder];
    
}

- (void)headerRereshing {

    self.pageindex = 0;//清空
    
    DBTool *tool = [DBTool sharedDBTool];


//    NSArray *data_health = [tool selectWithClass:[Health class] params:@" 1=1  ORDER BY _riqi desc LIMIT 7 "];
    NSArray *data_health = [tool selectWithClass:[Health class] params:@" 1=1  ORDER BY _riqi desc  "];
//    NSArray *data_health = [tool selectWithClass:[Health class] params:nil];
    for (int i=0;i<data_health.count;i++) {
        Health *p4 = data_health[i];
        NSLog(@"%@",p4);
    }
  
    [_arrData removeAllObjects];

    _arrData = data_health;
    
    
        [_tableViewDefault.mj_header endRefreshing];
        [_tableViewDefault reloadData];
        
        

    


}

#pragma mark - cell 代理
- (void)btnClicked:(UIButton *)sender cell:(HealthCell *)cell
{
    //    NSLog(@"%@",sender.currentTitle);
    //
    //    @try {
    //        //需要捕获的数据处理
    //        NSIndexPath *indexPath = [_tableViewDefault indexPathForCell:cell];
    //        ModelAddrAddressList *modelCell = [self.arrData objectAtIndex:indexPath.row];
    //
    //        //跳到修改地址
    //        [self pushModifyWithTitle:@"修改收货信息" model:modelCell];
    //        _modifyVC.isEdiet = YES;
    //    }
    //    @catch (NSException *exception) {
    //        NSString *msg = [NSString stringWithFormat:@"%@ %s %d crash reason:%@",self.class,__FUNCTION__,__LINE__,exception];
    //        NSLog(@"%@",msg);
    //
    ////        [GlobalFunc addErrorTitle:@"数据访问错误" errorStr:msg requestStr:@"" resPonseStr:@""];
    //    }
    //    @finally {
    //
    //    }
    
}

#pragma mark - table 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isPadYES)
    {
        return ScreenWidth*30/320;
    }
    else
    {
        return ScreenWidth*45/320;
    }
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return ScreenWidth*150/320;
//}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LocationLanguage(@"delete", @"删除");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrData count];
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *viewfooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,  GetWidth(150))];
//    viewfooter.backgroundColor = [Common2 colorWithHexString:@"#f8f8f8"];
//
//    UIButton *btnHeader = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnHeader setFrame:CGRectMake((ScreenWidth-GetWidth(190))/2, GetWidth(55), GetWidth(190),  GetWidth(40))];
//
//    //设置边界的宽度和颜色
//    [btnHeader.layer setBorderWidth:1];
//    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
//    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){0,0,0,0.5});
//    [btnHeader.layer setBorderColor:color];
//    // [btnHeader setBackgroundColor:[UIColor whiteColor]];
//    //[btnHeader defaultModify];
//    [btnHeader.titleLabel setFont:[UIFont systemFontOfSize:GetWidth(17)]];
//    [btnHeader setImage:[UIImage imageNamed:@"address_btn-add"] forState:UIControlStateNormal];
//    [btnHeader setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
//    [btnHeader setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [btnHeader setTitle:@"添加新地址" forState:UIControlStateNormal];
//    [btnHeader setTitleColor:[Common2 colorWithHexString:@"#333333"] forState:UIControlStateNormal];
//    [btnHeader addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
//    [viewfooter addSubview:btnHeader];
//
//    return viewfooter;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HealthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HealthCell"];
    @try {
        //需要捕获的数据处理
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HealthCell" owner:self options:nil] lastObject];
            //            cell.delegate = self;
            cell.backgroundColor = [UIColor whiteColor];
            //            cell.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            //            cell.viewBg.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            //
            //            [cell.viewBg defaultModify];
        }
        //        cell.frame = CGRectMake(0, 0, ScreenWidth, GetWidth(70));
//        cell.labelTitle.frame = CGRectMake(65, GetWidth(25), GetWidth(240), GetWidth(21));
//        //cell.labelContent.frame = CGRectMake(5, GetWidth(30), GetWidth(320), GetWidth(44));
//        
//        cell.btnShare.frame = CGRectMake(ScreenWidth-100, GetWidth(25), 87, 30);
//        cell.btnShare_now.frame = CGRectMake(ScreenWidth-200, GetWidth(25), 87, 30);
//        cell.btnShare.imageView.image=nil;
        
        
        if(isPadYES)
        {
            cell.labelRiqi.font = [UIFont systemFontOfSize:24.0f];
            cell.labelZuozishijian.font = [UIFont systemFontOfSize:24.0f];
            cell.labelZhanzishijian.font = [UIFont systemFontOfSize:24.0f];
            cell.labelZuozhanbi.font = [UIFont systemFontOfSize:24.0f];
            
            
            cell.labelRiqi.frame = CGRectMake(GetWidth(5), GetWidth(0), GetWidth(90), ScreenWidth*30/320);
            cell.labelZuozishijian.frame = CGRectMake(GetWidth(110), GetWidth(0), GetWidth(90), ScreenWidth*30/320);
            cell.labelZhanzishijian.frame = CGRectMake(GetWidth(210), GetWidth(0), GetWidth(90), ScreenWidth*30/320);
            cell.labelZuozhanbi.frame = CGRectMake(GetWidth(310), GetWidth(0), GetWidth(90), ScreenWidth*30/320);
            
        }
        else{
            cell.labelRiqi.frame = CGRectMake(GetWidth(5), GetWidth(15), GetWidth(90), GetWidth(25));
            cell.labelZuozishijian.frame = CGRectMake(GetWidth(110), GetWidth(15), GetWidth(90), GetWidth(25));
            cell.labelZhanzishijian.frame = CGRectMake(GetWidth(210), GetWidth(15), GetWidth(90), GetWidth(25));
            cell.labelZuozhanbi.frame = CGRectMake(GetWidth(310), GetWidth(15), GetWidth(90), GetWidth(25));
        }
        //        cell.labDefault.frame = CGRectMake(GetWidth(310), GetWidth(25), GetWidth(30), GetWidth(15));
        //        cell.imgArrowright.frame = CGRectMake(GetWidth(340), GetWidth(25), GetWidth(15), GetWidth(15));
        //        cell.labelAddr.frame = CGRectMake(GetWidth(20), GetWidth(50), GetWidth(335), GetWidth(50));
        //        cell.imgLine.frame = CGRectMake(GetWidth(0), GetWidth(109), ScreenWidth, GetWidth(1));
        
        
        //        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 0, 1, 130)];
        //        viewLine.backgroundColor =  [Common2 colorWithHexString:@"#2B2B73"];
        //        [cell addSubview:viewLine];
        //
        //        UIView *viewLine2 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/2-15, GetWidth(70)/2, 30, 1)];
        //        viewLine2.backgroundColor =  [Common2 colorWithHexString:@"#2B2B73"];
        //        [cell addSubview:viewLine2];
        //
        //        UIView *viewLine3 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/2-5,  GetWidth(70)/2-5, 10, 10)];
        //        viewLine3.backgroundColor =  [Common2 colorWithHexString:@"#2B2B73"];
        //        [cell addSubview:viewLine3];
        //
        //        viewLine3.layer.masksToBounds = YES;
        //        viewLine3.layer.cornerRadius = 5.0;
        
        
        
        
        Health *dic = [self.arrData objectAtIndex:indexPath.row];
        cell.labelRiqi.text = [NSString stringWithFormat:@"%@",dic.riqi];
        cell.labelZuozishijian.text =  [NSString stringWithFormat:@"%.2f",dic.zuozishijian];
        cell.labelZhanzishijian.text = [NSString stringWithFormat:@"%.2f",dic.zhanzishijian];
       
        if(dic.zuozishijian==0.00 && dic.zhanzishijian!=0.00)
        {
            cell.labelZuozhanbi.text = @"0%";
        }
        else if(dic.zhanzishijian==0.00 && dic.zuozishijian!=0.00 )
        {
            cell.labelZuozhanbi.text = @"100%";
        }
        else if(dic.zhanzishijian==0.00 && dic.zuozishijian==0.00 )
        {
            cell.labelZuozhanbi.text = @"0%";
        }
        else
        {
            cell.labelZuozhanbi.text = [NSString stringWithFormat:@"%.f%@",dic.zuozishijian/(dic.zuozishijian+dic.zhanzishijian)*100,@"%"] ;
            
        }
        
        // [NSString stringWithFormat:@"%.2f",dic.zuozhanbi];
        //        NSString *addr = @"";
        //        if ([dic objectForKey:@"cat_icon_url"]) {
        //            addr = [addr stringByAppendingString:[dic objectForKey:@"cat_icon_url"]];
        //        }
        //        if ([dic objectForKey:@"city_name"]) {
        //            addr = [addr stringByAppendingString:[dic objectForKey:@"city_name"]];
        //        }
        //        if ([dic objectForKey:@"address"]) {
        //            addr = [addr stringByAppendingString:[dic objectForKey:@"address"]];
        //        }
        //        if ([dic objectForKey:@"addr_for_dealer"]) {
        //            addr = [addr stringByAppendingString:[dic objectForKey:@"addr_for_dealer"]];
        //        }
        
//        cell.labelTitle.font = [UIFont systemFontOfSize:GetWidth(15)];
//        cell.labelContent.font = [UIFont systemFontOfSize:GetWidth(15)];
//        
//        cell.labelTitle.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"title"]];
////        cell.labelTitle.text = [NSString stringWithFormat:@"%@_%@",[dic valueForKey:@"title"],[dic valueForKey:@"url"]];
//        cell.labelContent.text = [self TimeStamp:[NSString stringWithFormat:@"%@",[dic valueForKey:@"created_at"]]];
//        cell.btnShare.backgroundColor =[Common2 colorWithHexString:@"#2B2B73"];
//        cell.btnShare_now.backgroundColor =[Common2 colorWithHexString:@"#2B2B73"];
//        [cell.btnShare addTarget:self action:@selector(deviceButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//         [cell.btnShare_now addTarget:self action:@selector(deviceButtonPressed_now:) forControlEvents:UIControlEventTouchUpInside];
        
//        NSString *isshare = [dic valueForKey:@"isshare"];
//        if([isshare isEqualToString:@"1"])
//        {
////            isshare=@"1";
//            [cell.btnShare setTitle:@"取消分享" forState:UIControlStateNormal];
//            
//        }
//        else
//        {
////            isshare=@"0";
//            [cell.btnShare setTitle:@"分享" forState:UIControlStateNormal];
//        }
        
//        [cell.btnShare setTitle:@"延时播放" forState:UIControlStateNormal];
//        [cell.btnShare_now setTitle:@"立即播放" forState:UIControlStateNormal];
//        
//        
//        cell.btnShare.layer.masksToBounds = YES;
//        cell.btnShare.layer.cornerRadius = 6;
//        
//        cell.btnShare_now.layer.masksToBounds = YES;
//        cell.btnShare_now.layer.cornerRadius = 6;
        
        //        [dic objectForKey:@"voiceurl"]
        
        //        //wy
        //        cell.imgDefaultAddr.hidden = YES;
        //        cell.labDefault.hidden = YES;
        //        if ([modelCell.isDefault isEqualToString:@"1"]) {
        //            cell.imgDefaultAddr.hidden = NO;
        //            cell.labDefault.hidden = NO;
        //            self.selectIndexPath = indexPath;
        //        }
        //
        //       //wy
        //        if (_address && [modelCell.autoid isEqualToString:_address]) {
        //            cell.backgroundColor = [Common colorWithHexString:@"#efefef"];
        //
        //        }
        
        //        cell.backgroundColor = [Common colorWithHexString:@"#efefef"];
        
    }
    @catch (NSException *exception) {
        NSString *msg = [NSString stringWithFormat:@"%@ %s %d crash reason:%@",self.class,__FUNCTION__,__LINE__,exception];
        NSLog(@"%@",msg);
        
        //        [GlobalFunc addErrorTitle:@"数据访问错误" errorStr:msg requestStr:@"" resPonseStr:@""];
    }
    @finally {
        
    }
    
    return cell;
}

-(NSString *)TimeStamp:(NSString *)strTime
{
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    //用[NSDate date]可以获取系统当前时间
    
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    //输出格式为：2010-10-27 10:22:13
    
    NSLog(@"%@",currentDateStr);
    
    //alloc后对不使用的对象别忘了release
    
    
    
    return currentDateStr;
    
}

- (void)sendcmdClicked
{
//    ECMessage* message;
    //                      NSString *sessionId=@"18611498571";
    NSString * textString = @"$star_dance$";
    //    NSString *strurl =[NSString stringWithFormat:@"%@%@",@"http://img.loobot.net/",[resp objectForKey:@"key"]];
    
    NSString *strzhiling = [NSString stringWithFormat:@"%@&%@#time=%@",textString,_strurl,_datetimeStr];
    
//    LoobotModelDBTool *loobotModelDBTool = [LoobotModelDBTool shareInstance];
//    NSMutableArray *arr = [NSMutableArray arrayWithArray:[loobotModelDBTool selectAllModel_isdefult]];
//    for (NSDictionary *dict in arr) {
//        LoobotModel *model = [[LoobotModel alloc]init];
//        model.loobotid = [dict valueForKey:@"loobotid"];
//        model.loobotname = [dict valueForKey:@"loobotname"];
//        model.loobotnumber = [dict valueForKey:@"loobotnumber"];
//
//        message = [[DeviceChatHelper sharedInstance] sendTextMessage:strzhiling to:model.loobotnumber];
//        [[DemoGlobalClass sharedInstance].AtPersonArray removeAllObjects];
//        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_onMesssageChanged object:message];
//
//    }
    
    
    [Common2 TipDialog:@"发送编剧同步成功"];


}

- (void)initComponent {
    self.date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setLocale:[NSLocale localeWithLocaleIdentifier:@"ZH_CN"]];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:_date];
    
    _currentYear  = (int)[components year];
    _currentMonth = (int)[components month];
    _currentDay   = (int)[components day];
    _currentHour  = (int)[components hour];
    _currentMin   = (int)[components minute];
    _currentSec   = (int)[components second];
}

- (void)hideTimePicker {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.backgroundView.top = self.view.height;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
    }];
}

- (void)initView {
    self.maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    self.maskView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideTimePicker)];
    [self.maskView addGestureRecognizer:tap];
    
    self.backgroundView.width = SCREEN_WIDTH;
}

- (void)initPickerView {
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 316-220, SCREEN_WIDTH, 316)];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    
    UIButton *buttonCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 46, 30)];
    [buttonCancel setTitle:LocationLanguage(@"cancel", @"取消") forState:UIControlStateNormal];
    [buttonCancel setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.backgroundView addSubview:buttonCancel];
    [buttonCancel addTarget:self action:@selector(cancelClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonSure = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 46, 0, 46, 30)];
    [buttonSure setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [buttonSure setTitle:LocationLanguage(@"yes", @"确定") forState:UIControlStateNormal];
    [self.backgroundView addSubview:buttonSure];
    [buttonSure addTarget:self action:@selector(sureClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.timePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 216 - 30)];
    self.timePickerView.delegate = self;
    self.timePickerView.dataSource = self;
    [self.backgroundView addSubview:self.timePickerView];
    
    // 选定当前的时间
    [self.timePickerView selectRow:0 inComponent:0 animated:YES];
    [self.timePickerView selectRow:_currentMonth - 1 inComponent:1 animated:YES];
    [self.timePickerView selectRow:_currentDay - 1 inComponent:2 animated:YES];
    [self.timePickerView selectRow:_currentHour inComponent:3 animated:YES];
    [self.timePickerView selectRow:_currentMin inComponent:4 animated:YES];
    [self.timePickerView selectRow:_currentSec inComponent:5 animated:YES];
}

- (void)cancelClicked:(UIButton *)button {
    [self hideTimePicker];
}

- (void)sureClicked:(UIButton *)button {
    [self hideTimePicker];
    
    // 得到选择的时间
    int year  = (int)[self.timePickerView selectedRowInComponent:0];
    int month = (int)[self.timePickerView selectedRowInComponent:1];
    int day   = (int)[self.timePickerView selectedRowInComponent:2];
    int hour  = (int)[self.timePickerView selectedRowInComponent:3];
    int min   = (int)[self.timePickerView selectedRowInComponent:4];
    int sec   = (int)[self.timePickerView selectedRowInComponent:5];
    
    DLog(@"%d-%d-%d", year, month, day);
    int realYear = _currentYear + year;
    int realMonth = month + 1;
    int realDay = day + 1;
    int realHour = hour;
    int realMin = min;
    int realSec = sec;
    
    NSString *timeStr = [NSString stringWithFormat:@"%d-%02d-%02d %02d:%02d:%02d", realYear, realMonth, realDay, realHour, realMin, realSec];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:timeStr];
    date = [self getNowDateFromatAnDate:date];
    DLog(@"%@", date);
    
    _datetimeStr=timeStr;
    //        weakSelf.timeLbl.text = datetimeStr;
    
//    [self sendcmdClicked];
//    _datetimeStr=datetimeStr;
    //        weakSelf.timeLbl.text = datetimeStr;
    
//    ECMessage* message;
    //                      NSString *sessionId=@"18611498571";
    NSString * textString = @"$star_dance$";
    //    NSString *strurl =[NSString stringWithFormat:@"%@%@",@"http://img.loobot.net/",[resp objectForKey:@"key"]];
    
    NSString *strzhiling = [NSString stringWithFormat:@"%@&%@#time=%@",textString,_strurl,_datetimeStr];
    
//    LoobotModelDBTool *loobotModelDBTool = [LoobotModelDBTool shareInstance];
//    NSMutableArray *arr = [NSMutableArray arrayWithArray:[loobotModelDBTool selectAllModel_isdefult]];
//    for (NSDictionary *dict in arr) {
//        LoobotModel *model = [[LoobotModel alloc]init];
//        model.loobotid = [dict valueForKey:@"loobotid"];
//        model.loobotname = [dict valueForKey:@"loobotname"];
//        model.loobotnumber = [dict valueForKey:@"loobotnumber"];
//        
//        message = [[DeviceChatHelper sharedInstance] sendTextMessage:strzhiling to:model.loobotnumber];
//        [[DemoGlobalClass sharedInstance].AtPersonArray removeAllObjects];
//        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_onMesssageChanged object:message];
//        
//    }
    
    
    [Common2 TipDialog:@"发送编剧同步成功"];

    
}

//  IOS 世界标准时间UTC /GMT 转为当前系统时区对应的时间
//  引用 http://blog.csdn.net/fengsh998/article/details/9731617
- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

#pragma mark - UIPickerViewDataSource, UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 6;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            return 2050 - _currentYear + 1;
        }break;
        case 1:
        {
            return 12;
        }break;
        case 2:
        {
            if (_selectedMonth == 0 || _selectedMonth == 2 || _selectedMonth == 4 || _selectedMonth == 6 || _selectedMonth == 7 || _selectedMonth == 9 || _selectedMonth == 11) {
                return 31;
            } else if (_selectedMonth == 1) {
                int yearint = _selectedYear + _currentYear;
                
                if(((yearint % 4 == 0) && (yearint % 100 != 0))||(yearint % 400 == 0)){
                    return 29;
                }
                else {
                    return 28; // or return 29
                }
            } else {
                return 30;
            }
            
        }break;
        case 3:
        {
            return 24;
        }break;
        case 4:
        {
            return 60;
        }
        case 5:
        {
            return 60;
        }
        default:
            return 0;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        _selectedYear = (int)row;
    } else if (component == 1) {
        _selectedMonth = (int)row;
    } else if (component == 2) {
        _selectedDay = (int)row;
    } else if (component == 3) {
        _selectedHour = (int)row;
    } else if (component == 4) {
        _selectedMin = (int)row;
    }
    else {
        _selectedSec = (int)row;
    }
    [pickerView reloadAllComponents];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [NSString stringWithFormat:@"%d年", _currentYear + (int)row];
    } else if (component == 1) {
        return [NSString stringWithFormat:@"%d月", (int)row + 1];
    } else if (component == 2){
        return [NSString stringWithFormat:@"%d日", (int)row + 1];
    } else if (component == 3) {
        return [NSString stringWithFormat:@"%d时", (int)row];
    } else if (component == 4) {
        return [NSString stringWithFormat:@"%d分", (int)row];
    }
    else {
        return [NSString stringWithFormat:@"%d秒", (int)row];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:13]];
        pickerLabel.layer.cornerRadius = 3;
        pickerLabel.layer.masksToBounds = YES;
        
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

//点击选中哪一行 的代理方法
- (void)clickDQconstellationEnsureBtnActionConstellationStr:(NSString *)str{
    
    /*
    str = [str stringByReplacingOccurrencesOfString:@"秒后" withString:@""];
    NSLog(str);
    
    [self.tool getSystimelineData:@""  block:^(id json) {
        
        
        NSString *strtimeline =  json[@"timeline"];
        
        int inttimeline = [strtimeline intValue]+[str intValue];
        NSLog(@"getMeishiList = %d",inttimeline);
        
        NSString*strtime=[NSString stringWithFormat:@"%d", inttimeline];//@"1368082020";//时间戳
        
        NSTimeInterval time=[strtime doubleValue];//因为时差问题要加8小时 == 28800 sec
        
        NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        
        NSLog(@"date:%@",[detaildate description]);
        
        //实例化一个NSDateFormatter对象
        
        NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
        
        //设定时间格式,这里可以设置成自己需要的格式
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        _datetimeStr = [dateFormatter stringFromDate:detaildate];
        
        NSLog(@"date:%@",_datetimeStr);
        
        [self sendcmdClicked];
        
        
        
    }];
    
    
    //    [HttpTools getWithURL2:get_systemtimeUrl params:nil success:^(id json) {
    //
    //        NSLog(@"getMeishiList = %@",json);
    //        NSString *strtimeline = json;
    //
    //
    //
    //        int inttimeline = [strtimeline intValue]+[str intValue];
    //        NSLog(@"getMeishiList = %d",inttimeline);
    //
    //    } failure:^(NSError *error) {
    //        
    //    }];
     */
    
}

- (void)deviceButtonPressed_now:(id)sender{
    /*
    [HttpTools getSystemTimeWithURL:get_systemtimeUrl params:nil success:^(id json) {
        
        NSLog(@"getMeishiList = %@",json);
        NSString *strtimeline= [json objectForKey:@"timeline"];
        
        
        
        
        NSTimeInterval time=[strtimeline doubleValue];//因为时差问题要加8小时 == 28800 sec
        
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        
        NSLog(@"date:%@",[detaildate description]);
        
        //实例化一个NSDateFormatter对象
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        //设定时间格式,这里可以设置成自己需要的格式
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        
        
        NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
        
        _datetimeStr=currentDateStr;
        //        weakSelf.timeLbl.text = datetimeStr;
        
        [self sendcmdClicked];
        
        
        
        
    } failure:^(NSError *error) {
        
    }];
     */
}

- (void)deviceButtonPressed:(id)sender{
    
    
    UIView *v = [sender superview];//获取父类view
    HealthCell *cell = (HealthCell *)[v superview];//获取cell
    
    NSIndexPath *indexPath = [_tableViewDefault indexPathForCell:cell];//获取cell对应的indexpath;
    
    NSDictionary *dic = [self.arrData objectAtIndex:indexPath.row];
    //    NSString *danceid = [dic valueForKey:@"danceid"];
    _strurl = [dic valueForKey:@"url"];
    
//     [self.DQconstellationView startAnimationFunction];
    
//    [self initComponent];
//    [self initView];
//    [self initPickerView];
//    
//    [self.view addSubview:self.maskView];
//    [self.view addSubview:self.backgroundView];
//    self.maskView.alpha = 0;
//    self.backgroundView.top = self.view.height;
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        self.maskView.alpha = 0.3;
//        self.backgroundView.bottom = self.view.height;
//    }];
    
    
//    __block JiankangListViewController *weakSelf = self;
//    
//    dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateTimeMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
//    //    dateTimePickerView.topViewColor = [UIColor greenColor];
//    //    dateTimePickerView.buttonTitleColor = [UIColor redColor];
//    [dateTimePickerView setMinYear:1990];
//    [dateTimePickerView setMaxYear:2036];
//    dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
//        NSLog(@"%@", datetimeStr);
//        
//        _datetimeStr=datetimeStr;
//        //        weakSelf.timeLbl.text = datetimeStr;
//        
//        ECMessage* message;
//        //                      NSString *sessionId=@"18611498571";
//        NSString * textString = @"$star_dance$";
//        //    NSString *strurl =[NSString stringWithFormat:@"%@%@",@"http://img.loobot.net/",[resp objectForKey:@"key"]];
//        
//        NSString *strzhiling = [NSString stringWithFormat:@"%@&%@#time=%@",textString,strurl,datetimeStr];
//        
//        LoobotModelDBTool *loobotModelDBTool = [LoobotModelDBTool shareInstance];
//        NSMutableArray *arr = [NSMutableArray arrayWithArray:[loobotModelDBTool selectAllModel_isdefult]];
//        for (NSDictionary *dict in arr) {
//            LoobotModel *model = [[LoobotModel alloc]init];
//            model.loobotid = [dict valueForKey:@"loobotid"];
//            model.loobotname = [dict valueForKey:@"loobotname"];
//            model.loobotnumber = [dict valueForKey:@"loobotnumber"];
//            
//            message = [[DeviceChatHelper sharedInstance] sendTextMessage:strzhiling to:model.loobotnumber];
//            [[DemoGlobalClass sharedInstance].AtPersonArray removeAllObjects];
//            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_onMesssageChanged object:message];
//            
//        }
//        
//        
//        [Common2 TipDialog:@"发送编剧同步成功"];
//        
//       
//    };
//    
//    if (dateTimePickerView) {
//        [self.view addSubview:dateTimePickerView];
//        [dateTimePickerView showHcdDateTimePicker];
//    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSDictionary *dic = [self.arrData objectAtIndex:indexPath.row];
//    Bianwu2ViewController *videoRender = [[Bianwu2ViewController alloc] init];
//    videoRender.strid =[NSString stringWithFormat:@"%@",[dic valueForKey:@"danceid"]];
//    videoRender.strName =[NSString stringWithFormat:@"%@",[dic valueForKey:@"title"]];
//    videoRender.navigationController.navigationBarHidden = YES;
//    [self.navigationController pushViewController:videoRender animated:YES];
    
    
//     NSDictionary *dic = [self.arrData objectAtIndex:indexPath.row];
//    Bianwu2ViewController *videoRender = [[Bianwu2ViewController alloc] init];
//    videoRender.strid =[NSString stringWithFormat:@"%@",[dic valueForKey:@"danceid"]];
//    videoRender.strName =[NSString stringWithFormat:@"%@",[dic valueForKey:@"title"]];
//    videoRender.navigationController.navigationBarHidden = YES;
//    [self.navigationController pushViewController:videoRender animated:YES];
    
//    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
//    
//    dispatch_async(dispatchQueue,^(void){
//        NSDictionary *dic = [self.arrData objectAtIndex:indexPath.row];
//        
//        
//        NSString *sessionId =@"";
//        if([SFHFKeychain getPasswordForUsername:@"UDID" andServiceName:KEY_UUID error:nil].length>0)
//        {
//            sessionId = [SFHFKeychain getPasswordForUsername:@"UDID" andServiceName:KEY_UUID error:nil];
//            
//        }
//        //            _phoneText.text=sessionId;
//        ECMessage* message;
//        NSString *sessionId2= sessionId;// @"18611498571";
//        NSString * textString =[dic objectForKey:@"voiceurl"];// @"ADJUST_LOWER";
//        message = [[DeviceChatHelper sharedInstance] sendTextMessage:textString to:sessionId2];
//        [[DemoGlobalClass sharedInstance].AtPersonArray removeAllObjects];
//        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_onMesssageChanged object:message];
//        
//        
//        
//        
//        ////        NSString*filePath = [[NSBundlemainBundle] pathForResource:@"Test" ofType:@"mp3"];
//        //
//        //        NSData* voiceData= [NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"voiceurl"]]];
//        //
//        //        NSError*error = nil;
//        //
//        //        play = [[AVAudioPlayer alloc]initWithData:voiceData error:&error];
//        //        NSLog(@"%@",error);
//        //        play.volume = 1.0f;
//        //        [play play];
//        //        NSLog(@"yesssssssssss..........%f",play.duration);
//        ////        [_btn setTitle:@"按住录音" forState:UIControlStateNormal];
//        //
//        //
//        //
//        ////        self.audioPlay = [[AVAudioPlayer alloc] initWithData:data error:&error];
//        ////
//        ////        if(_audioPlay != nil) {
//        ////
//        ////            self.audioPlay.delegate = self;
//        ////
//        ////
//        ////
//        ////        } else {
//        ////
//        ////            NSLog(@"Error");
//        ////
//        ////            NSLog(@"%@", error.description);
//        ////
//        ////        }
//        
//        
//        
//    });
//    
//    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    //
//    //    @try {
//    //        //需要捕获的数据处理
//    //        ModelAddrAddressList *modelCell = [self.arrData objectAtIndex:indexPath.row];
//    //
//    //        if (_type == 1) { //选择
//    ////            [self netRequestWithTag:3 addressID:modelCell.autoid];//选择地址
//    //
//    //        } else { //管理
//    //            //跳到修改地址
//    //            [self pushModifyWithTitle:@"编辑地址" model:modelCell];
//    //            _modifyVC.isEdiet = YES;
//    //            _modifyVC.isdefAddress = modelCell.isDefault;
//    //
//    //        }
//    //    }
//    //    @catch (NSException *exception) {
//    //        NSString *msg = [NSString stringWithFormat:@"%@ %s %d crash reason:%@",self.class,__FUNCTION__,__LINE__,exception];
//    //        NSLog(@"%@",msg);
//    //
//    ////        [GlobalFunc addErrorTitle:@"数据访问错误" errorStr:msg requestStr:@"" resPonseStr:@""];
//    //    }
//    //    @finally {
//    //
//    //    }
//    
//    //    ZiliaokuTwoViewController *videoRender = [[ZiliaokuTwoViewController alloc] init];
//    //    videoRender.navigationController.navigationBarHidden = YES;
//    //    [self.navigationController pushViewController:videoRender animated:YES];
}

//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}



//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        DanceModel *noticeModel = self.arrData[indexPath.row];
//        DanceModelDBTool *noticeDBTool = [DanceModelDBTool shareInstance];
//        [noticeDBTool deleteModelWithkey:@"danceid" value:noticeModel.danceid];
//        [self.arrData removeObject:noticeModel];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}




//发送验证码
-(void)acceptVerifycodeTouched:(id)sender
{
    NSLog(@"%@",@"aaaaa");
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    
}

@end
