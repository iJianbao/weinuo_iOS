//
//  AddressCell.h
//  天天网
//
//  Created by ios on 13-12-9.
//  Copyright (c) 2013年 Ios. All rights reserved.
//

#import "BaseCell.h"

@interface HealthCell : BaseCell

@property (strong, nonatomic) IBOutlet UIView *viewBg;//背景图片


@property (weak, nonatomic) IBOutlet UILabel *labelRiqi;//收货人姓名+手机号码
@property (weak, nonatomic) IBOutlet UILabel *labelZuozishijian;//收货地址
@property (weak, nonatomic) IBOutlet UILabel *labelZhanzishijian;//收货地址
@property (weak, nonatomic) IBOutlet UILabel *labelZuozhanbi;//收货地址

@end
