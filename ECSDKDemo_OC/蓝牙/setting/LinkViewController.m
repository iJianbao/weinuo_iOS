//
//  LoginVC.m
//  waimaidan2.0
//
//  Created by sunzhf on 13-4-3.
//  Copyright (c) 2013年 qianliqianxun. All rights reserved.
//

#import "LinkViewController.h"
#import "Common2.h"
//#import "CommonHttpRequest.h"
//#import "RegisterVC.h"
//#import "MineViewController.h"
//#import "CommodityInfoViewController.h"
//#import "FindPwdViewController.h"
#import "DBTool.h"
#import "Gaodu.h"
#import "ToolViewController.h"
#import "MainBlueTouchViewController.h"
#import "LinkViewController.h"
#import "AppDelegate.h"

@implementation LinkViewController

//友盟统计
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
}

- (void)setFid:(id)vc {
    m_fvc = vc;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = LocationLanguage(@"smartDeskControl", @"智能升降桌");
		
		[g_winDic setObject:[NSNumber numberWithInt:1] forKey:[NSString stringWithFormat:@"%@", self]];
		
//        UIBarButtonItem *buttonLeft = [Common2 CreateNavBarButton:self setEvent:@selector(LeftBarButtonItemPressed) background:@"btn_back.png" setTitle:nil];
//        self.navigationItem.leftBarButtonItem = buttonLeft;
    }
    return self;
}

//点击返回按钮返回主界面
- (void)LeftBarButtonItemPressed
{
//	[self HideKeyboard];
	[self.navigationController popViewControllerAnimated:YES];
}

//注册页面
- (void)RightBarButtonItemPressed {
    NSString *str_name = txtName.text;
    NSString *str_height = txtGaodu.text;
    if(str_name.length==0)
    {
        [SVProgressHUD showErrorWithStatus:LocationLanguage(@"nameNotEmpty", @"名称不能为空")];
        [txtName becomeFirstResponder];
        return;
    }
    if(str_height.length==0)
    {
        [SVProgressHUD showErrorWithStatus:LocationLanguage(@"pleaseEnterHeight", @"请输入高度")];
        [txtGaodu becomeFirstResponder];
        return;
    }
    
    DBTool *tool = [DBTool sharedDBTool];
    NSString *deviceId = @"";
    if ([BLEManager sharedManager].currentPeriperal) {
        deviceId = [BLEManager sharedManager].currentPeriperal.identifier.UUIDString;
    }
    int int_height = [str_height intValue];
    
    [tool createTableWithClass:[Gaodu class]];
    
    NSString *isIn = [BLEManager sharedManager].is_CM ? @"0" : @"1";
    NSString *strid = [[NSUUID UUID] UUIDString];//随机字符串
    NSLog(@"%@",strid);
    Gaodu *h1 = [Gaodu initName:str_name height:int_height isIn:isIn deviceId:deviceId strid:strid];
    [tool insertWithObj:h1];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
	self.view.backgroundColor = [Common2 colorWithHexString:@"#2B2B73"];

    
    UIImageView *imageView_error = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-ScreenWidth*120/320)/2, ScreenWidth*80/320, ScreenWidth*120/320, ScreenWidth*120/320)];
    [imageView_error setImage:[UIImage imageNamed:LocationLanguage(@"pic_disconnected_error", @"pic_disconnected_error")]];
    [self.view addSubview:imageView_error];
    
    
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, ScreenWidth*160/320, [UIScreen mainScreen].bounds.size.width-80.0f*2, 60.0f)];
//    label.text = @"当前未连接升降桌～";
//    label.textColor = [Common2 colorWithHexString:@"#ffffff"];
//    label.font = [UIFont systemFontOfSize:14.0f];
//    label.numberOfLines = 0;
//    label.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:label];
    
    
    UIButton *btn_link = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_link.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 150.0f)/2, ScreenWidth*220/320, 150.0f, 45.0f);
    [btn_link setTitle:LocationLanguage(@"to_connected", @"连接") forState:UIControlStateNormal];
    [btn_link setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn_link.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn_link.layer.borderColor = [UIColor whiteColor].CGColor;
    btn_link.layer.borderWidth = 1;
    [btn_link addTarget:self action:@selector(LinkClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn_link];
    
    
    
//    UIButton *btn_link2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn_link2.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-150.0f)/2, ScreenWidth*320/320, 150.0f, 45.0f);
//    [btn_link2 setImage:[UIImage imageNamed:@"btn_disconnected_go.png"] forState:UIControlStateNormal];
//    [btn_link2 addTarget:self action:@selector(LinkClicked2) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.view addSubview:btn_link2];
    
    
//    if(![BLEManager sharedManager].isConnecting){
//        return;
//    }
//    [BLEManager sharedManagerWithDelegate:self];//初始化
//    [BLEManager sharedManager].delegate  =self;
    
    

   }

- (void)LinkClicked {
//    [[AppDelegate shareInstance] registerLocalNotification:@"600"];
    [[BLEManager sharedManager] disableBLEManager];
    MainBlueTouchViewController *videoRender = [[MainBlueTouchViewController alloc] init];
    videoRender.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:videoRender animated:YES];
}

- (void)LinkClicked2
{
    ToolViewController *videoRender = [[ToolViewController alloc] init];
    videoRender.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:videoRender animated:YES];
    
}

- (UITextField*)createTextField:(NSString*)title
{
	UITextField *text = [[UITextField alloc] init];
	text.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	text.contentMode = UIViewContentModeCenter;
	text.autocapitalizationType = UITextAutocapitalizationTypeNone;
	text.placeholder = title;
	text.clearButtonMode = YES;
	text.delegate = self;
	[text setTextColor:[Common2 colorWithHexString:@"#31302f"]];
	[text setFont:[UIFont systemFontOfSize:14]];
	
	return text;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//	NSCharacterSet *cs;
//	cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
//	NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//	BOOL basic = [string isEqualToString:filtered];
//	return basic;
//}

- (void)HideKeyboard
{
	[txtName resignFirstResponder];
//	[m_txtPassWord resignFirstResponder];
}

//登录请求服务器
- (void)Login_handle
{
//    if (m_txtUserName.text.length == 0) {
//        [Common TipDialog:@"手机不能为空"];
//        return;
//    } else if (m_txtPassWord.text.length == 0) {
//        [Common TipDialog:@"密码不能为空"];
//        return;
//    }
//    [self HideKeyboard];
//	
////	NSMutableDictionary *dic = [INTERFACE_LOGIN_URL JSONValue];
////	[dic setObject:m_txtUserName.text forKey:@"mobile"];
////	[dic setObject:m_txtPassWord.text forKey:@"password"];
////    [[CommonHttpRequest defaultInstance] sendHttpRequest:dic encryptStr:ENCRYPT_MEMBER_LOGIN delegate:self controller:self actiViewFlag:1];
////    NSString *name = m_txtUserName.text;
////    NSString *pwd  = m_txtPassWord.text;
//    
//    NSString *name = @"sunzhf1982@163.com";
//    NSString *pwd  = @"e10adc3949ba59abbe56e057f20f883e";
//    NSString *urlString = [NSString stringWithFormat:@"%@&name=%@&pwd=%@", GETLOGIN_INTERFACE_URL, name, pwd];
//    [[CommonHttpRequest defaultInstance] sendHttpRequest2:urlString encryptStr:ENCRYPT_MEMBER_LOGIN delegate:self controller:self actiViewFlag:1];
//    
//    NSMutableDictionary* infoDict = [[[NSMutableDictionary alloc]init] autorelease];
//    [infoDict setObject:m_txtUserName.text forKey:@"nicheng"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushSelectNicheng" object:nil userInfo:infoDict];
//    [self.navigationController popViewControllerAnimated:YES];
    
    
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];

    
    NSString *title = txtName.text;
//    NSString *imsi  = [dic_uuid objectForKey:@"uuid"];
    NSString *urlString = [NSString stringWithFormat:@"%@userid=%@&title=%@", UPDATE_NICHENG_INTERFACE_URL, userid, title];
//    [[CommonHttpRequest defaultInstance] sendHttpRequest2:urlString encryptStr:UPDATE_NICHENG_INTERFACE_URL delegate:self controller:self actiViewFlag:1];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	switch ([textField tag]) {
		case 200:
			[txtName becomeFirstResponder];
            NSString *str_tag = txtName.text;
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",str_tag] forKey:@"tag"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.navigationController popViewControllerAnimated:YES];
			break;
		
	}
	return YES;
}

- (IBAction)getPasswordClickButton:(id)sender
{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.waimaidan.com/index.php?c=member&a=lostpw"]];
	
	[self HideKeyboard];
    
//    RegisterVC *controller = [[RegisterVC alloc] init];
//	[controller setFid:m_fvc];
//    [self.navigationController pushViewController:controller animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)didFinishSuccess:(ASIHTTPRequest *)loader
{
//     [self.navigationController popViewControllerAnimated:YES];
    if ([[loader.userInfo objectForKey:@"type"] isEqualToString:UPDATE_NICHENG_INTERFACE_URL])
    {
        NSString *responseString = [loader responseString];
        NSDictionary *dictionary = [responseString JSONValue];
        NSArray *array = [dictionary objectForKey:@"items"];
        NSMutableDictionary *dic = [array objectAtIndex:0];
        NSLog(@"%@",dic);
        

       [[NSUserDefaults standardUserDefaults] setObject:txtName.text forKey:@"nicheng"];
        
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfo"];
//        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"userInfo"];
        
        
//        NSMutableDictionary* infoDict = [[[NSMutableDictionary alloc]init] autorelease];
//        [infoDict setObject:m_txtUserName.text forKey:@"nicheng"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushSelectNicheng" object:nil userInfo:infoDict];
        [self.navigationController popViewControllerAnimated:YES];
   
    }

   
}
- (void) didFinishFail:(ASIHTTPRequest *)loader{
    [Uitil TipDialog:NETWORK_CONNECT_FAIL_MSG];
}

*/
- (void)dealloc
{
	[g_winDic removeObjectForKey:[NSString stringWithFormat:@"%@", self]];
	

	

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
    
}

@end
