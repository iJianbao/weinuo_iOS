//
//  WebjsViewController.m
//  天天网
//
//  Created by zhaoweibing on 14-9-5.
//  Copyright (c) 2014年 oyxc. All rights reserved.
//

#import "ControlViewController.h"
#import "YinpinListViewController.h"
#import "SVProgressHUDManager.h"
#import "Common2.h"
#import "Global.h"
#import "ListTableViewCell.h"
//#import "UITableViewRowAction+JZExtension.h"
#import "MJRefresh.h"
//@import MJRefresh;
#import "ShangchengRcommandDataTool.h"

#import "ZiliaokuDetailsViewController.h"
#import "ShangchengViewController.h"
#import "ListViewController.h"
#import "YYSearchViewController.h"

#import "MJExtension.h"
#import "MJRefresh.h"
#import "XimalayaclassCell.h"

#import "LoobotModel.h"
#import "LoobotModelDBTool.h"
#import "LinkViewController.h"
#import "NSStringConvertUtil.h"



#import "XMSDK.h"
//#import "CatagoryViewController.h"
//#import "TagTableViewController.h"
//#import "AlbumTableViewController.h"
//#import "TrackTableViewController.h"
#import "GerneralTableViewController.h"
#import "XMSDKPlayerDataCollector.h"

#import "XMSDKDownloadManager.h"

#import "XimalayaTwoViewController.h"

#import "YLTanKuangView.h"
#import "YLItemView.h"
#import "MyBleManager.h"
#import "Health.h"


#import "HexUtils.h"

#import "ExampleTableViewController.h"
#import "ExampleScanNameViewController.h"
#import "WarningViewController.h"
#import "BLEManager.h"

#import "DBTool.h"
#import "Gaodu.h"

@interface ControlViewController () <UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSIndexPath *selectIndexPath;
@property (strong, nonatomic) UIImageView *imgState;
@property (strong, nonatomic) UIView *viewFoot;

@property (nonatomic, strong) NSMutableArray *arrData;//数据源
@property (nonatomic, strong) UITableView *tableViewDefault;
@property (nonatomic, assign) NSInteger pageindex;
@property (nonatomic, assign) NSInteger pagesize;
//@property (nonatomic,strong) ShangchengRcommandDataTool *tool;

@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSArray *urlStringArray;

@property (strong, nonatomic) UIImageView *flameAnimation;
@property (strong, nonatomic) UILabel *label_dangqiangaodu_value;
@property (strong, nonatomic) UIButton *btn_warning;
@property (strong, nonatomic) UIView *view_bg;
@property (strong, nonatomic) UILabel *label_warning;
@property (strong, nonatomic) UIImageView *imageView_zhuo;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *timer2;
@property (strong, nonatomic) NSTimer *timer3;
@property (nonatomic, assign) NSInteger danwei;

@property (nonatomic, strong) NSString *strLizhugaodu;


@property (strong, nonatomic) UIButton *imageBtn_up;
@property (strong, nonatomic) UIButton *imageBtn_down;

@property (strong, nonatomic) DBTool *tool;


@end

@implementation ControlViewController

static NSString * const BShopId =  @"XimalayaclassCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = _strName;
        self.hidesBottomBarWhenPushed = NO;
        
        UIBarButtonItem *buttonLeft = [Common2 CreateNavBarButton:self setEvent:@selector(leftBarClicked:) background:@"btn_back.png" setTitle:nil];
        self.navigationItem.leftBarButtonItem = buttonLeft;
        
        
        UIBarButtonItem *buttonRight = [Common2 CreateNavBarButton:self setEvent:@selector(rightBarClicked:) background:@"nav_search.png" setTitle:nil];
        self.navigationItem.rightBarButtonItem = buttonRight;
        
        
        
        
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
//    labelcenter.text =_strName;// @"资料库二级";
//    labelcenter.textAlignment= NSTextAlignmentCenter;
//    [viewNavigation addSubview:labelcenter];
//    
////    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
////    btn_right.frame = CGRectMake(ScreenWidth-40-5,10, 40, 40);
////    [btn_right setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
////    [btn_right setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateHighlighted];
////    [btn_right addTarget:self action:@selector(rightBarClicked:) forControlEvents:UIControlEventTouchUpInside];
////    [viewNavigation addSubview:btn_right];
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
//    ShangchengViewController *videoRender = [[ShangchengViewController alloc] init];
//    videoRender.navigationController.navigationBarHidden = NO;
//    [self.navigationController pushViewController:videoRender animated:YES];
    YYSearchViewController *videoRender = [[YYSearchViewController alloc] init];
    //    videoRender.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:videoRender animated:YES];
    
}


- (void)getInitData
{
    if(![BLEManager sharedManager].isConnecting){
        //        return;
    }
    else
    {
        [BLEManager sharedManagerWithDelegate:self];//初始化
        [BLEManager sharedManager].delegate  =self;
        
        NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@",@"PR020001"];
        NSLog(@"发送的命令是%@",strHeightCmdCode_strHexData);
        
        NSString *strCheckCode = [HexUtils generateCheckCode:strHeightCmdCode_strHexData];
        
        NSString * strHeightCmd = [HexUtils addToCompleteStr:strCheckCode];
        
        //读取高度
        NSData *sendData_gaodu = [HexUtils hexToBytes:strHeightCmd];
        NSLog(@"value : %@",sendData_gaodu);
        
        [[BLEManager sharedManager] setValue:sendData_gaodu forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"喜马拉雅主界面"];
//    //    [GlobalFunc countView:@"web内嵌页"];
//    self.navigationController.navigationBarHidden = NO;
////    [self layoutNavigation];
    
    
//    _timer2 = [NSTimer timerWithTimeInterval:0.3 target:self selector:@selector(getInitData) userInfo:nil repeats:NO];
//    [[NSRunLoop currentRunLoop] addTimer:_timer2 forMode:NSRunLoopCommonModes];
    
    _view_bg.hidden=YES;
    
    //获取单位
    _timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(getGaodu) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    //获取高度
    _timer2 = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(getGaodu2) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer2 forMode:NSRunLoopCommonModes];
    //获取警告
    _timer3 = [NSTimer timerWithTimeInterval:2.5 target:self selector:@selector(getGaodu3) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer3 forMode:NSRunLoopCommonModes];
    
    
    
    
//    [self getInitData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"喜马拉雅主界面"];
//    [SVProgressHUDManager dismiss];
    [_timer invalidate];
    [_timer2 invalidate];
    [_timer3 invalidate];
    
    _view_bg.hidden=YES;

}

//- (ShangchengRcommandDataTool *)tool{
//    if (_tool == nil) {
//        _tool = [[ShangchengRcommandDataTool alloc]init];
//
//    }
//    return _tool;
//}

- (void)WarningClicked:(UIButton *)sender
{
    WarningViewController *videoRender = [[WarningViewController alloc] init];

    videoRender.strTitle=@"";
    videoRender.strContent=@"";
    if(sender.tag==1)
    {
        videoRender.strTitle=@"检测到系统输入主电源电压过高，系统无法正常工作";
        videoRender.strContent=@"请确认电网供电是否正常，如确认正常请重新 给系统上电，如果报警未解除，请联系您的供应 商";
    }
    else if(sender.tag==2)
    {
        videoRender.strTitle=@"检测到系统输入主电源电压过低，系统无法正常工作";
        videoRender.strContent=@"请确认电网供电是否正常，如确认正常请重新 给系统上电，报警如果未解除，请联系您的供应 商";
    }
    else if(sender.tag==3)
    {
        videoRender.strTitle=@"系统负载超过最大载荷，系统无法正常工作";
        videoRender.strContent=@"请减少系统当前载荷至最大允许载荷范围内，通过重新上电或者复位解除此报警";
    }
    else if(sender.tag==4)
    {
        videoRender.strTitle=@"系统或者电机过热，系统无法正常工作";
        videoRender.strContent=@"系统过热，请按照使用说明让系统休息，达到 时 间后报警自动解除";
    }
    else if(sender.tag==5)
    {
        videoRender.strTitle=@"系统上升或下降遇到障碍物，已自动回退";
        videoRender.strContent=@"无需任何操作，系统自动回退后报警将解除";
        
    }
    else if(sender.tag==6)
    {
        videoRender.strTitle=@"系统各电机运行不同步，系统无法正常工作";
        videoRender.strContent=@"通过复位操作解除此报警";
    }
    else if(sender.tag==7)
    {
        
        
        videoRender.strTitle=@"电机未连接或者未检测到霍尔信号，系统无法正常工作";
        videoRender.strContent=@"检查电机 是否连接正常，如果正常，通过复位 操作能解除此报警，如果报警未解除，请联系您 的供应商";
    }
    
    videoRender.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:videoRender animated:YES];
    
}

- (void)WarningCloseClicked
{
    _view_bg.hidden=YES;

    
}
- (NSData *)convertHexStrToString:(NSString *)str {
    if (!str.length) {
        return nil;
    }
    
    NSMutableData *tempData = [NSMutableData dataWithCapacity:10];
    NSRange range;
    if ([str length] %2 == 0) {
        range = NSMakeRange(0,2);
    } else {
        range = NSMakeRange(0,1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [tempData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return [NSData dataWithData:tempData];
}


- (void)getGaodu
{
    if(![BLEManager sharedManager].isConnecting){
//        return;
    }
    else
    {
        [BLEManager sharedManagerWithDelegate:self];//初始化
        [BLEManager sharedManager].delegate  =self;
        
        //单位
        
        NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@",@"PR020001"];
        NSLog(@"发送的命令是%@",strHeightCmdCode_strHexData);

        NSString *strCheckCode = [HexUtils generateCheckCode:strHeightCmdCode_strHexData];

        NSString * strHeightCmd = [HexUtils addToCompleteStr:strCheckCode];

        //读取高度
        NSData *sendData_gaodu2 = [HexUtils hexToBytes:strHeightCmd];
        NSLog(@"value : %@",sendData_gaodu2);

        [[BLEManager sharedManager] setValue:sendData_gaodu2 forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备


//高度

//        //读取高度
//        NSData *sendData_gaodu = [HexUtils hexToBytes:@"1B5052313033303031433705"];
//        NSLog(@"value : %@",sendData_gaodu);
//
//        [[BLEManager sharedManager] setValue:sendData_gaodu forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
//
//报警
//        //读取报警信息
//        NSData *sendData_warning = [HexUtils hexToBytes:@"1B5052313031303032433605"];
//        NSLog(@"value : %@",sendData_warning);
//
//        [[BLEManager sharedManager] setValue:sendData_warning forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
        
        


    }

    
}

- (void)getGaodu2
{
    if(![BLEManager sharedManager].isConnecting){
        //        return;
    }
    else
    {
        [BLEManager sharedManagerWithDelegate:self];//初始化
        [BLEManager sharedManager].delegate  =self;
        
        
        
//        NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@",@"PR020001"];
//        NSLog(@"发送的命令是%@",strHeightCmdCode_strHexData);
//
//        NSString *strCheckCode = [HexUtils generateCheckCode:strHeightCmdCode_strHexData];
//
//        NSString * strHeightCmd = [HexUtils addToCompleteStr:strCheckCode];
//
//        //读取高度
//        NSData *sendData_gaodu2 = [HexUtils hexToBytes:strHeightCmd];
//        NSLog(@"value : %@",sendData_gaodu2);
//
//        [[BLEManager sharedManager] setValue:sendData_gaodu2 forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
        
        
        
        
        //读取高度
        NSData *sendData_gaodu = [HexUtils hexToBytes:@"1B5052313033303031433705"];
        NSLog(@"value : %@",sendData_gaodu);
        
        [[BLEManager sharedManager] setValue:sendData_gaodu forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
        
        
//        //读取报警信息
//        NSData *sendData_warning = [HexUtils hexToBytes:@"1B5052313031303032433605"];
//        NSLog(@"value : %@",sendData_warning);
//
//        [[BLEManager sharedManager] setValue:sendData_warning forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
        
        
        
        
    }
    
    
}


- (void)getGaodu3
{
    if(![BLEManager sharedManager].isConnecting){
        //        return;
    }
    else
    {
        [BLEManager sharedManagerWithDelegate:self];//初始化
        [BLEManager sharedManager].delegate  =self;
        
        
        
//        NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@",@"PR020001"];
//        NSLog(@"发送的命令是%@",strHeightCmdCode_strHexData);
//
//        NSString *strCheckCode = [HexUtils generateCheckCode:strHeightCmdCode_strHexData];
//
//        NSString * strHeightCmd = [HexUtils addToCompleteStr:strCheckCode];
//
//        //读取高度
//        NSData *sendData_gaodu2 = [HexUtils hexToBytes:strHeightCmd];
//        NSLog(@"value : %@",sendData_gaodu2);
//
//        [[BLEManager sharedManager] setValue:sendData_gaodu2 forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
//
//
//
//
//        //读取高度
//        NSData *sendData_gaodu = [HexUtils hexToBytes:@"1B5052313033303031433705"];
//        NSLog(@"value : %@",sendData_gaodu);
//
//        [[BLEManager sharedManager] setValue:sendData_gaodu forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
        
        
        //读取报警信息
        NSData *sendData_warning = [HexUtils hexToBytes:@"1B5052313031303032433605"];
        NSLog(@"value : %@",sendData_warning);
        
        [[BLEManager sharedManager] setValue:sendData_warning forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
        
        
        
        
    }
    
    
}

- (void)UpClicked
{
    
//    NSString *strcmd = [HexUtils getisBuzzerOpenedCmd:100];
    
    if(_strLizhugaodu.intValue>=125)
    {
        [SVProgressHUD showErrorWithStatus:@"已到达最大高度"];
        return;
    }
    
    if(![BLEManager sharedManager].isConnecting){
        return;
    }
    [BLEManager sharedManagerWithDelegate:self];//初始化
    [BLEManager sharedManager].delegate  =self;
    
////    [[BLEManager sharedManager] connectingPeripheral:[BLEManager sharedManager].periperal];//连接设备
//
////    [MyBleManager sendVariableToDevice:100];
//
//    NSString *strcmd = [HexUtils getSetHeightCmd:100];
//
//    [HexUtils hexToBytes:strcmd];
//
//    NSData *sendData= [HexUtils hexToBytes:strcmd];
//    NSLog(@"发送的命令是%@",strcmd);
//    NSLog(@"发送的命令是%@",sendData);
//
//
////    NSData *sendData = [self convertHexStrToString:@"1B43573230313030323030303430303030343305"];
//    NSLog(@"value : %@",sendData);
//
//    [[BLEManager sharedManager] setValue:sendData forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
//
//    1b505732303032303130303032384505
//    NSData *sendData_gaodu = [HexUtils hexToBytes:@"1B5352303130303031433705"];
//    NSLog(@"value : %@",sendData_gaodu);
//
//    [[BLEManager sharedManager] setValue:sendData_gaodu forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    

    
 
    
//    //复位
//    NSData *sendData_gaodu = [HexUtils hexToBytes:@"1B505732303032303130303032384505"];
//    NSLog(@"value : %@",sendData_gaodu);
//
//    [[BLEManager sharedManager] setValue:sendData_gaodu forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    
    
    //上升
    NSData *sendData = [HexUtils hexToBytes:@"1B43573230313030323030303430303030343305"];
    NSLog(@"value : %@",sendData);

    [[BLEManager sharedManager] setValue:sendData forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(getGaodu) userInfo:nil repeats:NO];
    
//    //读取高度
//    NSData *sendData_gaodu = [HexUtils hexToBytes:@"1B5052313033303031433705"];
//    NSLog(@"value : %@",sendData_gaodu);
//
//    [[BLEManager sharedManager] setValue:sendData_gaodu forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    
    
//    //下降
//    NSData *sendData_gaodu = [HexUtils hexToBytes:@"1B43573230313030323030303630303030343505"];
//    NSLog(@"value : %@",sendData_gaodu);
//
//    [[BLEManager sharedManager] setValue:sendData_gaodu forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    
    
    
//        //自学习
//        NSData *sendData_gaodu = [HexUtils hexToBytes:@"1B505732303032303130303031384405"];
//        NSLog(@"value : %@",sendData_gaodu);
//
//        [[BLEManager sharedManager] setValue:sendData_gaodu forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    
    
    
}


- (void)DownClicked
{
//    NSString *strResponse =@"1B41574E5F424400434205";
//
//
//    NSData *data_cmd= [HexUtils hexToBytes:strResponse];
//
//    NSLog(@"发送的命令是1  %@",data_cmd);
//
//
//    NSString * str  =[[NSString alloc] initWithData:data_cmd encoding:NSUTF8StringEncoding];
//
//    NSLog(@"发送的命令是2  %@",str);
//
//
//    Byte value[6]={0};
//    value[0]=0x1B;
//    value[1]=0x99;
//    value[2]=0x01;
//    value[3]=0x1B;
//    value[4]=0x99;
//    value[5]=0x01;
//    NSData * data2 = [NSData dataWithBytes:&value length:sizeof(value)];
//    NSLog(@"发送的命令是3  %@",data2);
//
////    NSString * str2  =[[NSString alloc] initWithData:data_cmd encoding:NSUTF8StringEncoding];
//
////    NSLog(@"发送的命令是3  %@",&value);
    
    if(_strLizhugaodu.intValue<=61)
    {
         [SVProgressHUD showErrorWithStatus:@"已到达最低高度"];
        return;
    }
    if(![BLEManager sharedManager].isConnecting){
        return;
    }
    [BLEManager sharedManagerWithDelegate:self];//初始化
    [BLEManager sharedManager].delegate  =self;
    
    //    [[BLEManager sharedManager] connectingPeripheral:[BLEManager sharedManager].periperal];//连接设备
    
    //    [MyBleManager sendVariableToDevice:100];
    
    NSString *strcmd = [HexUtils getSetHeightCmd:60];
    
    [HexUtils hexToBytes:strcmd];
    
    NSData *sendData= [HexUtils hexToBytes:strcmd];
    NSLog(@"发送的命令是%@",strcmd);
    NSLog(@"发送的命令是%@",sendData);
    
    
    //    NSData *sendData = [self convertHexStrToString:@"1B43573230313030323030303430303030343305"];
    NSLog(@"value : %@",sendData);
    
        //下降
        NSData *sendData_gaodu = [HexUtils hexToBytes:@"1B43573230313030323030303630303030343505"];
        NSLog(@"value : %@",sendData_gaodu);

        [[BLEManager sharedManager] setValue:sendData_gaodu forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(getGaodu) userInfo:nil repeats:NO];
    

    
    
//    NSData *sendData_gaodu = [self convertHexStrToString:@"1B5352303130303031433705"];
//    NSLog(@"value : %@",sendData);
//
//    [[BLEManager sharedManager] setValue:sendData_gaodu forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    
}



- (void)ZuoziClicked
{
    
    if(![BLEManager sharedManager].isConnecting){
        return;
    }
    [BLEManager sharedManagerWithDelegate:self];//初始化
    [BLEManager sharedManager].delegate  =self;
    
    //    [[BLEManager sharedManager] connectingPeripheral:[BLEManager sharedManager].periperal];//连接设备
    
    //    [MyBleManager sendVariableToDevice:100];
    
    
    NSString *str_zuozigaodu=[[NSUserDefaults standardUserDefaults] objectForKey:@"zuozigaodu"];
    
    NSString *strcmd = [HexUtils getSetHeightCmd:[str_zuozigaodu integerValue]];
    
    [HexUtils hexToBytes:strcmd];
    
    NSData *sendData= [HexUtils hexToBytes:strcmd];
    NSLog(@"发送的命令是%@",strcmd);
    NSLog(@"发送的命令是%@",sendData);
    
    
    //    NSData *sendData = [self convertHexStrToString:@"1B43573230313030323030303430303030343305"];
    NSLog(@"value : %@",sendData);
    
    [[BLEManager sharedManager] setValue:sendData forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    
    
//    NSData *sendData_gaodu = [self convertHexStrToString:@"1B5352303130303031433705"];
//    NSLog(@"value : %@",sendData);
//
//    [[BLEManager sharedManager] setValue:sendData_gaodu forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    
    
//    [self performSelector:@selector(getGaodu) withObject:nil afterDelay:0.3];
//   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(getGaodu) userInfo:nil repeats:NO];
    
//    [self getGaodu];
    
////    NSString 转换成NSData 对象
//
//    NSData* xmlData = [@"testdata" dataUsingEncoding:NSUTF8StringEncoding];
////    NSData 转换成NSString对象
//
//    NSData * data;
//    NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
////    NSData 转换成char*
//
////    NSData *data;
////    char *test=[data bytes];
//////    char* 转换成NSData对象
////
////    byte* tempData = malloc(sizeof(byte)*16);
////    NSData *content=[NSData dataWithBytes:tempData length:16];

}


- (void)ZhanziClicked
{
    
    if(![BLEManager sharedManager].isConnecting){
        return;
    }
    [BLEManager sharedManagerWithDelegate:self];//初始化
    [BLEManager sharedManager].delegate  =self;
    
    //    [[BLEManager sharedManager] connectingPeripheral:[BLEManager sharedManager].periperal];//连接设备
    
    //    [MyBleManager sendVariableToDevice:100];
    
    NSString *str_zhanzigaodu=[[NSUserDefaults standardUserDefaults] objectForKey:@"zhanzigaodu"];
    NSString *strcmd = [HexUtils getSetHeightCmd:[str_zhanzigaodu integerValue]];
    
    [HexUtils hexToBytes:strcmd];
    
    NSData *sendData= [HexUtils hexToBytes:strcmd];
    NSLog(@"发送的命令是%@",strcmd);
    NSLog(@"发送的命令是%@",sendData);
    
    
    //    NSData *sendData = [self convertHexStrToString:@"1B43573230313030323030303430303030343305"];
    NSLog(@"value : %@",sendData);
    
    [[BLEManager sharedManager] setValue:sendData forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    
    
//    NSData *sendData_gaodu = [self convertHexStrToString:@"1B5352303130303031433705"];
//    NSLog(@"value : %@",sendData);
//
//    [[BLEManager sharedManager] setValue:sendData_gaodu forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    
//    [self getGaodu];
    
//     NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(getGaodu) userInfo:nil repeats:NO];
    
//    #import "ExampleScanNameViewController.h"
    
//    ExampleScanNameViewController *videoRender = [[ExampleScanNameViewController alloc] init];
//    //    videoRender.navigationController.navigationBarHidden = YES;
//    [self.navigationController pushViewController:videoRender animated:YES];

    
////    #import "ExampleTableViewController.h"
//    ExampleTableViewController *videoRender = [[ExampleTableViewController alloc] init];
//    //    videoRender.navigationController.navigationBarHidden = YES;
//    [self.navigationController pushViewController:videoRender animated:YES];

}


- (void)JiyigaoduClicked
{

    
    NSArray *data_gaodu = [_tool selectWithClass:[Gaodu class] params:nil];
    for (int i=0;i<data_gaodu.count;i++)
    {
        Gaodu *p4 = data_gaodu[i];
        NSLog(@"%@",p4);
    }
    

   
    YLTanKuangView *tanKuangView = [[YLTanKuangView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight*0.45)];
    [self.view.window addSubview:tanKuangView];
    
    // 设置数据
    NSArray *titleArray = [NSArray arrayWithObjects:@"选择记忆高度",@"取消", nil];
//    NSArray *imageArray = [NSArray arrayWithObjects:@"image1",@"image2",@"image3",@"image3",@"image3",@"image3", nil];
//    NSArray *modelArray = [NSArray arrayWithObjects:@"选择方式一",@"选择方式二",@"选择方式三",@"选择方式三",@"选择方式三",@"选择方式三", nil];
    
    
    
    [tanKuangView initWithModelArray:data_gaodu titleArray:titleArray andImageArray:data_gaodu];
    
    __weak YLTanKuangView *tanKuangView1 = tanKuangView;
    __weak typeof(self) weakSelf = self;
    tanKuangView.clickBlock = ^(UIView *itemView) {
                if (itemView.tag == 101) {// 点击选项一
        
                }
                if (itemView.tag == 102) {// 点击选项二
        
                }
                if (itemView.tag == 103) {// 点击选项三
        
                }
        
        
        if(![BLEManager sharedManager].isConnecting){
            return;
        }
        [BLEManager sharedManagerWithDelegate:self];//初始化
        [BLEManager sharedManager].delegate  =self;
        
        //    [[BLEManager sharedManager] connectingPeripheral:[BLEManager sharedManager].periperal];//连接设备
        
        //    [MyBleManager sendVariableToDevice:100];
        
        
    
        
        NSString *strcmd = [HexUtils getSetHeightCmd:itemView.tag];
        
        [HexUtils hexToBytes:strcmd];
        
        NSData *sendData= [HexUtils hexToBytes:strcmd];
        NSLog(@"发送的命令是%@",strcmd);
        NSLog(@"发送的命令是%@",sendData);
        
        
        //    NSData *sendData = [self convertHexStrToString:@"1B43573230313030323030303430303030343305"];
        NSLog(@"value : %@",sendData);
        
        [[BLEManager sharedManager] setValue:sendData forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
        
        
//        NSData *sendData_gaodu = [self convertHexStrToString:@"1B5352303130303031433705"];
//        NSLog(@"value : %@",sendData);
//
//        [[BLEManager sharedManager] setValue:sendData_gaodu forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
//       NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(getGaodu) userInfo:nil repeats:NO];
        
        
        YLItemView *itemView1 = (YLItemView*)itemView;
//        weakSelf.textField.text = itemView1.titleLabel.text;
        [tanKuangView1 destroyTanKuangView];
        
    };
    
    // 显示弹框
    [tanKuangView showTanKuangView];
    
}

//- (void)viewWillAppear:(BOOL)animated
//{
////    [self getGaodu];
////    if([BLEManager sharedManager].periperal)
////    {
////            [BLEManager sharedManagerWithDelegate:self];//初始化
////            [BLEManager sharedManager].delegate  =self;
////        [[BLEManager sharedManager] connectingPeripheral:[BLEManager sharedManager].periperal];//连接设备
////        [SVProgressHUD show];
////    }
//
//}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    if([BLEManager sharedManager].periperal)
//    {
//        [SVProgressHUD dismiss];
//        [[BLEManager sharedManager] disconnectPeripheral:[BLEManager sharedManager].periperal];//断开蓝牙
//    }
//    
//}

#pragma mark --蓝牙连接完成
- (void)BLEManagerDidConnectPeripheral:(CBPeripheral *)peripheral
{
    
    [SVProgressHUD dismiss];
    
    CBPeripheral *connctedPeripheral = peripheral;//当前连接成功的设备
    [SVProgressHUD showSuccessWithStatus:@"连接成功"];
    
    
    //扫描当前连接的蓝牙设备的所有服务
    [[BLEManager sharedManager] scanningForServicesWithPeripheral:connctedPeripheral];
    
}

#pragma mark --接受获取到得服务
- (void)BLEManagerReceiveAllService:(CBService *)service
{
//    [thisServices addObject:service];
//    [thisServiceTableView reloadData];
}


#pragma mark --蓝牙连接失败
- (void)BLEManagerDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"蓝牙连接失败，请重新连接");
    LinkViewController *appStartController = [[LinkViewController alloc] init];
    [AppDelegate shareInstance] .window.rootViewController = [[UINavigationController alloc] initWithRootViewController:appStartController];// appStartController;
}
static char DIGITS_UPPER[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
static char *encodeHex(const char *data, int size, char hexTable[]) {
    char *output = malloc(size * 2);
    return encodeHexInternal(output, data, size, hexTable);
}

static char *encodeHexInternal(char *output_buf, const char *data, int size, char hexTable[]) {
    for (int i = 0, j = 0; i < size; i++) {
        output_buf[j++] = hexTable[((0XF0 & data[i]) >> 4) & 0X0F];
        output_buf[j++] = hexTable[((0X0F & data[i])) & 0X0F];
    }
    return output_buf;
}

- (NSString *)encodeHexData:(NSData *)data {
    char *e = encodeHex(data.bytes, (int)data.length, DIGITS_UPPER);
    NSString *str = [[NSString alloc] initWithBytes:e length:data.length * 2 encoding:NSASCIIStringEncoding];
    free(e);
    return str;
}

- (NSString *)getCurrentTime_shijianchuo {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.f", a];
    return timeString;
    
}

- (NSString *)getNianyueriByShijianchuo:(NSString *)timestamp
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp.integerValue];
    
    NSLog(@"confromTimesp  = %@",confromTimesp);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:confromTimesp];
    return dateTime;
    
}

 - (NSString *)getCurrentTime {
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     [formatter setDateFormat:@"yyyy-MM-dd"];
     NSString *dateTime = [formatter stringFromDate:[NSDate date]];
     return dateTime;
     
 }

- (NSString *)getCurrentTime2 {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; [formatter setDateFormat:@"MM.dd"]; NSString *dateTime = [formatter stringFromDate:[NSDate date]]; return dateTime;
    
}



#pragma mark --接受数据返回的信息及广播
- (void)BLEManagerReceiveData:(NSData *)value fromPeripheral:(CBPeripheral *)peripheral andServiceUUID:(NSString *)serviceUUID andCharacteristicUUID:(NSString *)charUUID
{
    
    NSString *str_receve = [self encodeHexData:value];
    NSLog(@"receve value : %@",str_receve);
//    if ([str_receve containsString:@"1B41"]) {
//        if(str_receve.length>12)
//        {
//        }
////        @property (strong, nonatomic) UIView *view_bg;
////        @property (strong, nonatomic) UILabel *label_warning;
////        _view_bg.hidden  = YES;
////        _label_warning.text =@"
    
//        _label_warning.text =@"无霍尔报警";
//    }
//    else
    if ([str_receve containsString:@"1B41"]) {
        
//        if(str_receve.length==10)
//        {
////            1B413030303030303430433505
////            1B41343105
//            //        @property (strong, nonatomic) UIView *view_bg;
//            //        @property (strong, nonatomic) UILabel *label_warning;
//            //        _view_bg.hidden  = YES;
//            //        _label_warning.text =@"
//            [self showWarningView];
//            _label_warning.text =@"无霍尔报警";
//        }
        
        if(str_receve.length>12)
        {
            if(str_receve.length ==26)
            {
                
                [self showWarningView:str_receve];
//                //            1B41343105
//                //        @property (strong, nonatomic) UIView *view_bg;
//                //        @property (strong, nonatomic) UILabel *label_warning;
//                //        _view_bg.hidden  = YES;
//                //        _label_warning.text =@"
//                [self showWarningView];
//                _label_warning.text =@"无霍尔报警";
            }
            else
            {
                _view_bg.hidden=YES;
            }
            if(str_receve.length ==18)
            {
                
                str_receve = [str_receve substringFromIndex:4];
                str_receve = [str_receve substringToIndex:8];
                
                NSString *str_gaodu = [HexUtils hexToCompleteNum:str_receve];
                
                if(str_gaodu.length<2)
                {
                    if([str_gaodu isEqualToString:@"1"])
                    {
                        _danwei =1;
                    }
                    else if([str_gaodu isEqualToString:@"2"])
                    {
                        _danwei =2;
                    }
                    return;
                }
                
                NSString *str_gaodu2 = [str_gaodu substringToIndex:str_gaodu.length-2];
                
                _strLizhugaodu = [str_gaodu substringToIndex:str_gaodu.length-2];
                
                if([str_gaodu2 isEqualToString:@"60"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up001.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"61"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up002.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"62"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up003.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"63"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up004.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"64"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up005.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"65"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up006.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"66"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up007.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"67"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up008.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"68"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up009.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"69"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up010.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"70"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up011.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"71"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up012.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"72"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up013.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"73"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up014.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"74"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up015.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"75"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up016.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"76"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up017.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"77"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up018.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"78"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up019.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"79"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up020.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"80"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up021.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"81"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up022.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"82"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up023.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"83"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up024.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"84"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up025.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"85"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up026.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"86"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up027.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"87"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up028.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"88"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up029.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"89"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up030.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"90"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up031.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"91"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up032.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"92"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up033.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"93"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up034.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"94"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up035.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"95"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up036.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"96"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up037.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"97"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up038.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"98"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up039.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"99"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up040.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"100"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up041.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"101"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up042.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"102"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up043.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"103"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up044.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"104"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up045.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"105"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up046.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"106"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up047.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"107"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up048.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"108"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up049.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"109"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up050.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"110"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up051.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"111"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up052.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"112"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up053.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"113"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up054.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"114"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up055.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"115"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up056.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"116"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up057.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"117"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up058.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"118"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up059.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"119"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up060.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"120"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up061.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"121"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up062.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"122"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up063.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"123"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up064.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"124"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up065.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"125"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up066.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"126"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up067.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"127"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up068.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"128"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up069.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"129"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up070.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"130"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up071.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"131"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up072.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"132"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up073.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"133"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up074.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"134"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up075.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"135"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up076.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"136"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up077.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"137"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up078.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"138"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up079.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"139"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up080.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"140"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up081.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"141"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up082.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"142"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up083.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"143"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up084.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"144"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up085.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"145"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up086.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"146"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up087.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"147"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up088.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"148"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up089.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"149"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up090.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"150"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up091.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"151"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up092.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"152"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up093.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"153"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up094.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"154"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up095.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"155"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up096.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"156"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up097.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"157"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up098.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"158"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up099.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"159"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up100.png"]];
                }
                else if([str_gaodu2 isEqualToString:@"160"])
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up100.png"]];
                }
                else
                {
                    [_imageView_zhuo setImage:[UIImage imageNamed:@"up100.png"]];
                }
                
                
                
                
                
                
                
                
                
                //            str_receve =@"1A04";
                //            NSNumber *number_gaodu = [HexUtils numberHexString:str_receve];
                
                //            NSString *str_gaodu = number_gaodu.stringValue;//[NSString stringWithFormat:@"%d",number_gaodu];
                //
                //            str_gaodu = [NSString stringWithFormat:@"%@.%@",[str_gaodu substringToIndex:2],[[str_gaodu substringFromIndex:2]  substringToIndex:1]];
                //            NSLog(@"%@",str_gaodu);
                
                _label_dangqiangaodu_value.text = [NSString stringWithFormat:@"%@ cm",str_gaodu];
                if(_danwei==1)
                {
                    _label_dangqiangaodu_value.text = [NSString stringWithFormat:@"%@ cm",str_gaodu];
                }
                else if(_danwei==2)
                {
                    _label_dangqiangaodu_value.text = [NSString stringWithFormat:@"%.1f IN",str_gaodu.floatValue*0.3937008];
                }

                NSString *str_zhanzigaodu=[[NSUserDefaults standardUserDefaults] objectForKey:@"zhanzigaodu"];
                if(str_zhanzigaodu.intValue == str_gaodu.intValue )
                {
                    NSString *str_shijianchuo=[self getCurrentTime_shijianchuo];
                    NSString *str_zhanzigaodulasttime=[[NSUserDefaults standardUserDefaults] objectForKey:@"zhanzigaodulasttime"];
                    NSString *str_shijiancha_tian = [HexUtils getShijianjiange_tian:str_zhanzigaodulasttime endTimestamp:str_shijianchuo];
                    
                    NSString *str_shijiancha_zhanzi =@"0";
                    
                    if(str_shijiancha_tian.doubleValue<1)
                    {
                        str_shijiancha_zhanzi = [HexUtils getShijianjiange:str_zhanzigaodulasttime endTimestamp:str_shijianchuo];
                        
                        [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zhanzigaodulasttime"];
                        [[NSUserDefaults standardUserDefaults] synchronize];

                    }
                    else
                    {
                        
                        [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zhanzigaodulasttime"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        return;
                        
                    }
//                    [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zhanzigaodulasttime"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    NSString *str_nianyueri=[self getCurrentTime];
                    NSString *str_yueri=[self getCurrentTime2];
                    
                    
                    if(str_zhanzigaodulasttime ==nil)
                    {
                         [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zhanzigaodulasttime"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        return;
                    }
                    NSString *params =[NSString stringWithFormat:@"_riqi='%@'",str_nianyueri];
                    NSArray *data = [_tool selectWithClass:[Health class] params:params];
                    
                    Health *h1 = [data objectAtIndex:0];
                    h1.zhanzishijian = h1.zhanzishijian + str_shijiancha_zhanzi.floatValue;
                    [_tool updateWithObj:h1 andKey:@"riqi" isEqualValue:str_nianyueri];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zhanzigaodulasttime"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                else
                {
                    NSString *str_shijianchuo=[self getCurrentTime_shijianchuo];
                     [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zhanzigaodulasttime"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
                NSString *str_zuozigaodu=[[NSUserDefaults standardUserDefaults] objectForKey:@"zuozigaodu"];
                if(str_zuozigaodu.intValue == str_gaodu.intValue)
                {
                    NSString *str_shijianchuo=[self getCurrentTime_shijianchuo];
                    NSString *str_zuozigaodulasttime=[[NSUserDefaults standardUserDefaults] objectForKey:@"zuozigaodulasttime"];

                    NSString *str_shijiancha_tian = [HexUtils getShijianjiange_tian:str_zuozigaodulasttime endTimestamp:str_shijianchuo];
                    
                    NSString *str_shijiancha_zuozi =@"0";
                    
                    if(str_shijiancha_tian.doubleValue<1)
                    {
                        str_shijiancha_zuozi = [HexUtils getShijianjiange:str_zuozigaodulasttime endTimestamp:str_shijianchuo];
                        
                        [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zuozigaodulasttime"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                    else
                    {
                        [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zuozigaodulasttime"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        return;
                    }
                    
//                    [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zuozigaodulasttime"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];

                    NSString *str_nianyueri=[self getCurrentTime];
                    NSString *str_yueri=[self getCurrentTime2];
                    if(str_zuozigaodulasttime ==nil)
                    {
                        [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zuozigaodulasttime"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        return;
                    }
                    NSString *params =[NSString stringWithFormat:@"_riqi='%@' ",str_nianyueri];
                    NSArray *data = [_tool selectWithClass:[Health class] params:params];
                    
                    Health *h1 = [data objectAtIndex:0];
                    //                h1.zuozishijian =1.10;
                    h1.zuozishijian = h1.zuozishijian + str_shijiancha_zuozi.floatValue;
                    [_tool updateWithObj:h1 andKey:@"riqi" isEqualValue:str_nianyueri];
                    
                     [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zuozigaodulasttime"];
                    [[NSUserDefaults standardUserDefaults] synchronize];

                }
                else
                {
                    NSString *str_shijianchuo=[self getCurrentTime_shijianchuo];
                    [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zuozigaodulasttime"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
            }
            
            
            
            
        }
        
    }
    
//    NSLog(@"receve value : %@",str_receve);
//    NSString *backString = [[NSString alloc]initWithData:value encoding:NSUTF8StringEncoding];
//    NSLog(@"receve value : %@",backString);
//    self.label_dangqiangaodu_value.text = backString;
    
//    NSNumber *number_gaodu = [HexUtils numberHexString:backString];
//
//    NSLog(@"%@",number_gaodu);
//
//    //    NSLog(@"receve value : %@",backString);
//    self.label_dangqiangaodu_value.text = [NSString stringWithFormat:@"%d",number_gaodu];
    
}


- (void)showWarningView
{
    _view_bg = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenWidth*0/320, ScreenWidth*320/320, ScreenWidth*35/320)];
    _view_bg.backgroundColor =[Common2 colorWithHexString:@"#ffffff"];
    [self.view addSubview:_view_bg];
    _view_bg.hidden=YES;
    
    
    UIImageView *imageView_warning_left = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*5/320, ScreenWidth*3/320, ScreenWidth*25/320, ScreenWidth*25/320)];
    [imageView_warning_left setImage:[UIImage imageNamed:@"icon_warnning.png"]];
    [_view_bg addSubview:imageView_warning_left];
    
    UIImageView *imageView_warning_right = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*40/320, ScreenWidth*3/320, ScreenWidth*25/320, ScreenWidth*25/320)];
    [imageView_warning_right setImage:[UIImage imageNamed:@"close_remeber.png"]];
    [_view_bg addSubview:imageView_warning_right];
    
    
    _label_warning = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*40/320, ScreenWidth*3/320, ScreenWidth*160/320, ScreenWidth*30/320)];
    _label_warning.text = @"Notice:未知警告";
    _label_warning.textColor = [Common2 colorWithHexString:@"#000000"];
    _label_warning.tintColor = [Common2 colorWithHexString:@"#000000"];
    _label_warning.font = [UIFont systemFontOfSize:14.0f];
    _label_warning.numberOfLines = 0;
    _label_warning.textAlignment = NSTextAlignmentLeft;
    [_view_bg addSubview:_label_warning];
    
    
    _btn_warning = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_warning.frame = CGRectMake(0, ScreenWidth*0/320, ScreenWidth*320/320, ScreenWidth*35/320);
    [_btn_warning addTarget:self action:@selector(WarningClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_view_bg addSubview:_btn_warning];
    
    
    UIButton *btn_warning_right = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_warning_right.frame = CGRectMake(ScreenWidth*320/320-ScreenWidth*35/320, ScreenWidth*0/320, ScreenWidth*35/320, ScreenWidth*35/320);
    [btn_warning_right addTarget:self action:@selector(WarningCloseClicked) forControlEvents:UIControlEventTouchUpInside];
    [_view_bg addSubview:btn_warning_right];
    
}

- (void)showWarningView:(NSString *)str_receve
{
//    _view_bg = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenWidth*0/320, ScreenWidth*320/320, ScreenWidth*35/320)];
//    _view_bg.backgroundColor =[Common2 colorWithHexString:@"#ffffff"];
//    [self.view addSubview:_view_bg];
//    
//    
//    UIImageView *imageView_warning_left = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*5/320, ScreenWidth*3/320, ScreenWidth*25/320, ScreenWidth*25/320)];
//    [imageView_warning_left setImage:[UIImage imageNamed:@"icon_warnning.png"]];
//    [_view_bg addSubview:imageView_warning_left];
//    
//    UIImageView *imageView_warning_right = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*40/320, ScreenWidth*3/320, ScreenWidth*25/320, ScreenWidth*25/320)];
//    [imageView_warning_right setImage:[UIImage imageNamed:@"close_remeber.png"]];
//    [_view_bg addSubview:imageView_warning_right];
//    
//    
//    _label_warning = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*40/320, ScreenWidth*3/320, ScreenWidth*160/320, ScreenWidth*30/320)];
//    _label_warning.text = @"Notice:未知警告";
//    _label_warning.textColor = [Common2 colorWithHexString:@"#000000"];
//    _label_warning.tintColor = [Common2 colorWithHexString:@"#000000"];
//    _label_warning.font = [UIFont systemFontOfSize:14.0f];
//    _label_warning.numberOfLines = 0;
//    _label_warning.textAlignment = NSTextAlignmentLeft;
//    [_view_bg addSubview:_label_warning];
//    
//    
//    UIButton *btn_warning = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn_warning.frame = CGRectMake(0, ScreenWidth*0/320, ScreenWidth*320/320, ScreenWidth*35/320);
//    [btn_warning addTarget:self action:@selector(WarningClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [_view_bg addSubview:btn_warning];
//    
//    
//    UIButton *btn_warning_right = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn_warning_right.frame = CGRectMake(ScreenWidth*320/320-ScreenWidth*35/320, ScreenWidth*0/320, ScreenWidth*35/320, ScreenWidth*35/320);
//    [btn_warning_right addTarget:self action:@selector(WarningCloseClicked) forControlEvents:UIControlEventTouchUpInside];
//    [_view_bg addSubview:btn_warning_right];
    
    
    
    NSString *strWarning =str_receve;// =@"1B413030303030303430433505";
    //    NSNumber *number_gaodu = [HexUtils numberHexString:str_asciiCode_all];
    if(strWarning.length==26)
    {
        strWarning = [strWarning substringFromIndex:4];
        strWarning = [strWarning substringToIndex:16];
        
        //        NSString *str_gaodu = [HexUtils hexToCompleteNum:str_receve];
        
        NSLog(@"receve value : %@",strWarning);
        //        NSNumber *number_gaodu = [HexUtils numberHexString:strWarning];
        
        
        NSString *str_one = [strWarning substringToIndex:2];
        NSString *str_one2= [strWarning substringFromIndex:2];
        
        NSString *str_two = [str_one2 substringToIndex:2];
        NSString *str_two2= [str_one2 substringFromIndex:2];
        
        NSString *str_three = [str_two2 substringToIndex:2];
        NSString *str_three2= [str_two2 substringFromIndex:2];
        
        NSString *str_four = [str_three2 substringToIndex:2];
        NSString *str_four2= [str_three2 substringFromIndex:2];
        
        NSString *str_five = [str_four2 substringToIndex:2];
        NSString *str_five2= [str_four2 substringFromIndex:2];
        
        NSString *str_six = [str_five2 substringToIndex:2];
        NSString *str_six2= [str_five2 substringFromIndex:2];
        
        NSString *str_seven = [str_six2 substringToIndex:2];
        NSString *str_seven2= [str_six2 substringFromIndex:2];
        
        NSString *str_eight = [str_seven2 substringToIndex:2];
        NSString *str_eight2= [str_seven2 substringFromIndex:2];
        
        
        NSNumber *asciiCode1 =[HexUtils numberHexString:str_one];
        NSString *str_asciiCode1 = [NSString stringWithFormat:@"%C", asciiCode1.intValue]; // A
        
        NSNumber *asciiCode2 =[HexUtils numberHexString:str_two];
        NSString *str_asciiCode2 = [NSString stringWithFormat:@"%C", asciiCode2.intValue];
        
        NSNumber *asciiCode3 =[HexUtils numberHexString:str_three];
        NSString *str_asciiCode3 = [NSString stringWithFormat:@"%C", asciiCode3.intValue];
        
        NSNumber *asciiCode4 =[HexUtils numberHexString:str_four];
        NSString *str_asciiCode4 = [NSString stringWithFormat:@"%C", asciiCode4.intValue];
        
        NSNumber *asciiCode5 =[HexUtils numberHexString:str_five];
        NSString *str_asciiCode5 = [NSString stringWithFormat:@"%C", asciiCode5.intValue];
        
        NSNumber *asciiCode6 =[HexUtils numberHexString:str_six];
        NSString *str_asciiCode6 = [NSString stringWithFormat:@"%C", asciiCode6.intValue];
        
        NSNumber *asciiCode7=[HexUtils numberHexString:str_seven];
        NSString *str_asciiCode7 = [NSString stringWithFormat:@"%C", asciiCode7.intValue];
        
        NSNumber *asciiCode8 =[HexUtils numberHexString:str_eight];
        NSString *str_asciiCode8 = [NSString stringWithFormat:@"%C", asciiCode8.intValue];
        
        NSString *str_asciiCode_all = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@", str_asciiCode1,str_asciiCode2,str_asciiCode3,str_asciiCode4,str_asciiCode5,str_asciiCode6,str_asciiCode7,str_asciiCode8];
        NSLog(@"receve value : %@",str_asciiCode_all);
        NSLog(@"receve value : %@",str_asciiCode_all);
        if(![str_asciiCode_all isEqualToString:@"00000000"])
        {
            NSData *data_all = [HexUtils HexToByteArr:strWarning];
            
            NSLog(@"receve value : %@",data_all);
            NSLog(@"receve value : %@",data_all);
        }
        
        //        NSString *str = @"40";
        //        NSData  *data = [str  dataUsingEncoding:4]; // UTF-8编码
        //        Byte        *bytes  = (Byte *)[data bytes];
        //        int           length  = data.length;
        
        NSData *data_all = [HexUtils hexToBytes:@"00000040"];
        NSData *data_all2 = [HexUtils hexToBytes:@"00000040"];
        
        
        //        NSString *testString = @"00000040";
        //        NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
        //        Byte *testByte = (Byte *)[testData bytes];
        //        for(int i=0;i<[testData length];i++)
        //            printf("testByte = %d\n",testByte[i]);
        
        //        NSString *str = @"00000040";
        //        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(NSUTF16BigEndianStringEncoding);
        //        NSData *data = [str dataUsingEncoding:enc];
        //        Byte *byte = (Byte *)[data bytes];
        //        for (int i=0 ; i<[data length]; i++) {
        //            NSLog(@"byte = %d",byte[i]);
        //        }
        
        NSString *strBit1 = [NSStringConvertUtil getBinaryByhex:str_asciiCode1];
        NSString *strBit2 = [NSStringConvertUtil getBinaryByhex:str_asciiCode2];
        NSString *strBit3 = [NSStringConvertUtil getBinaryByhex:str_asciiCode3];
        NSString *strBit4 = [NSStringConvertUtil getBinaryByhex:str_asciiCode4];
        NSString *strBit5 = [NSStringConvertUtil getBinaryByhex:str_asciiCode5];
        NSString *strBit6 = [NSStringConvertUtil getBinaryByhex:str_asciiCode6];
        NSString *strBit7 = [NSStringConvertUtil getBinaryByhex:str_asciiCode7];
        NSString *strBit8 = [NSStringConvertUtil getBinaryByhex:str_asciiCode8];
        
        NSLog(@"strBit7 = %@",strBit7);
        NSLog(@"strBit8 = %@",strBit8);
        
        NSString *strBit33 =[NSString stringWithFormat:@"%@%@", strBit7,strBit8];
        NSString *strBit22 =[NSString stringWithFormat:@"%@%@", strBit5,strBit5];
        NSString *strBit11 =[NSString stringWithFormat:@"%@%@", strBit3,strBit4];
        NSString *strBit00 =[NSString stringWithFormat:@"%@%@", strBit1,strBit2];
        
        //        if([[[strBit33 substringToIndex:2] substringFromIndex:1] isEqualToString:@"1"])
        //        {
        //            NSLog(@"strBit8 = %@",@"1");
        //        }
//        strBit11 =@"00000001";
        if([[strBit11 substringFromIndex:7] isEqualToString:@"1"])
        {
            _view_bg.hidden=NO;
            NSLog(@"strBit8 = %@",@"1");
            _label_warning.text = @"Notice:输入电源过压";
            _btn_warning.tag=1;
            
        }
//        strBit11 =@"00000010";
        if([[[strBit11 substringFromIndex:6] substringToIndex:1] isEqualToString:@"1"])
        {
            _view_bg.hidden=NO;
            NSLog(@"strBit8 = %@",@"1");
            _label_warning.text = @"Notice:输入电源欠压";
            _btn_warning.tag=2;
        }
//        strBit11 =@"01000000";
        if([[[strBit11 substringToIndex:2] substringFromIndex:1] isEqualToString:@"1"])
        {
            _view_bg.hidden=NO;
            NSLog(@"strBit8 = %@",@"1");
            _label_warning.text = @"Notice:过载报警";
            _btn_warning.tag=3;
        }
        
//        strBit00 =@"00001000";
        if([[[strBit00 substringFromIndex:4] substringToIndex:1] isEqualToString:@"1"])
        {
            _view_bg.hidden=NO;
            NSLog(@"strBit8 = %@",@"1");
            _label_warning.text = @"Notice:过热报警";
            _btn_warning.tag=4;
        }
//        strBit33 =@"00000001";
        if([[strBit33 substringFromIndex:7] isEqualToString:@"1"])
        {
            _view_bg.hidden=NO;
            NSLog(@"strBit8 = %@",@"1");
            _label_warning.text = @"Notice:碰撞报警";
            _btn_warning.tag=5;
        }

//        strBit33 =@"00000010";
        if([[[strBit33 substringFromIndex:6] substringToIndex:1] isEqualToString:@"1"])
        {
            _view_bg.hidden=NO;
            NSLog(@"strBit8 = %@",@"1");
            _label_warning.text = @"Notice:失步报警";
            _btn_warning.tag=6;
        }
//        strBit33 =@"01000000";
        if([[[strBit33 substringToIndex:2] substringFromIndex:1] isEqualToString:@"1"])
        {
            _view_bg.hidden=NO;
            NSLog(@"strBit8 = %@",@"1");
            _label_warning.text = @"Notice:无霍尔报警";
            _btn_warning.tag=7;
        }
//        else
//        {
//            NSLog(@"strBit8 = %@",@"1");
//            _label_warning.text = @"Notice:未知报警";
//            btn_warning.tag=8;
//        }
        
        //        NSString *str_five222 = [[strBit33 substringToIndex:2] substringFromIndex:1];
        //        NSString *str_five2333= [str_five222 substringFromIndex:1];
        //
        //        NSLog(@"strBit8 = %@",str_five2333);
        //        [self getBitOnIndexIsTrue:strBit4 index:7]
        
        //        /**
        //         * 获取字节（有8bit）所在位（第num bit处）的数值
        //         * 为0还是1
        //         * 为1时返回true
        //         * @param by 字节
        //         * @param index 位置
        //         * @return
        //         */
        //        public static boolean getBitOnIndexIsTrue(byte by,int index){
        //            StringBuffer sb = new StringBuffer();
        //            sb.append((by>>index)&0x1);
        //            return sb.toString().equals("1");
        //        }
        
    }
    
    
    
}
- (void)viewDidLoad
{
   
    _tool = [DBTool sharedDBTool];
    [_tool createTableWithClass:[Health class]];

 if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    [super viewDidLoad];
    
    
     [self showWarningView];
    
   self.view.backgroundColor = [Common2 colorWithHexString:@"#2B2B73"];

    _imageView_zhuo = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*10/320, ScreenWidth*10/320, ScreenWidth*480/320/3, ScreenWidth*435/320/3)];
    [_imageView_zhuo setImage:[UIImage imageNamed:@"up001.png"]];
    [self.view addSubview:_imageView_zhuo];
    
    
    UILabel *label_dangqiangaodu = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2+ScreenWidth*30/320, ScreenWidth*60/320, ScreenWidth*160/320, ScreenWidth*30/320)];
    label_dangqiangaodu.text = @"当前高度";
    label_dangqiangaodu.textColor = [Common2 colorWithHexString:@"#ffffff"];
    label_dangqiangaodu.tintColor = [Common2 colorWithHexString:@"#ffffff"];
    label_dangqiangaodu.font = [UIFont boldSystemFontOfSize:24.0f];
    label_dangqiangaodu.numberOfLines = 0;
    label_dangqiangaodu.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label_dangqiangaodu];
    
    
    _label_dangqiangaodu_value = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2+ScreenWidth*30/320, ScreenWidth*100/320, ScreenWidth*160/320, ScreenWidth*30/320)];
    _label_dangqiangaodu_value.text = @"60.0 cm";
    _label_dangqiangaodu_value.textColor = [Common2 colorWithHexString:@"#ffffff"];
    _label_dangqiangaodu_value.tintColor = [Common2 colorWithHexString:@"#ffffff"];
    _label_dangqiangaodu_value.font = [UIFont boldSystemFontOfSize:32.0f];
    _label_dangqiangaodu_value.numberOfLines = 0;
    _label_dangqiangaodu_value.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_label_dangqiangaodu_value];
    
//    UILabel *label_dangqiangaodu_danwei = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2+ScreenWidth*100/320, ScreenWidth*100/320, ScreenWidth*160/320, ScreenWidth*30/320)];
//    label_dangqiangaodu_danwei.text = @"cm";
//    label_dangqiangaodu_danwei.textColor = [Common2 colorWithHexString:@"#ffffff"];
//    label_dangqiangaodu_danwei.tintColor = [Common2 colorWithHexString:@"#ffffff"];
//    label_dangqiangaodu_danwei.font = [UIFont boldSystemFontOfSize:28.0f];
//    label_dangqiangaodu_danwei.numberOfLines = 0;
//    label_dangqiangaodu_danwei.textAlignment = NSTextAlignmentLeft;
//    [self.view addSubview:label_dangqiangaodu_danwei];
    
    
    _imageBtn_up = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageBtn_up.frame = CGRectMake(ScreenWidth/2-ScreenWidth*10/320-ScreenWidth*90/320, ScreenWidth*155/320, ScreenWidth*80/320, ScreenWidth*80/320);
//    [imageBtn_up setTitle:@"更多" forState:UIControlStateNormal];
    [_imageBtn_up addTarget:self action:@selector(UpClicked) forControlEvents:UIControlEventTouchUpInside];
    [_imageBtn_up setBackgroundImage:[UIImage imageNamed:@"desk_btn_up.png"] forState:UIControlStateNormal];
    [_imageBtn_up setBackgroundImage:[UIImage imageNamed:@"desk_btn_up_pre.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:_imageBtn_up];
    
    UILongPressGestureRecognizer *longPressBtn_up = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLongBtn_up:)];
    //         longPress.minimumPressDuration = 0.5; //定义按的时间
    longPressBtn_up.minimumPressDuration = 0.8; //定义按的时间
    longPressBtn_up.numberOfTouchesRequired = 1;
//    longPressBtn_up.allowableMovement = NO;
    [_imageBtn_up addGestureRecognizer:longPressBtn_up];

    
    _imageBtn_down = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageBtn_down.frame = CGRectMake(ScreenWidth/2+ScreenWidth*20/320, ScreenWidth*155/320, ScreenWidth*80/320, ScreenWidth*80/320);
//    [imageBtn_down setTitle:@"更多" forState:UIControlStateNormal];
    [_imageBtn_down addTarget:self action:@selector(DownClicked) forControlEvents:UIControlEventTouchUpInside];
    [_imageBtn_down setBackgroundImage:[UIImage imageNamed:@"desk_btn_down.png"] forState:UIControlStateNormal];
    [_imageBtn_down setBackgroundImage:[UIImage imageNamed:@"desk_btn_down_pre.png"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:_imageBtn_down];
    
    UILongPressGestureRecognizer *longPressBtn_down = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLongBtn_down:)];
    //         longPress.minimumPressDuration = 0.5; //定义按的时间
    longPressBtn_down.minimumPressDuration = 0.8; //定义按的时间
    longPressBtn_down.numberOfTouchesRequired = 1;
//    longPressBtn_down.allowableMovement = NO;
    
//    longPressBtn_down.minimumPressDuration = 0.5;
    [_imageBtn_down addGestureRecognizer:longPressBtn_down];
    

    
    
    UIButton *imageBtn_zuozimoshi = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn_zuozimoshi.frame = CGRectMake(ScreenWidth*5/320, ScreenWidth*250/320, ScreenWidth*150/320, ScreenWidth*90/320);
//    [imageBtn_zuozimoshi setTitle:@"更多" forState:UIControlStateNormal];
    [imageBtn_zuozimoshi addTarget:self action:@selector(ZuoziClicked) forControlEvents:UIControlEventTouchUpInside];
    [imageBtn_zuozimoshi setImage:[UIImage imageNamed:@"btn_mode_sit.png"] forState:UIControlStateNormal];
    [imageBtn_zuozimoshi setImage:[UIImage imageNamed:@"btn_mode_sit_pre.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:imageBtn_zuozimoshi];
    
    
    UIButton *imageBtn_zhanzimoshi = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn_zhanzimoshi.frame = CGRectMake(ScreenWidth/2+ScreenWidth*5/320, ScreenWidth*250/320, ScreenWidth*150/320, ScreenWidth*90/320);
//    [imageBtn_zhanzimoshi setTitle:@"更多" forState:UIControlStateNormal];
    [imageBtn_zhanzimoshi addTarget:self action:@selector(ZhanziClicked) forControlEvents:UIControlEventTouchUpInside];
    [imageBtn_zhanzimoshi setImage:[UIImage imageNamed:@"btn_mode_stand.png"] forState:UIControlStateNormal];
    [imageBtn_zhanzimoshi setImage:[UIImage imageNamed:@"btn_mode_stand_pre.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:imageBtn_zhanzimoshi];
    
    UIButton *imageBtn_jiyigaodu = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn_jiyigaodu.frame = CGRectMake(ScreenWidth*10/320, ScreenWidth*350/320, ScreenWidth*300/320, ScreenWidth*100/320);
//    [imageBtn_jiyigaodu setTitle:@"更多" forState:UIControlStateNormal];
    [imageBtn_jiyigaodu addTarget:self action:@selector(JiyigaoduClicked) forControlEvents:UIControlEventTouchUpInside];
    [imageBtn_jiyigaodu setImage:[UIImage imageNamed:@"btn_mode_memory.png"] forState:UIControlStateNormal];
    [imageBtn_jiyigaodu setImage:[UIImage imageNamed:@"btn_mode_memory_pre.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:imageBtn_jiyigaodu];
    
    if(isPadYES)
    {
        label_dangqiangaodu.font = [UIFont boldSystemFontOfSize:38.0f];
        _label_dangqiangaodu_value.font = [UIFont boldSystemFontOfSize:46.0f];
        _imageView_zhuo.frame = CGRectMake(ScreenWidth/2-ScreenWidth*480/320/3*0.85, ScreenWidth*10/320*0.75-50, ScreenWidth*480/320/3*0.80, ScreenWidth*435/320/3*0.75);
        label_dangqiangaodu.frame =CGRectMake((ScreenWidth/2+ScreenWidth*30/320*0.75), ScreenWidth*60/320*0.75-50, ScreenWidth*160/320*0.75, ScreenWidth*30/320*0.75);
        _label_dangqiangaodu_value.frame =CGRectMake((ScreenWidth/2+ScreenWidth*30/320*0.75), ScreenWidth*100/320*0.75-50, ScreenWidth*160/320*0.75, ScreenWidth*30/320*0.75);
        _imageBtn_up.frame = CGRectMake((ScreenWidth/2-ScreenWidth*10/320-ScreenWidth*90/320*0.75), ScreenWidth*155/320*0.75-50, ScreenWidth*80/320*0.75, ScreenWidth*80/320*0.75);
    
        _imageBtn_down.frame = CGRectMake((ScreenWidth/2+ScreenWidth*20/320*0.75), ScreenWidth*155/320*0.75-50, ScreenWidth*80/320*0.75, ScreenWidth*80/320*0.75);
        
        imageBtn_zuozimoshi.frame = CGRectMake(ScreenWidth/2-ScreenWidth*150/320-5, ScreenWidth*250/320*0.75-50, ScreenWidth*150/320, ScreenWidth*90/320*0.75);
    
        imageBtn_zhanzimoshi.frame = CGRectMake(ScreenWidth/2+5, ScreenWidth*250/320*0.75-50, ScreenWidth*150/320, ScreenWidth*90/320*0.75);
    
        imageBtn_jiyigaodu.frame = CGRectMake(ScreenWidth/2-ScreenWidth*300/320/2, ScreenWidth*350/320*0.75-50, ScreenWidth*300/320, ScreenWidth*100/320*0.75);
    }
    
 }

-(void)btnLongBtn_up:(UILongPressGestureRecognizer *)gestureRecognizer{
//    _imageBtn_up.selected = YES;

    if(_strLizhugaodu.intValue>=125)
    {
        [SVProgressHUD showErrorWithStatus:@"已到达最大高度"];
        return;
    }

    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
//        [_imageBtn_up setBackgroundImage:[UIImage imageNamed:@"desk_btn_up_pre.png"] forState:UIControlStateNormal];
//        [_imageBtn_up setBackgroundImage:[UIImage imageNamed:@"desk_btn_up_pre.png"] forState:UIControlStateHighlighted];
        
        NSLog(@"ssseeeeee");
        
//        [self UpClicked];
        
        if(![BLEManager sharedManager].isConnecting){
            return;
        }
        [BLEManager sharedManagerWithDelegate:self];//初始化
        [BLEManager sharedManager].delegate  =self;


        NSString *strcmd = [HexUtils getSetHeightCmd:126];

        [HexUtils hexToBytes:strcmd];

        NSData *sendData= [HexUtils hexToBytes:strcmd];
        NSLog(@"发送的命令是%@",strcmd);
        NSLog(@"发送的命令是%@",sendData);

//        //上升
//        NSData *sendData = [HexUtils hexToBytes:@"1B43573230313030323030303430303030343305"];
//        NSLog(@"value : %@",sendData);

        [[BLEManager sharedManager] setValue:sendData forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
        
        
        
        
    }
    
    else if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"mimimimimimi");
        
        if(![BLEManager sharedManager].isConnecting){
            return;
        }
        [BLEManager sharedManagerWithDelegate:self];//初始化
        [BLEManager sharedManager].delegate  =self;
        
        NSString * strcmddefault = @"CW20100200000000";// [HexUtils addToCompleteStr:@"CW20100200000000"];
        NSString *strCheckCode = [HexUtils generateCheckCode:strcmddefault];
//        NSString * strHeightCmd = [HexUtils addToCompleteStr:strCheckCode];
         NSString *strcmd =[HexUtils addToCompleteStr:strCheckCode];
            NSData *sendData= [HexUtils hexToBytes:strcmd];
            NSLog(@"发送的命令是%@",strcmd);
            NSLog(@"发送的命令是%@",sendData);
        //上升
//        NSData *sendData = [HexUtils hexToBytes:@"1B43573230313030323030303430303030343305"];
//        NSLog(@"value : %@",sendData);
        
        [[BLEManager sharedManager] setValue:sendData forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
        
        
//        [_imageBtn_up setBackgroundImage:[UIImage imageNamed:@"desk_btn_up.png"] forState:UIControlStateNormal];
//        [_imageBtn_up setBackgroundImage:[UIImage imageNamed:@"desk_btn_up.png"] forState:UIControlStateHighlighted];
    }
    
    else if(gestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        NSLog(@"lostllllllll");
        
    }
    
}

-(void)btnLongBtn_down:(UILongPressGestureRecognizer *)gestureRecognizer{
    
    if(_strLizhugaodu.intValue<=61)
    {
        [SVProgressHUD showErrorWithStatus:@"已到达最低高度"];
        return;
    }
//    _imageBtn_down.selected = YES;
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"ssseeeeee");
        
//        [self DownClicked];
        
        if(![BLEManager sharedManager].isConnecting){
            return;
        }
        [BLEManager sharedManagerWithDelegate:self];//初始化
        [BLEManager sharedManager].delegate  =self;

        NSString *strcmd = [HexUtils getSetHeightCmd:60];

        [HexUtils hexToBytes:strcmd];

        NSData *sendData= [HexUtils hexToBytes:strcmd];
        NSLog(@"发送的命令是%@",strcmd);
        NSLog(@"发送的命令是%@",sendData);

//        //上升
//        NSData *sendData = [HexUtils hexToBytes:@"1B43573230313030323030303630303030343505"];
//        NSLog(@"value : %@",sendData);

        [[BLEManager sharedManager] setValue:sendData forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    }
    
    else if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"mimimimimimi");
        
                if(![BLEManager sharedManager].isConnecting){
                    return;
                }
                [BLEManager sharedManagerWithDelegate:self];//初始化
                [BLEManager sharedManager].delegate  =self;
        
        NSString * strcmddefault = @"CW20100200000000";// [HexUtils addToCompleteStr:@"CW20100200000000"];
        NSString *strCheckCode = [HexUtils generateCheckCode:strcmddefault];
        //        NSString * strHeightCmd = [HexUtils addToCompleteStr:strCheckCode];
        NSString *strcmd =[HexUtils addToCompleteStr:strCheckCode];
        NSData *sendData= [HexUtils hexToBytes:strcmd];
        NSLog(@"发送的命令是%@",strcmd);
        NSLog(@"发送的命令是%@",sendData);
        //上升
        //        NSData *sendData = [HexUtils hexToBytes:@"1B43573230313030323030303430303030343305"];
        //        NSLog(@"value : %@",sendData);
        
        [[BLEManager sharedManager] setValue:sendData forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    }
    
    else if(gestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        NSLog(@"lostllllllll");
        
    }
    
}

- (void) resetflameAnimation
{
    
    [_flameAnimation setImage:[UIImage imageNamed:@"up001.png"]];
    
//    //    [_flameAnimation removeFromSuperview];
//    double meileizhi =_strmeili.doubleValue;
//    if(meileizhi>=0 &&meileizhi<=10)
//    {
//        [_flameAnimation setImage:[UIImage imageNamed:@"bie.0001.png"]];
//        
//    }
//    else if(meileizhi>10 &&meileizhi<=20)
//    {
//        [_flameAnimation setImage:[UIImage imageNamed:@"bie.0002.png"]];
//        
//    }
//    else if(meileizhi>20 &&meileizhi<=30)
//    {
//        [_flameAnimation setImage:[UIImage imageNamed:@"bie.0003.png"]];
//        
//    }
//    else if(meileizhi>30 &&meileizhi<=40)
//    {
//        [_flameAnimation setImage:[UIImage imageNamed:@"bie.0004.png"]];
//        
//    }
//    else if(meileizhi>40 &&meileizhi<=50)
//    {
//        [_flameAnimation setImage:[UIImage imageNamed:@"bie.0005.png"]];
//        
//    }
//    else if(meileizhi>50 &&meileizhi<=60)
//    {
//        [_flameAnimation setImage:[UIImage imageNamed:@"bie.0006.png"]];
//        
//    }
//    else if(meileizhi>60 &&meileizhi<=100)
//    {
//        [_flameAnimation setImage:[UIImage imageNamed:@"aa.0001.png"]];
//        
//    }

    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    
}



#pragma mark --蓝牙连接完成
//- (void)BLEManagerDidConnectPeripheral:(CBPeripheral *)peripheral
//{
//
//    [SVProgressHUD dismiss];
//
//    CBPeripheral *connctedPeripheral = peripheral;//当前连接成功的设备
//    [SVProgressHUD showSuccessWithStatus:@"连接成功"];
//
//
//    //扫描当前连接的蓝牙设备的所有服务
//    [[BLEManager sharedManager] scanningForServicesWithPeripheral:connctedPeripheral];
//
//}

//- (void)BLEManagerReceiveAllService:(CBService *)service
//{
//    //    [thisServices addObject:service];
//    //    [thisServiceTableView reloadData];
//}


# pragma mark - BLEManager Methods
- (void)BLEManagerDisabledDelegate {
    
}



#pragma mark --接收到扫描到得所有设备
- (void)BLEManagerReceiveAllPeripherals:(NSMutableArray *) peripherals andAdvertisements:(NSMutableArray *)advertisements {
    
    [SVProgressHUD dismiss];//结束转圈
    //    [dataSource addObjectsFromArray:peripherals];//加入数据源
    //    [advertisementsDataSource addObjectsFromArray:advertisements];
    //    [blueListTableview reloadData];
    
}

//#pragma mark --蓝牙连接完成
//- (void)BLEManagerDidConnectPeripheral:(CBPeripheral *)peripheral
//{
//
//    [SVProgressHUD dismiss];
//
//    CBPeripheral *connctedPeripheral = peripheral;//当前连接成功的设备
//    [SVProgressHUD showSuccessWithStatus:@"连接成功"];
//
//
//    //扫描当前连接的蓝牙设备的所有服务
//    [[BLEManager sharedManager] scanningForServicesWithPeripheral:connctedPeripheral];
//
//}
//
//#pragma mark --接受获取到得服务
//- (void)BLEManagerReceiveAllService:(CBService *)service
//{
//    //    [thisServices addObject:service];
//    //    [thisServiceTableView reloadData];
//}


#pragma mark --蓝牙连接失败
//- (void)BLEManagerDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
//    NSLog(@"蓝牙连接失败，请重新连接");
//}

#pragma mark --接受数据返回的信息及广播
//- (void)BLEManagerReceiveData:(NSData *)value fromPeripheral:(CBPeripheral *)peripheral andServiceUUID:(NSString *)serviceUUID andCharacteristicUUID:(NSString *)charUUID
//{
//    
//    NSLog(@"receve value : %@",value);
//    NSString *backString = [[NSString alloc]initWithData:value encoding:NSUTF8StringEncoding];
//    
//    //    NSLog(@"receve value : %@",backString);
//    //    notifyLabel.text = backString;
//    
//}


@end



