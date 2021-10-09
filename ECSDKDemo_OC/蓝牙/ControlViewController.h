//
//  RedPacketViewController.h
//  天天网
//
//  Created by zhaoweibing on 14-9-5.
//  Copyright (c) 2014年 oyxc. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "GCUIViewController.h"
//#import "XMSDK.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BLEManager.h"
@interface ControlViewController : GCUIViewController<BLEManagerDelegate> {
    
}

@property (nonatomic, strong) NSString *strid;
@property (nonatomic, strong) NSString *strName;

- (void)startSearch;
- (void)stopSearch;

@end
