//
//  ToolCell.h
//  EasyBlueTooth
//
//  Created by nf on 2017/8/18.
//  Copyright © 2017年 chenSir. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EasyPeripheral.h"

@interface MainBlueCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *nameImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *RSSILabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *servicesLabel;


@property (nonatomic,strong)EasyPeripheral *peripheral ;

+ (CGFloat)cellHeight ;

@end
