//
//  LongSitWaringView.h
//  lanya
//
//  Created by apple on 2020/3/22.
//  Copyright © 2020 ronglian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LongSitWaringView : UIView

@property (weak, nonatomic) IBOutlet UILabel *waringLabel;
@property (weak, nonatomic) IBOutlet UIImageView *standSitImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (nonatomic, copy) NSString *longTimeStr;
@property (nonatomic, copy) void(^sureBlock)(BOOL isClose);

- (void)startAnimation;
- (void)stopAnimation;


@end

NS_ASSUME_NONNULL_END
