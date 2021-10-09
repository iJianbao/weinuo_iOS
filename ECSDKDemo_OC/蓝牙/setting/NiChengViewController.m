//
//  LoginVC.m
//  waimaidan2.0
//
//  Created by sunzhf on 13-4-3.
//  Copyright (c) 2013年 qianliqianxun. All rights reserved.
//

#import "NiChengViewController.h"
#import "Common2.h"
//#import "CommonHttpRequest.h"
//#import "RegisterVC.h"
//#import "MineViewController.h"
//#import "CommodityInfoViewController.h"
//#import "FindPwdViewController.h"
//#import "FavoritesViewController.h"

@implementation NiChengViewController

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
		self.title = @"标签";
		
		[g_winDic setObject:[NSNumber numberWithInt:1] forKey:[NSString stringWithFormat:@"%@", self]];
		
		UIBarButtonItem *buttonLeft = [Common2 CreateNavBarButton:self setEvent:@selector(LeftBarButtonItemPressed) background:@"btn_back.png" setTitle:nil];
		self.navigationItem.leftBarButtonItem = buttonLeft;

		
		UIBarButtonItem *buttonRight = [Common2 CreateNavBarButton:self setEvent:@selector(RightBarButtonItemPressed) background:nil setTitle:LocationLanguage(@"save", @"保存")];
		self.navigationItem.rightBarButtonItem = buttonRight;

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
- (void)RightBarButtonItemPressed
{
    NSString *str_tag = m_txtUserName.text;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",str_tag] forKey:@"tag"];

    [[NSUserDefaults standardUserDefaults] synchronize];
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
//    self.view.frame =CGRectMake(0, 0+NavHeight+100, ScreenWidth, ScreenHeight);
	UIImageView *textImageVBack = [[UIImageView alloc] initWithFrame:CGRectMake(8, 15, ScreenWidth*304/320, 50)];
	textImageVBack.userInteractionEnabled = YES;
	textImageVBack.image = [[UIImage imageNamed:@"shurubj.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//	UIView *viewXian = [[UIView alloc] initWithFrame:CGRectMake(0, 51, ScreenWidth*304/320, 0.5)];
//	viewXian.backgroundColor = [Common colorWithHexString:@"#d9d7d7"];
//	[textImageVBack addSubview:viewXian];
//	[viewXian release];
	[self.view addSubview:textImageVBack];
    
//    UILabel *latUserName = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 50, 50)];
//    latUserName.text = @"昵称:";
//    latUserName.font = [UIFont systemFontOfSize:14.0f];
//    latUserName.numberOfLines = 0;
//    latUserName.textAlignment = UITextAlignmentLeft;
//    [latUserName setTextColor:[Common2 colorWithHexString:@"#31302f"]];
//    [self.view addSubview:latUserName];

	
//	UILabel *latUserName = [Common2 createLabel:CGRectMake(16, 0, 50, 50) TextColor:@"#31302f" Font:[UIFont systemFontOfSize:14] textAlignment:UITextAlignmentLeft labTitle:@"昵称:"];
//	[textImageVBack addSubview:latUserName];

    m_txtUserName= [[UITextField alloc] initWithFrame:CGRectMake(16, 15, ScreenWidth*290/320, 50)];
//    UITextField *text = [[UITextField alloc] init];
    m_txtUserName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    m_txtUserName.contentMode = UIViewContentModeCenter;
    m_txtUserName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    m_txtUserName.placeholder = @"请输入标签";
    m_txtUserName.clearButtonMode = UITextFieldViewModeUnlessEditing;
    m_txtUserName.delegate = self;
    [m_txtUserName setTextColor:[Common2 colorWithHexString:@"#31302f"]];
    [m_txtUserName setFont:[UIFont systemFontOfSize:14]];
	
    
//	m_txtUserName = [self createTextField:@"请输入标签"];
	m_txtUserName.returnKeyType = UIReturnKeyDone;
    m_txtUserName.tag = 200;
//	m_txtUserName.frame = CGRectMake(16, 15, ScreenWidth*290/320, 50);
	[self.view addSubview:m_txtUserName];
    
//    m_txtUserName.text= _strName;
	
	[m_txtUserName becomeFirstResponder];
    
//    UIButton *btn_Login = [UIButton buttonWithType:UIButtonTypeCustom];
//	btn_Login.frame = CGRectMake(8, textImageVBack.frame.origin.y + textImageVBack.frame.size.height + 15, ScreenWidth*304/320, 50);
//    UIImage *butBGImage = [UIImage imageNamed:@"img.bundle/login/denglu_button.png"];
////    [btn_Login setBackgroundImage:[butBGImage stretchableImageWithLeftCapWidth:8 topCapHeight:20] forState:UIControlStateNormal];
//    btn_Login.backgroundColor =[UIColor colorWithRed:236/255.0 green:48/255.0 blue:57/255.0 alpha:0.9];
//	[btn_Login setTitleColor:[Common2 colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
//	[btn_Login setTitle:@"保存" forState:UIControlStateNormal];
//	btn_Login.titleLabel.font = [UIFont systemFontOfSize:17];
//    btn_Login.layer.masksToBounds = YES;
//    btn_Login.layer.cornerRadius = 3;
//	[btn_Login addTarget:self action:@selector(Login_handle) forControlEvents:UIControlEventTouchUpInside];
//	[self.view addSubview:btn_Login];
    
//    NSMutableDictionary *dic_user = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
//    if (dic_user) {
//        m_txtUserName.text =[dic_user objectForKey:@"nicheng"];
//	}

    
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
	[m_txtUserName resignFirstResponder];
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

    
    NSString *title = m_txtUserName.text;
//    NSString *imsi  = [dic_uuid objectForKey:@"uuid"];
    NSString *urlString = [NSString stringWithFormat:@"%@userid=%@&title=%@", UPDATE_NICHENG_INTERFACE_URL, userid, title];
//    [[CommonHttpRequest defaultInstance] sendHttpRequest2:urlString encryptStr:UPDATE_NICHENG_INTERFACE_URL delegate:self controller:self actiViewFlag:1];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	switch ([textField tag]) {
		case 200:
			[m_txtUserName becomeFirstResponder];
            NSString *str_tag = m_txtUserName.text;
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
        

       [[NSUserDefaults standardUserDefaults] setObject:m_txtUserName.text forKey:@"nicheng"];
        
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
