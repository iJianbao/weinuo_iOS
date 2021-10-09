//
//  MeitikuTitleView.m
//  lanya
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 ronglian. All rights reserved.
//

#import "MeitikuTitleView.h"

@interface MeitikuTitleView()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation MeitikuTitleView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    [self.leftButton addTarget:self
                        action:@selector(leftButtonAction)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self.rightButton addTarget:self
                         action:@selector(rightButtonAction)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.lineView setTransform:CGAffineTransformMakeTranslation(0, 0)];
}

- (void)wanerSelected:(int)type {
    [UIView animateWithDuration:0.2 animations:^{
        [self.lineView setTransform:CGAffineTransformMakeTranslation(type == 1 ? self.width/2 : 0, 0)];
    }];
}

- (void)leftButtonAction {
    if (_meitikuBlcok) {
        _meitikuBlcok(0);
    }
}

- (void)rightButtonAction {
    if (_meitikuBlcok) {
        _meitikuBlcok(1);
    }
}

- (UIButton *)leftButton {
    if (_leftButton == nil) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _leftButton.frame = CGRectMake(0, 0, self.width/2, self.height);
        [_leftButton setTitle:LocationLanguage(@"control", @"控制") forState:UIControlStateNormal];
        [_leftButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self addSubview:_leftButton];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (_rightButton == nil) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _rightButton.frame = CGRectMake(self.width/2, 0, self.width/2, self.height);
        [_rightButton setTitle:LocationLanguage(@"aboutHealth", @"健康") forState:UIControlStateNormal];
        [_rightButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self addSubview:_rightButton];
    }
    return _rightButton;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.frame = CGRectMake(0, self.height - 2, self.width/2, 2);
        _lineView.backgroundColor = UIColor.whiteColor;
        [self addSubview:_lineView];
    }
    return _lineView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
