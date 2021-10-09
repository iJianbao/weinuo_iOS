

#import "HealthViewController.h"

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

#import "VVWaterWaveView.h"

#import "UUChart.h"

#import "JiankangListViewController.h"

#import "DBTool.h"
#import "Health.h"



@interface HealthViewController () <UUChartDataSource>
{
    NSIndexPath *path;
    UUChart *chartView;
}
//@property (nonatomic,strong) ShangchengRcommandDataTool *tool;

//@property(nonatomic,strong) SessionViewController * sessionView;

@property (nonatomic , assign) int expires;
@property(nonatomic,strong) NSString* qiniuToken;

@property (strong, nonatomic) UISwitch *autoLoginSwitch;
@property (strong, nonatomic) UISwitch *ipSwitch;

@property (weak, nonatomic) IBOutlet VVWaterWaveView *waterWaveViewTop;
@property (weak, nonatomic) IBOutlet VVWaterWaveView *waterWaveViewBottom;

@property (weak, nonatomic) IBOutlet UISlider *percentSlider;
@property (weak, nonatomic) IBOutlet UISlider *amplitudeSlider;

@property (strong, nonatomic) UILabel *label_zhanzishijian;
@property (strong, nonatomic) UILabel *label_zuozishijian;
@property (strong, nonatomic) UILabel *label_zuozhanbivalue;

@end

@implementation HealthViewController
@synthesize autoLoginSwitch = _autoLoginSwitch;
@synthesize ipSwitch = _ipSwitch;
//- (ShangchengRcommandDataTool *)tool{
//    if (_tool == nil) {
//        _tool = [[ShangchengRcommandDataTool alloc]init];
//
//    }
//    return _tool;
//}

-(void)getDataSouce {
    if(chartView) {
        [chartView removeFromSuperview];
    }
    chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(ScreenWidth*5/320, (ScreenWidth*260/320) * DEVICE_HEIGHT_SCALE, ScreenWidth-ScreenWidth*10/320, ScreenWidth*180/320)
                                              withSource:self
                                               withStyle:UUChartLineStyle];
    [chartView showInView:self.view];
    
    if(isPadYES)
    {
        chartView.frame = CGRectMake(ScreenWidth*5/320, ScreenWidth*160/320, ScreenWidth-ScreenWidth*10/320, ScreenWidth*180/320);
        
    }
    
    
    DBTool *tool = [DBTool sharedDBTool];
    [tool createTableWithClass:[Health class]];
    
    NSString *str_nianyueri= [self getCurrentTime];
    NSString *str_yueri=[self getCurrentTime2];
    NSString *params =[NSString stringWithFormat:@"_riqi='%@'",str_nianyueri];
    NSArray *data = [tool selectWithClass:[Health class] params:params];
    if(data.count != 0) {
        Health *h1 = [data objectAtIndex:0];
        //        h1.zuozishijian =1.10;
        CGFloat zuoziScoud = h1.zuozishijian * 60 * 60;
        int zuozihour = (int) (zuoziScoud / 3600.0);
        int zuoziminu = (int) (zuoziScoud - zuozihour * 3600.0) / 60.0;
        NSString *zuoziStr = [NSString stringWithFormat:@"%d%@%d%@", zuozihour, LocationLanguage(@"hours", @"小时"), zuoziminu, LocationLanguage(@"minutes", @"分钟")];
        _label_zuozishijian.text = [NSString stringWithFormat:@"%@%@", LocationLanguage(@"sittingTime", @"坐姿时间:"), zuoziStr];
        
        CGFloat zhanziScoud = h1.zhanzishijian * 60 * 60;
        int zhanzihour = (int) (zhanziScoud / 3600);
        int zhanziminu = (int) (zhanziScoud - zhanzihour * 3600) / 60;
        NSString *zhanziStr = [NSString stringWithFormat:@"%d%@%d%@", zhanzihour, LocationLanguage(@"hours", @"小时"), zhanziminu, LocationLanguage(@"minutes", @"分钟")];
        _label_zhanzishijian.text = [NSString stringWithFormat:@"%@%@", LocationLanguage(@"standingTime", @"站姿时间: "), zhanziStr];
        
        
        if(h1.zuozishijian==0.00 && h1.zhanzishijian!=0.00)
        {
            _label_zuozhanbivalue.text = @"0%";
            self.waterWaveViewBottom.percent = 0.0;
        }
        else if(h1.zhanzishijian==0.00 && h1.zuozishijian!=0.00 )
        {
            _label_zuozhanbivalue.text = @"100%";
            self.waterWaveViewBottom.percent = 1.0;
        }
        else if(h1.zhanzishijian==0.00 && h1.zuozishijian==0.00 )
        {
            _label_zuozhanbivalue.text = @"0%";
            self.waterWaveViewBottom.percent = 0.0;
        }
        else
        {
            _label_zuozhanbivalue.text = [NSString stringWithFormat:@"%.0f%%",h1.zuozishijian/(h1.zhanzishijian+h1.zuozishijian)*100];
            
            //            self.waterWaveViewBottom.percent = [NSString stringWithFormat:@"%.0f",h1.zuozishijian/(h1.zhanzishijian+h1.zuozishijian)].intValue;
            
//            NSString * aaa =[NSString stringWithFormat:@"%.1f",h1.zuozishijian/(h1.zhanzishijian+h1.zuozishijian)];
            
            self.waterWaveViewBottom.percent =  [NSString stringWithFormat:@"%.2f",h1.zuozishijian/(h1.zhanzishijian+h1.zuozishijian)].floatValue;
        }
    }
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"我的"];
    //    [GlobalFunc countView:@"web内嵌页"];
    self.navigationController.navigationBarHidden = NO;
    
    
    
    
    

    

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"我的"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self getDataSouce];
    
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



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = CustomLocalizedString(@"gerenzhongxin", nil);//@"个人中心";
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
    
    
    UIImageView *imageView_zuozhanbi = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*2/320, ScreenWidth*20/320, ScreenWidth*25/320, ScreenWidth*25/320)];
    [imageView_zuozhanbi setImage:[UIImage imageNamed:@"health_icon_percent.png"]];
    [self.view addSubview:imageView_zuozhanbi];
    
    
    UILabel *label_zuozhanbi = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*35/320, ScreenWidth*20/320, 300, ScreenWidth*30/320)];
    label_zuozhanbi.text = LocationLanguage(@"standRatio", @"今日坐站时间比");
    label_zuozhanbi.textColor = [Common2 colorWithHexString:@"#ffffff"];
    label_zuozhanbi.tintColor = [Common2 colorWithHexString:@"#ffffff"];
    label_zuozhanbi.font = [UIFont boldSystemFontOfSize:18.0f];
    label_zuozhanbi.numberOfLines = 0;
    label_zuozhanbi.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label_zuozhanbi];
    
    CGFloat scale = DEVICE_HEIGHT_SCALE;
    
    UIImageView *imageView_qiri = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*2/320, (ScreenWidth*230/320) * scale, ScreenWidth*25/320, ScreenWidth*25/320)];
    [imageView_qiri setImage:[UIImage imageNamed:@"health_icon_data.png"]];
    [self.view addSubview:imageView_qiri];
    
    UILabel *label_qiri = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*35/320, imageView_qiri.frame.origin.y, ScreenWidth*160/320, ScreenWidth*30/320)];
    label_qiri.text = LocationLanguage(@"7Days", @"最近七日记录");
    label_qiri.textColor = [Common2 colorWithHexString:@"#ffffff"];
    label_qiri.tintColor = [Common2 colorWithHexString:@"#ffffff"];
    label_qiri.font = [UIFont boldSystemFontOfSize:18.0f];
    label_qiri.numberOfLines = 0;
    label_qiri.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label_qiri];
    
    
    UIButton *imageBtn_more = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn_more.frame = CGRectMake(ScreenWidth-170, imageView_qiri.frame.origin.y, 150, ScreenWidth*30/320);
    [imageBtn_more setTitle:LocationLanguage(@"more", @"更多") forState:UIControlStateNormal];
    imageBtn_more.titleLabel.numberOfLines = 0;
    imageBtn_more.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [imageBtn_more addTarget:self action:@selector(JiankonglistClicked) forControlEvents:UIControlEventTouchUpInside];
//    [imageBtn_more setImage:[UIImage imageNamed:@"icon_app.png"] forState:UIControlStateNormal];
    [self.view addSubview:imageBtn_more];
    
    
    _label_zuozishijian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2, (ScreenWidth*50/320) * scale, ScreenWidth/2 - 10, ScreenWidth*30/320)];
    _label_zuozishijian.text = [NSString stringWithFormat:@"%@0.00%@",
                                LocationLanguage(@"sittingTime", @"坐姿时间:"), LocationLanguage(@"hours", @"小时")];
    _label_zuozishijian.textColor = [Common2 colorWithHexString:@"#ffffff"];
    _label_zuozishijian.tintColor = [Common2 colorWithHexString:@"#ffffff"];
    _label_zuozishijian.font = [UIFont systemFontOfSize:16.0f];
    _label_zuozishijian.numberOfLines = 0;
    _label_zuozishijian.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_label_zuozishijian];
    
    
    _label_zhanzishijian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2, (ScreenWidth*70/320) * scale, ScreenWidth/2 - 10, ScreenWidth*30/320)];
    _label_zhanzishijian.text = [NSString stringWithFormat:@"%@0:00%@",
                                 LocationLanguage(@"standingTime", @"站姿时间: "), LocationLanguage(@"hours", @"小时")];
    _label_zhanzishijian.textColor = [Common2 colorWithHexString:@"#ffffff"];
    _label_zhanzishijian.tintColor = [Common2 colorWithHexString:@"#ffffff"];
    _label_zhanzishijian.font = [UIFont systemFontOfSize:16.0f];
    _label_zhanzishijian.numberOfLines = 0;
    _label_zhanzishijian.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_label_zhanzishijian];
    
    CGRect rect = self.waterWaveViewBottom.frame;
    rect.origin.y *= scale;
    self.waterWaveViewBottom.frame = rect;
    self.waterWaveViewBottom.percent = self.percentSlider.value;
    self.waterWaveViewBottom.amplitude = self.amplitudeSlider.value;
    self.waterWaveViewBottom.waveLayerColorArray = @[
                                                     [UIColor colorWithRed:131/255.0 green:169/255.0 blue:235/255.0 alpha:0.5],
                                                     [UIColor colorWithRed:131/255.0 green:169/255.0 blue:235/255.0 alpha:0.7],
                                                     [UIColor colorWithRed:131/255.0 green:169/255.0 blue:235/255.0 alpha:1.0]
                                                     ];
    self.waterWaveViewBottom.layer.cornerRadius = self.waterWaveViewBottom.frame.size.width * 0.5;
    self.waterWaveViewBottom.clipsToBounds = YES;
    
    [self.waterWaveViewBottom startWave];
    
    //    self.waterWaveViewBottom.percent = 0.0;
    
    self.waterWaveViewBottom.amplitude = 5;
    
    NSString *languStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"];
    BOOL isEn = [languStr isEqualToString:@"en"] || [languStr isEqualToString:@"ru"];
    rect = _label_zuozishijian.frame;
    rect.size.height += isEn ? 20 : 0;
    rect.origin.y = self.waterWaveViewBottom.center.y - rect.size.height;
    _label_zuozishijian.frame = rect;
    
    rect = _label_zhanzishijian.frame;
    rect.size.height += isEn ? 20 : 0;
    rect.origin.y = self.waterWaveViewBottom.center.y;
    _label_zhanzishijian.frame = rect;
    
    
    _label_zuozhanbivalue = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*40/320, ScreenWidth*50/320, ScreenWidth*80/320, ScreenWidth*30/320)];
    _label_zuozhanbivalue.center = CGPointMake(self.waterWaveViewBottom.bounds.size.width/2, self.waterWaveViewBottom.bounds.size.height/2);
    _label_zuozhanbivalue.text = @"0%";
    _label_zuozhanbivalue.textColor = [Common2 colorWithHexString:@"#2B2B73"];
    _label_zuozhanbivalue.tintColor = [Common2 colorWithHexString:@"#ffffff"];
    _label_zuozhanbivalue.font = [UIFont boldSystemFontOfSize:32.0f];
    _label_zuozhanbivalue.numberOfLines = 0;
    _label_zuozhanbivalue.textAlignment = NSTextAlignmentCenter;
    [self.waterWaveViewBottom addSubview:_label_zuozhanbivalue];
    
    
    
    if(isPadYES)
    {
        label_zuozhanbi.font = [UIFont boldSystemFontOfSize:28.0f];
        label_qiri.font = [UIFont boldSystemFontOfSize:28.0f];
        imageBtn_more.font = [UIFont boldSystemFontOfSize:28.0f];
        _label_zuozishijian.font = [UIFont systemFontOfSize:26.0f];
        _label_zhanzishijian.font = [UIFont systemFontOfSize:26.0f];
        
        imageView_zuozhanbi.frame = CGRectMake(ScreenWidth*2/320, ScreenWidth*20/320, ScreenWidth*25/320, ScreenWidth*25/320);
        label_zuozhanbi.frame = CGRectMake(ScreenWidth*35/320, ScreenWidth*20/320, ScreenWidth*160/320, ScreenWidth*30/320);
        imageView_qiri.frame = CGRectMake(ScreenWidth*2/320, ScreenWidth*130/320, ScreenWidth*25/320, ScreenWidth*25/320);
        label_qiri.frame = CGRectMake(ScreenWidth*35/320, ScreenWidth*130/320, ScreenWidth*160/320, ScreenWidth*30/320);
        imageBtn_more.frame = CGRectMake(ScreenWidth-ScreenWidth*60/320, ScreenWidth*130/320, ScreenWidth*60/320, ScreenWidth*30/320);
        _label_zuozishijian.frame = CGRectMake(ScreenWidth/2, ScreenWidth*50/320, ScreenWidth*260/320, ScreenWidth*30/320);
        _label_zhanzishijian.frame = CGRectMake(ScreenWidth/2, ScreenWidth*70/320, ScreenWidth*260/320, ScreenWidth*30/320);
        _label_zuozhanbivalue.frame = CGRectMake(ScreenWidth*25/320, ScreenWidth*25/320, ScreenWidth*80/320, ScreenWidth*30/320);
        self.waterWaveViewBottom.frame = CGRectMake(ScreenWidth*30/320, ScreenWidth*50/320, ScreenWidth*70/320, ScreenWidth*70/320);
        self.waterWaveViewBottom.layer.cornerRadius = ScreenWidth*70/320 * 0.5;
    }
    
    
  
    
//    self.waterWaveViewBottom.percent = self.percentSlider.value;
//    self.waterWaveViewBottom.amplitude = self.amplitudeSlider.value;
//    self.waterWaveViewBottom.waveLayerColorArray = @[
//                                                     [UIColor colorWithRed:131/255.0 green:169/255.0 blue:235/255.0 alpha:0.5],
//                                                     [UIColor colorWithRed:131/255.0 green:169/255.0 blue:235/255.0 alpha:0.7],
//                                                     [UIColor colorWithRed:131/255.0 green:169/255.0 blue:235/255.0 alpha:1.0]
//                                                     ];
//    self.waterWaveViewBottom.layer.cornerRadius = self.waterWaveViewBottom.frame.size.width * 0.5;
//    self.waterWaveViewBottom.clipsToBounds = YES;
//
//    [self.waterWaveViewBottom startWave];
//
////    self.waterWaveViewBottom.percent = 0.0;
//
//    self.waterWaveViewBottom.amplitude = 5;
//
//
//
//    _label_zuozhanbivalue = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*40/320, ScreenWidth*50/320, ScreenWidth*80/320, ScreenWidth*30/320)];
//    _label_zuozhanbivalue.text = @"0%";
//    _label_zuozhanbivalue.textColor = [Common2 colorWithHexString:@"#2B2B73"];
//    _label_zuozhanbivalue.tintColor = [Common2 colorWithHexString:@"#ffffff"];
//    _label_zuozhanbivalue.font = [UIFont boldSystemFontOfSize:32.0f];
//    _label_zuozhanbivalue.numberOfLines = 0;
//    _label_zuozhanbivalue.textAlignment = NSTextAlignmentLeft;
//    [self.waterWaveViewBottom addSubview:_label_zuozhanbivalue];
//
//
//
//
//
//    chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(ScreenWidth*5/320, ScreenWidth*260/320, ScreenWidth-ScreenWidth*10/320, ScreenWidth*180/320)
//                                              withSource:self
//                                               withStyle:UUChartLineStyle];
//    [chartView showInView:self.view];
    
    
//    [self getDataSouce];
    
    
    
//    DBTool *tool = [DBTool sharedDBTool];
//    [tool createTableWithClass:[Health class]];
//
//    NSString *str_nianyueri=[self getCurrentTime];
//    NSString *str_yueri=[self getCurrentTime2];
//    NSString *params =[NSString stringWithFormat:@"_riqi='%@'",str_nianyueri];
//    NSArray *data = [tool selectWithClass:[Health class] params:params];
//    if(data.count!=0)
//    {
//        Health *h1 = [data objectAtIndex:0];
////        h1.zuozishijian =1.10;
//
//        label_zuozishijian.text = [NSString stringWithFormat:@"坐姿时间：%.2f小时",h1.zuozishijian];
//        label_zhanzishijian.text = [NSString stringWithFormat:@"站姿时间：%.2f小时",h1.zhanzishijian];
//
//        if(h1.zuozishijian==0.00 && h1.zhanzishijian!=0.00)
//        {
//            label_zuozhanbivalue.text = @"0%";
//            self.waterWaveViewBottom.percent = 0.0;
//        }
//        else if(h1.zhanzishijian==0.00 && h1.zuozishijian!=0.00 )
//        {
//            label_zuozhanbivalue.text = @"100%";
//            self.waterWaveViewBottom.percent = 1.0;
//        }
//        else if(h1.zhanzishijian==0.00 && h1.zuozishijian==0.00 )
//        {
//            label_zuozhanbivalue.text = @"0%";
//            self.waterWaveViewBottom.percent = 0.0;
//        }
//        else
//        {
//            label_zuozhanbivalue.text = [NSString stringWithFormat:@"%.0f%%",h1.zuozishijian/(h1.zhanzishijian+h1.zuozishijian)*100];
//
////            self.waterWaveViewBottom.percent = [NSString stringWithFormat:@"%.0f",h1.zuozishijian/(h1.zhanzishijian+h1.zuozishijian)].intValue;
//
//            self.waterWaveViewBottom.percent = [NSString stringWithFormat:@"%.0f",h1.zuozishijian/(h1.zhanzishijian+h1.zuozishijian)].floatValue;
//        }
//    }
 }

- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; [formatter setDateFormat:@"yyyy-MM-dd"]; NSString *dateTime = [formatter stringFromDate:[NSDate date]]; return dateTime;
    
}

- (NSString *)getCurrentTime2 {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; [formatter setDateFormat:@"MM.dd"]; NSString *dateTime = [formatter stringFromDate:[NSDate date]]; return dateTime;
    
}

- (void)JiankonglistClicked
{
    JiankangListViewController *videoRender = [[JiankangListViewController alloc] init];
    videoRender.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:videoRender animated:YES];
    
    
}


/*
- (void)logoutAction
{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.removeFromSuperViewOnHide = YES;
    hub.labelText = @"正在注销...";
    
    [[ECDevice sharedInstance] logout:^(ECError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//
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

- (NSArray *)getXTitles:(int)num
{
    DBTool *tool = [DBTool sharedDBTool];
    NSArray *data_health = [tool selectWithClass:[Health class] params:@" 1=1  ORDER BY _riqi desc LIMIT 7 "];
    
    NSMutableArray *xTitles = [NSMutableArray array];
    for (int i=0; i<data_health.count; i++) {
        Health *p4 = data_health[i];
        NSString * str = p4.riqi2;// [NSString stringWithFormat:@"R-%d",i];
        [xTitles addObject:str];
    }
    return xTitles;
    
//    NSMutableArray *xTitles = [NSMutableArray array];
//    for (int i=0; i<num; i++) {
//        NSString * str = [NSString stringWithFormat:@"R-%d",i];
//        [xTitles addObject:str];
//    }
//    return xTitles;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{
    
    return [self getXTitles:7];
    
    
}
//数值多重数组
- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
    DBTool *tool = [DBTool sharedDBTool];
    NSArray *data_health = [tool selectWithClass:[Health class] params:@" 1=1  ORDER BY _riqi desc LIMIT 7 "];
    
    NSString *zhangzuobi1=@"0";
    NSString *zhangzuobi2=@"0";
    NSString *zhangzuobi3=@"0";
    NSString *zhangzuobi4=@"0";
    NSString *zhangzuobi5=@"0";
    NSString *zhangzuobi6=@"0";
    NSString *zhangzuobi7=@"0";
    for (int i=0; i<data_health.count; i++) {
        Health *p4 = data_health[i];
        if(i==0)
        {
            zhangzuobi1 =  [NSString stringWithFormat:@"%.f",p4.zuozishijian/(p4.zuozishijian+p4.zhanzishijian)*100] ;
            
        }
        else if(i==1)
        {
            zhangzuobi2 =  [NSString stringWithFormat:@"%.f",p4.zuozishijian/(p4.zuozishijian+p4.zhanzishijian)*100] ;
            
        }
        else if(i==2)
        {
            zhangzuobi3 =  [NSString stringWithFormat:@"%.f",p4.zuozishijian/(p4.zuozishijian+p4.zhanzishijian)*100] ;
            
        }
        else if(i==3)
        {
            zhangzuobi4 = [NSString stringWithFormat:@"%.f",p4.zuozishijian/(p4.zuozishijian+p4.zhanzishijian)*100] ;
            
        }
        else if(i==4)
        {
            zhangzuobi5 =  [NSString stringWithFormat:@"%.f",p4.zuozishijian/(p4.zuozishijian+p4.zhanzishijian)*100] ;
            
        }
        else if(i==5)
        {
            zhangzuobi6 =  [NSString stringWithFormat:@"%.f",p4.zuozishijian/(p4.zuozishijian+p4.zhanzishijian)*100] ;
            
        }
        else if(i==6)
        {
            zhangzuobi7 =  [NSString stringWithFormat:@"%.f",p4.zuozishijian/(p4.zuozishijian+p4.zhanzishijian)*100] ;
            
        }
        
        
    }
    
    NSArray *ary4 = @[zhangzuobi1,zhangzuobi2,zhangzuobi3,zhangzuobi4,zhangzuobi5,zhangzuobi6,zhangzuobi7];
    
    return @[ary4];
    
//    NSArray *ary4 = @[@"23",@"42",@"25",@"15",@"30",@"42",@"32"];
//
//    return @[ary4];
    
    
}

#pragma mark - @optional
//颜色数组
- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    return @[UUGreen,UURed,UUBrown];
}
//显示数值范围
- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
{
    return CGRangeMake(100, 0);
    
}

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart
{
    //    if (path.row==2) {
    //        return CGRangeMake(25, 75);
    //    }
    return CGRangeZero;
}

//判断显示横线条
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index
{
    return path.row==2;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    
}



@end
