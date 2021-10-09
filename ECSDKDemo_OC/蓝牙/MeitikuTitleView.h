//
//  MeitikuTitleView.h
//  lanya
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 ronglian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeitikuTitleView : UIView

@property (nonatomic, copy) void(^meitikuBlcok)(int type);

- (void)wanerSelected:(int)type;

@end

NS_ASSUME_NONNULL_END
