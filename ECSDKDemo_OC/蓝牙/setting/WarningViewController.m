//
//  LoginVC.m
//  waimaidan2.0
//
//  Created by sunzhf on 13-4-3.
//  Copyright (c) 2013年 qianliqianxun. All rights reserved.
//

#import "WarningViewController.h"
#import "Common2.h"
//#import "CommonHttpRequest.h"
//#import "RegisterVC.h"
//#import "MineViewController.h"
//#import "CommodityInfoViewController.h"
//#import "FindPwdViewController.h"
#import "DBTool.h"
#import "Gaodu.h"
#import "BLEManager.h"

@implementation WarningViewController

//友盟统计
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)setFid:(id)vc
{
    m_fvc = vc;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
	{
		self.title = LocationLanguage(@"alarm", @"报警");
		
		[g_winDic setObject:[NSNumber numberWithInt:1] forKey:[NSString stringWithFormat:@"%@", self]];
		
		UIBarButtonItem *buttonLeft = [Common2 CreateNavBarButton:self setEvent:@selector(LeftBarButtonItemPressed) background:@"btn_back.png" setTitle:nil];
		self.navigationItem.leftBarButtonItem = buttonLeft;

		
	

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
    if(str_name.length == 0) {
        [SVProgressHUD showErrorWithStatus:LocationLanguage(@"nameNotEmpty", @"名称不能为空")];
        [txtName becomeFirstResponder];
        return;
    }
    if(str_height.length == 0) {
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
    
    NSString *strid = [[NSUUID UUID] UUIDString];//随机字符串
    NSString *isIn = [BLEManager sharedManager].is_CM ? @"0" : @"1";
    NSLog(@"%@",strid);
    
    Gaodu *h1 = [Gaodu initName:str_name height:int_height isIn:isIn deviceId:deviceId strid:strid];
    [tool insertWithObj:h1];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{


    [super viewDidLoad];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
	self.view.backgroundColor = [UIColor whiteColor];

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, ScreenWidth*10/320, ScreenWidth*320/320-20, ScreenWidth*60/320)];
    label.text = LocationLanguage(@"system3", @"系统或电机过热，系统无法正常工作");
    
    label.font = [UIFont systemFontOfSize:16.0f];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    label.text =_strTitle;
    [self.view addSubview:label];
    [label sizeToFit];
    
    UIView *view_line = [[UIView alloc] initWithFrame:CGRectMake(0, label.bottom + 10, ScreenWidth*320/320, ScreenWidth*1/320)];
    view_line.backgroundColor =[Common2 colorWithHexString:@"#4F39AA"];
    [self.view addSubview:view_line];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, view_line.bottom + 10, ScreenWidth*320/320-20, 400)];
    label2.text = LocationLanguage(@"system11", @"系统过热，请按照使用说明让系统休息，达到时间后报警自动解除");
    label2.font = [UIFont systemFontOfSize:16.0f];
    label2.numberOfLines = 0;
    label2.textAlignment = NSTextAlignmentLeft;
    label2.text =_strContent;
    [self.view addSubview:label2];
    [label2 sizeToFit];
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

@end
