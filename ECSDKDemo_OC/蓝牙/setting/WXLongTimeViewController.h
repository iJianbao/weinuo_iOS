//
//  WXLongTimeViewController.h
//  lanya
//
//  Created by apple on 2020/3/22.
//  Copyright © 2020 ronglian. All rights reserved.
//

#import "GCUIViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WXLongTimeViewController : GCUIViewController

@property (nonatomic, copy) void(^WXCallBack)(BOOL refresh);

@end

NS_ASSUME_NONNULL_END
