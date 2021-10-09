//
//  ViewController.m
//  ZLCBlueTooth
//
//  Created by shining3d on 16/8/17.
//  Copyright © 2016年 shining3d. All rights reserved.
//

#import "MainBlueTouchViewController.h"
#import "MainBlueCell.h"
#import "MeitikuViewController.h"
#import "ControlViewController.h"

#import "DBTool.h"
#import "BlueTouchDevice.h"
#import "ZYInputAlertView.h"
#import "LinkViewController.h"

#import "AppDelegate.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

static BOOL isNOFirstIn = NO;
static BlueTouchDevice *currentConnectedDevice = nil;

@interface MainBlueTouchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UISwitch *autoLoginSwitch;
@property (strong, nonatomic) DBTool *tool;

@property (nonatomic,assign) NSInteger cellsection;
@property (nonatomic,assign) NSInteger cellrow;

@property (nonatomic,assign) NSInteger clickcount;

@property (nonatomic, strong) MeitikuViewController *appStartController;
@property (nonatomic, assign) BOOL isLinkSuccess;

@property (nonatomic, assign) BOOL isLinking;       // 连接中状态

@end

@implementation MainBlueTouchViewController {
	UITableView *blueListTableview;
	NSMutableArray *dataSource;
    
    NSMutableArray *dataSource_1;
    NSMutableArray *dataSource_2;
    NSMutableArray *dataSource_3;
}

@synthesize autoLoginSwitch = _autoLoginSwitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [g_winDic setObject:[NSNumber numberWithInt:1] forKey:[NSString stringWithFormat:@"%@", self]];
        
        self.title = LocationLanguage(@"connectBluetooth", @"蓝牙连接");
        self.hidesBottomBarWhenPushed = NO;

        UIBarButtonItem *buttonRight = [Common2 CreateNavBarButton:self setEvent:@selector(RightBarButtonItemPressed) background:@"bluetooth_btn_search.png" setTitle:nil];
        self.navigationItem.rightBarButtonItem = buttonRight;
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(RightBarButtonItemLongPressed)];
        longPressGestureRecognizer.minimumPressDuration = 3;
        [buttonRight.customView addGestureRecognizer:longPressGestureRecognizer];
    }
    return self;
}

//点击返回按钮返回主界面
- (void)LeftBarButtonItemPressed {
    if (self.isLinkSuccess) {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.25;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:self.appStartController animated:NO];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//注册页面
- (void)RightBarButtonItemPressed {
    if ([BLEManager sharedManager].blueToothPoweredOn == 1) {
        [SVProgressHUD showErrorWithStatus:LocationLanguage(@"trunOnBluetooth", @"蓝牙没有开启，在设置中打开蓝牙")];
        return;
    }else if ([BLEManager sharedManager].blueToothPoweredOn == 2) {
        [SVProgressHUD showErrorWithStatus:LocationLanguage(@"notAvailablePermission", @"未开启蓝牙权限，请在手机设置中打开")];
        return;
    }
    [[BLEManager sharedManager] disableBLEManager];
    [dataSource removeAllObjects];
    [blueListTableview reloadData];
    [BLEManager sharedManagerWithDelegate:self];
    [BLEManager sharedManager].delegate  = self;
    [[BLEManager sharedManager] scanningForPeripherals];//开始扫描
    [SVProgressHUD showWithStatus:LocationLanguage(@"searching", @"搜索中")];
}

- (void)RightBarButtonItemLongPressed {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否清空历史连接蓝牙" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[BLEManager sharedManager] disConnected];
        [_tool deleteRecordAllWithClass:[BlueTouchDevice class]];
        [self RightBarButtonItemPressed];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
    
    [[BLEManager sharedManager] disableBLEManager];
    _tool = [DBTool sharedDBTool];
    NSString *params1 =[NSString stringWithFormat:@"_type='%@'",@"1"];
    [_tool deleteRecordWithClass:[BlueTouchDevice class] params:params1];
    
    [BLEManager sharedManagerWithDelegate:self];
    [BLEManager sharedManager].delegate  = self;
    [[BLEManager sharedManager] scanningForPeripherals];//开始扫描
    [SVProgressHUD showWithStatus:LocationLanguage(@"searching", @"搜索中")];
    
    if([BLEManager sharedManager].blueToothPoweredOn == 0) {
        [_autoLoginSwitch setOn:YES  animated:YES];
    }else {
        [_autoLoginSwitch setOn:NO  animated:YES];
    }
    if (isNOFirstIn) {
        if ([BLEManager sharedManager].blueToothPoweredOn == 1) {
            [SVProgressHUD showErrorWithStatus:LocationLanguage(@"trunOnBluetooth", @"蓝牙没有开启，在设置中打开蓝牙")];
        }else if ([BLEManager sharedManager].blueToothPoweredOn == 2) {
            [SVProgressHUD showErrorWithStatus:LocationLanguage(@"notAvailablePermission", @"未开启蓝牙权限，请在手机设置中打开")];
        }
    }else {
        isNOFirstIn = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[BLEManager sharedManager] disableBLEManager];
    [SVProgressHUD dismiss];
}

- (void)autoLoginChanged:(UISwitch *)autoSwitch {
//    NSString * textString =@"";
    
    if(self.autoLoginSwitch.isOn==YES) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"saomiao"];
//        [_autoLoginSwitch setOn:NO  animated:YES];
        
        [dataSource removeAllObjects];
        [blueListTableview reloadData];
        [BLEManager sharedManagerWithDelegate:self];
        [[BLEManager sharedManager] scanningForPeripherals];//开始扫描
        [SVProgressHUD show];//转圈
    }
    else{
        [dataSource removeAllObjects];
        [blueListTableview reloadData];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"saomiao"];
//        [_autoLoginSwitch setOn:YES  animated:YES];
        
        [[BLEManager sharedManager] disableBLEManager];
        [blueListTableview reloadData];
    }
}

- (UISwitch *)autoLoginSwitch {
    if (_autoLoginSwitch == nil) {
        _autoLoginSwitch = [[UISwitch alloc] init];
        [_autoLoginSwitch addTarget:self action:@selector(autoLoginChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _autoLoginSwitch;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *buttonLeft = [Common2 CreateNavBarButton:self setEvent:@selector(LeftBarButtonItemPressed) background:@"btn_back.png" setTitle:nil];
    self.navigationItem.leftBarButtonItem = buttonLeft;
    
    UILabel *label_warning = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*10/320, ScreenWidth*5/320, ScreenWidth*130/320, ScreenWidth*30/320)];
    if(isPadYES) {
        label_warning.frame =CGRectMake(ScreenWidth*10/320, ScreenWidth*0/320, ScreenWidth*130/320, ScreenWidth*30/320);
    }
    label_warning.text = LocationLanguage(@"bluetooth", @"蓝牙");
    label_warning.textColor = [Common2 colorWithHexString:@"#000000"];
    label_warning.tintColor = [Common2 colorWithHexString:@"#000000"];
    label_warning.font = [UIFont systemFontOfSize:18.0f];
    label_warning.numberOfLines = 0;
    label_warning.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label_warning];
    
    self.autoLoginSwitch.frame = CGRectMake(ScreenWidth-60, ScreenWidth*5/320, self.autoLoginSwitch.frame.size.width, self.autoLoginSwitch.frame.size.height);
    [self.view addSubview:self.autoLoginSwitch];
    
    self.autoLoginSwitch.enabled = NO;
	
    __weak typeof(self.autoLoginSwitch) weakSwitch = self.autoLoginSwitch;
    [BLEManager sharedManager].poweredOnBlock = ^(int code) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSwitch.on = code == 0;
        });
    };
	
	[self setTableView];                            // 设置tableview
	
    [BLEManager sharedManager].is_autoLink = YES;   // 自动连接
	[BLEManager sharedManagerWithDelegate:self];    // 遵循蓝牙代理
    if (self.isSourceSetting == NO) {
        [BLEManager sharedManager].linkDelegate = self;
    }
    
    _tool = [DBTool sharedDBTool];
    
    NSString *params3 =[NSString stringWithFormat:@"_type='%@'",@"3"];
    [_tool deleteRecordWithClass:[BlueTouchDevice class] params:params3];
    
    [self getDateSouce];
    
    UILongPressGestureRecognizer *longPressed = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressedAct:)];
    
    longPressed.minimumPressDuration = 1.0; //定义按的时间
    
    [blueListTableview addGestureRecognizer:longPressed];
    
    [self removeNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enterBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void)enterBackground {
    [self.appStartController.controlVc stopSearch];
}

- (void)didBecomeActive {
    self.isLinkSuccess = self.isLinkSuccess;
}

// 移除通知
- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)getDateSouce {
    [dataSource_1 removeAllObjects];
    
    NSString *params2 =[NSString stringWithFormat:@"_type='%@'",@"2"];
    // 连接过的设备
    dataSource_2 = [_tool selectWithClass:[BlueTouchDevice class] params:params2];
    // 可用设备
    NSString *params3 =[NSString stringWithFormat:@"_type='%@'",@"3"];
    dataSource_3 = [_tool selectWithClass:[BlueTouchDevice class] params:params3];
    
    NSMutableArray *soureArray_2 = dataSource_2.mutableCopy;
    NSMutableArray *soureArray_3 = dataSource_3.mutableCopy;
    // 1：连接过的设备 和 可用设备重复，只显示连接中的设备
    // 2：连接过的设备 不存在 可用设备中，不显示连接中的此设备
    NSString *currentDeviceId = @"";
    if ([BLEManager sharedManager].currentPeriperal) {
        currentDeviceId = [BLEManager sharedManager].currentPeriperal.identifier.UUIDString;
        [[NSUserDefaults standardUserDefaults] setObject:currentDeviceId forKey:@"lastDeviceIdentifier"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // 连接成功
        self.isLinkSuccess = YES;
    }else {
        // 连接失败
        self.isLinkSuccess = NO;
    }
    for (int i = 0; i < soureArray_2.count; i++) {
        BOOL isAvailable = NO;
        BlueTouchDevice *device22 = soureArray_2[i];
        // 修改当前连接设备的名称
        if ([device22.identifier isEqualToString:currentDeviceId]) {
            currentConnectedDevice = device22;
            [dataSource_1 removeAllObjects];
            [dataSource_1 addObject:device22];
            [dataSource_2 removeObject:device22];
        }
        for (int j = 0; j < soureArray_3.count; j++) {
            BlueTouchDevice *device33 = soureArray_3[j];
            // 修改当前连接设备的名称
            if ([device33.identifier isEqualToString:currentDeviceId]) {
                currentConnectedDevice = device33;
                [dataSource_1 removeAllObjects];
                [dataSource_1 addObject:device33];
                [dataSource_3 removeObject:device33];
            }
            if (![device33.identifier isEqualToString:device22.identifier]) {
                continue;
            }
            isAvailable = YES;
            [dataSource_3 removeObject:device33];
            break;
        }
        // 不存在，不需要 显示连接过的设备
        if (isAvailable == NO) {
            [dataSource_2 removeObject:device22];
        }
    }
    // 自动连接2：从历史连接的列表中选择第一个进行连接
    if ([BLEManager sharedManager].currentPeriperal == nil &&
        [BLEManager sharedManager].is_autoLink &&
        _isLinking == NO &&
        dataSource_2.count > 0) {
        for (int i = 0; i < dataSource.count; i++) {
            BlueTouchDevice *device = dataSource_2.firstObject;
            CBPeripheral *periperal = dataSource[i];
            if([device.identifier isEqualToString:periperal.identifier.UUIDString]) {
                // 连接
                _isLinking = YES;
                [BLEManager sharedManager].periperal = periperal;
                [[BLEManager sharedManager] connectingPeripheral:periperal]; //连接设备
                
                [SVProgressHUD showWithStatus:LocationLanguage(@"connecting", @"正在连接")];
            }
        }
    }
}

- (void)scanStart:(UIBarButtonItem *)item {
//	[[BLEManager sharedManager]disableBLEManager]; //断开蓝牙
	[[BLEManager sharedManager] scanningForPeripherals];//开始扫描
	[SVProgressHUD show];//转圈
}


#pragma mark --根据蓝牙设备数据设置tableview
- (void)setTableView {
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout               = UIRectEdgeNone;

    dataSource                                = [[NSMutableArray alloc]init];//加入数据源
    
    dataSource_1                  = [[NSMutableArray alloc]init];//数据源
    dataSource_2                  = [[NSMutableArray alloc]init];//数据源
    dataSource_3                  = [[NSMutableArray alloc]init];//数据源
    


    blueListTableview                         = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-50) style:UITableViewStylePlain];
    blueListTableview.delegate                = self;
    blueListTableview.dataSource              = self;
    blueListTableview.tableFooterView         = [[UIView alloc]init];
	[self.view addSubview:blueListTableview];
	//让底部不被遮挡
	blueListTableview.autoresizingMask  = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return LocationLanguage(@"connectionDevices", @"当前连接设备");
    }else if(section == 1) {
        return LocationLanguage(@"historyDevices", @"连接过的设备");
    }else {
        return LocationLanguage(@"availableDevices", @"可用设备");
    }
}
-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return dataSource_1.count;
    }else if(section == 1) {
        return dataSource_2.count;
    }else{
        return dataSource_3.count;
    }
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MainBlueCell cellHeight] ;
}
//设置tableview cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainBlueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainBlueCell"];
    //需要捕获的数据处理
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MainBlueCell" owner:self options:nil] lastObject];
        cell.backgroundColor = [UIColor whiteColor];
    }
    if (indexPath.section == 0) {
        BlueTouchDevice *p = dataSource_1[indexPath.row]; // 获取到已连接的设备
        cell.nameLabel.text = [NSString stringWithFormat:@"%@",p.nickname];//将设备名显示到cell
        cell.servicesLabel.text = [NSString stringWithFormat:@"%@",p.identifier];
        cell.stateLabel.hidden = NO;
    }else if(indexPath.section == 1) {
        BlueTouchDevice *p = dataSource_2[indexPath.row];   //获取到连接过的设备
        cell.nameLabel.text = [NSString stringWithFormat:@"%@",p.nickname];//将设备名显示到cell
        cell.servicesLabel.text = [NSString stringWithFormat:@"%@",p.identifier];
        cell.stateLabel.hidden = YES;
    }else if(indexPath.section == 2) {
        BlueTouchDevice *p = dataSource_3[indexPath.row];   //获取到可用的设备
        cell.nameLabel.text = [NSString stringWithFormat:@"%@",p.nickname];//将设备名显示到cell
        cell.servicesLabel.text = [NSString stringWithFormat:@"%@",p.identifier];
        cell.stateLabel.hidden = YES;
    }
    return cell;
}

-(void)longPressedAct:(UILongPressGestureRecognizer *)gestureRecognizer {
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"ssseeeeee");
        CGPoint point = [gestureRecognizer locationInView:blueListTableview];
        NSIndexPath * indexPath = [blueListTableview indexPathForRowAtPoint:point];
        
        NSInteger index = indexPath.row;
        NSInteger section = indexPath.section;
        
        ZYInputAlertView *alertView = [ZYInputAlertView alertView];
        alertView.placeholder = LocationLanguage(@"pleaseRename", @"请输入名称");
        
        [alertView confirmBtnClickBlock:^(NSString *inputString) {
            if(inputString.length == 0) {
                [SVProgressHUD showErrorWithStatus:LocationLanguage(@"nameNotEmpty", @"名称不能为空")];
                [alertView.inputTextView becomeFirstResponder];
                return;
            }
            if(inputString.length > 10) {
                [SVProgressHUD showErrorWithStatus:LocationLanguage(@"max20", @"蓝牙名称不能超过10个汉字")];
                [alertView.inputTextView becomeFirstResponder];
                return;
            }
            NSArray *specialStringArray = [@[] mutableCopy];
            NSString * string = @"~,￥,#,&,*,<,>,《,》,(,),[,],{,},【,】,^,@,/,￡,¤,,|,§,¨,「,」,『,』,￠,￢,￣,（,）,——,+,|,$,_,€,¥,[,`,~,!,@,#,$,%,^,&,*,(,),+,=,|,{,},',:,;,',,\,\,[,\,\,],.,<,>,/,?,~,！,@,#,￥,%,……,&,*,（,）,——,+,|,{,},【,】,‘,；,：,”,“,’,。,，,、";
            specialStringArray = [string componentsSeparatedByString:@","];
            //    NSString * intriduction = self.textField.text;
            for (NSInteger i = 0; i < specialStringArray.count; i ++) {
                //判断字符串中是否含有特殊符号
                if ([inputString rangeOfString:specialStringArray[i]].location != NSNotFound) {
                    [SVProgressHUD showErrorWithStatus:LocationLanguage(@"notAllowed", @"不能输入特殊字符")];
                    [alertView.inputTextView becomeFirstResponder];
                    return;
                }
            }
            NSString *params2 =[NSString stringWithFormat:@"_nickname='%@' ",inputString];
            NSMutableArray *dataSource_db2 = [_tool selectWithClass:[BlueTouchDevice class] params:params2];
            if(dataSource_db2.count > 0) {
                [SVProgressHUD showErrorWithStatus:LocationLanguage(@"nameExists", @"蓝牙名称不能重复")];
                [alertView.inputTextView becomeFirstResponder];
                return;
            }
            BlueTouchDevice *db_periperal;
            if (section == 0) {
                NSLog(@"选择是设备：%@",[dataSource_1 objectAtIndex:index]);
                db_periperal = [dataSource_1 objectAtIndex:index];
                db_periperal.nickname =inputString;
            }else if (section == 1) {
                NSLog(@"选择是设备：%@",[dataSource_2 objectAtIndex:index]);
                db_periperal = [dataSource_2 objectAtIndex:index];
                db_periperal.nickname =inputString;
            }else if (section == 2) {
                NSLog(@"选择是设备：%@",[dataSource_3 objectAtIndex:index]);
                db_periperal = [dataSource_3 objectAtIndex:index];
                db_periperal.nickname =inputString;
            }
            if (db_periperal.identifier.length > 0) {
                NSString *params1 =[NSString stringWithFormat:@" update BlueTouchDevice set _nickname = '%@' where _identifier='%@' and (_type='%@' or _type='%@' or _type='%@' )",inputString, db_periperal.identifier,@"1",@"2",@"3"];
                [_tool execSql:params1];
                           
                [self getDateSouce];
                [blueListTableview reloadData];
            }
        }];
        [alertView show];
    }else if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"lostllllllll");
    }
}

#pragma mark-- tableview点击连接事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return;
    }else if(indexPath.section == 1) {
        _cellsection = indexPath.section;
        _cellrow = indexPath.row;
        [SVProgressHUD dismiss];//结束转圈
        
        NSInteger index = indexPath.row;
        if(index == -1){
            [[BLEManager sharedManager] stopScanningForPeripherals];//停止扫描
            return;
        }
        NSLog(@"选择是设备：%@",[dataSource_2 objectAtIndex:index]);
        BlueTouchDevice *db_periperal = [dataSource_2 objectAtIndex:index];

        int isdevice = 0;
        for (int i=0;i<dataSource.count;i++) {
            CBPeripheral *periperal= dataSource[i];
            NSLog(@"%@",periperal);
            if([db_periperal.identifier isEqualToString:periperal.identifier.UUIDString]) {
                isdevice = 1;
                NSString *params1 =[NSString stringWithFormat:@"_type='%@'",@"1"];
                [_tool deleteRecordWithClass:[BlueTouchDevice class] params:params1];
                
                BlueTouchDevice *device = [BlueTouchDevice initidentifier:periperal.identifier.UUIDString name:periperal.name nickname:db_periperal.nickname state:@"disconnected" type:@"1"];
                [_tool insertWithObj:device];
                
                [[BLEManager sharedManager] disConnected];//断开设备
                [BLEManager sharedManager].periperal = periperal;
                [[BLEManager sharedManager] connectingPeripheral:periperal];//连接设备
                
                [SVProgressHUD showWithStatus:LocationLanguage(@"connecting", @"正在连接")];
            }
        }
        if(isdevice == 0) {
            [SVProgressHUD showErrorWithStatus: LocationLanguage(@"notSupportBluetooth", @"当前蓝牙不可用")];
        }
    }else if(indexPath.section == 2) {
        _cellsection = indexPath.section;
        _cellrow = indexPath.row;
        [SVProgressHUD dismiss];//结束转圈
        
        NSInteger index = indexPath.row;
        if(index == -1){
            [[BLEManager sharedManager] stopScanningForPeripherals];//停止扫描
            return;
        }

        NSLog(@"选择是设备：%@",[dataSource_3 objectAtIndex:index]);
        BlueTouchDevice *db_periperal = [dataSource_3 objectAtIndex:index];

        int isdevice = 0;
        for (int i=0;i<dataSource.count;i++) {
            CBPeripheral *periperal= dataSource[i];
            NSLog(@"%@",periperal);

            if([db_periperal.identifier isEqualToString:periperal.identifier.UUIDString]) {
                NSString *params2 =[NSString stringWithFormat:@"_type='%@' and _identifier='%@' ",@"2",periperal.identifier.UUIDString];
                NSMutableArray *dataSource_db2 = [_tool selectWithClass:[BlueTouchDevice class] params:params2];
                if(dataSource_db2.count == 0) {
                    BlueTouchDevice *device3 = [BlueTouchDevice initidentifier:periperal.identifier.UUIDString name:periperal.name nickname:db_periperal.nickname state:@"disconnected" type:@"2"];
                    [_tool insertWithObj:device3];
                }
                isdevice = 1;
                
                NSString *params1 =[NSString stringWithFormat:@"_type='%@'",@"1"];
                [_tool deleteRecordWithClass:[BlueTouchDevice class] params:params1];
                
                BlueTouchDevice *device = [BlueTouchDevice initidentifier:periperal.identifier.UUIDString name:periperal.name  nickname:db_periperal.nickname state:@"disconnected" type:@"1"];
                [_tool insertWithObj:device];
                                
                [[BLEManager sharedManager] disConnected]; //断开设备
                [BLEManager sharedManager].periperal = periperal;
                [[BLEManager sharedManager] connectingPeripheral:periperal]; //连接设备

                [SVProgressHUD showWithStatus:LocationLanguage(@"connecting", @"正在连接")];
            }
        }
        if (isdevice == 0) {
            [SVProgressHUD showErrorWithStatus: LocationLanguage(@"notSupportBluetooth", @"当前蓝牙不可用")];
        }
    }
}

#pragma mark --蓝牙连接完成
- (void)BLEManagerDidConnectPeripheral:(CBPeripheral *)peripheral {
    _clickcount = 1;
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:LocationLanguage(@"successfulConnection", @"连接成功")];
    //扫描当前连接的蓝牙设备的所有服务
    [[BLEManager sharedManager] scanningForServicesWithPeripheral:peripheral];
    
    currentConnectedDevice = nil;
    
    BlueTouchDevice *db_periperal;
    // 1：从 dataSource_2 中查找
    for (int i = 0; i < dataSource_2.count; i++) {
        db_periperal = [dataSource_2 objectAtIndex:i];
        if (![db_periperal.identifier isEqualToString:peripheral.identifier.UUIDString]) {
            continue;
        }
        for (int j = 0; j < dataSource.count; j++) {
           CBPeripheral *periperal = dataSource[j];
           NSLog(@"%@",periperal);
           if([db_periperal.identifier isEqualToString:periperal.identifier.UUIDString]) {
               NSString *params1 =[NSString stringWithFormat:@"_type='%@'",@"1"];
               [_tool deleteRecordWithClass:[BlueTouchDevice class] params:params1];
               
               BlueTouchDevice *device = [BlueTouchDevice initidentifier:periperal.identifier.UUIDString name:periperal.name nickname:db_periperal.nickname state:@"disconnected" type:@"1"];
               [_tool insertWithObj:device];
           }
       }
    }
    // 2：从 dataSource_3 中查找
    for (int i = 0; i < dataSource_3.count; i++) {
        db_periperal = [dataSource_3 objectAtIndex:i];
        if (![db_periperal.identifier isEqualToString:peripheral.identifier.UUIDString]) {
            continue;
        }
        for (int j = 0; j < dataSource.count; j++) {
            CBPeripheral *periperal= dataSource[j];
            NSLog(@"%@",periperal);
            if([db_periperal.identifier isEqualToString:periperal.identifier.UUIDString]) {
                NSString *params1 =[NSString stringWithFormat:@"_type='%@'",@"1"];
                [_tool deleteRecordWithClass:[BlueTouchDevice class] params:params1];
                
                BlueTouchDevice *device = [BlueTouchDevice initidentifier:periperal.identifier.UUIDString name:periperal.name  nickname:db_periperal.nickname state:@"disconnected" type:@"1"];
                [_tool insertWithObj:device];
                
                NSString *params2 =[NSString stringWithFormat:@"_type='%@' and _identifier='%@' ",@"2",periperal.identifier.UUIDString];
                NSMutableArray *dataSource_db2 = [_tool selectWithClass:[BlueTouchDevice class] params:params2];
                if(dataSource_db2.count==0) {
                    BlueTouchDevice *device3 = [BlueTouchDevice initidentifier:periperal.identifier.UUIDString name:periperal.name nickname:db_periperal.nickname state:@"disconnected" type:@"2"];
                    [_tool insertWithObj:device3];
                }
            }
        }
    }
    
    [self getDateSouce];
    [blueListTableview reloadData];
}

- (void)BLEManagerReceiveAllService:(CBService *)service {
//    [thisServices addObject:service];
//    [thisServiceTableView reloadData];
}


# pragma mark - BLEManager Methods
- (void)BLEManagerDisabledDelegate {
	
}

#pragma mark --接收到扫描到得所有设备
- (void)BLEManagerReceiveAllPeripherals:(NSMutableArray *)peripherals
                      andAdvertisements:(NSMutableArray *)advertisements {
    
	[SVProgressHUD dismiss];//结束转圈
    
    NSString *params3 =[NSString stringWithFormat:@"_type='%@'",@"3"];
    [_tool deleteRecordWithClass:[BlueTouchDevice class] params:params3];
    
    NSString *params2 =[NSString stringWithFormat:@"_type='%@'",@"2"];
    dataSource_2 = [_tool selectWithClass:[BlueTouchDevice class] params:params2];
    
    for(int i = 0; i < peripherals.count; i++) {
        CBPeripheral *periperal= peripherals[i];
        NSLog(@"%@",periperal);
        
        int isxiangtong =0;
        NSString *nickname=@"";
        for(int j = 0; j < dataSource_2.count; j++) {
            BlueTouchDevice *device2 = dataSource_2[j];
            NSLog(@"%@",device2);
            if([periperal.identifier.UUIDString isEqualToString:device2.identifier]) {
                isxiangtong =1;
                nickname =device2.nickname;
            }
        }
        if(isxiangtong == 1) {
            BlueTouchDevice *device = [BlueTouchDevice initidentifier:periperal.identifier.UUIDString name:periperal.name nickname:nickname state:@"disconnected" type:@"3"];
            [_tool insertWithObj:device];
        }else{
            BlueTouchDevice *device = [BlueTouchDevice initidentifier:periperal.identifier.UUIDString name:periperal.name nickname:periperal.name state:@"disconnected" type:@"3"];
            [_tool insertWithObj:device];
        }
        
        // 自动连接1：连接上次连接过的设备
        if ([BLEManager sharedManager].currentPeriperal == nil &&
            _isLinking == NO &&
            [BLEManager sharedManager].is_autoLink) {
            NSString *deviceId = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastDeviceIdentifier"];
            if ([deviceId isKindOfClass:[NSString class]] && deviceId.length > 0) {
                if ([periperal.identifier.UUIDString isEqualToString:deviceId]) {
                    // 连接
                    _isLinking = YES;
                    [BLEManager sharedManager].periperal = periperal;
                    [[BLEManager sharedManager] connectingPeripheral:periperal]; //连接设备

                    [SVProgressHUD showWithStatus:LocationLanguage(@"connecting", @"正在连接")];
                }
            }
        }
    }
    [dataSource addObjectsFromArray:peripherals];//加入数据源
    
    [self getDateSouce];
	[blueListTableview reloadData];
}

#pragma mark --蓝牙连接失败
- (void)BLEManagerDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"蓝牙连接失败，请重新连接");
    currentConnectedDevice = nil;
    [self getDateSouce];
    [blueListTableview reloadData];
    
    [SVProgressHUD showErrorWithStatus: LocationLanguage(@"cluetoothDisconnected", @"蓝牙连接失败，请重新连接")];
}

// 连接成功 + 失败 = 都会走到这里
- (void)setIsLinkSuccess:(BOOL)isLinkSuccess {
    self.navigationItem.leftBarButtonItem.customView.hidden = !isLinkSuccess;
    if (_isSourceSetting) {
        return;
    }
    _isLinkSuccess = isLinkSuccess;
    if (isLinkSuccess) {
        if (self.appStartController == nil) {
            self.appStartController = [[MeitikuViewController alloc] init];
        }
        // 如果不是在控制界面，就不搜索
        if (self.navigationController.topViewController == self.appStartController ||
            self.navigationController.topViewController == self) {
            [self.appStartController.controlVc startSearch];
        }
    }else {
        [self.appStartController.controlVc stopSearch];
        [self.navigationController setViewControllers:@[self]];
        self.appStartController = nil;
        self.isLinking = NO;
    }
}

- (void)dealloc {
    [self removeNotification];
    NSLog(@"%@ --- %s", self, __FUNCTION__);
}
@end
