//
//  WebjsViewController.m
//  天天网
//
//  Created by zhaoweibing on 14-9-5.
//  Copyright (c) 2014年 oyxc. All rights reserved.
//

#import "BlueTouchSettingViewController.h"
#import "AppDelegate.h"
#import "Global.h"
#import "Common2.h"

////#import "LoginVC.h"
//#import "SessionViewController.h"
//#import "UIButton+Badge.h"
//#import "ShangchengRcommandDataTool.h"
//#import "LoadingAnimation.h"

//#import "UIImageView+WebCache.h"
//#import "ImageCacher.h"
//#import "FileHelpers.h"

//#import "MJPhotoBrowser.h"
//#import "MJPhoto.h"
//#import "CTAssetsPickerController.h"
//#import "RSKImageCropViewController.h"
//#import "QiniuSDK.h"



//#import "QiniuSDK.h"
//#import "QN_GTM_Base64.h"
#include <CommonCrypto/CommonCrypto.h>
//#import "JSONKit.h"
//#import "AFNetworking.h"
//@import AFNetworking;

//#import "VDVideoRecordListViewController.h"

//#import "StartSettingViewController.h"
//#import "WakeupwordSettingViewController.h"

//#import "HttpTools.h"



//#import "LanguageViewController.h"
//#import "DeviceViewController.h"
//#import "SettingYanzhengViewController.h"
//#import "EEBaseInfoUtil.h"

//#import "GuideViewController.h"
//#import "WendaViewController.h"
//#import "LoobotListViewController.h"

//#import "WhiteListViewController.h"


//#import "LoobotModel.h"
//#import "LoobotModelDBTool.h"

#import "AboutViewController.h"
#import "ToolViewController.h"
#import "ZixuexiViewController.h"
#import "GaodushezhiViewController.h"
#import "DanweishezhiViewController.h"
#import "FengmingqiViewController.h"
#import "XipingshijianViewController.h"
#import "PengzhuangbaohuViewController.h"
#import "ShoubingliangduViewController.h"
#import "MainBlueTouchViewController.h"
#import "DBTool.h"
#import "BlueTouchDevice.h"

#import "WXLongTimeViewController.h"

@interface BlueTouchSettingViewController ()
//@property (nonatomic,strong) ShangchengRcommandDataTool *tool;

@property (strong, nonatomic) DBTool *dbtool;

//@property(nonatomic,strong) SessionViewController * sessionView;

@property (nonatomic , assign) int expires;
@property(nonatomic,strong) NSString* qiniuToken;

@property (strong, nonatomic) UISwitch *autoLoginSwitch;
@property (strong, nonatomic) UISwitch *ipSwitch;
@end

@implementation BlueTouchSettingViewController
@synthesize autoLoginSwitch = _autoLoginSwitch;
@synthesize ipSwitch = _ipSwitch;

//- (ShangchengRcommandDataTool *)tool{
//    if (_tool == nil) {
//        _tool = [[ShangchengRcommandDataTool alloc]init];
//
//    }
//    return _tool;
//}



//- (IBAction)qiniuUpload:(id)sender {
//    
//    
//    QNUploadManager *upManager = [[QNUploadManager alloc] init];
//    NSData *data = [@"Hello, World!" dataUsingEncoding : NSUTF8StringEncoding];
//    
//    // NSURL *fileUrl=[NSURL URLWithString:@"file:///Users/yishiyaonie/Downloads/trim.4C7DE72F-3BEC-4DBB-8FA4-4F11BFDEF0ED.MOV"];
//    
//    // NSData *data = [NSData dataWithContentsOfURL:fileUrl ];
//    [upManager putData:data key:nil token:@"0MLvWPnyya1WtPnXFy9KLyGHyFPNdZceomLVk0c9:Mm_ic_Of23LLqd-rCno8Z4lCX5Q=:eyJzY29wZSI6InFpbml1LXBsdXBsb2FkIiwiZGVhZGxpbmUiOjE0NDI4Mjc2NDF9"
//              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//                  NSLog(@"%@", info);
//                  NSLog(@"七牛返回信息%@", resp);
//              } option:nil];
//}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"我的"];
    //    [GlobalFunc countView:@"web内嵌页"];
    self.navigationController.navigationBarHidden = NO;
//    [self layoutNavigation];
    
//    loadView = [[LoadingAnimation alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height)];
//    [self.view addSubview:loadView];
//    
//    [self getData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"我的"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//        loadView = [[LoadingAnimation alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height)];
//        [self.view addSubview:loadView];
//    
//        [self getData];
}

- (void)leftBarClicked:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)download
{
    NSString *path = @"自己查看一下文档，这里填你需要下载的文件的url";
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:path] cachePolicy:1 timeoutInterval:15.0f];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"response = %@",response);
        
        //得到了JSON文件 解析就好了。
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        NSLog(@"%@", result);
        
    }];
}

- (void)rightBarClicked:(UIButton *)sender
{
    

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
//    labelcenter.text = @"个人中心";
//    labelcenter.textAlignment= NSTextAlignmentCenter;
//    [viewNavigation addSubview:labelcenter];
//    
////        UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
////        btn_right.frame = CGRectMake(ScreenWidth-40-5,10, 40, 40);
////        [btn_right setImage:[UIImage imageNamed:@"massage.png"] forState:UIControlStateNormal];
////        [btn_right setImage:[UIImage imageNamed:@"massage.png"] forState:UIControlStateHighlighted];
////    btn_right.showsTouchWhenHighlighted=YES;
////        [btn_right addTarget:self action:@selector(rightBarClicked:) forControlEvents:UIControlEventTouchUpInside];
////        [viewNavigation addSubview:btn_right];
//    
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = LocationLanguage(@"settings", @"设置");//CustomLocalizedString(@"gerenzhongxin", nil);//@"个人中心";
        self.hidesBottomBarWhenPushed = NO;
        
        UIBarButtonItem *buttonLeft = [Common2 CreateNavBarButton:self setEvent:@selector(leftBarClicked:) background:@"btn_back.png" setTitle:nil];
        self.navigationItem.leftBarButtonItem = buttonLeft;
        
        
//        UIBarButtonItem *buttonRight = [Common2 CreateNavBarButton:self setEvent:@selector(rightBarClicked:) background:@"massage.png" setTitle:nil];
//        self.navigationItem.rightBarButtonItem = buttonRight;
        
        
        
        
    }
    return self;
}


- (IBAction)LogoutClicked:(UIButton *)sender
{
//    LoginVC *videoRender = [[LoginVC alloc] init];
//    videoRender.navigationController.navigationBarHidden = YES;
//    [self.navigationController pushViewController:videoRender animated:YES];

    
}

-(void)connectStateChanged:(NSNotification *)notification {
//    ECError* error = notification.object;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectStateChanged:) name:KNOTIFICATION_minepop object:nil];
    

 if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    [super viewDidLoad];
    self.view.backgroundColor = [Common2 colorWithHexString:@"#2B2B73"];
    
    
//    [HttpTools getWithURL2:qiniu_TokenUrl params:nil success:^(id json) {
//        _qiniuToken =json;
//        NSLog(@"getMeishiList = %@",json);
//    } failure:^(NSError *error) {
//
//    }];
//

//    NSArray *array1 = [NSArray arrayWithObjects:@"宝宝",@"昵称",@"成员",@"账号",nil];
//    NSArray *array1 = [NSArray arrayWithObjects:CustomLocalizedString(@"wudarao", nil),CustomLocalizedString(@"kaijishegnyin", nil),CustomLocalizedString(@"xuanzeyuyan", nil),CustomLocalizedString(@"jiaoluoboshuohua", nil),CustomLocalizedString(@"jiqirshezhi", nil),CustomLocalizedString(@"huanxingceshezhi", nil),CustomLocalizedString(@"dianhuabaimingdan", nil),nil];
    NSArray *array2 = [NSArray arrayWithObjects:CustomLocalizedString(@"shebeishezhi", nil),nil];
    
    
    NSArray *array1 = [NSArray arrayWithObjects:LocationLanguage(@"connectBluetooth", @"蓝牙连接"),
                       LocationLanguage(@"self-learning", @"自学习"),
                       LocationLanguage(@"heightSet", @"高度设置"),
                       LocationLanguage(@"unit", @"单位设置"),
                       LocationLanguage(@"buzzer", @"蜂鸣器"),
                       LocationLanguage(@"handleBrightness", @"手柄亮度"),
                       LocationLanguage(@"screenSaverTime", @"息屏时间"),
                       LocationLanguage(@"protection", @"碰撞保护"),
                       LocationLanguage(@"setting_longtime", @"久坐提醒"),
                       LocationLanguage(@"about", @"关于"), nil];
    
    //,@"勿扰模式",@"开机声音",@"选择语言",@"设备设置",@"教路波说话",@"机器人设置",@"机器人名称/唤醒词设置",

    m_arrayList = [[NSMutableArray alloc] initWithObjects: array1,nil];
    
    _m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64 ) style:UITableViewStylePlain];
    _m_tableView.delegate = self;
    _m_tableView.dataSource = self;
    _m_tableView.rowHeight = 51;
    _m_tableView.separatorColor = [Common2 colorWithHexString:@"#f0efed"];
    _m_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    _m_tableView.scrollEnabled = YES;
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if (IOS7_OR_LATER) {
        [_m_tableView setSeparatorInset:UIEdgeInsetsZero];//
    }
#endif
    _m_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [Common2 colorWithHexString:@"#f0efed"];
    _m_tableView.backgroundView = view;

    //	m_tableView.backgroundColor = [Common colorWithHexString:@"#f0efed"];
    [self.view addSubview:_m_tableView];
//    UIView *tableHeaderView = [self createTableHeader];
//    m_tableView.tableHeaderView = tableHeaderView;

    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exitButton.frame = CGRectMake(9, 20, ScreenWidth-18, 48);
    //    exitButton.backgroundColor =RGBCOLOR(226, 86, 89);
    
    [exitButton setTitle:CustomLocalizedString(@"tuichudangqiangzhanghao", nil) forState:UIControlStateNormal];
    //    [exitButton setTitle:@"退出" forState:UIControlStateHighlighted];
    //    [exitButton setBackgroundImage:[UIImage imageNamed:@"img.bundle/common/red_btn@2x.png"] forState:UIControlStateNormal];
    exitButton.backgroundColor =[UIColor colorWithRed:253/255.0 green:156/255.0 blue:39/255.0 alpha:1.0];
    exitButton.layer.masksToBounds = YES;
    exitButton.layer.cornerRadius = 3;
    exitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    exitButton.titleLabel.textColor = [UIColor whiteColor];
    [exitButton addTarget:self action:@selector(resginAction) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:exitButton];
    
    
    lbl_name = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-100, 80, 200, 15)];
    lbl_name.backgroundColor = [UIColor clearColor];
    lbl_name.font = [UIFont systemFontOfSize:12];
    lbl_name.textColor = [Common2 colorWithHexString:@"#31302f"];
    lbl_name.textAlignment = UITextAlignmentCenter;
    [footView addSubview:lbl_name];
    //    lbl_name.text =EEBaseInfoUtil.appVersion;
    
    NSString *signature =@"";
//    lbl_name.text = [NSString stringWithFormat:@"%@:%@",CustomLocalizedString(@"dangqianbanben", nil),EEBaseInfoUtil.appVersion];
    
    
    
    
//    m_tableView.tableFooterView = footView;
    


    
 }

- (void)getData {
    
//    [self.tool getUserInfoData:[DemoGlobalClass sharedInstance].userName block:^(id json) {
//
//        [loadView removeFromSuperview];
//
//        NSLog(@"%@",json);
//
//        NSDictionary* dic = json[@"item"];
//
//        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"userinfo"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//
////        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userinfo"];
//        NSString *struserimage = [dic objectForKey:@"userimage"];
//        [m_imageIconV sd_setImageWithURL:[NSURL URLWithString:struserimage] placeholderImage:[UIImage imageNamed:@"ig_profile_photo_default.png"]];
//
////        UIView *tableHeaderView = [self createTableHeader];
////        m_tableView.tableHeaderView = tableHeaderView;
//
//        [m_tableView reloadData];
    
//        NSString *strjingli = [dic objectForKey:@"jingli"];
//        NSString *strmeili = [dic objectForKey:@"meili"];
//        NSString *strzhili = [dic objectForKey:@"zhili"];
        
//        self.lbl_jingli.text =strjingli;
//        self.lbl_meili.text =strmeili;
//        self.lbl_zhili.text =strzhili;
//        
//        self.zdProgressView_jingli.progress = strjingli.doubleValue/10;
//        self.zdProgressView_meili.progress = strmeili.doubleValue/10;
//        self.zdProgressView_zhili.progress = strzhili.doubleValue/10;
        
        
        
        
        
//    }];
}

//- (void)getData {
//    
//    
//    //获得侧边数据
//    [self.tool getIdaddyClassListData:^(id json) {
//        
//        [loadView removeFromSuperview];
//        //        [SVProgressHUDManager dismiss];
//        //        [_arrData removeAllObjects];
//        NSLog(@"%@",json);
//        //        _arrData = json[@"audioinfos"][@"cats"];//  [FenleiMainCategorys mj_objectArrayWithKeyValuesArray:json[@"main_categorys"]];
//        //
//        //
//        //
//        //        [_tableViewDefault.mj_header endRefreshing];
//        //        [_tableViewDefault reloadData];
//        
//        
//        //        self.categoryArray = json;
//        //        NSLog(@"%@",self.categoryArray);
//        
//        //        [self reloadViews];
//        
//    }];
//}
/*
- (void)logoutAction
{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.removeFromSuperViewOnHide = YES;
    hub.labelText = @"正在注销...";
    
    [[ECDevice sharedInstance] logout:^(ECError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
//        [DemoGlobalClass sharedInstance].userName = nil;
//
//        [DemoGlobalClass sharedInstance].isLogin = NO;
        
        //为了页面的跳转，使用了该错误码，用户在使用过程中，可以自定义消息，或错误码值
//        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_onConnected object:[ECError errorWithCode:10]];
    }];
}
- (IBAction)resginAction
{
    [self logoutAction];
    
    

     [SFHFKeychain deleteItemForUsername:@"UDID" andServiceName:KEY_UUID  error:nil];

    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userid"];
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    if(!userid)
    {
//        [self.navigationController popViewControllerAnimated:YES];
        
//        LoginVC *login = [[LoginVC alloc] init];
//        //	[login setFid:self];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
//
//        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//        [window.rootViewController presentModalViewController:nav animated:YES];
        
        
        
//        LoginVC *appStartController = [[LoginVC alloc] init];
//        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//        window.rootViewController =[[UINavigationController alloc] initWithRootViewController:appStartController];
        
//         [self.navigationController popViewControllerAnimated:YES];

    }
    
}
*/
- (UIView*)createTableHeader
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 160)];
    
     view.backgroundColor = [Common2 colorWithHexString:@"#2B2B73"];

    UIButton *btnhide = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2-50, 20, 90, 90)];
    [view addSubview:btnhide];
    
    m_imageIconV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-50, 15, 100, 100)];
    m_imageIconV.backgroundColor = [UIColor clearColor];
    
    m_imageIconV.layer.masksToBounds = YES;
    //    m_imageIconV.layer.cornerRadius = 6.0;
    //    m_imageIconV.layer.borderWidth = 1.0;
    
    //    m_imageIconV.layer.cornerRadius=27.0;    //最重要的是这个地方要设成imgview高的一半
    //
    //    m_imageIconV.layer.borderWidth=1.0;
    
    m_imageIconV.layer.cornerRadius = m_imageIconV.frame.size.height / 2 ;
    m_imageIconV.layer.borderColor = [UIColor whiteColor].CGColor;
    m_imageIconV.layer.borderWidth = 1.0f;
    
    
    [view addSubview:m_imageIconV];
    //    m_imageIconV.layer.cornerRadius = 8.0;
    //    m_imageIconV.layer.masksToBounds = YES;
    
//    [m_imageIconV setImage:[UIImage imageNamed:@"ig_profile_photo_default.png"]];
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userinfo"];
    NSString *struserimage = [dic objectForKey:@"userimage"];
//    [m_imageIconV sd_setImageWithURL:[NSURL URLWithString:struserimage] placeholderImage:[UIImage imageNamed:@"ig_profile_photo_default.png"]];

//    
//    btnhide.badgeValue = @"12";
    
    imageView_sex = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2+50-22, 83, 22, 22)];
    [view addSubview:imageView_sex];
    [imageView_sex setImage:[UIImage imageNamed:@"img.bundle/common/male_icon@2x.png"]];
    
    
    
    UIButton *imageView = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2-50, 15, 100, 100)];
    imageView.tag = 140;
    //    [imageView setBackgroundImage:[UIImage imageNamed:@"img.bundle/common/moreBg_01@2x.png"] forState:UIControlStateNormal];
    //    [imageView setBackgroundImage:[UIImage imageNamed:@"img.bundle/common/moreBg_01@2x.png"] forState:UIControlStateHighlighted];
    //	[imageView setImage:[UIImage imageNamed:@"img.bundle/user/img8.png"] forState:UIControlStateHighlighted];
    [imageView addTarget:self action:@selector(changeHead) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:imageView];
    
    
    
    lbl_name = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-100, 130, 200, 15)];
    lbl_name.backgroundColor = [UIColor clearColor];
    lbl_name.font = [UIFont boldSystemFontOfSize:16];
    lbl_name.textColor = [Common2 colorWithHexString:@"#ffffff"];
    lbl_name.textAlignment = UITextAlignmentCenter;
    [view addSubview:lbl_name];
    
 
    lbl_name.text = [dic objectForKey:@"nickname"];
    
    
    

    
    return view;
}


#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [m_arrayList count];
}

//获取数据条数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[m_arrayList objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }
    return 5;
}

#pragma mark - table 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isPadYES)
    {
        return ScreenWidth*28/320;
    }
    else
    {
        return ScreenWidth*45/320;
    }
    
}

//填充数据源
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Contentidentifier = [NSString stringWithFormat:@"Cell%d%d",indexPath.section, indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Contentidentifier];
    
    if ( !cell )
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Contentidentifier];
        //		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        UIImageView *imageViewJian = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-40, 18.5, 8, 14)];
        imageViewJian.image = [UIImage imageNamed:@"jiantou.png"];
        cell.accessoryView = imageViewJian;
    }
    NSArray * array = [m_arrayList objectAtIndex:indexPath.section];
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    if (indexPath.row == 8) {
        NSString *longTime = [[NSUserDefaults standardUserDefaults] objectForKey:Long_time];
        if (longTime.length == 0) {
            longTime = @"120";
        }
        int min = [longTime intValue];
        int hour = min / 60;
        min = min - hour * 60;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d h %d min", hour, min];
    }else {
        cell.detailTextLabel.text = @"";
    }
    return cell;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",buttonIndex);
    if(buttonIndex ==0)
    {

        
    }
    else if(buttonIndex ==1)
    {
        [[BLEManager sharedManager]disableBLEManager];
        
        MainBlueTouchViewController *videoRender = [[MainBlueTouchViewController alloc] init];
        videoRender.navigationController.navigationBarHidden = YES;
        [self.navigationController pushViewController:videoRender animated:YES];
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSString *userid  = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    //    if (!userid) {
    ////        [self butEventLogin];
    //        return;
    //    }
    //    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    UIImageView *imageBack = (UIImageView*)[cell viewWithTag:120];
    //    NSDictionary *dic;
    //    id vc = nil;
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
   
                case 0:
                {
//                    ToolViewController *videoRender = [[ToolViewController alloc] init];
//                    videoRender.navigationController.navigationBarHidden = YES;
//                    [self.navigationController pushViewController:videoRender animated:YES];
                    
//                    NSString *strname =[BLEManager sharedManager].periperal.name;
//                    _dbtool = [DBTool sharedDBTool];
//                    NSString *params1 =[NSString stringWithFormat:@"_type='%@'",@"1"];
//                     NSMutableArray *dataSource_1 = [_dbtool selectWithClass:[BlueTouchDevice class] params:params1];
//                        for (int i=0;i<dataSource_1.count;i++)
//                        {
//                            BlueTouchDevice *db_periperal= dataSource_1[i];
//                            NSLog(@"%@",db_periperal);
//
//                            if([db_periperal.identifier isEqualToString:[BLEManager sharedManager].periperal.identifier.UUIDString])
//                            {
//                                strname = db_periperal.nickname;
//                            }
//
//
//                        }
                    
                    MainBlueTouchViewController *videoRender = [[MainBlueTouchViewController alloc] init];
                    videoRender.isSourceSetting = YES;
                    videoRender.navigationController.navigationBarHidden = YES;
                    [self.navigationController pushViewController:videoRender animated:YES];
                    
                    
                    
//                    NSString *strContent =@"当前蓝牙连接名称是:";
//                    NSString *strTitle = @"您确定要断开当前连接重新连接蓝牙吗？";//  [NSString stringWithFormat:@"当前蓝牙连接名称是:%@",[BLEManager sharedManager].periperal.name];
//                    NSString *strContent = [NSString stringWithFormat:@"当前蓝牙连接名称是:\n%@ \nMac地址是:\n%@",strname,[BLEManager sharedManager].periperal.identifier.UUIDString];
//
//
//                    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:strTitle message:strContent delegate:self cancelButtonTitle:LocationLanguage(@"cancel", @"取消") otherButtonTitles:LocationLanguage(@"yes", @"确定"), nil];
//                    alt.delegate=self;
//                    [alt show];
                    
//                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前蓝牙连接名称是:" preferredStyle:UIAlertControllerStyleAlert];
//                    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
//                    [self.view addSubview:alert];
                    // 弹出对话框
//                    [self presentViewController:alert animated:true completion:nil];
                    
                    
                    

                    
                }
                    break;
                    

                    
                case 1:
                {
              
                    ZixuexiViewController *videoRender = [[ZixuexiViewController alloc] init];
                    videoRender.navigationController.navigationBarHidden = YES;
                    [self.navigationController pushViewController:videoRender animated:YES];
                }
                    
                    break;
                    
                case 2:
                {
                    
                    GaodushezhiViewController *videoRender = [[GaodushezhiViewController alloc] init];
//                    videoRender.navigationController.navigationBarHidden = YES;
                    [self.navigationController pushViewController:videoRender animated:YES];
                }
                  
                    break;

                case 3:
                {
//                    #import "DanweishezhiViewController.h"
                    DanweishezhiViewController *videoRender = [[DanweishezhiViewController alloc] init];
//                    videoRender.navigationController.navigationBarHidden = YES;
                    [self.navigationController pushViewController:videoRender animated:YES];
                }
                    break;
                case 4:
                {
                    
                    FengmingqiViewController *videoRender = [[FengmingqiViewController alloc] init];
//                    videoRender.navigationController.navigationBarHidden = YES;
                    [self.navigationController pushViewController:videoRender animated:YES];
                }
                    break;
               
                case 5:
                {
//#import "XipingshijianViewController.h"
//#import "PengzhuangbaohuViewController.h"
//#import "ShoubingliangduViewController.h"
                    
                    ShoubingliangduViewController *videoRender = [[ShoubingliangduViewController alloc] init];
//                    videoRender.navigationController.navigationBarHidden = YES;
                    [self.navigationController pushViewController:videoRender animated:YES];
                }
                     break;
                case 6:
                {
                    XipingshijianViewController *videoRender = [[XipingshijianViewController alloc] init];
//                    videoRender.navigationController.navigationBarHidden = YES;
                    [self.navigationController pushViewController:videoRender animated:YES];
                }
                 
                    
                    break;
                case 7:
                {
                    PengzhuangbaohuViewController *videoRender = [[PengzhuangbaohuViewController alloc] init];
//                    videoRender.navigationController.navigationBarHidden = YES;
                    [self.navigationController pushViewController:videoRender animated:YES];
                }
                    
                    
                    break;
                case 8:
                {
                    WXLongTimeViewController *vc = [[WXLongTimeViewController alloc] init];
                    __weak typeof(self) weakSelf = self;
                    vc.WXCallBack = ^(BOOL refresh) {
                        if (refresh) {
                            [weakSelf.m_tableView reloadData];
                        }
                    };
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 9:
                {
                    AboutViewController *videoRender = [[AboutViewController alloc] init];
                    videoRender.navigationController.navigationBarHidden = YES;
                    [self.navigationController pushViewController:videoRender animated:YES];

                }
                    
                    
                    break;


                default:
                {
                    
                    
                }
                    break;
                    
            }
            break;
            
            
            
            
    }
    //    [self.navigationController pushViewController:vc animated:YES];
    
    //    [self performSelector:@selector(refreshImage:) withObject:indexPath afterDelay:0.3];
}

/*
- (UISwitch *)autoLoginSwitch
{
    if (_autoLoginSwitch == nil) {
        _autoLoginSwitch = [[UISwitch alloc] init];
        [_autoLoginSwitch addTarget:self action:@selector(autoLoginChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _autoLoginSwitch;
}

- (void)autoLoginChanged:(UISwitch *)autoSwitch
{
//    BOOL isworao = [[NSUserDefaults standardUserDefaults] objectForKey:@"wuraomoshi"];
    
    NSString * textString =@"";
    

    if(self.autoLoginSwitch.isOn==YES)
    {
        
        
   
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"wuraomoshi"];
        [_autoLoginSwitch setOn:YES  animated:YES];
     
        textString = @"$message$&aaronli";
        
    }
    else{

        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"wuraomoshi"];
        [_autoLoginSwitch setOn:NO  animated:YES];
        
        textString = @"$message$&notaaronli";
    }
    
    
    
    NSString *sessionId =@"";
    if([SFHFKeychain getPasswordForUsername:@"UDID" andServiceName:KEY_UUID error:nil].length>0)
    {
        sessionId = [SFHFKeychain getPasswordForUsername:@"UDID" andServiceName:KEY_UUID error:nil];
        
    }
    ECMessage* message;
    //    NSString *sessionId=@"18611498571";
    
//    LoobotModelDBTool *loobotModelDBTool = [LoobotModelDBTool shareInstance];
//    NSMutableArray *arr = [NSMutableArray arrayWithArray:[loobotModelDBTool selectAllModel_isdefult]];
//    for (NSDictionary *dict in arr) {
//        LoobotModel *model = [[LoobotModel alloc]init];
//        model.loobotid = [dict valueForKey:@"loobotid"];
//        model.loobotname = [dict valueForKey:@"loobotname"];
//        model.loobotnumber = [dict valueForKey:@"loobotnumber"];
//        
////        message = [[DeviceChatHelper sharedInstance] sendTextMessage:textString to:model.loobotnumber];
////        [[DemoGlobalClass sharedInstance].AtPersonArray removeAllObjects];
////        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_onMesssageChanged object:message];
//        
//    }
    [Common2 TipDialog:LocationLanguage(@"settingSuccessfully", @"设置成功")];
    
    //    [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:autoSwitch.isOn];
}

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

- (void)changeHead {
    

    
//        NSString *userid  = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
//        if (!userid) {
////            [self butEventLogin];
//            return;
//        }
    
        _bchangeHead = YES;
        //选择图片
        CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
        picker.maximumNumberOfSelection =1;
        picker.assetsFilter = [ALAssetsFilter allPhotos];
        picker.delegate = self;
    
        [self presentViewController:picker animated:YES completion:NULL];
    

}
//相册选择的
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    if( _bchangeHead )
    {//修改头像
        UIImage * photo = [UIImage imageWithCGImage:[[assets.lastObject defaultRepresentation] fullScreenImage]];
        if( photo == nil ) return;
        
        RSKImageCropViewController *imageCropVC = nil;
        
        imageCropVC = [[RSKImageCropViewController alloc] initWithImage:photo cropMode:RSKImageCropModeCircle];
        imageCropVC.dataSource = self;
        imageCropVC.delegate = self;
        //        [self pushViewController:imageCropVC];
        [self.navigationController pushViewController:imageCropVC animated:YES];
    }
    else
    {//修改个人相册
        //        BOOL b = NO;
        //        for (  ALAsset * one in assets  )
        //        {
        //            [_allimgs addObject:[UIImage imageWithCGImage: [[one defaultRepresentation] fullScreenImage] ]];
        //            b = YES;
        //        }
        //        if( b )
        //            [self updatePhotosLayout];
    }
}

//通过相册拍照的
-(void)assetsPickerControllerDidCamera:(CTAssetsPickerController *)picker imgage:(UIImage*)image
{
    if( _bchangeHead )
    {
        RSKImageCropViewController *imageCropVC = nil;
        
        imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image cropMode:RSKImageCropModeCircle];
        imageCropVC.dataSource = self;
        imageCropVC.delegate = self;
        [self.navigationController pushViewController:imageCropVC animated:YES];
    }
    else
    {
        //        if (_allimgs.count<4) {
        //            [_allimgs addObject:image];
        //            [self updatePhotosLayout];
        //        }
    }
}

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [controller.navigationController popViewControllerAnimated:YES];
}

- (CGRect)imageCropViewControllerCustomMaskRect:(RSKImageCropViewController *)controller
{
    return   CGRectMake(self.view.center.x-m_imageIconV.frame.size.width/2, self.view.center.y-m_imageIconV.frame.size.height/2, m_imageIconV.frame.size.width,  m_imageIconV.frame.size.height);
    
}
- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller
{
    return [UIBezierPath bezierPathWithRect:CGRectMake(self.view.center.x- m_imageIconV.frame.size.width/2, self.view.center.y-m_imageIconV.frame.size.height/2, m_imageIconV.frame.size.width, m_imageIconV.frame.size.height)];
}
- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage
{
    
    [controller.navigationController popViewControllerAnimated:YES];
    
    
//    NSData *data=UIImagePNGRepresentation(croppedImage);
    NSData *data=UIImageJPEGRepresentation(croppedImage,0.1);

//    NSString *token = @"XQVVimLvG63eLDhOzncOVcp0DXubWUVBarlgLYhv:hzMjOM-e8wFRvCYTrpPN6_axIkI=:eyJzY29wZSI6Imx1Ym8iLCJkZWFkbGluZSI6MTQ3MDQ5OTU0OH0=";
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
        [upManager putData:data key:nil token:_qiniuToken
                  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                      NSLog(@"info = %@\n", info);
                      NSLog(@"key = %@\n",key);
                      NSLog(@"resp = %@\n", resp);
                      NSLog(@"key = %@\n", [resp objectForKey:@"key"]);
                      
                      NSString *strurl = [NSString stringWithFormat:@"%@%@",@"http://img.loobot.net/",[resp objectForKey:@"key"]];
                       NSLog(@"resp = %@\n", strurl);
//                      [m_imageIconV sd_setImageWithURL:[NSURL URLWithString:strurl] placeholderImage:[UIImage imageNamed:@"ig_profile_photo_default.png"]];
                      
//                              NSString *userid  =[DemoGlobalClass sharedInstance].userName;
////                              if (!userid) {
////                      //            [self butEventLogin];
////                                  return;
////                              }
//                      [self.tool uploadHeadData:userid userImage:strurl block:^(id json) {
//
//                          [loadView removeFromSuperview];
                      

//                          loadView = [[LoadingAnimation alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height)];
//                          [self.view addSubview:loadView];
//                          
//                          [self getData];
                          
                          
//                      }];

                   
                      
                      
                  } option:nil];
    

    
}*/

@end
