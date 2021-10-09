//
//  GCUIViewController.h
//  JinSeShiJi
//  UIViewController基类
//  Created by zxs on 13-9-30.
//
//

#import <UIKit/UIKit.h>

@interface GCUIViewController : UIViewController{
@protected
    float autoSize;
    float autoV;
    float height;
    float width;
    float statusBarHeight;
}

@property(nonatomic,assign)float autoSize;
@property(nonatomic,assign)float autoV;
@property(nonatomic,assign)float height;
@property(nonatomic,assign)float width;
@property(nonatomic,assign)float statusBarHeight;//ios7以上，布局从statusbar的位置开始

@end
