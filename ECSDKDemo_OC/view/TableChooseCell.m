//
//  MulChooseCell.m
//  MulChooseDemo
//
//  Created by L2H on 16/7/13.
//  Copyright © 2016年 ailk. All rights reserved.
//

#import "TableChooseCell.h"
#define HorizonGap 15
#define TilteBtnGap 10
#define ColorRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation TableChooseCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, ColorRGB(0xf7f7f7).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 0.5, rect.size.width, 0.5));
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self MakeView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)MakeView{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.SelectIconBtn];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top);
        make.height.equalTo(self.contentView.mas_height);
    }];
    [self.SelectIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.titleLabel.mas_top);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(self.contentView.mas_height);
        
        //        [_SelectIconBtn setImage:[UIImage imageNamed:@"table_Selected"] forState:UIControlStateNormal];
        //        [_SelectIconBtn setImage:[UIImage imageNamed:@"table_Selected"] forState:UIControlStateSelected];
    }];
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        if(isPadYES)
        {
            _titleLabel.font = [UIFont systemFontOfSize:24];
        }
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

-(UIButton *)SelectIconBtn{
    if (!_SelectIconBtn) {
        _SelectIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_SelectIconBtn setImage:[UIImage imageNamed:@"table_UnSelect"] forState:UIControlStateNormal];
        [_SelectIconBtn setImage:[UIImage imageNamed:@"table_Selected"] forState:UIControlStateSelected];
        _SelectIconBtn.userInteractionEnabled = NO;
    }
    return _SelectIconBtn;
}


-(void)UpdateCellWithState:(BOOL)select{
    self.SelectIconBtn.selected = select;
    _isSelected = select;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
