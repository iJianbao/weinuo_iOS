//
//  LoginVC.m
//  waimaidan2.0
//
//  Created by sunzhf on 13-4-3.
//  Copyright (c) 2013年 qianliqianxun. All rights reserved.
//

#import "JiyigaoduEditViewController.h"
#import "Common2.h"
//#import "CommonHttpRequest.h"
//#import "RegisterVC.h"
//#import "MineViewController.h"
//#import "CommodityInfoViewController.h"
//#import "FindPwdViewController.h"
#import "DBTool.h"
#import "Gaodu.h"
#import "BLEManager.h"

@implementation JiyigaoduEditViewController

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
		self.title = LocationLanguage(@"edit", @"高度修改");
		
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
- (void)RightBarButtonItemPressed {
    
    NSString *str_name = txtName.text;
    NSString *str_height = [txtGaodu.text stringByReplacingOccurrencesOfString:@"," withString:@"."];
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
    // 1: 如果当前是 cm
    CGFloat saveHeight = 0;
    if ([BLEManager sharedManager].is_CM) {
        saveHeight = [BLEManager isCmHeightNum:str_height];
        if (saveHeight == 0) {
            NSString *cmMinStr = [BLEManager floatHeight:[BLEManager sharedManager].minHeight
                                                  needCm:[BLEManager sharedManager].is_CM];
            NSString *cmMaxStr = [BLEManager floatHeight:[BLEManager sharedManager].maxHeight
                                                  needCm:[BLEManager sharedManager].is_CM];
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@ %@ - %@", LocationLanguage(@"pleaseInputCorrectHeight", @"请输入正确的高度,范围为"), cmMinStr, cmMaxStr]];
            return;
        }
    }else {
        // 2: 当前是 in
        saveHeight = [BLEManager isInHeightNum:str_height];
        if (saveHeight == 0) {
            NSString *inMinStr = [BLEManager floatHeight:[BLEManager sharedManager].inMinHeight
                                                  needCm:[BLEManager sharedManager].is_CM];
            NSString *inMaxStr = [BLEManager floatHeight:[BLEManager sharedManager].inMaxHeight
                                                  needCm:[BLEManager sharedManager].is_CM];
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@ %@ - %@", LocationLanguage(@"pleaseInputCorrectHeight", @"请输入正确的高度,范围为"), inMinStr, inMaxStr]];
            return;
        }
    }

    DBTool *tool = [DBTool sharedDBTool];
    NSString *deviceId = @"";
    if ([BLEManager sharedManager].currentPeriperal) {
        deviceId = [BLEManager sharedManager].currentPeriperal.identifier.UUIDString;
    }
    [tool createTableWithClass:[Gaodu class]];
    NSString *strid = [[NSUUID UUID] UUIDString];//随机字符串
    NSString *isIn = [BLEManager sharedManager].is_CM ? @"0" : @"1";
    NSLog(@"保存记忆高度%@, %@",strid, isIn);
    Gaodu *h1 = [Gaodu initName:str_name height:saveHeight isIn:isIn deviceId:deviceId strid:strid];
    [tool updateWithObj:h1 andKey:@"strid" isEqualValue:_strID];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)) {
        self.navigationController.navigationBar.translucent = NO;
    }
	self.view.backgroundColor = [UIColor whiteColor];
    
	UIImageView *textImageVBack_mingcheng = [[UIImageView alloc] initWithFrame:CGRectMake(8, 15, ScreenWidth*304/320, 50)];
	textImageVBack_mingcheng.userInteractionEnabled = YES;
	textImageVBack_mingcheng.image = [[UIImage imageNamed:@"shurubj.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];

	[self.view addSubview:textImageVBack_mingcheng];
    
    UILabel *label_mingchengname = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 80, 50)];
    label_mingchengname.text = LocationLanguage(@"heightName", @"名称");
    label_mingchengname.textColor = [Common2 colorWithHexString:@"#000000"];
    label_mingchengname.tintColor = [Common2 colorWithHexString:@"#000000"];
    label_mingchengname.font = [UIFont systemFontOfSize:14.0f];
    label_mingchengname.numberOfLines = 0;
    label_mingchengname.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label_mingchengname];

    txtName= [[UITextField alloc] initWithFrame:CGRectMake(66, 17, ScreenWidth*200/320, 50)];
//    UITextField *text = [[UITextField alloc] init];
    txtName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtName.contentMode = UIViewContentModeCenter;
    txtName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txtName.placeholder = LocationLanguage(@"inputName", @"请输入名称");
    txtName.clearButtonMode = UITextFieldViewModeUnlessEditing;
    txtName.delegate = self;
    [txtName setTextColor:[Common2 colorWithHexString:@"#31302f"]];
    [txtName setFont:[UIFont systemFontOfSize:14]];
//	m_txtUserName = [self createTextField:@"请输入标签"];
	txtName.returnKeyType = UIReturnKeyDone;
    txtName.tag = 200;
//	m_txtUserName.frame = CGRectMake(16, 15, ScreenWidth*290/320, 50);
	[self.view addSubview:txtName];
    
//    m_txtUserName.text= _strName;
	
	[txtName becomeFirstResponder];
    
    UIImageView *textImageVBack_gaodu = [[UIImageView alloc] initWithFrame:CGRectMake(8, 15+60, ScreenWidth*304/320, 50)];
    textImageVBack_gaodu.userInteractionEnabled = YES;
    textImageVBack_gaodu.image = [[UIImage imageNamed:@"shurubj.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    
    [self.view addSubview:textImageVBack_gaodu];
    
    UILabel *label_dangqiangaoduname = [[UILabel alloc] initWithFrame:CGRectMake(15, 15+60, 80, 50)];
    label_dangqiangaoduname.text =  LocationLanguage(@"heightCount", @"高度");
    label_dangqiangaoduname.textColor = [Common2 colorWithHexString:@"#000000"];
    label_dangqiangaoduname.tintColor = [Common2 colorWithHexString:@"#000000"];
    label_dangqiangaoduname.font = [UIFont systemFontOfSize:14.0f];
    label_dangqiangaoduname.numberOfLines = 0;
    label_dangqiangaoduname.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label_dangqiangaoduname];
    
    txtGaodu= [[UITextField alloc] initWithFrame:CGRectMake(66, 17+60, ScreenWidth*200/320, 50)];
    //    UITextField *text = [[UITextField alloc] init];
    txtGaodu.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtGaodu.contentMode = UIViewContentModeCenter;
    txtGaodu.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txtGaodu.placeholder = LocationLanguage(@"pleaseEnterHeight", @"请输入高度");
    txtGaodu.clearButtonMode = UITextFieldViewModeUnlessEditing;
    txtGaodu.delegate = self;
    [txtGaodu setTextColor:[Common2 colorWithHexString:@"#31302f"]];
    [txtGaodu setFont:[UIFont systemFontOfSize:14]];
    txtGaodu.keyboardType = UIKeyboardTypeDecimalPad;
    //	m_txtUserName = [self createTextField:@"请输入标签"];
    txtGaodu.returnKeyType = UIReturnKeyDone;
    txtGaodu.tag = 200;
    //	m_txtUserName.frame = CGRectMake(16, 15, ScreenWidth*290/320, 50);
    [self.view addSubview:txtGaodu];
    
    //    m_txtUserName.text= _strName;
    
    [txtGaodu becomeFirstResponder];
    
    
    UILabel *label_dangqiangaodu = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-60, 15+60, 80, 50)];
    label_dangqiangaodu.text = [BLEManager sharedManager].is_CM ? @"cm" : @"IN";
    label_dangqiangaodu.textColor = [Common2 colorWithHexString:@"#000000"];
    label_dangqiangaodu.tintColor = [Common2 colorWithHexString:@"#000000"];
    label_dangqiangaodu.font = [UIFont systemFontOfSize:18.0f];
    label_dangqiangaodu.numberOfLines = 0;
    label_dangqiangaodu.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label_dangqiangaodu];
    
    
    txtName.text =_strName;
    txtGaodu.text =_strGaodu;
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	switch ([textField tag]) {
		case 200:
            [self RightBarButtonItemPressed];
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
