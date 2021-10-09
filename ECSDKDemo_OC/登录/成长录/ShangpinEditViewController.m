//
//  ShangpinEditViewController.m
//  bulkBuy
//
//  Created by 孙正丰 on 13-10-7.
//  Copyright (c) 2013年 孙正丰. All rights reserved.
//

#import "ShangpinAddViewController.h"
#import "CommonHttpRequest.h"
#import "Global.h"
#import "Common2.h"
#import "LoginVC.h"
#import "SVProgressHUDManager.h"
#import "HttpTools.h"

#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#define ORIGINAL_MAX_WIDTH 640.0f

#import "UIImageView+WebCache.h"
#import "ImageCacher.h"
#import "FileHelpers.h"
//#import "QianmingViewController.h"
//#import "CollegeHttpTool.h"
#import "GlobalFunc.h"
#import "MyPicker3View.h"
#import "UIViewController+HUD.h"
#import "ShangchengRcommandDataTool.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "ImageCacher.h"
#import "FileHelpers.h"


#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "CTAssetsPickerController.h"
#import "RSKImageCropViewController.h"
#import "SVProgressHUD.h"
//#import "gerenEditViewController.h"
#import "ShangchengRcommandDataTool.h"

#import "QiniuSDK.h"
#import "QN_GTM_Base64.h"
#include <CommonCrypto/CommonCrypto.h>
#import "JSONKit.h"
#import "AFNetworking.h"
//@import AFNetworking;

//#import "CategoryListViewController.h"

//#import "LoginShopVC.h"
#import "BRPlaceholderTextView.h"
#import "PPNumberButton.h"
#import "MHActionSheet.h"
#define kBasePadding 15
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define mDevice  ([[[UIDevice currentDevice] systemVersion] floatValue])

//默认最大输入字数为  kMaxTextCount  300
#define kMaxTextCount 10000
#define HeightVC [UIScreen mainScreen].bounds.size.height//获取设备高度
#define WidthVC [UIScreen mainScreen].bounds.size.width//获取设备宽度

@interface ShangpinAddViewController () <UITextViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, VPImageCropperDelegate>
@property (nonatomic, strong) UIImageView *portraitImageView;
@property (strong, nonatomic) NSString *proviceName;//省名称
@property (strong, nonatomic) NSString *cityName;//市名称
@property (strong, nonatomic) NSString *areaName;//区名称
@property (strong, nonatomic) NSString *proviceID;//省ID
@property (strong, nonatomic) NSString *cityID;//市ID
@property (strong, nonatomic) NSString *areaID;//区ID



@property (strong, nonatomic) NSDictionary *dic;
@property (nonatomic,strong) ShangchengRcommandDataTool *tool;

@property (weak, nonatomic) UIButton *btnAddr;//所在地区

@property(nonatomic,strong) NSString* qiniuToken;

@property(nonatomic,strong) NSString* imgUrl;

@property(nonatomic,strong) NSString* categoryid;
@property(nonatomic,strong) NSString* categoryname;

@property (nonatomic, strong) BRPlaceholderTextView *noteTextView;

@property (nonatomic, strong) PPNumberButton *numberButton_action;
@property(nonatomic,strong) NSString* str_action_repeat;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *arraydataSource;


@end
@implementation ShangpinAddViewController

- (ShangchengRcommandDataTool *)tool{
    if (_tool == nil) {
        _tool = [[ShangchengRcommandDataTool alloc]init];
        
    }
    return _tool;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];


}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
        
        self.title = @"任务添加";
        
        
        [g_winDic setObject:[NSNumber numberWithInt:1] forKey:[NSString stringWithFormat:@"%@", self]];

        
        UIBarButtonItem *buttonLeft = [Common2 CreateNavBarButton:self setEvent:@selector(LeftBarButtonItemPressed) background:@"back" setTitle:nil];
        self.navigationItem.leftBarButtonItem = buttonLeft;
        
        
                UIBarButtonItem *buttonRight = [Common2 CreateNavBarButton:self setEvent:@selector(RightBarButtonItemPressed) background:nil setTitle:@"提交"];
        		self.navigationItem.rightBarButtonItem = buttonRight;
        
        
    }
    return self;
}

//点击返回按钮返回主界面
- (void)LeftBarButtonItemPressed
{
    [self.navigationController popViewControllerAnimated:YES];
//     [self dismissViewControllerAnimated:YES completion:nil];
}



//搜索页面
- (void)RightBarButtonItemPressed
{
    

    
    if (_noteTextView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入任务内容"];
        [_noteTextView becomeFirstResponder];
        return;
    }
    
    if (_imgUrl==nil ||[_imgUrl isEqualToString:@""] ) {
        [SVProgressHUD showErrorWithStatus:@"请上传任务图片"];
        
        return;
    }
    

    
    //    [SVProgressHUDManager showWithStatus:@"提交中"];
    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    
// 
//    [dic setValue:_imgUrl forKey:@"cover"];
//
//    [dic setValue:_noteTextView.text forKey:@"description"];
  

    NSString *strContent =_noteTextView.text;

    NSString *userid  = [DemoGlobalClass sharedInstance].userName;
    
    [self.tool AddRenwuData:userid StrJifen:_str_action_repeat  StrContent:strContent StrImageUrl:_imgUrl block:^(id json) {
        
        NSString *sessionId =@"";
        if([SFHFKeychain getPasswordForUsername:@"UDID" andServiceName:KEY_UUID error:nil].length>0)
        {
            sessionId = [SFHFKeychain getPasswordForUsername:@"UDID" andServiceName:KEY_UUID error:nil];
            
        }
        [self.tool update_userinfoData:[DemoGlobalClass sharedInstance].userName op:@"zhili" block:^(id json) {
            NSLog(@"%@",json);
            NSDictionary* dic = json[@"item"];
            NSString *strzhili= [dic objectForKey:@"zhili"];
            
   [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_getuserinfopop object:nil];
            
            
            
        }];
        
        [Common2 TipDialog:@"发布成功"];
//        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    

    
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _str_action_repeat=@"1";
    

    _dataSource = [[NSMutableArray alloc] init];

   
    _Btn_Muban.frame = CGRectMake(12, 68-NavHeight, ScreenWidth*304/320, 45);
    _Btn_Muban.layer.masksToBounds = YES;
    _Btn_Muban.layer.cornerRadius = 3;
    _imgview_bg.frame = CGRectMake(10, 120-NavHeight, ScreenWidth*306/320, 145);
    
    
    //文本输入框
    _noteTextView = [[BRPlaceholderTextView alloc]init];
    _noteTextView.frame = CGRectMake(12, 122-NavHeight, ScreenWidth*304/320, 141);
    _noteTextView.keyboardType = UIKeyboardTypeDefault;
    //文字样式
    [_noteTextView setFont:[UIFont fontWithName:@"Heiti SC" size:15.5]];
    _noteTextView.maxTextLength = kMaxTextCount;
    [_noteTextView setTextColor:[Common2 colorWithHexString:@"#666666"]];
    _noteTextView.delegate = self;
    _noteTextView.font = [UIFont boldSystemFontOfSize:15.5];
    _noteTextView.placeholder= @"   请输入任务内容...";
    self.noteTextView.returnKeyType = UIReturnKeyDone;
    [self.noteTextView setPlaceholderColor:[Common2 colorWithHexString:@"#666666"]];
    [self.noteTextView setPlaceholderOpacity:1];
    _noteTextView.textContainerInset = UIEdgeInsetsMake(2, 10, 2, 10);
    [self.view addSubview:_noteTextView];
    
    UILabel * labelcenter = [[UILabel alloc]initWithFrame:CGRectMake(10,280-NavHeight, 80, 30)];
    labelcenter.backgroundColor =[UIColor clearColor];
    labelcenter.font = [UIFont boldSystemFontOfSize:16];
    labelcenter.textColor =[Common2 colorWithHexString:@"#000000"];
    labelcenter.text = @"任务积分:";
    labelcenter.textAlignment= NSTextAlignmentCenter;
    [self.view addSubview:labelcenter];
    
    _numberButton_action = [[PPNumberButton alloc] initWithFrame:CGRectMake(100, 280-NavHeight, 110, 30)];
    //开启抖动动画
    _numberButton_action.shakeAnimation = YES;
    [_numberButton_action setImageWithincreaseImage:[UIImage imageNamed:@"increase_normal"] decreaseImage:[UIImage imageNamed:@"decrease_normal"]];
    [_numberButton_action setTitleWithNum:@"1"];
    _numberButton_action.numberBlock = ^(NSString *num){
        NSLog(@"%@",num);
        _str_action_repeat = [NSString stringWithFormat:@"%@", num];
        
    };
    [self.view addSubview:_numberButton_action];
    
    
    _lbl_img.frame = CGRectMake(8, 340-NavHeight, 80, 30);
    _lbl_img.font = [UIFont boldSystemFontOfSize:16];
    
    _Btn_image.frame = CGRectMake(100, 320-NavHeight, 100, 100);

    
    _Btn_ok.frame = CGRectMake(10, 430-NavHeight, ScreenWidth*320/320-20, 50);
    
    _Btn_ok.layer.masksToBounds = YES;
    _Btn_ok.layer.cornerRadius = 3;
    

    
//    _Txt_name.returnKeyType = UIReturnKeyNext;
//    _Txt_price.returnKeyType = UIReturnKeyNext;
//    _Txt_count.returnKeyType = UIReturnKeyNext;
    
    
    _Txt_name.keyboardType = UIKeyboardTypeDefault;
    [_Txt_price setKeyboardType:UIKeyboardTypeNumberPad];
    [_Txt_price_original setKeyboardType:UIKeyboardTypeNumberPad];
    [_Txt_count setKeyboardType:UIKeyboardTypeNumberPad];
    
    [HttpTools getWithURL2:qiniu_TokenUrl params:nil success:^(id json) {
        _qiniuToken =json;
        NSLog(@"getMeishiList = %@",json);
    } failure:^(NSError *error) {
        
    }];
    

//    _Txt_name.text =_str_name;
//    _Txt_price.text =_str_price;
//    _Txt_count.text = [NSString stringWithFormat:@"%d",_str_count];
//    _Txt_content.text =_str_content;
//
//
// [_Btn_image sd_setImageWithURL:[NSURL URLWithString:_str_image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"compose_pic_add"]];
    
    NSDictionary *dic_userinfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userinfo"];
    NSString *strbirthday = [dic_userinfo objectForKey:@"birthday"];
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [dateFormatter dateFromString:strbirthday];
    
    NSInteger intage=1;
    intage=[self ageWithDateOfBirth:date];
    
    int agetype=1;
    if(intage>=0&&intage<2)
    {
        agetype=1;
    }
    else if(intage>=2&&intage<4)
    {
        agetype=2;
    }
    else if(intage>=4&&intage<5)
    {
        agetype=3;
    }
    else if(intage>=5&&intage<6)
    {
        agetype=4;
    }
    else if(intage>=6&&intage<8)
    {
        agetype=5;
    }
    else if(intage>=8&&intage<12)
    {
        agetype=6;
    }

    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    

    [dic setValue:[NSString stringWithFormat:@"%d",agetype] forKey:@"agetype"];
    
    //获得侧边数据
    [self.tool get_RenwumubanListbyageListData:dic block:^(id json) {


         [_dataSource removeAllObjects];
    
        _dataSource  =json[@"items"];
        _arraydataSource = [[NSMutableArray alloc] init ];
        for(NSDictionary *dic in _dataSource)
        {
            NSString *content=   [dic objectForKey:@"content"];
            [_arraydataSource addObject:content];
            
        }
        

     
        
    }];

    

    
}


- (NSInteger)ageWithDateOfBirth:(NSDate *)date;
{
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return iAge;
}

- (IBAction)btnClickedOnMuban:(UIButton *)sender {

    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"模板选择" style:MHSheetStyleWeiChat itemTitles:_arraydataSource];
    actionSheet.cancleTitle = @"取消选择";
    __weak typeof(self) weakSelf = self;
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = [NSString stringWithFormat:@"第%ld行,%@",index, title];
        _noteTextView.text=title;
//        [weakSelf.selectSource replaceObjectAtIndex:indexPath.row withObject:text];
//        [weakSelf.tableView reloadData];
    }];

    
//        MHSheetViewController *chatVC = [[MHSheetViewController alloc] init];
//        [self.navigationController pushViewController:chatVC animated:YES];
    

}

#pragma mark - 按钮响应事件
- (void)btnClickedOnModify:(UIButton *)sender {
    
    
    
    @try {
        //需要捕获的数据处理
        NSMutableArray *muArrSource = [NSMutableArray arrayWithArray:[GlobalFunc parseArrFromFile:oyxc_area]];
        
        UIWindow *tmpWindow = [[UIApplication sharedApplication] keyWindow];
        if ([tmpWindow.subviews containsObject:_myPick]) {
            return ;
        }
        _myPick = [[MyPicker3View alloc] initPickViewWithArray:muArrSource delegate:self];
        [_myPick setComponentByProviceID:_proviceID cityID:_cityID areaID:_areaID];
        [_myPick showPick];
    }
    @catch (NSException *exception) {
        NSString *msg = [NSString stringWithFormat:@"%@ %s %d crash reason:%@",self.class,__FUNCTION__,__LINE__,exception];
        NSLog(@"%@",msg);
        
        [GlobalFunc addErrorTitle:@"数据访问错误" errorStr:msg requestStr:@"" resPonseStr:@""];
    }
    @finally {
        
    }
}





- (void)butEventLogin
{
//    LoginShopVC *login = [[LoginShopVC alloc] init];
//    [login setFid:self];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
//    
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    [window.rootViewController presentModalViewController:nav animated:YES];
    
}


- (IBAction)UploadClicked:(UIButton *)sender
{
    NSString *userid  = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    if (!userid) {
                [self butEventLogin];
//        return;
    }
    
    _bchangeHead = YES;
    //选择图片
    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
    picker.maximumNumberOfSelection =1;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)FenleiClicked:(UIButton *)sender
{

//    CategoryListViewController *searchList = [[CategoryListViewController alloc] init];
//    [self.navigationController pushViewController:searchList animated:YES];
    
}

- (IBAction)OKClicked:(UIButton *)sender
{
    
    [self RightBarButtonItemPressed];
    
}


- (void)butSubmit
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

//- (void)loadPortrait {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
//        NSURL *portraitUrl = [NSURL URLWithString:@"http://www.baidu.com/img/baidu_sylogo1.gif"];
//        //        UIImage *protraitImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:portraitUrl]];
//        //        UIImage *protraitImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:portraitUrl]];
//        //        [headPhoto setImage:[UIImage imageNamed:@"defaultHeadImage.png"]];
//        //        UIImage *protraitImg =[UIImage imageNamed:@"defaultHeadImage.png"];
//        UIImage *protraitImg = [UIImage imageNamed:@"img.bundle/userInfo/defaultHeadImage.png"];
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            self.portraitImageView.image = protraitImg;
//            
//            
//            
//            NSString *photo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userimg"];
//            if (photo) {
//                NSURL *url=[NSURL URLWithString:photo];
//                [self.portraitImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"img.bundle/userInfo/defaultHeadImage.png"]];
//            }
//            
//            
//            
//            
//            
//            
//        });
//    });
//}

- (void)editPortrait {
    
    
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    
    
    

    //    [self.portraitImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"img.bundle/userInfo/defaultHeadImage.png"]];
    
    //    NSData *data = UIImagePNGRepresentation(self.portraitImageView.image);
//    NSData *data = UIImagePNGRepresentation(editedImage);
//    NSString *urlString = [NSString stringWithFormat:@"%@", UPDATE_PHOTO_INTERFACE_URL];
//    NSURL *url = [[NSURL alloc]initWithString:urlString];
//    //以表格形式的请求对象
//    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
//    request.delegate =self;
//    request.requestMethod = @"POST";//设置请求方式
//    //添加请求内容
//    [request addData:data withFileName:[NSString stringWithFormat:@"%d.png",arc4random()] andContentType:@"image/png" forKey:@"file"];
//    NSString *userid  = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
//    [request addPostValue:userid forKey:@"userid"];
//    //开始异步请求
//    [request startAsynchronous];
//    
//    //如果成功则自动执行
//    [request setDidFinishSelector:@selector(requestedSuccessfully:)];
//    //如果失败则自动执行
//    [request setDidFailSelector:@selector(requestedFail)];
//    
//    
//    
//    self.portraitImageView.image = editedImage;
//    [cropperViewController dismissViewControllerAnimated:YES completion:^{
//        // TO DO
//    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if(actionSheet.tag ==101)
    {
        //    TSLocateView *locateView = (TSLocateView *)actionSheet;
        //    TSLocation *location = locateView.locate;
        //    NSLog(@"city:%@ lat:%f lon:%f", location.city, location.latitude, location.longitude);
        //    lbl_city.text = [NSString stringWithFormat:@"%@ ", location.city];

        //You can uses location to your application.
        if(buttonIndex == 0) {
            NSLog(@"Cancel");
        }else {
            NSLog(@"Select");
        }
    }
    else
    {
        
        if (buttonIndex == 0) {
            // 拍照
            if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([self isFrontCameraAvailable]) {
                    controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                }
                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                controller.mediaTypes = mediaTypes;
                controller.delegate = self;
                [self presentViewController:controller
                                   animated:YES
                                 completion:^(void){
                                     NSLog(@"Picker View Controller is presented");
                                 }];
            }
            
        } else if (buttonIndex == 1) {
            // 从相册中选取
            if ([self isPhotoLibraryAvailable]) {
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                controller.mediaTypes = mediaTypes;
                controller.delegate = self;
                [self presentViewController:controller
                                   animated:YES
                                 completion:^(void){
                                     NSLog(@"Picker View Controller is presented");
                                 }];
            }
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark portraitImageView getter
- (UIImageView *)portraitImageView {
    if (!_portraitImageView) {
        CGFloat w = 70.0f; CGFloat h = w;
        CGFloat x = (self.view.frame.size.width - w) / 2;
        CGFloat y = (self.view.frame.size.height - h) / 36;
        _portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_portraitImageView.layer setCornerRadius:(_portraitImageView.frame.size.height/8)];
        [_portraitImageView.layer setMasksToBounds:YES];
        [_portraitImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_portraitImageView setClipsToBounds:YES];
        _portraitImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        _portraitImageView.layer.shadowOffset = CGSizeMake(4, 4);
        _portraitImageView.layer.shadowOpacity = 0.5;
        _portraitImageView.layer.shadowRadius = 0.0;
        _portraitImageView.layer.borderColor = [[UIColor blackColor] CGColor];
        _portraitImageView.layer.borderWidth = 0.0f;
        _portraitImageView.userInteractionEnabled = YES;
        _portraitImageView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
        [_portraitImageView addGestureRecognizer:portraitTap];
    }
    return _portraitImageView;
}









- (void)changeHead {
    
    NSString *userid  = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    if (!userid) {
//        [self butEventLogin];
        return;
    }
    
    _bchangeHead = YES;
    //选择图片
    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
    picker.maximumNumberOfSelection =1;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:NULL];
}



//相册选择的
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    if( _bchangeHead )
    {//修改头像
        UIImage * photo = [UIImage imageWithCGImage:[[assets.lastObject defaultRepresentation] fullScreenImage]];
        if( photo == nil ) return;
        
        RSKImageCropViewController *imageCropVC = nil;
        
        imageCropVC = [[RSKImageCropViewController alloc] initWithImage:photo cropMode:RSKImageCropModeSquare];
        imageCropVC.dataSource = self;
        imageCropVC.delegate = self;
        //        [self pushViewController:imageCropVC];
        [self.navigationController pushViewController:imageCropVC animated:YES];
    }
    else
    {//修改个人相册
        //        BOOL b = NO;
        //        for (  ALAsset * one in assets  )
        //        {
        //            [_allimgs addObject:[UIImage imageWithCGImage: [[one defaultRepresentation] fullScreenImage] ]];
        //            b = YES;
        //        }
        //        if( b )
        //            [self updatePhotosLayout];
    }
}

//通过相册拍照的
-(void)assetsPickerControllerDidCamera:(CTAssetsPickerController *)picker imgage:(UIImage*)image
{
    if( _bchangeHead )
    {
        RSKImageCropViewController *imageCropVC = nil;
        
        imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image cropMode:RSKImageCropModeSquare];
        imageCropVC.dataSource = self;
        imageCropVC.delegate = self;
        [self.navigationController pushViewController:imageCropVC animated:YES];
    }
    else
    {
        //        if (_allimgs.count<4) {
        //            [_allimgs addObject:image];
        //            [self updatePhotosLayout];
        //        }
    }
}

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [controller.navigationController popViewControllerAnimated:YES];
}

//- (CGRect)imageCropViewControllerCustomMaskRect:(RSKImageCropViewController *)controller
//{
//    return   CGRectMake(self.view.center.x-m_imageIconV.frame.size.width/2, self.view.center.y-m_imageIconV.frame.size.height/2, m_imageIconV.frame.size.width,  m_imageIconV.frame.size.height);
//    
//}
//- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller
//{
//    return [UIBezierPath bezierPathWithRect:CGRectMake(self.view.center.x- m_imageIconV.frame.size.width/2, self.view.center.y-m_imageIconV.frame.size.height/2, m_imageIconV.frame.size.width, m_imageIconV.frame.size.height)];
//}
- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage
{
    
    [controller.navigationController popViewControllerAnimated:YES];
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
//    [_Btn_image setImage:croppedImage forState:UIControlStateNormal];
    
     [self showHudInView:self.view hint:@"图片上传中"];
    
//    NSData *data=UIImagePNGRepresentation(croppedImage);
    NSData *data=UIImageJPEGRepresentation(croppedImage,0.1);
    
    //    NSString *token = @"XQVVimLvG63eLDhOzncOVcp0DXubWUVBarlgLYhv:hzMjOM-e8wFRvCYTrpPN6_axIkI=:eyJzY29wZSI6Imx1Ym8iLCJkZWFkbGluZSI6MTQ3MDQ5OTU0OH0=";
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    [upManager putData:data key:nil token:_qiniuToken
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  NSLog(@"info = %@\n", info);
                  NSLog(@"key = %@\n",key);
                  NSLog(@"resp = %@\n", resp);
                  NSLog(@"key = %@\n", [resp objectForKey:@"key"]);
                  
                  NSString *strurl = [NSString stringWithFormat:@"%@%@",@"http://img.loobot.net/",[resp objectForKey:@"key"]];
                  NSLog(@"resp = %@\n", strurl);
//                  [m_imageIconV sd_setImageWithURL:[NSURL URLWithString:strurl] placeholderImage:[UIImage imageNamed:@"compose_pic_add"]];
                  

                  
                  [_Btn_image sd_setImageWithURL:[NSURL URLWithString:strurl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"compose_pic_add"]];
        

                  _imgUrl =strurl;
                  
                  [self hideHud];
                  
                  
                  
              } option:nil];

    
    
    
    


}


@end
