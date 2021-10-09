//
//  WebjsViewController.m
//  天天网
//
//  Created by zhaoweibing on 14-9-5.
//  Copyright (c) 2014年 oyxc. All rights reserved.
//

#import "ShoubingliangduViewController.h"

#import "Global.h"

#import "AppDelegate.h"
#import "Common2.h"

//#import "WifiViewCo ntroller.h"
//#import "IntroduceViewController.h"
//#import "VersionViewController.h"
//#import "QRViewController.h"

#import "SingleChooseTable.h"
//#import "LoobotModel.h"
//#import "LoobotModelDBTool.h"
#import "HexUtils.h"
#import "LinkViewController.h"
@interface ShoubingliangduViewController ()
{
    SingleChooseTable * MyTable;
    NSMutableArray * dataArr;
}


@end

@implementation ShoubingliangduViewController

- (void)layoutNavigation {
    
    UIView *viewNavigation = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 64)];
    viewNavigation.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewNavigation];
    
    
    UIButton *btn_left = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_left.frame = CGRectMake(5,10, 40, 40);
    [btn_left setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [btn_left setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateHighlighted];
    btn_left.showsTouchWhenHighlighted=YES;
    [btn_left addTarget:self action:@selector(leftBarClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewNavigation addSubview:btn_left];
    
    UILabel * labelcenter = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-90,10, 180, 40)];
    labelcenter.backgroundColor =[UIColor clearColor];
    labelcenter.font = [UIFont boldSystemFontOfSize:18];
    labelcenter.textColor =[Common2 colorWithHexString:@"#ffffff"];
    labelcenter.text = LocationLanguage(@"handleBrightness", @"手柄亮度");// CustomLocalizedString(@"xuanzeyuyan", nil);
    labelcenter.textAlignment= NSTextAlignmentCenter;
    [viewNavigation addSubview:labelcenter];
    
//        UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn_right.frame = CGRectMake(ScreenWidth-40-5,10, 40, 40);
//        [btn_right setImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
//        [btn_right setImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateHighlighted];
//    btn_right.showsTouchWhenHighlighted=YES;
//        [btn_right addTarget:self action:@selector(rightBarClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [viewNavigation addSubview:btn_right];
    
}


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
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"语言选择"];
    //    [GlobalFunc countView:@"web内嵌页"];
//    self.navigationController.navigationBarHidden = YES;
//    [self layoutNavigation];
    [self getInitData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:LocationLanguage(@"unit", @"单位设置")];
}

- (void)getInitData
{
    if(![BLEManager sharedManager].isConnecting){
        [SVProgressHUD showErrorWithStatus:LocationLanguage(@"bluetoothDisconnected", @"蓝牙连接已断开")];
        return;
    }
        [BLEManager sharedManagerWithDelegate:self];//初始化
        [BLEManager sharedManager].delegate  =self;
        
        NSString *strHeightCmdCode_strHexData = [NSString stringWithFormat:@"%@",@"PR020201"];
        NSLog(@"发送的命令是%@",strHeightCmdCode_strHexData);
        NSString *strCheckCode = [HexUtils generateCheckCode:strHeightCmdCode_strHexData];
        
        NSString * strHeightCmd = [HexUtils addToCompleteStr:strCheckCode];
        
        //读取高度
        NSData *sendData_gaodu = [HexUtils hexToBytes:strHeightCmd];
        NSLog(@"value : %@",sendData_gaodu);
        
        [[BLEManager sharedManager] setValue:sendData_gaodu forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
    
}
- (void)viewDidLoad
{

 if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    [super viewDidLoad];
    self.title = LocationLanguage(@"handleBrightness", @"手柄亮度");
    self.view.backgroundColor = [Common2 colorWithHexString:@"#2B2B73"];
    UIBarButtonItem *buttonLeft = [Common2 CreateNavBarButton:self setEvent:@selector(leftBarClicked:) background:@"btn_back.png" setTitle:nil];
    self.navigationItem.leftBarButtonItem = buttonLeft;
//    NSArray *array1 = [NSArray arrayWithObjects:@"我的订单",@"我的动态", nil];
//    
//    NSArray *array2 = [NSArray arrayWithObjects:@"简体中文",@"繁体中文",@"English",nil];
//    NSArray *array3 = [NSArray arrayWithObjects:@"更多",  nil];
//    m_arrayList = [[NSMutableArray alloc] initWithObjects: array2,nil];
//    
//    m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kDeviceWidth, kDeviceHeight - 64) style:UITableViewStyleGrouped];
//    m_tableView.delegate = self;
//    m_tableView.dataSource = self;
//    m_tableView.rowHeight = 51;
//    m_tableView.separatorColor = [Common2 colorWithHexString:@"#f0efed"];
//    m_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    m_tableView.scrollEnabled = NO;
//    
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
//    if (IOS7_OR_LATER) {
//        [m_tableView setSeparatorInset:UIEdgeInsetsZero];//
//    }
//#endif
//    m_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
//    view.backgroundColor = [Common2 colorWithHexString:@"#f0efed"];
//    m_tableView.backgroundView = view;
//    
//    //    //	m_tableView.backgroundColor = [Common colorWithHexString:@"#f0efed"];
//    [self.view addSubview:m_tableView];
//    //    UIView *tableHeaderView = [self createTableHeader];
//    //    m_tableView.tableHeaderView = tableHeaderView;
    
    dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    dataArr = [NSMutableArray arrayWithObjects:LocationLanguage(@"energySave", @"节能"),
               LocationLanguage(@"normalBrightness", @"普通"),
               LocationLanguage(@"highBrightness", @"高亮"),  nil];
    MyTable = [SingleChooseTable ShareTableWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kDeviceHeight - 64)];
    MyTable.dataArr = dataArr;
    
    NSString *shoubingliangdu =[[NSUserDefaults standardUserDefaults] objectForKey:@"shoubingliangdu"];
    if(shoubingliangdu !=NULL){
        MyTable.chooseContent = shoubingliangdu;
    }
    
    [MyTable ReloadData];
    //选中内容
    MyTable.block = ^(NSString *chooseContent,NSIndexPath *indexPath){
        NSLog(@"数据：%@ ；第%ld行",chooseContent,indexPath.row);
        [MyTable ReloadData];
        [[NSUserDefaults standardUserDefaults] setObject:chooseContent forKey:@"shoubingliangdu"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if(![BLEManager sharedManager].isConnecting){
            return;
        }
        [BLEManager sharedManagerWithDelegate:self];//初始化
        [BLEManager sharedManager].delegate  =self;
        
        NSString *strcmd = [HexUtils getHandlerBrightnessCmd:@"0001"];
        if(indexPath.row==0)
        {
            strcmd = [HexUtils getHandlerBrightnessCmd:@"0001"];
        }
        else if(indexPath.row==1)
        {
            strcmd = [HexUtils getHandlerBrightnessCmd:@"0002"];
        }
        else if(indexPath.row==2)
        {
            strcmd = [HexUtils getHandlerBrightnessCmd:@"0003"];
        }
       
        [HexUtils hexToBytes:strcmd];
        
        NSData *sendData= [HexUtils hexToBytes:strcmd];
        NSLog(@"发送的命令是%@",strcmd);
        NSLog(@"发送的命令是%@",sendData);
        
        
        //    NSData *sendData = [self convertHexStrToString:@"1B43573230313030323030303430303030343305"];
        NSLog(@"value : %@",sendData);
        
        //自学习
//        NSData *sendData_gaodu = [HexUtils hexToBytes:@"1B43573230313030323030303430303030343305"];
//        NSLog(@"value : %@",sendData_gaodu);
        
        [[BLEManager sharedManager] setValue:sendData forServiceUUID:@"FFE0" andCharacteristicUUID:@"FFE1" withPeripheral:[BLEManager sharedManager].periperal];//发送消息到设备
        
        [Common2 TipDialog:LocationLanguage(@"settingSuccessfully", @"设置成功") ];
        
       
    };
    [self.view addSubview:MyTable];
    
    [self getInitData];
    
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

//填充数据源
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Contentidentifier = [NSString stringWithFormat:@"Cell%d%d",indexPath.section, indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Contentidentifier];
    
    UIImageView *imageBack;
    UILabel *labTitle;
    UILabel *labTitle2;
    UIImageView *imageleft;
    if ( !cell )
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Contentidentifier];
        		cell.accessoryType = UITableViewCellSelectionStyleNone;
        cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        imageBack = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, self.view.frame.size.width-18, 50.5)];
        imageBack.tag = 120;
        [cell addSubview:imageBack];
        
        
//        UIImageView *imageViewJian = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-40, 18.5, 8, 14)];
//        imageViewJian.image = [UIImage imageNamed:@"jiantou.png"];
//        [cell addSubview:imageViewJian];
        
        
        
        imageleft = [[UIImageView alloc] initWithFrame:CGRectMake(20, 14.5, 22, 22)];
        imageleft.image = [UIImage imageNamed:@"mine_top_btn_more"];
        [cell addSubview:imageleft];
        imageleft.tag = 123;
        
        
        labTitle  = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, self.view.frame.size.width-18, 51)];
        labTitle.tag = 121;
        labTitle.font = [UIFont systemFontOfSize:14];
        labTitle.backgroundColor = [UIColor clearColor];
        labTitle.textColor = [Common2 colorWithHexString:@"#31302f"];
        [cell addSubview:labTitle];
        
        
        
        labTitle2  = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-108, 0, 58, 51)];
        labTitle2.tag = 124;
        labTitle2.font = [UIFont systemFontOfSize:14];
        labTitle2.backgroundColor = [UIColor clearColor];
        labTitle2.textColor = [Common2 colorWithHexString:@"#31302f"];
        [cell addSubview:labTitle2];
        //        [labTitle2 release];
        labTitle2.hidden =YES;
        
        //        if (!indexPath.row && !indexPath.section) {
        //            UIView *numView = [self createNumView];
        //            [cell addSubview:numView];
        //
        //        }
    }
    
    imageBack = (UIImageView*)[cell viewWithTag:120];
    labTitle = (UILabel*)[cell viewWithTag:121];
    
    imageleft = (UIImageView*)[cell viewWithTag:123];
    labTitle2 = (UILabel*)[cell viewWithTag:124];
    NSArray * array = [m_arrayList objectAtIndex:indexPath.section];
    //    if (!indexPath.row) {
    //        //        if (indexPath.section == 1) {
    //        //            [self setNum:[[[m_userDic objectForKey:@"orders"] objectForKey:@"notPaid"] intValue] cellView:cell];
    //        //        }
    //        imageBack.image = [[UIImage imageNamed:@"img.bundle/common/shurubj_top.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:4];
    //        imageBack.frame = CGRectMake(8, 0, self.view.frame.size.width-18, 51.5);
    //    } else if (indexPath.row == ([array count]-1)) {
    //        imageBack.image = [[UIImage imageNamed:@"img.bundle/common/shurubj_down.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1];
    //    } else {
    //        imageBack.image = [[UIImage imageNamed:@"img.bundle/common/shurubj_middle.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:25];
    //    }
    
    labTitle.text = [array objectAtIndex:indexPath.row];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            imageleft.image = [UIImage imageNamed:@"icon-order"];
        }
        else if (indexPath.row == 1) {
            
            imageleft.image = [UIImage imageNamed:@"icon-feedback"];
        }
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            imageleft.image = [UIImage imageNamed:@"vertifyInform"];
        }
        if (indexPath.row == 1) {
            
            imageleft.image = [UIImage imageNamed:@"评价_4"];
        }
        else if (indexPath.row == 2) {
            
            imageleft.image = [UIImage imageNamed:@"myattention"];
        }
        else if (indexPath.row == 3) {
            
            imageleft.image = [UIImage imageNamed:@"stu_work_ask"];
        }
        else if (indexPath.row == 4) {
            
            imageleft.image = [UIImage imageNamed:@"消息"];
            
            labTitle2.hidden =NO;
            //                labTitle2.text = @"清除缓存";
            //            CGFloat size = [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
            //            labTitle2.text =  [NSString stringWithFormat:@"%.2fM",size];
        }
        
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
            imageleft.image = [UIImage imageNamed:LocationLanguage(@"settings", @"设置")];
        }
        
    }
    
    //    if (indexPath.section == 1) {
    //        switch (indexPath.row) {
    //
    //            case 2: { //帮助中心
    //                //                labTitle2  = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-118, 0, 58, 51)];
    //                //                labTitle2.tag = 121;
    //                //                labTitle2.font = [UIFont systemFontOfSize:14];
    //                //                labTitle2.backgroundColor = [UIColor clearColor];
    //                //                labTitle2.textColor = [Common colorWithHexString:@"#31302f"];
    //                //                [cell addSubview:labTitle2];
    //                //                        [labTitle2 release];
    //                //                labTitle2.hidden =YES;
    //
    //                labTitle2.hidden =NO;
    //                //                labTitle2.text = @"清除缓存";
    //                CGFloat size = [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
    //                labTitle2.text = [NSString stringWithFormat:@"%.2fM",size];
    //            }
    //
    //                break;
    //            default:
    //                break;
    //        }
    //    }
    
    
    return cell;
}




- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == m_tableView) {
            CGFloat cornerRadius = 5.f;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 10, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            } else if (indexPath.row == 0) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [tableView visibleCells];
    
    for (UITableViewCell *cell in array) {
        
        // 不打对勾
        
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        
    }
    
    
    
    UITableViewCell *cell=[m_tableView cellForRowAtIndexPath:indexPath];
    
    // 打对勾
    
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    
//    NSString *Contentidentifier = [NSString stringWithFormat:@"Cell%d%d",indexPath.section, indexPath.row];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Contentidentifier];
//    
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;//勾标记
//    //    NSString *userid  = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
//    //    if (!userid) {
//    ////        [self butEventLogin];
//    //        return;
//    //    }
//    //    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    //    UIImageView *imageBack = (UIImageView*)[cell viewWithTag:120];
//    //    NSDictionary *dic;
//    //    id vc = nil;
//    switch (indexPath.section) {
//        case 0:
//            switch (indexPath.row) {
//                    //				case 0:
//                    //					vc = [[ZeouViewController alloc] init];
//                    //                    break;
//                    
//                case 0:
//                {
//                    
//                }
//                    break;
//                    
//                case 1:
//                {
//                    
//                }
//                    break;
//                    
//                case 2:
//                {
//                    //                    //#import "QRViewController.h"
//                    QRViewController *videoRender = [[QRViewController alloc] init];
//                    //                    WifiViewController *videoRender = [[WifiViewController alloc] init];
//                    videoRender.navigationController.navigationBarHidden = YES;
//                    [self.navigationController pushViewController:videoRender animated:YES];
//                }
//                    break;
//                    break;
//                case 3:
//                {
//                    IntroduceViewController *videoRender = [[IntroduceViewController alloc] init];
//                    videoRender.navigationController.navigationBarHidden = YES;
//                    [self.navigationController pushViewController:videoRender animated:YES];
//                }
//                    break;
//                case 4:
//                {
//                    VersionViewController *videoRender = [[VersionViewController alloc] init];
//                    videoRender.navigationController.navigationBarHidden = YES;
//                    [self.navigationController pushViewController:videoRender animated:YES];
//                }
//                    break;
//                default:
//                {
//                    
//                }
//                    break;
//                    
//            }
//            break;
//            
//    }
}


- (IBAction)wifiClicked:(UIButton *)sender
{
    
//    WifiViewController *videoRender = [[WifiViewController alloc] init];
//    videoRender.navigationController.navigationBarHidden = YES;
//    [self.navigationController pushViewController:videoRender animated:YES];
    
}

- (IBAction)introduceVClicked:(UIButton *)sender
{
    
//    IntroduceViewController *videoRender = [[IntroduceViewController alloc] init];
//    videoRender.navigationController.navigationBarHidden = YES;
//    [self.navigationController pushViewController:videoRender animated:YES];
//    
}

- (IBAction)versionClicked:(UIButton *)sender
{
    
    
    
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
#pragma mark --蓝牙连接完成
- (void)BLEManagerDidConnectPeripheral:(CBPeripheral *)peripheral
{
    
    [SVProgressHUD dismiss];
    
    CBPeripheral *connctedPeripheral = peripheral;//当前连接成功的设备
    [SVProgressHUD showSuccessWithStatus:LocationLanguage(@"successfulConnection", @"连接成功")];
    
    
    //扫描当前连接的蓝牙设备的所有服务
    [[BLEManager sharedManager] scanningForServicesWithPeripheral:connctedPeripheral];
    
}

- (void)BLEManagerReceiveAllService:(CBService *)service
{
    //    [thisServices addObject:service];
    //    [thisServiceTableView reloadData];
}


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
- (void)BLEManagerDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"蓝牙连接失败，请重新连接");
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"zhanzigaodulasttime"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"zuozigaodulasttime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark --接受数据返回的信息及广播
- (void)BLEManagerReceiveData:(NSData *)value fromPeripheral:(CBPeripheral *)peripheral andServiceUUID:(NSString *)serviceUUID andCharacteristicUUID:(NSString *)charUUID
{
    
    NSLog(@"receve value : %@",value);
    NSString *backString = [[NSString alloc]initWithData:value encoding:NSUTF8StringEncoding];
    
    //    NSLog(@"receve value : %@",backString);
    //    notifyLabel.text = backString;
    NSString *str_receve = [HexUtils encodeHexData:value];
    NSLog(@"receve value : %@",str_receve);
    if ([str_receve containsString:@"1B41"]) {
        if(str_receve.length > 12) {
            str_receve = [str_receve substringFromIndex:4];
            str_receve = [str_receve substringToIndex:8];
            
            NSString *str_gaodu = [HexUtils hexToCompleteNum:str_receve];
            if([str_gaodu isEqualToString:@"1"]) {
                MyTable.chooseContent= LocationLanguage(@"energySave", @"节能");
                [MyTable ReloadData];
            }else if([str_gaodu isEqualToString:@"2"]) {
                MyTable.chooseContent= LocationLanguage(@"normalBrightness", @"普通");
                [MyTable ReloadData];
            }else if([str_gaodu isEqualToString:@"3"]) {
                MyTable.chooseContent= LocationLanguage(@"highBrightness", @"高亮");
                [MyTable ReloadData];
            }
        }
    }
}


@end


