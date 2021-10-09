//
//  GCUIViewController.m
//  JinSeShiJi
//
//  Created by zxs on 13-9-30.
//
//

#import "GCUIViewController.h"

@interface GCUIViewController ()

@end

@implementation GCUIViewController
@synthesize autoSize,autoV,height,statusBarHeight,width;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    height=self.view.frame.size.height;
    width=self.view.frame.size.width;
    if (IOS7_OR_LATER) {
        
        
        
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        
        //        self.navigationController.navigationBar.barTintColor =[UIColor grayColor];
        //        self.tabBarController.tabBar.barTintColor =[UIColor grayColor];
        
        self.navigationController.navigationBar.translucent = NO;
        self.tabBarController.tabBar.translucent = NO;
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = YES;
        
        
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        
        
        
        //        self.edgesForExtendedLayout = UIRectEdgeNone;
        //        CGRect viewBounds = self.view.bounds;
        //        float navBarHeight = self.navigationController.navigationBar.frame.size.height + 20;
        //        viewBounds.size.height = ([[UIScreen mainScreen] bounds].size.height) - navBarHeight;
        //        self.view.bounds = viewBounds;
        
        
        self.autoSize=height/416;
        self.autoV=height-480;
        statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    }
    else{
        self.autoSize=height/416;
        self.autoV=height-460;
        statusBarHeight = 0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle

{
    [super preferredStatusBarStyle];
    return UIStatusBarStyleLightContent;
}


- (BOOL)prefersStatusBarHidden

{
    [super prefersStatusBarHidden];
    return NO;
}


@end

