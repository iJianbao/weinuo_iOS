//
//  RedPacketViewController.h
//  天天网
//
//  Created by zhaoweibing on 14-9-5.
//  Copyright (c) 2014年 oyxc. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "GCUIViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BLEManager.h"
@interface FengmingqiViewController : GCUIViewController <BLEManagerDelegate,UITableViewDelegate, UITableViewDataSource>{

    UITableView *m_tableView;
    NSMutableArray *m_arrayList;
    
    NSDictionary *m_userDic;
    
    UILabel *lbl_name;
    UILabel *lbl_nianling;
    
    UILabel *lbl_address;
    UILabel *lbl_userid;
    UIImageView *m_imageIconV;
    
    UILabel *lbl_sex;
    UILabel *lbl_age;
    UILabel *lbl_qianming;
    
    UIImageView *imageView_sex;
    
    BOOL            _bchangeHead;

}

@property (weak, nonatomic) IBOutlet UIButton *regBtn;


- (IBAction)leftBarClicked:(UIButton *)sender;

@end
