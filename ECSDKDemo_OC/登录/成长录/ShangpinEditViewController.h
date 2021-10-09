//
//  ShangpinEditViewController.h
//  bulkBuy
//
//  Created by 孙正丰 on 13-10-7.
//  Copyright (c) 2013年 孙正丰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCUIViewController.h"
//#import "TSLocateView.h"
#import "MBProgressHUD.h"
#import "MyPicker3View.h"
@interface ShangpinAddViewController : GCUIViewController <Pick3Delegate,UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate>
{

    
    NSDictionary *m_userDic;

    
    MBProgressHUD *m_progress_;
    
//    UIImageView *m_imageIconV;
    
    
    BOOL            _bchangeHead;
    
}

@property (weak, nonatomic) IBOutlet UIButton *Btn_ok;
@property (weak, nonatomic) IBOutlet UIButton *Btn_Muban;
@property (weak, nonatomic) IBOutlet UIButton *Btn_image;
@property (weak, nonatomic) IBOutlet UIButton *Btn_fenlei;
@property (weak, nonatomic) IBOutlet UITextField *Txt_name;
@property (weak, nonatomic) IBOutlet UITextField *Txt_price;
@property (weak, nonatomic) IBOutlet UITextField *Txt_price_original;
@property (weak, nonatomic) IBOutlet UITextField *Txt_count;
@property (weak, nonatomic) IBOutlet UITextField *Txt_content;

@property (weak, nonatomic) IBOutlet UILabel *lbl_img;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_price;
@property (weak, nonatomic) IBOutlet UILabel *lbl_price_original;
@property (weak, nonatomic) IBOutlet UILabel *lbl_count;





@property (nonatomic ,strong) NSString *str_image;
@property (nonatomic ,strong) NSString *str_name;
@property (nonatomic ,strong) NSString *str_price;
@property (nonatomic ,strong) NSString *str_price_original;
@property (nonatomic,assign) NSInteger str_count;
@property (nonatomic ,strong) NSString *str_content;


@property (weak, nonatomic) IBOutlet UIImageView *imgview_bg;


@property (strong, nonatomic) MyPicker3View *myPick;
- (void)setLoginOK;

//- (void)setPaymentOK;

- (void)selMyOrder;

- (void)selMyOrder2;

- (void)selJifen;

- (void)selToday;

@end
