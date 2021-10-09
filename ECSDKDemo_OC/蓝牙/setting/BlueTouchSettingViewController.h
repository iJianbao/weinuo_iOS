//
//  RedPacketViewController.h
//  天天网
//
//  Created by zhaoweibing on 14-9-5.
//  Copyright (c) 2014年 oyxc. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "GCUIViewController.h"
//#import "LoadingAnimation.h"
//#import "MJPhotoBrowser.h"
//#import "MJPhoto.h"
//#import "CTAssetsPickerController.h"
//#import "RSKImageCropViewController.h"
@interface BlueTouchSettingViewController : GCUIViewController<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate> {

    NSMutableArray *m_arrayList;
    
    NSDictionary *m_userDic;
    
    UILabel *lbl_name;
    UILabel *lbl_nianling;
    
    UILabel *lbl_address;
    UILabel *lbl_userid;
    UIImageView *m_imageIconV;
    UIImageView *m_imageBaobao;
    UILabel *lbl_sex;
    UILabel *lbl_age;
    UILabel *lbl_qianming;
    
    UIImageView *imageView_sex;
    
    BOOL            _bchangeHead;
    
//    LoadingAnimation *loadView;

}
@property (nonatomic, strong) UITableView *m_tableView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;


- (IBAction)leftBarClicked:(UIButton *)sender;

@end
