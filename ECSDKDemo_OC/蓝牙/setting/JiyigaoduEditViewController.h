//
//  LoginVC.h
//  waimaidan2.0
//
//  Created by sunzhf on 13-4-3.
//  Copyright (c) 2013年 qianliqianxun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCUIViewController.h"
@interface JiyigaoduEditViewController : GCUIViewController<UITextFieldDelegate>{
    
    UITextField *txtName;
    UITextField *txtGaodu;
    id m_fvc;
}
@property (nonatomic, strong) NSString *strID;
@property (nonatomic, strong) NSString *strName;
@property (nonatomic, strong) NSString *strGaodu;
- (void)setFid:(id)vc;
@end
