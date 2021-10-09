//
//  LongSitWaringView.m
//  lanya
//
//  Created by apple on 2020/3/22.
//  Copyright © 2020 ronglian. All rights reserved.
//

#import "LongSitWaringView.h"

@implementation LongSitWaringView

- (void)awakeFromNib {
    [super awakeFromNib];
    _waringLabel.text = LocationLanguage(@"warning1", @"警告");
    [_sureButton setTitle:[NSString stringWithFormat:@"  %@  ", LocationLanguage(@"continue_long_tip", @"稍后提示")] forState:UIControlStateNormal];
    _sureButton.layer.borderWidth = 0.5;
    _sureButton.layer.borderColor = [UIColorFromRGB(0x9AA6FF) CGColor];
    _sureButton.layer.cornerRadius = 4;
    
    [_closeButton setTitle:[NSString stringWithFormat:@"  %@  ", LocationLanguage(@"close_long_tip", @"关闭")] forState:UIControlStateNormal];
    _closeButton.layer.borderWidth = 0.5;
    _closeButton.layer.borderColor = [UIColorFromRGB(0x9AA6FF) CGColor];
    _closeButton.layer.cornerRadius = 4;
}

- (void)startAnimation {
    _standSitImageView.animationImages = @[[UIImage imageNamed:@"up_1"], [UIImage imageNamed:@"zuo1"]];
    _standSitImageView.animationDuration = 0.8;
    _standSitImageView.animationRepeatCount = 0;
    [_standSitImageView startAnimating];
}

- (void)stopAnimation {
    [_standSitImageView stopAnimating];
    [self removeFromSuperview];
}

- (void)setLongTimeStr:(NSString *)longTimeStr {
    int min = [longTimeStr intValue];
    int hour = min / 60;
    min = min - hour * 60;
    NSString *s1 = [NSString stringWithFormat:@" %d %@ %d %@", hour, LocationLanguage(@"hours", @"小时"), min, LocationLanguage(@"minutes", @"分钟")];
    NSString *showStr = [NSString stringWithFormat:LocationLanguage(@"overHours", @"超过时间"), s1];
    showStr = LocationLanguage(@"localNotifiContent", @"时间到了，该站起来了");
    _contentLabel.text = showStr;
}
- (IBAction)sureBtnAction:(id)sender {
    if (_sureBlock) {
        _sureBlock (NO);
    }
    [self stopAnimation];
}
- (IBAction)closeBtnAction:(id)sender {
    if (_sureBlock) {
        _sureBlock (YES);
    }
    [self stopAnimation];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
