

#import "MeitikuViewController.h"
#import "MeitikuTitleView.h"
#import "Common2.h"
#import "Global.h"

//#import "LoginVC.h"
//#import "RegisterVC.h"
//#import "WenziViewController.h"
//#import "MyOrderListViewController.h"
//#import "UserOrderListViewController.h"
#import "ControlViewController.h"
#import "HealthViewController.h"
//#import "KoudaigushiByageViewController.h"
#import "BlueTouchSettingViewController.h"
#import "ExampleTableViewController.h"
#import "VVWaterWaveView.h"
#import "ToolViewController.h"
#import "LinkViewController.h"


@interface MeitikuViewController ()<UIScrollViewDelegate>

//头部的选项卡
@property(nonatomic,strong) MeitikuTitleView *titleView;
//滚动条
@property(nonatomic,strong) UIScrollView *scrollView;

//大数组，子控制器的
@property(nonatomic,strong) NSMutableArray *childViews;
@property(nonatomic,strong) HealthViewController *vCorderlist2;


@end

@implementation MeitikuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     
        
        [g_winDic setObject:[NSNumber numberWithInt:1] forKey:[NSString stringWithFormat:@"%@", self]];
        
        self.title = LocationLanguage(@"smartDeskControl", @"智能升降桌");
        self.hidesBottomBarWhenPushed = NO;
        
//        UIBarButtonItem *buttonLeft = [Common2 CreateNavBarButton:self setEvent:@selector(LeftBarButtonItemPressed) background:@"btn_back.png" setTitle:nil];
//        self.navigationItem.leftBarButtonItem = buttonLeft;
        [self.navigationItem setHidesBackButton:YES];
        
        UIBarButtonItem *buttonRight = [Common2 CreateNavBarButton:self setEvent:@selector(RightBarButtonItemPressed) background:@"btn_set.png" setTitle:nil];
        self.navigationItem.rightBarButtonItem = buttonRight;
        
//        UIBarButtonItem *buttonRight = [Common2 CreateNavBarButton:self setEvent:@selector(RightBarButtonItemPressed) background:nil setTitle:@"发布动态"];
//        self.navigationItem.rightBarButtonItem = buttonRight;
        
        
        //        UIBarButtonItem *buttonLeft = [Common2 CreateNavBarButton:self setEvent:@selector(LeftBarButtonItemPressed) background:nil setTitle:@"发布动态"];
        //		self.navigationItem.leftBarButtonItem = buttonLeft;
        //		[buttonLeft release];
        
    }
    return self;
}


//返回按钮
- (void)LeftBarButtonItemPressed {
    [self.navigationController popToRootViewControllerAnimated:YES];
//    LinkViewController *videoRender = [[LinkViewController alloc] init];
//    videoRender.navigationController.navigationBarHidden = YES;
//    [self.navigationController pushViewController:videoRender animated:YES];
}

//返回按钮
- (void)RightBarButtonItemPressed {
    BlueTouchSettingViewController *videoRender = [[BlueTouchSettingViewController alloc] init];
    videoRender.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:videoRender animated:YES];
}


- (void)viewDidLoad {
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)) {
        self.navigationController.navigationBar.translucent = NO;
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [Common2 colorWithHexString:@"#ffffff"];
    
    [self titleView];
    // 添加scrollView
    [self scrollView];
    // 添加各子控制器
    [self setupChildVcs];
}

- (void)netRequestSuccess:(NSDictionary *)dic tag:(NSUInteger) tag {
    @try {
        
    }
    @catch (NSException *exception) {
        NSString *msg = [NSString stringWithFormat:@"%@ %s %d crash reason:%@",self.class,__FUNCTION__,__LINE__,exception];
        NSLog(@"%@",msg);
        //        [GlobalFunc addErrorTitle:@"数据访问错误" errorStr:msg requestStr:@"" resPonseStr:@""];
    }
    @finally {
        
    }
}


- (void)netRequestFailedTag:(NSUInteger)tag {
    
}


- (NSMutableArray *)childViews {
    if(_childViews == nil) {
        _childViews = [NSMutableArray array];
    }
    return _childViews;
}

- (UIScrollView *)scrollView {
    if(_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,  _titleView.height, ScreenWidth, ScreenHeight)];
        if(isPadYES) {
            _scrollView.frame=CGRectMake(0,  _titleView.height-20, ScreenWidth, ScreenHeight -NavHeight- ScreenWidth*20/220);
        }
        _scrollView.delegate=self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(2 * ScreenWidth, 0);
        _scrollView.bounces = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (MeitikuTitleView *)titleView {
    if(_titleView == nil) {
        CGRect rect = CGRectMake(0, 0, ScreenWidth, ScreenWidth*40/220);
        if(isPadYES) {
            rect = CGRectMake(0, -10, ScreenWidth, ScreenWidth*36/320);
        }
        _titleView =[[MeitikuTitleView alloc] initWithFrame:rect];
        _titleView.layer.borderColor = LIGHTGRAY.CGColor;
//        _titleView.layer.borderWidth = 1.0;
        _titleView.backgroundColor = [Common2 colorWithHexString:@"#0B0088"];
        __weak typeof(self) weakSelf = self;
        _titleView.meitikuBlcok = ^(int type) {
            [weakSelf.scrollView setContentOffset:CGPointMake(type * UIScreenW, 0) animated:YES];
        };
        [self.view addSubview:_titleView];
    }
    return _titleView;
}

#pragma mark 添加各子控制器
- (void)setupChildVcs {
    [self.childViews removeAllObjects];
    //在线顾问控制器
    [self addChildViewController:self.controlVc];
    [self.childViews addObject:self.controlVc.view];
    //我的顾问控制器
    _vCorderlist2 = [[HealthViewController  alloc] init];
    [self addChildViewController:_vCorderlist2];
    [self.childViews addObject:_vCorderlist2.view];
        
    for(int i=0; i< self.childViews.count; i++) {
        UIView *childV = self.childViews[i];
        CGFloat childVX = UIScreenW * i ;
        childV.frame = CGRectMake(childVX, 0, UIScreenW, ScreenHeight -  40);
        [self.scrollView addSubview:childV];
    }
}


#pragma mark 滚动条
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    if(scrollView == _scrollView) {
        if(_scrollView.contentOffset.x / UIScreenW ==0) {
            [_titleView wanerSelected:0];
        }else if (_scrollView.contentOffset.x / UIScreenW ==1) {
            [_titleView wanerSelected:1];
            [_vCorderlist2 getDataSouce];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
        //百分点页面统计
    //  [BfdAgent endPageView:self pageName: @"MyOrderViewController" options: @{@"uid":[GlobalFunc getUserId]}];
}

- (ControlViewController *)controlVc {
    if (_controlVc == nil) {
        _controlVc = [[ControlViewController alloc] init];
    }
    return _controlVc;
}

- (void)dealloc {
    NSLog(@"%@ --- %s", self, __FUNCTION__);
}

@end
