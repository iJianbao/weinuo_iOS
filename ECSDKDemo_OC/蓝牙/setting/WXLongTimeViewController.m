//
//  WXLongTimeViewController.m
//  lanya
//
//  Created by apple on 2020/3/22.
//  Copyright © 2020 ronglian. All rights reserved.
//

#import "WXLongTimeViewController.h"
#import "AppDelegate.h"

@interface WXLongTimeViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, assign) BOOL isRefresh;

@end

@implementation WXLongTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = LocationLanguage(@"setting_longtime", @"久坐提醒");
    self.view.backgroundColor = [Common2 colorWithHexString:@"#2B2B73"];
    UIBarButtonItem *buttonLeft = [Common2 CreateNavBarButton:self setEvent:@selector(leftBarClicked:)
                                                   background:@"btn_back.png" setTitle:nil];
    self.navigationItem.leftBarButtonItem = buttonLeft;
    
    [self.view addSubview:self.pickerView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *longTime = [[NSUserDefaults standardUserDefaults] objectForKey:Long_time];
    if (longTime.length == 0) {
        longTime = @"120";
    }
    int min = [longTime intValue];
    int hour = min / 60;
    min = min - hour * 60;
    
    [_pickerView selectRow:hour inComponent:0 animated:NO];
    [_pickerView selectRow:min inComponent:2 animated:NO];
    _isRefresh = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    int hour = (int)[_pickerView selectedRowInComponent:0];
    int min = (int)[_pickerView selectedRowInComponent:2];
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", hour * 60 + min] forKey:Long_time];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (_WXCallBack) {
        _WXCallBack(_isRefresh);
    }
}

- (void)leftBarClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        CGRect rect = CGRectMake(15, 20, self.view.bounds.size.width - 30, 218);
        _pickerView = [[UIPickerView alloc] initWithFrame:rect];
        _pickerView.layer.borderWidth = 1;
        _pickerView.layer.borderColor = [UIColor colorWithRed:255 green:1 blue:1 alpha:0.8].CGColor;
        _pickerView.layer.cornerRadius = 4;
        [_pickerView setDelegate:self];
        [_pickerView setDataSource:self];
    }
    return _pickerView;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 4;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *genderLabel = [[UILabel alloc] init];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.textColor = [UIColor whiteColor];
    if (component == 0) {
        genderLabel.text = [NSString stringWithFormat:@"%ld", (long)row];
    }else if (component == 1) {
        genderLabel.text = LocationLanguage(@"hours", @"小时");
    }else if (component == 2) {
        genderLabel.text = [NSString stringWithFormat:@"%ld", (long)row];
    }else {
        genderLabel.text = LocationLanguage(@"minutes", @"分钟");
    }
    return genderLabel;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return 24;
    }else if (component == 1) {
        return 1;
    }else if (component == 2) {
        return 60;
    }else {
        return 1;
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        _isRefresh = YES;
        NSString *showStr = [NSString stringWithFormat:@"%d %@ %d %@",
                             (int)row,
                             LocationLanguage(@"hours", @"小时"),
                             (int)[pickerView selectedRowInComponent:2],
                             LocationLanguage(@"minutes", @"分钟")];
        [Common2 TipDialog:[NSString stringWithFormat:LocationLanguage(@"setting_toast_longtime", @"您已设置久坐提醒时间为"), showStr]];
    }else if (component == 2) {
        _isRefresh = YES;
        NSString *showStr = [NSString stringWithFormat:@"%d %@ %d %@",
                             (int)[pickerView selectedRowInComponent:0],
                             LocationLanguage(@"hours", @"小时"),
                             (int)row,
                             LocationLanguage(@"minutes", @"分钟")];
        [Common2 TipDialog:[NSString stringWithFormat:LocationLanguage(@"setting_toast_longtime", @"您已设置久坐提醒时间为"), showStr]];
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:Long_time_close];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:Long_time_interval];
    [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:Long_time_notification];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
