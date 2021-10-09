//
//  LoginVC.h
//  waimaidan2.0
//
//  Created by sunzhf on 13-4-3.
//  Copyright (c) 2013年 qianliqianxun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCUIViewController.h"
@interface ZhanzimoshiViewController : GCUIViewController<UITextFieldDelegate>{
    
    UITextField *m_txtUserName;
    UITextField *m_txtPassWord;
    id m_fvc;
}
@property (nonatomic, strong) NSString *strName;
- (void)setFid:(id)vc;
@end
