//
//  RedPacketViewController.h
//  天天网
//
//  Created by zhaoweibing on 14-9-5.
//  Copyright (c) 2014年 oyxc. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "GCUIViewController.h"

@interface JiankangListViewController : GCUIViewController {
    
    
    
}

@property (weak, nonatomic) IBOutlet UIButton *regBtn;

@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *zhilingText;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@property (nonatomic, strong) NSString *strid;
@property (nonatomic, strong) NSString *strName;
- (IBAction)leftBarClicked:(UIButton *)sender;

@end
