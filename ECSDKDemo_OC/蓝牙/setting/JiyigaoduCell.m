//
//  AddressCell.m
//  天天网
//
//  Created by ios on 13-12-9.
//  Copyright (c) 2013年 Ios. All rights reserved.
//

#import "JiyigaoduCell.h"

@implementation JiyigaoduCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - 按钮响应事件
- (IBAction)btnClickedOnAddress:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(btnClicked:cell:)]) {
        [self.delegate btnClicked:sender cell:self];
    } else {
        NSLog(@"代理没响应，快开看看吧");
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
