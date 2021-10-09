//
//  WebjsViewController.m
//  天天网
//
//  Created by zhaoweibing on 14-9-5.
//  Copyright (c) 2014年 oyxc. All rights reserved.
//

#import "ControlViewController.h"
//#import "YinpinListViewController.h"
#import "Common2.h"
#import "Global.h"
//#import "ListTableViewCell.h"
//#import "UITableViewRowAction+JZExtension.h"
//#import "MJRefresh.h"
//@import MJRefresh;
//#import "ShangchengRcommandDataTool.h"

//#import "ZiliaokuDetailsViewController.h"
//#import "ShangchengViewController.h"
//#import "ListViewController.h"
//#import "YYSearchViewController.h"

//#import "MJExtension.h"
//#import "MJRefresh.h"
//#import "XimalayaclassCell.h"

//#import "LoobotModel.h"
//#import "LoobotModelDBTool.h"
#import "LinkViewController.h"
#import "NSStringConvertUtil.h"
#import "AppDelegate.h"

//#import "XMSDK.h"
//#import "CatagoryViewController.h"
//#import "TagTableViewController.h"
//#import "AlbumTableViewController.h"
//#import "TrackTableViewController.h"
//#import "GerneralTableViewController.h"
//#import "XMSDKPlayerDataCollector.h"

//#import "XMSDKDownloadManager.h"

//#import "XimalayaTwoViewController.h"

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

#import "LongSitWaringView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ControlViewController ()

@property (nonatomic, strong) NSMutableArray *titleArray;

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

@property (nonatomic, strong) NSArray *warnArray;

@property (nonatomic, assign) int srarchHeightTimeCount;

@property (nonatomic, assign) int yy_getInfoType;   //  1: 表示获取单位
@property (nonatomic, assign) int yy_sureCmdCount;  //  确认此命令的次数（当前命令只有第二次才来确认此命令是正确的命令）
@property (nonatomic, assign) int yy_control;

@property (nonatomic, assign) int yy_saveSitStand;
@property (nonatomic, strong) LongSitWaringView *longSitWaringView;
@property (nonatomic, copy) NSString *sitRecordTime;
@property (nonatomic, assign) int sitLookTime;
@property (nonatomic, assign) int yy_lastIsSitMode;    // 0：初始值，1：不是，2：是
@end

@implementation ControlViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //获取高度
    self.srarchHeightTimeCount = 0;
    [self startSearch];
    // 取消通知
    [[AppDelegate shareInstance] cancelLocalNotification];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopSearch];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.yy_getInfoType = 1;
    self.yy_saveSitStand = 0;
    [self stopSearch];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect rect = CGRectMake(15, (self.view.height - 280)/2 - 60 - DEVICE_SAFE_BOTTOM, self.view.width - 30, 280);
    self.longSitWaringView.frame = rect;
}

- (void)startSearch {
    [self stopSearch];
    [BLEManager sharedManagerWithDelegate:self];//初始化
    [BLEManager sharedManager].delegate = self;
    _timer2 = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(searchHeight) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer2 forMode:NSRunLoopCommonModes];
}
- (void)stopSearch {
    _view_bg.hidden = YES;
    [_timer2 invalidate];
    _timer2 = nil;
    if (_yy_control == 1) {
        [self cancelSendUp];
    }else if (_yy_control == 2) {
        [self cancelSendDown];
    }
}

- (void)searchHeight {
    if (self.yy_getInfoType == 1) {
        // 单位 0.1
        NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@",@"PR020001"];
        NSString *strCheckCode = [HexUtils generateCheckCode:strHeightCmdCode_strHexData];
        NSString * strHeightCmd = [HexUtils addToCompleteStr:strCheckCode];
        NSData *sendData_gaodu2 = [HexUtils hexToBytes:strHeightCmd];
        
        [[BLEManager sharedManager] setValue:sendData_gaodu2 forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];
    }else if (_srarchHeightTimeCount % 3 == 0 && [BLEManager sharedManager].minHeight == -1) {
        // 获取最低高度
        NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@",@"PR002201"];
        NSString *strCheckCode = [HexUtils generateCheckCode:strHeightCmdCode_strHexData];
        NSString * strHeightCmd = [HexUtils addToCompleteStr:strCheckCode];
        NSData *sendData_minHeight = [HexUtils hexToBytes:strHeightCmd];
        
        [[BLEManager sharedManager] setValue:sendData_minHeight forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    }else if (_srarchHeightTimeCount % 3 == 0 && [BLEManager sharedManager].maxHeight == -1) {
        // 读最大行程
        NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@",@"PR002301"];
        NSString *strCheckCode = [HexUtils generateCheckCode:strHeightCmdCode_strHexData];
        NSString * strHeightCmd = [HexUtils addToCompleteStr:strCheckCode];
        NSData *sendData_maxHeight = [HexUtils hexToBytes:strHeightCmd];

        [[BLEManager sharedManager] setValue:sendData_maxHeight forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    }else if (_srarchHeightTimeCount % 14 == 0 && [BLEManager sharedManager].maxHeight != -1) {
        // 报警
        NSData *sendData_warning = [HexUtils hexToBytes:@"1B5052313031303032433605"];
        NSLog(@"读取报警--------------");
        [[BLEManager sharedManager] setValue:sendData_warning forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];
    }else if (_srarchHeightTimeCount % 3 == 0 && [BLEManager sharedManager].maxHeight != -1) {
        // 读取高度
        NSData *sendData_gaodu = [HexUtils hexToBytes:@"1B5052313033303031433705"];
        NSLog(@"读取高度--------------");
        [[BLEManager sharedManager] setValue:sendData_gaodu forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    }
    _srarchHeightTimeCount += 1;
    if (_srarchHeightTimeCount > 10000000) {
        _srarchHeightTimeCount = 0;
    }
}

- (void)WarningClicked:(UIButton *)sender {
    WarningViewController *videoRender = [[WarningViewController alloc] init];

    videoRender.strTitle=@"";
    videoRender.strContent=@"";
    if(sender.tag==1)
    {
        videoRender.strTitle= LocationLanguage(@"system0", @"检测到系统输入主电源电压过高，系统无法正常工作");
        videoRender.strContent= LocationLanguage(@"system8", @"请确认电网供电是否正常，如确认正常请重新 给系统上电，如果报警未解除，请联系您的供应 商");
    }
    else if(sender.tag==2)
    {
        videoRender.strTitle= LocationLanguage(@"system1", @"检测到系统输入主电源电压过低，系统无法正常工作");
        videoRender.strContent= LocationLanguage(@"system9", @"请确认电网供电是否正常，如确认正常请重新 给系统上电，报警如果未解除，请联系您的供应 商");
    }
    else if(sender.tag==3)
    {
        videoRender.strTitle= LocationLanguage(@"system2", @"系统负载超过最大载荷，系统无法正常工作");
        videoRender.strContent= LocationLanguage(@"system10", @"请减少系统当前载荷至最大允许载荷范围内，通过重新上电或者复位解除此报警");
    }
    else if(sender.tag==4)
    {
        videoRender.strTitle= LocationLanguage(@"system3", @"系统或者电机过热，系统无法正常工作");
        videoRender.strContent= LocationLanguage(@"system11", @"系统过热，请按照使用说明让系统休息，达到 时 间后报警自动解除");
    }
    else if(sender.tag==5)
    {
        videoRender.strTitle= LocationLanguage(@"system4", @"系统上升或下降遇到障碍物，已自动回退");
        videoRender.strContent= LocationLanguage(@"system12", @"无需任何操作，系统自动回退后报警将解除");
        
    }
    else if(sender.tag==6)
    {
        videoRender.strTitle= LocationLanguage(@"system5", @"系统各电机运行不同步，系统无法正常工作");
        videoRender.strContent= LocationLanguage(@"system13", @"通过复位操作解除此报警");
    }
    else if(sender.tag==7)
    {
        videoRender.strTitle= LocationLanguage(@"system6", @"电机未连接或者未检测到霍尔信号，系统无法正常工作");
        videoRender.strContent= LocationLanguage(@"system14", @"检查电机 是否连接正常，如果正常，通过复位 操作能解除此报警，如果报警未解除，请联系您 的供应商");
    }
    videoRender.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:videoRender animated:YES];
}

- (void)WarningCloseClicked {
    _view_bg.hidden = YES;
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

- (void)sendUp {
    if(_strLizhugaodu.floatValue >= [BLEManager sharedManager].maxHeight) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:LocationLanguage(@"highestPosition", @"已到达最大高度")];
        });
        return;
    }
    _yy_control = 1;

    NSString *strcmd = [HexUtils getSetHeightCmd:[BLEManager sharedManager].maxHeight];
    [HexUtils hexToBytes:strcmd];
    NSData *sendData= [HexUtils hexToBytes:strcmd];
    NSLog(@"发送的命令是%@", strcmd);
    NSLog(@"发送的命令是%@", sendData);

    [[BLEManager sharedManager] setValue:sendData forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal]; //发送消息到设备
}

- (void)cancelSendUp {
    if(![BLEManager sharedManager].isConnecting){
        return;
    }
    if (_yy_control == 0) {
        return;
    }
    _yy_control = 0;
    
    NSString * strcmddefault = @"CW20100200000000";// [HexUtils addToCompleteStr:@"CW20100200000000"];
    NSString *strCheckCode = [HexUtils generateCheckCode:strcmddefault];
    NSString *strcmd =[HexUtils addToCompleteStr:strCheckCode];
    NSData *sendData= [HexUtils hexToBytes:strcmd];
    NSLog(@"发送的命令是%@",strcmd);
    NSLog(@"发送的命令是%@",sendData);
    
    [[BLEManager sharedManager] setValue:sendData forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
}

- (void)sendDown {
    if(_strLizhugaodu.floatValue <= [BLEManager sharedManager].minHeight) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:LocationLanguage(@"lowestPosition", @"已到达最低高度")];
        });
        return;
    }
    _yy_control = 2;

    NSString *strcmd = [HexUtils getSetHeightCmd:[BLEManager sharedManager].minHeight];
    [HexUtils hexToBytes:strcmd];
    NSData *sendData= [HexUtils hexToBytes:strcmd];
    NSLog(@"发送的命令是%@", strcmd);
    NSLog(@"发送的命令是%@", sendData);

    [[BLEManager sharedManager] setValue:sendData forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal]; //发送消息到设备
}

- (void)cancelSendDown {
    if(![BLEManager sharedManager].isConnecting){
        return;
    }
    if (_yy_control == 0) {
        return;
    }
    _yy_control = 0;
    
    NSString * strcmddefault = @"CW20100200000000";// [HexUtils addToCompleteStr:@"CW20100200000000"];
    NSString *strCheckCode = [HexUtils generateCheckCode:strcmddefault];
    NSString *strcmd =[HexUtils addToCompleteStr:strCheckCode];
    NSData *sendData= [HexUtils hexToBytes:strcmd];
    NSLog(@"发送的命令是%@",strcmd);
    NSLog(@"发送的命令是%@",sendData);
    
    [[BLEManager sharedManager] setValue:sendData forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
}

- (void)ZuoziClicked {
    if(![BLEManager sharedManager].isConnecting) {
        [SVProgressHUD showErrorWithStatus:LocationLanguage(@"bluetoothDisconnected", @"蓝牙连接已断开")];
        return;
    }
    NSString *str_zuozigaodu = [BLEManager sharedManager].yy_zuoziInfo;
    NSArray *zuoziArray = [str_zuozigaodu componentsSeparatedByString:@"#"];
    CGFloat zuoziHeight = [BLEManager autoInOrCm:[zuoziArray.firstObject floatValue]
                                            isIn:zuoziArray.lastObject
                                          needCm:YES];
    NSString *strcmd = [HexUtils getSetHeightCmd:zuoziHeight];
    
    [HexUtils hexToBytes:strcmd];
    
    NSData *sendData= [HexUtils hexToBytes:strcmd];
    NSLog(@"发送的命令是%@",strcmd);
    NSLog(@"发送的命令是%@",sendData);
    
    NSLog(@"value : %@",sendData);
    
    [[BLEManager sharedManager] setValue:sendData forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
}


- (void)ZhanziClicked {
    if(![BLEManager sharedManager].isConnecting) {
        [SVProgressHUD showErrorWithStatus:LocationLanguage(@"bluetoothDisconnected", @"蓝牙连接已断开")];
        return;
    }
    NSString *str_zhanzigaodu = [BLEManager sharedManager].yy_zhanziInfo;
    NSArray *zhanziArray = [str_zhanzigaodu componentsSeparatedByString:@"#"];
    CGFloat zhanziHeight = [BLEManager autoInOrCm:[zhanziArray.firstObject floatValue]
                                             isIn:zhanziArray.lastObject
                                           needCm:YES];
    NSString *strcmd = [HexUtils getSetHeightCmd:zhanziHeight];
    
    [HexUtils hexToBytes:strcmd];
    
    NSData *sendData= [HexUtils hexToBytes:strcmd];
    NSLog(@"发送的命令是%@",strcmd);
    NSLog(@"发送的命令是%@",sendData);
    
    NSLog(@"value : %@",sendData);
    
    [[BLEManager sharedManager] setValue:sendData forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
}


- (void)JiyigaoduClicked {
    NSString *deviceId = @"";
    if ([BLEManager sharedManager].currentPeriperal) {
        deviceId = [BLEManager sharedManager].currentPeriperal.identifier.UUIDString;
    }
    NSArray *data_gaodu = [_tool selectWithClass:[Gaodu class]
                                          params:[NSString stringWithFormat:@"_deviceId = '%@'", deviceId]];
    for (int i=0;i<data_gaodu.count;i++) {
        Gaodu *p4 = data_gaodu[i];
        NSLog(@"%@",p4);
    }
   
    YLTanKuangView *tanKuangView = [[YLTanKuangView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight*0.45)];
    [self.view.window addSubview:tanKuangView];
    
    // 设置数据
    NSArray *titleArray = [NSArray arrayWithObjects:LocationLanguage(@"chooseMemoryHeight", @"选择记忆高度"),
                                                    LocationLanguage(@"cancel", @"取消"), nil];
    
    [tanKuangView initWithModelArray:data_gaodu titleArray:titleArray andImageArray:data_gaodu];
    
    __weak YLTanKuangView *tanKuangView1 = tanKuangView;
//    __weak typeof(self) weakSelf = self;
    tanKuangView.clickBlock = ^(UIView *itemView, NSString *isIn, CGFloat height) {
        if(![BLEManager sharedManager].isConnecting) {
            [SVProgressHUD showErrorWithStatus:LocationLanguage(@"bluetoothDisconnected", @"蓝牙连接已断开")];
            return;
        }
        
        NSString *sendJiYiHeight = [BLEManager floatHeight:[BLEManager autoInOrCm:height
                                                                             isIn:isIn
                                                                           needCm:YES]
                                                    needCm:YES];
        NSString *strcmd = [HexUtils getSetHeightCmd:[sendJiYiHeight floatValue]];
        
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

#pragma mark --蓝牙连接完成
- (void)BLEManagerDidConnectPeripheral:(CBPeripheral *)peripheral {
    CBPeripheral *connctedPeripheral = peripheral;//当前连接成功的设备
    [SVProgressHUD showSuccessWithStatus:LocationLanguage(@"successfulConnection", @"连接成功")];
    
    //扫描当前连接的蓝牙设备的所有服务
    [[BLEManager sharedManager] scanningForServicesWithPeripheral:connctedPeripheral];
}

#pragma mark --接受获取到得服务
- (void)BLEManagerReceiveAllService:(CBService *)service {
//    [thisServices addObject:service];
//    [thisServiceTableView reloadData];
}


#pragma mark --蓝牙连接失败
- (void)BLEManagerDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"蓝牙连接失败，请重新连接1111");
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"zhanzigaodulasttime"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"zuozigaodulasttime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
    NSTimeInterval a = [[NSDate date] timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.f", a];
    return timeString;
    
}

- (NSString *)getNianyueriByShijianchuo:(NSString *)timestamp {
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
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; [formatter setDateFormat:@"MM.dd"]; NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

#pragma mark --接受数据返回的信息及广播
- (void)BLEManagerReceiveData:(NSData *)value fromPeripheral:(CBPeripheral *)peripheral
               andServiceUUID:(NSString *)serviceUUID andCharacteristicUUID:(NSString *)charUUID {
    NSString *str_receve = [self encodeHexData:value];
    NSLog(@"receve value : %@",str_receve);
        
    if ([str_receve hasPrefix:@"1B41"]) {
            
        if(str_receve.length > 12) {
            if(str_receve.length == 26) {
                [self showWarningView:str_receve];
                return;
            }
            if(str_receve.length == 18) {
                str_receve = [str_receve substringFromIndex:4];
                str_receve = [str_receve substringToIndex:8];
                NSString *str_gaodu = [HexUtils hexToCompleteNum:str_receve];
                if(str_gaodu.length < 2) {
                    self.danwei = [str_gaodu isEqualToString:@"1"] ? 1 : 2;
                    self.yy_getInfoType = 0;
                    self.yy_sureCmdCount = 0;
                    return;
                }
                NSString *str_gaodu2 = [str_gaodu substringToIndex:str_gaodu.length-2];
                // 先判断基础高度，最大行程
                if ([BLEManager sharedManager].minHeight == -1) {
//                    self.yy_sureCmdCount += 1;
//                    if (self.yy_sureCmdCount < 2) {
//                        return;
//                    }
                    [BLEManager sharedManager].minHeight = [str_gaodu floatValue];
                    NSLog(@"最低高度 === %@", str_gaodu);
                    self.yy_sureCmdCount = 0;
                    return;
                }else if ([BLEManager sharedManager].maxHeight == -1) {
                    self.yy_sureCmdCount += 1;
                    if (self.yy_sureCmdCount < 2) {
                        return;
                    }
                    [BLEManager sharedManager].maxHeight = [BLEManager sharedManager].minHeight + [str_gaodu floatValue];
                    NSLog(@"最大高度 === %f", [BLEManager sharedManager].maxHeight);
                    self.yy_sureCmdCount = 0;
                    return;
                }
                self.yy_sureCmdCount += 1;
                CGFloat mxmi = [BLEManager sharedManager].maxHeight - [BLEManager sharedManager].minHeight;
                if (self.yy_sureCmdCount < 2 && [str_gaodu floatValue] == mxmi) {
                    return;
                }
                // 当前高度
                self.strLizhugaodu = str_gaodu;
                // 1 - 100
                CGFloat sssss = [str_gaodu2 floatValue] - [BLEManager sharedManager].minHeight;
                int xxxxx =  (int)((sssss / mxmi) * 100);
                if (xxxxx <= 1) {
                    xxxxx = 1;
                }else if (xxxxx >= 100) {
                    xxxxx = 100;
                }
                UIImage *image;
                if (xxxxx < 10) {
                    image = [UIImage imageNamed:[NSString stringWithFormat:@"up00%d.png", xxxxx]];
                }else if (xxxxx >= 10 && xxxxx < 100) {
                    image = [UIImage imageNamed:[NSString stringWithFormat:@"up0%d.png", xxxxx]];
                }else {
                    image = [UIImage imageNamed:[NSString stringWithFormat:@"up%d.png", xxxxx]];
                }
                if (image != nil) {
                    [_imageView_zhuo setImage:image];
                }
                [self dealZuoZiAndZhanZi:str_gaodu];
            }
        }
    }
}

- (void)dealZuoZiAndZhanZi:(NSString *)curHeight {
    // 每5次，判断存储一次数据
    self.yy_saveSitStand += 1;
    if (self.yy_saveSitStand > 1000000) {
        self.yy_saveSitStand = 0;
    }
    
    CGFloat curHeightValue = [curHeight floatValue];
    
    // 站姿高度
    NSString *str_zhanzigaodu = [BLEManager sharedManager].yy_zhanziInfo;
    NSArray *zhanziArray = [str_zhanzigaodu componentsSeparatedByString:@"#"];
    CGFloat zhanzigaoduHeight = [BLEManager autoInOrCm:[zhanziArray.firstObject floatValue]
                                                  isIn:zhanziArray.lastObject
                                                needCm:YES];
    // 坐姿高度
    NSString *str_zuozigaodu = [BLEManager sharedManager].yy_zuoziInfo;
    NSArray *zuoziArray = [str_zuozigaodu componentsSeparatedByString:@"#"];
    CGFloat zuozigaoduHeight = [BLEManager autoInOrCm:[zuoziArray.firstObject floatValue]
                                                 isIn:zuoziArray.lastObject
                                               needCm:YES];
    
    BOOL isStand = ((zhanzigaoduHeight - 1) <= curHeightValue) && (curHeightValue <= (zhanzigaoduHeight + 1));
    BOOL isSit = ((zuozigaoduHeight - 1) <= curHeightValue) &&  (curHeightValue <= (zuozigaoduHeight + 1));
    
    self.yy_lastIsSitMode = isSit ? 2 : 1;
    if (isStand == NO && isSit == NO) {
        return;
    }
    if (self.yy_saveSitStand <= 10) {
        // 前10次直接存储
    }else if (self.yy_saveSitStand == 0 || self.yy_saveSitStand % 5 != 0) {
        // 间隔5次存储
        return;
    }
    
    NSString *str_shijianchuo = [self getCurrentTime_shijianchuo];
    if (isStand) {
        NSString *str_zhanzigaodulasttime = [[NSUserDefaults standardUserDefaults] objectForKey:@"zhanzigaodulasttime"];
        if(str_zhanzigaodulasttime == NULL || str_zhanzigaodulasttime == nil) {
            [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zhanzigaodulasttime"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return;
        }
        NSString *str_shijiancha_tian = [HexUtils getShijianjiange_tian:str_zhanzigaodulasttime endTimestamp:str_shijianchuo];
        NSString *str_shijiancha_zhanzi = @"0";
        if(str_shijiancha_tian.doubleValue < 1) {
            // 24小时之内
            NSString *str_nianyueri1 = [HexUtils getNianyueri:str_zhanzigaodulasttime];
            NSString *str_nianyueri2 = [HexUtils getNianyueri:str_shijianchuo];
            if([str_nianyueri1 isEqualToString:str_nianyueri2]) {
                // 日期相同
                str_shijiancha_zhanzi = [HexUtils getShijianjiange:str_zhanzigaodulasttime endTimestamp:str_shijianchuo];
                [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zhanzigaodulasttime"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else {
                [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zhanzigaodulasttime"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                return;
            }
        }else {
            [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zhanzigaodulasttime"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return;
        }
        NSString *str_nianyueri=[self getCurrentTime];
//        NSString *str_yueri=[self getCurrentTime2];
        
        NSString *params =[NSString stringWithFormat:@"_riqi='%@'",str_nianyueri];
        NSArray *data = [_tool selectWithClass:[Health class] params:params];
        if(data.count > 0) {
            Health *h1 = [data objectAtIndex:0];
            h1.zhanzishijian = h1.zhanzishijian + str_shijiancha_zhanzi.floatValue;
            [_tool updateWithObj:h1 andKey:@"riqi" isEqualValue:str_nianyueri];
        }
        [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zhanzigaodulasttime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else {
        [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zhanzigaodulasttime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    // 坐姿
    if (isSit) {
        NSString *str_zuozigaodulasttime = [[NSUserDefaults standardUserDefaults] objectForKey:@"zuozigaodulasttime"];
        if(str_zuozigaodulasttime == NULL || str_zuozigaodulasttime == nil) {
            [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zuozigaodulasttime"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return;
        }
        NSString *str_shijiancha_tian = [HexUtils getShijianjiange_tian:str_zuozigaodulasttime endTimestamp:str_shijianchuo];
        NSString *str_shijiancha_zuozi = @"0";
        if(str_shijiancha_tian.doubleValue < 1) {
            // 24小时内
            NSString *str_nianyueri1= [HexUtils getNianyueri:str_zuozigaodulasttime];
            NSString *str_nianyueri2= [HexUtils getNianyueri:str_shijianchuo];
            if([str_nianyueri1 isEqualToString:str_nianyueri2]) {
                // 日期相同
                str_shijiancha_zuozi = [HexUtils getShijianjiange:str_zuozigaodulasttime endTimestamp:str_shijianchuo];
                [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zuozigaodulasttime"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                // 坐姿时间计算
                [self dealWithLongTime:str_shijianchuo];
            }else {
                [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zuozigaodulasttime"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                return;
            }
        }else {
            [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zuozigaodulasttime"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return;
        }
        NSString *str_nianyueri=[self getCurrentTime];
//        NSString *str_yueri=[self getCurrentTime2];
        NSString *params =[NSString stringWithFormat:@"_riqi='%@' ",str_nianyueri];
        NSArray *data = [_tool selectWithClass:[Health class] params:params];
        if(data.count > 0) {
            Health *h1 = [data objectAtIndex:0];
            //                h1.zuozishijian =1.10;
            h1.zuozishijian = h1.zuozishijian + str_shijiancha_zuozi.floatValue;
            [_tool updateWithObj:h1 andKey:@"riqi" isEqualValue:str_nianyueri];
        }
        [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zuozigaodulasttime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else {
        [[NSUserDefaults standardUserDefaults] setObject:str_shijianchuo forKey:@"zuozigaodulasttime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)dealWithLongTime:(NSString *)currentTimecc {
    if (_sitRecordTime.length == 0) {
        _sitRecordTime = currentTimecc;
        return;
    }
    // 是否关闭提醒
    id aCloseSitTip = [[NSUserDefaults standardUserDefaults] objectForKey:Long_time_close];
    BOOL isCloseSitTip = aCloseSitTip != nil ? [aCloseSitTip boolValue] : NO;
    
    id aSitLongTimeInterval = [[NSUserDefaults standardUserDefaults] objectForKey:Long_time_interval];
    BOOL isSitLongTimeInterval = aSitLongTimeInterval != nil ? [aSitLongTimeInterval boolValue] : NO;
    
    NSString *longTime;
    if (isSitLongTimeInterval) {
        longTime = @"10";
    }else {
        longTime = [[NSUserDefaults standardUserDefaults] objectForKey:Long_time];
        longTime = longTime ? longTime : @"120";
    }
    _sitLookTime = [currentTimecc doubleValue] - [_sitRecordTime doubleValue];
    
    if ([longTime intValue] * 60 - _sitLookTime > 0) {
        [AppDelegate shareInstance].lastSitTipTimeCount = [longTime intValue] * 60 - _sitLookTime;
    }else {
        [AppDelegate shareInstance].lastSitTipTimeCount = [longTime intValue] * 60;
    }
    int showSitWarning = [[AppDelegate shareInstance] showSitLongWarning];
    if (showSitWarning == -1) {
        // 已经有通知过，则直接显示弹框
        [self showLongSitWaringView:longTime playVoice:NO];
    }else if (showSitWarning > 0 && showSitWarning != NSNotFound) {
        // 还需要 showSitWarning 时长 会通知 （这里反向计算出 _sitRecordTime 的大小）
        int count1 = [longTime intValue] * 60;
        int count2 = [currentTimecc doubleValue] + showSitWarning;
        int count3 = count2 - count1;
        _sitRecordTime = [NSString stringWithFormat:@"%d", count3];
    }else if ((_sitLookTime / 60 >= [longTime intValue]) && !isCloseSitTip) {
        [self showLongSitWaringView:longTime playVoice:YES];
    }
}

- (void)showLongSitWaringView:(NSString *)longTime playVoice:(BOOL)playVoice {
    static SystemSoundID soundID;
    
    if (self.longSitWaringView.superview) {
        return;
    }
    [self.view addSubview:self.longSitWaringView];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:Long_time_interval];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    __weak typeof(self) weakSelf = self;
    self.longSitWaringView.sureBlock = ^(BOOL isClose) {
        weakSelf.sitRecordTime = @"";
        AudioServicesDisposeSystemSoundID(soundID);
        [[NSUserDefaults standardUserDefaults] setBool:isClose forKey:Long_time_close];
        [[NSUserDefaults standardUserDefaults] synchronize];
    };
    self.longSitWaringView.longTimeStr = longTime;
    [self.longSitWaringView startAnimation];
    if (playVoice) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ppppp" ofType:@"mp3"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
        AudioServicesPlaySystemSound(soundID);
    }
}


- (void)showWarningView {
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
    _label_warning.text = LocationLanguage(@"unknownError", @"Notice:未知警告");
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

- (void)showWarningView:(NSString *)str_receve {
     NSString *strWarning = str_receve;// =@"1B413030303030303430433505";
    //    NSNumber *number_gaodu = [HexUtils numberHexString:str_asciiCode_all];
    if(strWarning.length == 26) {
        strWarning = [strWarning substringWithRange:NSMakeRange(4, 16)];
        NSLog(@"receve value : %@", strWarning);
        
        NSMutableArray<NSNumber *> *resultMutNum = @[].mutableCopy;
        NSMutableString *resultMutStr = @"".mutableCopy;
        for (int i = 0; i < 16; i+=2) {
            NSString *str = [strWarning substringWithRange:NSMakeRange(i, 2)];
            NSNumber *number_warning = [HexUtils numberHexString:str];
            
            NSString *str_asciiCode = [NSString stringWithFormat:@"%c", (unichar)[number_warning intValue]];
            [resultMutStr appendString:str_asciiCode];
            [resultMutNum addObject:[NSNumber numberWithInt:[str_asciiCode intValue]]];
        }
        
        NSLog(@"xxxxxxxxx = %@", resultMutStr);
        if ([resultMutStr isEqualToString:@"00000000"]) {
            _view_bg.hidden = YES;
            return;
        }
        int warnCode = [self getWarnCode:resultMutNum];
        if (warnCode > 0) {
            _view_bg.hidden = NO;
            _label_warning.text = self.warnArray[warnCode-1];
            _btn_warning.tag = warnCode;
            [self.view bringSubviewToFront:_view_bg];
        }else {
            NSLog(@"未定义");
        }
    }
}

- (int)getWarnCode:(NSArray<NSNumber *> *)bys {
    //@"00000001"
    if ([self getBitOnindexTrue:bys[7] withIndex:0]) {
        return 1;
    }
    //@"00000002"
    else if ([self getBitOnindexTrue:bys[7] withIndex:1]) {
        return 2;
    }
    //@"00000040"
    else if ([self getBitOnindexTrue:bys[6] withIndex:2]) {
        return 3;
    }
    //@"00000800"
    else if ([self getBitOnindexTrue:bys[5] withIndex:3]) {
        return 4;
    }
    //@"00010000"
    else if ([self getBitOnindexTrue:bys[3] withIndex:0]) {
        return 5;
    }
    //@"00020000"
    else if ([self getBitOnindexTrue:bys[3] withIndex:1]) {
        return 6;
    }
    //@"00400000"
    else if ([self getBitOnindexTrue:bys[2] withIndex:2]) {
        return 7;
    }else {
        return 0;
    }
}

- (BOOL)getBitOnindexTrue:(NSNumber *)by withIndex:(int)index {
    if (([by intValue] >> index) & 0x1) {
        return YES;
    }
    return NO;
}

- (NSArray *)warnArray {
    if (_warnArray == nil) {
        _warnArray = @[LocationLanguage(@"overvoltage", @"Notice:输入电源过压"),
        LocationLanguage(@"under-voltage", @"Notice:输入电源欠压"),
        LocationLanguage(@"overloadAlarm", @"Notice:过载报警"),
        LocationLanguage(@"overheatAlarm", @"Notice:过热报警"),
        LocationLanguage(@"collisionAlarm", @"Notice:碰撞报警"),
        LocationLanguage(@"out-of-stepAlarm", @"Notice:失步报警"),
        LocationLanguage(@"noHallAlarm", @"Notice:无霍尔报警")];
    }
    return _warnArray;
}

- (void)viewDidLoad {
    _tool = [DBTool sharedDBTool];
    [_tool createTableWithClass:[Health class]];
    
    _danwei = 1;
    self.yy_lastIsSitMode = 0;
    self.yy_getInfoType = 1;
    
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)) {
        self.navigationController.navigationBar.translucent = NO;
    }
    [super viewDidLoad];
    
    [self showWarningView];
    
   self.view.backgroundColor = [Common2 colorWithHexString:@"#2B2B73"];
    
    NSString *languStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"];
    BOOL isEn = [languStr isEqualToString:@"en"] || [languStr isEqualToString:@"ru"];
    CGFloat zhuoWidth = isEn ? ScreenWidth*480/320/3 - 10 : ScreenWidth*480/320/3;
    
    _imageView_zhuo = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*10/320, ScreenWidth*10/320,
                                                                    zhuoWidth, ScreenWidth*435/320/3)];
    [_imageView_zhuo setImage:[UIImage imageNamed:@"up001.png"]];
    [self.view addSubview:_imageView_zhuo];
    
    CGFloat dangqiangOffHeight = isEn ? 10 : 0;
    UILabel *label_dangqiangaodu = [[UILabel alloc] initWithFrame:CGRectMake(_imageView_zhuo.right + 10,
                                                                             ScreenWidth*60/320,
                                                                             ScreenWidth - _imageView_zhuo.right - 20,
                                                                             ScreenWidth*30/320 + dangqiangOffHeight)];
    label_dangqiangaodu.text = LocationLanguage(@"currentHeight", @"当前高度");
    label_dangqiangaodu.textColor = [Common2 colorWithHexString:@"#ffffff"];
    label_dangqiangaodu.tintColor = [Common2 colorWithHexString:@"#ffffff"];
    label_dangqiangaodu.font = [UIFont boldSystemFontOfSize:isEn ? 20.0f : 24.0f];
    label_dangqiangaodu.numberOfLines = 0;
    label_dangqiangaodu.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label_dangqiangaodu];
    
    
    _label_dangqiangaodu_value = [[UILabel alloc] initWithFrame:CGRectMake(_imageView_zhuo.right + 10,
                                                                           ScreenWidth*100/320,
                                                                           ScreenWidth - _imageView_zhuo.right - 20,
                                                                           ScreenWidth*30/320)];
    self.strLizhugaodu = @"60";
    _label_dangqiangaodu_value.textColor = [Common2 colorWithHexString:@"#ffffff"];
    _label_dangqiangaodu_value.tintColor = [Common2 colorWithHexString:@"#ffffff"];
    _label_dangqiangaodu_value.font = [UIFont boldSystemFontOfSize:32.0f];
    _label_dangqiangaodu_value.numberOfLines = 0;
    _label_dangqiangaodu_value.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label_dangqiangaodu_value];
    
    CGFloat scale = DEVICE_HEIGHT_SCALE;
    
    _imageBtn_up = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageBtn_up.frame = CGRectMake(ScreenWidth/2-ScreenWidth*10/320-ScreenWidth*90/320, (ScreenWidth*155/320) * scale, ScreenWidth*80/320, ScreenWidth*80/320);
    [_imageBtn_up setBackgroundImage:[UIImage imageNamed:@"desk_btn_up.png"] forState:UIControlStateNormal];
    [_imageBtn_up setBackgroundImage:[UIImage imageNamed:@"desk_btn_up_pre.png"] forState:UIControlStateHighlighted];
    [_imageBtn_up addTarget:self action:@selector(sendUp)
           forControlEvents:UIControlEventTouchDown];
    [_imageBtn_up addTarget:self action:@selector(cancelSendUp)
           forControlEvents:UIControlEventTouchDragExit | UIControlEventTouchUpInside];
    [self.view addSubview:_imageBtn_up];

    _imageBtn_down = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageBtn_down.frame = CGRectMake(ScreenWidth/2+ScreenWidth*20/320, _imageBtn_up.frame.origin.y, ScreenWidth*80/320, ScreenWidth*80/320);
    [_imageBtn_down setBackgroundImage:[UIImage imageNamed:@"desk_btn_down.png"] forState:UIControlStateNormal];
    [_imageBtn_down setBackgroundImage:[UIImage imageNamed:@"desk_btn_down_pre.png"] forState:UIControlStateHighlighted];
    [_imageBtn_down addTarget:self action:@selector(sendDown)
             forControlEvents:UIControlEventTouchDown];
    [_imageBtn_down addTarget:self action:@selector(cancelSendDown)
             forControlEvents:UIControlEventTouchDragExit | UIControlEventTouchUpInside];
    [self.view addSubview:_imageBtn_down];
    
    UIButton *imageBtn_zuozimoshi = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn_zuozimoshi.frame = CGRectMake(ScreenWidth*5/320, (ScreenWidth*250/320) * scale, ScreenWidth*150/320, ScreenWidth*90/320);
//    [imageBtn_zuozimoshi setTitle:@"更多" forState:UIControlStateNormal];
    [imageBtn_zuozimoshi addTarget:self action:@selector(ZuoziClicked) forControlEvents:UIControlEventTouchUpInside];
    [imageBtn_zuozimoshi setImage:[UIImage imageNamed:LocationLanguage(@"btn_mode_sit", @"btn_mode_sit")] forState:UIControlStateNormal];
    [imageBtn_zuozimoshi setImage:[UIImage imageNamed:LocationLanguage(@"btn_mode_sit_pre", @"btn_mode_sit_pre")] forState:UIControlStateHighlighted];
    [self.view addSubview:imageBtn_zuozimoshi];
    
    
    UIButton *imageBtn_zhanzimoshi = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn_zhanzimoshi.frame = CGRectMake(ScreenWidth/2+ScreenWidth*5/320, imageBtn_zuozimoshi.frame.origin.y, ScreenWidth*150/320, ScreenWidth*90/320);
//    [imageBtn_zhanzimoshi setTitle:@"更多" forState:UIControlStateNormal];
    [imageBtn_zhanzimoshi addTarget:self action:@selector(ZhanziClicked) forControlEvents:UIControlEventTouchUpInside];
    [imageBtn_zhanzimoshi setImage:[UIImage imageNamed:LocationLanguage(@"btn_mode_stand", @"btn_mode_stand")] forState:UIControlStateNormal];
    [imageBtn_zhanzimoshi setImage:[UIImage imageNamed:LocationLanguage(@"btn_mode_stand_pre", @"btn_mode_stand_pre")] forState:UIControlStateHighlighted];
    [self.view addSubview:imageBtn_zhanzimoshi];
    
    UIButton *imageBtn_jiyigaodu = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn_jiyigaodu.frame = CGRectMake(ScreenWidth*10/320, (ScreenWidth*350/320) * scale, ScreenWidth*300/320, ScreenWidth*100/320);
//    [imageBtn_jiyigaodu setTitle:@"更多" forState:UIControlStateNormal];
    [imageBtn_jiyigaodu addTarget:self action:@selector(JiyigaoduClicked) forControlEvents:UIControlEventTouchUpInside];
    [imageBtn_jiyigaodu setImage:[UIImage imageNamed:LocationLanguage(@"btn_mode_memory", @"btn_mode_memory")] forState:UIControlStateNormal];
    [imageBtn_jiyigaodu setImage:[UIImage imageNamed:LocationLanguage(@"btn_mode_memory_pre", @"btn_mode_memory_pre")] forState:UIControlStateHighlighted];
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

- (void)resetflameAnimation {
    [_flameAnimation setImage:[UIImage imageNamed:@"up001.png"]];
}

// danwei: 1 厘米  2 英尺
- (void)setDanwei:(NSInteger)danwei {
    _danwei = danwei;
    [BLEManager sharedManager].is_CM = danwei == 1;
    NSString *valueStr = [BLEManager floatHeight:[BLEManager autoInOrCm:[_strLizhugaodu floatValue]
                                                                   isIn:@"0"
                                                                 needCm:_danwei == 1]
                                          needCm:_danwei == 1];
    _label_dangqiangaodu_value.text = [NSString stringWithFormat:@"%@ %@", valueStr, _danwei == 1 ? @"cm" : @"IN"];
}
// 高度
- (void)setStrLizhugaodu:(NSString *)strLizhugaodu {
    _strLizhugaodu = strLizhugaodu;
    NSString *valueStr = [BLEManager floatHeight:[BLEManager autoInOrCm:[_strLizhugaodu floatValue]
                                                                   isIn:@"0"
                                                                 needCm:_danwei == 1]
                                          needCm:_danwei == 1];
    _label_dangqiangaodu_value.text = [NSString stringWithFormat:@"%@ %@", valueStr, _danwei == 1 ? @"cm" : @"IN"];
}

- (void)setYy_lastIsSitMode:(int)yy_lastIsSitMode {
    if (yy_lastIsSitMode == 0) {
        _yy_lastIsSitMode = 0;
        return;
    }
    [AppDelegate shareInstance].isSitModel = yy_lastIsSitMode == 2;
    _sitRecordTime = yy_lastIsSitMode == 2 ? _sitRecordTime : @"";
    if (_yy_lastIsSitMode == 0) {
        _yy_lastIsSitMode = yy_lastIsSitMode;
        return;
    }
    if (_yy_lastIsSitMode == yy_lastIsSitMode) {
        return;
    }
    _yy_lastIsSitMode = yy_lastIsSitMode;
    [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:Long_time_notification];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:Long_time_interval];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (LongSitWaringView *)longSitWaringView {
    if (_longSitWaringView == nil) {
        _longSitWaringView = [[NSBundle mainBundle] loadNibNamed:@"LongSitWaringView" owner:nil options:nil].firstObject;
    }
    return _longSitWaringView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
//    [SVProgressHUD dismiss];//结束转圈
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



