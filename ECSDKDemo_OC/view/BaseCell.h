//
//  BaseCell.h
//  zf
//
//  Created by zhangfeng on 13-7-12.
//  Copyright (c) 2013年 zhangfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIImageView+WebCache.h"
//#import "UIView+Common.h"

@protocol CellDelegate;

@interface BaseCell : UITableViewCell

@property (nonatomic, weak) id<CellDelegate> delegate;

@end


@protocol CellDelegate <NSObject>

- (void)btnClicked:(id)sender cell:(BaseCell *)cell;
- (void)btnClickeds:(id)sender cell:(BaseCell *)cell;

@end
