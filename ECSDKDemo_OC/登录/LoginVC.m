//
//  LoginVC.m
//  YiZanService
//
//  Created by ljg on 15-3-20.
//  Copyright (c) 2015年 zywl. All rights reserved.
//

#import "LoginVC.h"
#import "LoginView.h"
#import "RegisterVC.h"
#import "IQKeyboardManager.h"
#import "Common2.h"
#import "Global.h"



#import "CommonHttpRequest.h"
#import "RegisterVC.h"
#import "SVProgressHUD.h"


#import "RegTwoViewController.h"

#import "ShangchengRcommandDataTool.h"
#import "MyMD5.h"

#import "GetPwdVC.h"


#define ADDNavigitionHeight             64

#define ADDHeight             180

@interface LoginVC ()<UITextFieldDelegate>
{
    LoginView *loginView;
    
    NSTimer   *timer;
    int ReadSecond;
}
@property (nonatomic,strong) ShangchengRcommandDataTool *tool;
@end

@implementation LoginVC

- (ShangchengRcommandDataTool *)tool{
    if (_tool == nil) {
        _tool = [[ShangchengRcommandDataTool alloc]init];
        
    }
    return _tool;
}

- (void)layoutNavigation {
    
    UIView *viewNavigation = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 64)];
    viewNavigation.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewNavigation];
    
    
//    UIButton *btn_left = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn_left.frame = CGRectMake(5,10, 40, 40);
//    [btn_left setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    [btn_left setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateHighlighted];
//    [btn_left addTarget:self action:@selector(leftBarClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [viewNavigation addSubview:btn_left];
    
    UILabel * labelcenter = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-90,10, 180, 40)];
    labelcenter.backgroundColor =[UIColor clearColor];
    labelcenter.font = [UIFont boldSystemFontOfSize:18];
    labelcenter.textColor =[Common2 colorWithHexString:@"#ffffff"];
    labelcenter.text = CustomLocalizedString(@"denglu", nil);//@"登录";
    labelcenter.textAlignment= NSTextAlignmentCenter;
    [viewNavigation addSubview:labelcenter];
    
//    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn_right.frame = CGRectMake(ScreenWidth-40-5,10, 40, 40);
//    [btn_right setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    [btn_right setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateHighlighted];
//    [btn_right addTarget:self action:@selector(rightBarClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [viewNavigation addSubview:btn_right];
    
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



- (void)setFid:(id)vc
{
    m_fvc = vc;
}

//返回按钮
- (void)LeftBarButtonItemPressed
{
      [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController dismissModalViewControllerAnimated:YES];
    
//    [self.navigationController popViewControllerAnimated:YES];
//    RegTwoViewController *login = [[RegTwoViewController alloc] init];
//    [self.navigationController pushViewController:login animated:YES];
}

//搜索页面
- (void)RightBarButtonItemPressed
{
    
    RegisterVC *login = [[RegisterVC alloc] init];
    [self.navigationController pushViewController:login animated:YES];
    
    
}
-(void)loadView
{
//    self.hiddenTabBar = YES;
    [super loadView];
//    self.hiddenBackBtn = YES;
//    self.navBar.rightBtn.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"登录"];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    self.navigationController.navigationBarHidden = YES;
    [self layoutNavigation];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"登录"];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [Common2 colorWithHexString:@"#1685ED"];
    
    
    [[ECDevice sharedInstance] setPrivateCloudCompanyId:nil andCompanyPwd:nil];
    
//    self.Title =@"登录";
    // Do any additional setup after loading the view.
//    self.mPageName = @"登录";
    CGRect rect = self.view.frame;
    rect.origin.y +=100;
    self.view.frame = rect;
//    self.rightBtnTitle = @"注册";
    
    ReadSecond = 61;

    loginView = (LoginView*)[[[NSBundle mainBundle]loadNibNamed:@"LoginVC" owner:self options:nil]objectAtIndex:0];
    
//    loginView = [LoginView shareView];
    
    loginView.phoneView.layer.masksToBounds = YES;
    loginView.phoneView.layer.cornerRadius = 6;
    loginView.passView.layer.masksToBounds = YES;
    loginView.passView.layer.cornerRadius = 6;
    loginView.loginBtn.layer.masksToBounds = YES;
    loginView.loginBtn.layer.cornerRadius = 6;
    
    loginView.inputphone.clearButtonMode = UITextFieldViewModeUnlessEditing;
    loginView.inputpasswd.clearButtonMode = UITextFieldViewModeUnlessEditing;
    
    loginView.yanzhengmaBtn.layer.masksToBounds = YES;
    loginView.yanzhengmaBtn.layer.cornerRadius = 6;
    
    loginView.yanzhengmaView.layer.masksToBounds = YES;
    loginView.yanzhengmaView.layer.cornerRadius = 6;
    
    
    [self.view addSubview:loginView];
    [loginView.loginBtn addTarget:self action:@selector(loginBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
    [loginView.forgetBtn addTarget:self action:@selector(forgetBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
    [loginView.announce addTarget:self action:@selector(announceBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
    [loginView.connectKefuBtn addTarget:self action:@selector(ConnectionAction:) forControlEvents:UIControlEventTouchUpInside];
    [loginView.yanzhengmaBtn addTarget:self action:@selector(acceptVerifycodeTouched:) forControlEvents:UIControlEventTouchUpInside];
    [loginView.regBtn addTarget:self action:@selector(regBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    [loginView.inputphone setKeyboardType:UIKeyboardTypeNumberPad];
    loginView.inputphone.clearButtonMode = UITextFieldViewModeUnlessEditing;
    loginView.inputphone.tag = 11;
    loginView.inputphone.delegate = self;
    

    
//    [loginView.inputpasswd setKeyboardType:UIKeyboardTypeNumberPad];
    loginView.inputpasswd.clearButtonMode = UITextFieldViewModeUnlessEditing;
    loginView.inputpasswd.tag = 6;
    loginView.inputpasswd.delegate = self;
//    [self.contentView addSubview:self.view];
    
    loginView.loginBtn.backgroundColor =[UIColor colorWithRed:253/255.0 green:156/255.0 blue:39/255.0 alpha:1.0];
//    loginView.regBtn.backgroundColor =[UIColor colorWithRed:204/255.0 green:203/255.0 blue:202/255.0 alpha:1.0];
    
    [loginView.loginBtn setTitleColor:[UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [loginView.regBtn setTitleColor:[UIColor colorWithRed:108/255.0 green:93/255.0 blue:83/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    
    
//    loginView.inputphone.text= @"18611498570";
//    loginView.inputpasswd.text= @"123456";
    
    [loginView.loginBtn setTitle:CustomLocalizedString(@"denglu", nil) forState:UIControlStateNormal];
    [loginView.regBtn setTitle:CustomLocalizedString(@"zhuce", nil) forState:UIControlStateNormal];
    
    loginView.inputphone.placeholder=CustomLocalizedString(@"shurushoujihao", nil);
    loginView.inputpasswd.placeholder=CustomLocalizedString(@"shurumima", nil);
    
//    loginView.inputphone.text= @"17727950025";
//    loginView.inputpasswd.text= @"111111";
    
    loginView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    loginView.logo.frame = CGRectMake((ScreenWidth-129)/2, 47+ADDNavigitionHeight, 129, 96);
    
    loginView.phoneView.frame = CGRectMake((ScreenWidth-290)/2, 186+ADDNavigitionHeight, 290, 45);
    loginView.passView.frame = CGRectMake((ScreenWidth-290)/2, 247+ADDNavigitionHeight, 290, 45);
    loginView.inputphone.frame = CGRectMake(41, 8, ScreenWidth*210/320, 30);
    loginView.inputpasswd.frame = CGRectMake(41, 8, ScreenWidth*210/320,30);
    
    loginView.forgetBtn.frame = CGRectMake(ScreenWidth/2+ScreenWidth*20/320, 149+ADDHeight+ADDNavigitionHeight, 82, 30);
    
    loginView.loginBtn.frame = CGRectMake((ScreenWidth-290)/2, 187+ADDHeight+ADDNavigitionHeight, 290, 45);
    loginView.regBtn.frame = CGRectMake((ScreenWidth-290)/2, 247+ADDHeight+ADDNavigitionHeight, 290, 45);
    
    NSString *strusername =[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *strpassword =[[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    loginView.inputphone.text=strusername;
    loginView.inputpasswd.text=strpassword;

}

-(void)regBtnTouched:(id)sender
{
    RegisterVC *vc = [[RegisterVC alloc]init];
    vc.tagVC = self.tagVC;
    vc.comFrom = 1;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)ConnectionAction:(UIButton *)sender{
    
    GetPwdVC *vc = [[GetPwdVC alloc]init];
    vc.tagVC = self.tagVC;
    vc.comFrom = 1;
    [self.navigationController pushViewController:vc animated:YES];
//    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[GInfo shareClient].mServiceTel];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
-(void)leftBtnTouched:(id)sender{//登录页面返回主页

//    [self.tabBar btnTaped:self.tabBar.indexBtn];
//    [super leftBtnTouched:sender];
}
-(void)rightBtnTouched:(id)sender
{
    RegisterVC *vc = [[RegisterVC alloc]init];
    vc.tagVC = self.tagVC;
    vc.comFrom = 1;
//    [self pushViewController:vc];
}

//- (void)getData {
//    
//    [self.tool getUserInfoData:@"18611498570" block:^(id json) {
//        
////        [loadView removeFromSuperview];
//        
//        NSLog(@"%@",json);
//        
//        NSDictionary* dic = json[@"item"];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"userinfo"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        
////        //        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userinfo"];
////        NSString *struserimage = [dic objectForKey:@"userimage"];
////        [m_imageIconV sd_setImageWithURL:[NSURL URLWithString:struserimage] placeholderImage:[UIImage imageNamed:@"ig_profile_photo_default.png"]];
////        [m_tableView reloadData];
//        
//        //        NSString *strjingli = [dic objectForKey:@"jingli"];
//        //        NSString *strmeili = [dic objectForKey:@"meili"];
//        //        NSString *strzhili = [dic objectForKey:@"zhili"];
//        
//        //        self.lbl_jingli.text =strjingli;
//        //        self.lbl_meili.text =strmeili;
//        //        self.lbl_zhili.text =strzhili;
//        //
//        //        self.zdProgressView_jingli.progress = strjingli.doubleValue/10;
//        //        self.zdProgressView_meili.progress = strmeili.doubleValue/10;
//        //        self.zdProgressView_zhili.progress = strzhili.doubleValue/10;
//        
//
//        
//    }];
//}

- (void)xianshi{
    loginView.loginBtn.userInteractionEnabled = YES;
}

-(void)loginBtnTouched:(id)sender
{
//    [self getData];
    
    if (loginView.inputphone.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
        return;
    } else if (loginView.inputpasswd.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        return;
    }
    
    [self HideKeyboard];
    
    
//    [self showHudInView:self.view hint:NSLocalizedString(@"login.ongoing", @"Is Login...")];

    NSString *name = loginView.inputphone.text;
    NSString *pwd = [MyMD5 md5:loginView.inputpasswd.text];
//    NSString *pwd = loginView.inputpasswd.text;
//    NSString *pwd = @"$2y$13$t8ei8oClEZiZwxdEvcaNKu.DeOJcX1xsYekv1rHcWoocVCfUhkZm2";
//    NSString *urlString = [NSString stringWithFormat:@"%@&username=%@&password=%@&op=%@", QUERY_SITE_INTERFACE_URL2, name, pwd, @"login"];
//    [[CommonHttpRequest defaultInstance] sendHttpRequest2:urlString encryptStr:GETLOGIN_INTERFACE_URL delegate:self controller:self actiViewFlag:0];
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:name forKey:@"username"];//商品数量
    [dic setValue:pwd forKey:@"password"];//商品渠道
    [dic setValue:@"login" forKey:@"op"];//商品类型
//    [dic setValue:@"123456" forKey:@"pushid"];//商品类型
    
    loginView.loginBtn.userInteractionEnabled = NO;
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(xianshi) userInfo:nil repeats:NO];


    [self.tool loginData:dic block:^(id json) {
        
        
        
 
                NSDictionary *dic = json;
                if ([[dic objectForKey:@"code"] intValue] ==1)
                {
        
                    NSString *name = loginView.inputphone.text;
                        NSString *pwd = [MyMD5 md5:loginView.inputpasswd.text];
//                    NSString *pwd = loginView.inputpasswd.text;
        
                    NSCharacterSet *ws = [NSCharacterSet whitespaceAndNewlineCharacterSet];
                    NSString *trimmed = [loginView.inputphone.text stringByTrimmingCharactersInSet:ws];
                    NSString *userName = trimmed;
                    NSString *password = [@"" stringByTrimmingCharactersInSet:ws];
        
                    ECLoginInfo * loginInfo = [[ECLoginInfo alloc] init];
                    loginInfo.username = userName;
                    loginInfo.userPassword = password;
                    loginInfo.appKey = [DemoGlobalClass sharedInstance].appKey;
                    loginInfo.appToken = [DemoGlobalClass sharedInstance].appToken;
                    loginInfo.authType = [DemoGlobalClass sharedInstance].loginAuthType;
                    loginInfo.mode = LoginMode_InputPassword;
                    
                    NSString *password2 = loginView.inputpasswd.text;
                    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"username"];
                    [[NSUserDefaults standardUserDefaults] setObject:password2 forKey:@"password"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
        
                    __weak typeof(self) weakself = self;
//                    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:weakself.view animated:YES];
//                    hud.labelText = @"正在登录...";
//                    hud.removeFromSuperViewOnHide = YES;
        
                    [DemoGlobalClass sharedInstance].userPassword = password;
                    [[DeviceDBHelper sharedInstance] openDataBasePath:userName];
                    [DemoGlobalClass sharedInstance].isHiddenLoginError = NO;
                    [[ECDevice sharedInstance] login:loginInfo completion:^(ECError *error){
        
                        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_onConnected object:error];
                        if (error.errorCode == ECErrorType_NoError) {
                            [DemoGlobalClass sharedInstance].userName = userName;

                            [SFHFKeychain deleteItemForUsername:@"UDID"  andServiceName:KEY_UUID  error:nil];
                            NSString *strUUID =@"";
                            if([SFHFKeychain getPasswordForUsername:@"UDID" andServiceName:KEY_UUID error:nil].length>0)
                            {
                                strUUID = [SFHFKeychain getPasswordForUsername:@"UDID" andServiceName:KEY_UUID error:nil];
                                
                            }else
                            {
                                //        strUUID = [GlobalFunc getUUID];
                                NSLog(@"--%@",strUUID);
                                NSString *struser =[DemoGlobalClass sharedInstance].userName;
                                
//                                strUUID = [strUUID stringByAppendingFormat:@"%@", struser];
//                                [SFHFKeychain storeUsername:@"UDID" andPassword:strUUID forServiceName:KEY_UUID updateExisting:1 error:nil];
                            }

                        }
        
                        __strong typeof(weakself) strongSelf = weakself;
//                        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
                    }];
        
        
        
                    NSLog(@"%@",dic);
        
        
                     [Common2 TipDialog:@"登录成功！"];
        
                }
                else if ([[dic objectForKey:@"code"] intValue] ==0)
                {
                    
                
                    [SVProgressHUD showErrorWithStatus:[dic objectForKey:@"message"]];
                    return;
                    
                    
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:[dic objectForKey:@"message"]];
                    return;
                }
        
        
        
        
        
        
        
//        NSCharacterSet *ws = [NSCharacterSet whitespaceAndNewlineCharacterSet];
//        NSString *trimmed = [loginView.inputphone.text stringByTrimmingCharactersInSet:ws];
//        NSString *userName = trimmed;
//        NSString *password = [@"" stringByTrimmingCharactersInSet:ws];
//        
//        ECLoginInfo * loginInfo = [[ECLoginInfo alloc] init];
//        loginInfo.username = userName;
//        loginInfo.userPassword = password;
//        loginInfo.appKey = [DemoGlobalClass sharedInstance].appKey;
//        loginInfo.appToken = [DemoGlobalClass sharedInstance].appToken;
//        loginInfo.authType = [DemoGlobalClass sharedInstance].loginAuthType;
//        loginInfo.mode = LoginMode_InputPassword;
//        
//        __weak typeof(self) weakself = self;
//        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:weakself.view animated:YES];
//        hud.labelText = @"正在登录...";
//        hud.removeFromSuperViewOnHide = YES;
//        
//        [DemoGlobalClass sharedInstance].userPassword = password;
//        [[DeviceDBHelper sharedInstance] openDataBasePath:userName];
//        [DemoGlobalClass sharedInstance].isHiddenLoginError = NO;
//        [[ECDevice sharedInstance] login:loginInfo completion:^(ECError *error){
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_onConnected object:error];
//            if (error.errorCode == ECErrorType_NoError) {
//                [DemoGlobalClass sharedInstance].userName = userName;
//            }
//            
//            __strong typeof(weakself) strongSelf = weakself;
//            
//        }];

        

        
        
        
////                NSString *responseString = [loader responseString];
//                NSDictionary *dic = json;
//                if ([[dic objectForKey:@"code"] intValue] ==1)
//                {
//        
//                    NSString *name = loginView.inputphone.text;
//                    //    NSString *pwd = [MyMD5 md5:loginView.inputpasswd.text];
//                    NSString *pwd = loginView.inputpasswd.text;
//        
//                    NSCharacterSet *ws = [NSCharacterSet whitespaceAndNewlineCharacterSet];
//                    NSString *trimmed = [loginView.inputphone.text stringByTrimmingCharactersInSet:ws];
//                    NSString *userName = trimmed;
//                    NSString *password = [@"" stringByTrimmingCharactersInSet:ws];
//        
//                    ECLoginInfo * loginInfo = [[ECLoginInfo alloc] init];
//                    loginInfo.username = userName;
//                    loginInfo.userPassword = password;
//                    loginInfo.appKey = [DemoGlobalClass sharedInstance].appKey;
//                    loginInfo.appToken = [DemoGlobalClass sharedInstance].appToken;
//                    loginInfo.authType = [DemoGlobalClass sharedInstance].loginAuthType;
//                    loginInfo.mode = LoginMode_InputPassword;
//        
//                    __weak typeof(self) weakself = self;
//                    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:weakself.view animated:YES];
//                    hud.labelText = @"正在登录...";
//                    hud.removeFromSuperViewOnHide = YES;
//        
//                    [DemoGlobalClass sharedInstance].userPassword = password;
//                    [[DeviceDBHelper sharedInstance] openDataBasePath:userName];
//                    [DemoGlobalClass sharedInstance].isHiddenLoginError = NO;
//                    [[ECDevice sharedInstance] login:loginInfo completion:^(ECError *error){
//        
//                        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_onConnected object:error];
//                        if (error.errorCode == ECErrorType_NoError) {
//                            [DemoGlobalClass sharedInstance].userName = userName;
//                        }
//        
//                        __strong typeof(weakself) strongSelf = weakself;
//                        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
//                    }];
//        
//        
//        
//                    NSLog(@"%@",dic);
//        
//        
//                     [Common2 TipDialog:@"登录成功！"];
//        
//                }
//                else if ([[dic objectForKey:@"code"] intValue] ==0)
//                {
//                    
//                    
//                    [Common2 TipDialog:[dic objectForKey:@"message"]];
//                    return;
//                    
//                    
//                }
//                else
//                {
//                    [Common2 TipDialog:[dic objectForKey:@"message"]];
//                    return;
//                }
        
        
    }];



}
- (void)HideKeyboard
{
    [loginView.inputphone resignFirstResponder];
    [loginView.inputpasswd resignFirstResponder];
}
//发送验证码
-(void)acceptVerifycodeTouched:(id)sender
{
//    loginView.yanzhengmaBtn.userInteractionEnabled = NO;
//    if (![Util isMobileNumber:loginView.inputphone.text]) {
//        [self showErrorStatus:@"请输入合法的手机号码"];
//        [loginView.inputphone becomeFirstResponder];
//        return;
//    }
//    [SUser sendSM:loginView.inputphone.text block:^(SResBase *resb) {
//        if (resb.msuccess) {
//            timer = [NSTimer scheduledTimerWithTimeInterval:1
//                                                     target:self
//                                                   selector:@selector(RemainingSecond)
//                                                   userInfo:nil
//                                                    repeats:YES];
//            [timer fire];
//            
//        }
//        else
//        {
//            [self showErrorStatus:resb.mmsg];
//            loginView.yanzhengmaBtn.userInteractionEnabled = YES;
//        }
//    }];
}
-(void)RemainingSecond
{
    
    ReadSecond--;
    
    if (ReadSecond<=0) {
        
        [loginView.yanzhengmaBtn setTitle:@"重新发送验证码" forState:UIControlStateNormal];
        //  [regitstView.acceptVerifycode setTitleColor:COLOR(224, 44, 87) forState:UIControlStateNormal];
        ReadSecond=61;
        loginView.yanzhengmaBtn.userInteractionEnabled = YES;
        [timer invalidate];
        timer = nil;
        
        //   [TimerShowButton  addTarget:self action:@selector(PostVeriryCode:) forControlEvents:UIControlEventTouchUpInside];
        return;
    }
    else
    {
        
        
        NSString *GroupButtonTitle=[NSString stringWithFormat:@"%i%@",ReadSecond,@"秒可重新发送"];
        [loginView.yanzhengmaBtn setTitle:GroupButtonTitle forState:UIControlStateNormal];
        // [regitstView.acceptVerifycode setTitleColor:COLOR(161, 161, 161) forState:UIControlStateNormal];
       loginView.yanzhengmaBtn.userInteractionEnabled = NO;
        //  [self PostVeriryCode:nil];
        
        
    }
    
    
    
}

-(void)logOK
{

    if( self.tagVC )
    {
        NSMutableArray* t = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
        [t removeLastObject];
        [t addObject:self.tagVC];
        [self.navigationController setViewControllers:t animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }

   // [APService setAlias:[Qu_UserInfo currentUser].q_username callbackSelector:nil object:nil];
    
}


///限制电话号码输入长度
#define TEXT_MAXLENGTH 11
///限制验证码输入长度
#define PASS_LENGHT 20
#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res;
    if (textField.tag==11) {
        res= TEXT_MAXLENGTH-[new length];
        
        
    }else
    {
        res= PASS_LENGHT-[new length];
        
    }
    if(res >= 0){
        return YES;
    }
    else{
        NSRange rg = {0,[string length]+res};
        if (rg.length>0) {
            NSString *s = [string substringWithRange:rg];
            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}
-(void)forgetBtnTouched:(id)sender
{
    GetPwdVC *vc = [[GetPwdVC alloc]init];
    vc.tagVC = self.tagVC;
    vc.comFrom = 1;
    [self.navigationController pushViewController:vc animated:YES];
//    RegisterVC *vc = [[RegisterVC alloc]init];
//    vc.tagVC = self.tagVC;
//    vc.comFrom = 2;
//    [self pushViewController:vc];
}
-(void)announceBtnTouched:(id)sender
{
//    WebVC* vc = [[WebVC alloc]init];
//    vc.mName = @"免责声明";
//    
//    http://wap.meimeidaojia.com.cn/More/aboutus
//    vc.mUrl = @"http://wap.meimeidaojia.com.cn/More/disclaimer";
//    [self pushViewController:vc];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little app://./main.htmlpreparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didFinishSuccess:(ASIHTTPRequest *)loader
{
    if ([[loader.userInfo objectForKey:@"type"] isEqualToString:GETLOGIN_INTERFACE_URL])
    {
        
        NSCharacterSet *ws = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimmed = [loginView.inputphone.text stringByTrimmingCharactersInSet:ws];
        NSString *userName = trimmed;
        NSString *password = [@"" stringByTrimmingCharactersInSet:ws];
        
        ECLoginInfo * loginInfo = [[ECLoginInfo alloc] init];
        loginInfo.username = userName;
        loginInfo.userPassword = password;
        loginInfo.appKey = [DemoGlobalClass sharedInstance].appKey;
        loginInfo.appToken = [DemoGlobalClass sharedInstance].appToken;
        loginInfo.authType = [DemoGlobalClass sharedInstance].loginAuthType;
        loginInfo.mode = LoginMode_InputPassword;
        
        __weak typeof(self) weakself = self;
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:weakself.view animated:YES];
        hud.labelText = @"正在登录...";
        hud.removeFromSuperViewOnHide = YES;
        
        [DemoGlobalClass sharedInstance].userPassword = password;
        [[DeviceDBHelper sharedInstance] openDataBasePath:userName];
        [DemoGlobalClass sharedInstance].isHiddenLoginError = NO;
        [[ECDevice sharedInstance] login:loginInfo completion:^(ECError *error){
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_onConnected object:error];
            if (error.errorCode == ECErrorType_NoError) {
                [DemoGlobalClass sharedInstance].userName = userName;
            }
            
            __strong typeof(weakself) strongSelf = weakself;
            
        }];
        
        
        
        
////         [self hideHud];
//        
//        NSString *responseString = [loader responseString];
//        NSDictionary *dic = [responseString JSONValue];
//        if ([[dic objectForKey:@"code"] intValue] ==1)
//        {
//            
//            NSString *name = loginView.inputphone.text;
//            //    NSString *pwd = [MyMD5 md5:loginView.inputpasswd.text];
//            NSString *pwd = loginView.inputpasswd.text;
//            
//            NSCharacterSet *ws = [NSCharacterSet whitespaceAndNewlineCharacterSet];
//            NSString *trimmed = [loginView.inputphone.text stringByTrimmingCharactersInSet:ws];
//            NSString *userName = trimmed;
//            NSString *password = [@"" stringByTrimmingCharactersInSet:ws];
//            
//            ECLoginInfo * loginInfo = [[ECLoginInfo alloc] init];
//            loginInfo.username = userName;
//            loginInfo.userPassword = password;
//            loginInfo.appKey = [DemoGlobalClass sharedInstance].appKey;
//            loginInfo.appToken = [DemoGlobalClass sharedInstance].appToken;
//            loginInfo.authType = [DemoGlobalClass sharedInstance].loginAuthType;
//            loginInfo.mode = LoginMode_InputPassword;
//            
//            __weak typeof(self) weakself = self;
//            MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:weakself.view animated:YES];
//            hud.labelText = @"正在登录...";
//            hud.removeFromSuperViewOnHide = YES;
//            
//            [DemoGlobalClass sharedInstance].userPassword = password;
//            [[DeviceDBHelper sharedInstance] openDataBasePath:userName];
//            [DemoGlobalClass sharedInstance].isHiddenLoginError = NO;
//            [[ECDevice sharedInstance] login:loginInfo completion:^(ECError *error){
//                
//                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_onConnected object:error];
//                if (error.errorCode == ECErrorType_NoError) {
//                    [DemoGlobalClass sharedInstance].userName = userName;
//                }
//                
//                __strong typeof(weakself) strongSelf = weakself;
//                [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
//            }];
//
//            
//            
//            NSLog(@"%@",dic);
//
//            
//             [Common2 TipDialog:@"登录成功！"];
//            
//        }
//        else if ([[dic objectForKey:@"code"] intValue] ==0)
//        {
//            
//            
//            [Common2 TipDialog:[dic objectForKey:@"message"]];
//            return;
//            
//            
//        }
//        else
//        {
//            [Common2 TipDialog:[dic objectForKey:@"message"]];
//            return;
//        }
    }
}

//点击登陆后的操作
- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
}



- (void) didFinishFail:(ASIHTTPRequest *)loader{
    [Uitil TipDialog:NETWORK_CONNECT_FAIL_MSG];
}



@end
