//
//  BLEManager.h
//  BTLE
//
//  Created by Nick Yang on 10/10/15.
//  Copyright (c) 2015 Nick Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define timeInverval 2.0f // timeount for scanning peripherals
#define defaultRSSI -100 // signal of blue device for detecting

typedef void(^BlueToothPoweredBlock)(int code);

@class BLEManager;
@protocol BLEManagerDelegate <NSObject>

@required
- (void)BLEManagerDisabledDelegate;

@optional
- (void)BLEManagerReceiveAllPeripherals:(NSMutableArray *) peripherals andAdvertisements:(NSMutableArray *)advertisements;
- (void)BLEManagerReceiveAllService:(CBService *) service;
- (void)BLEManagerDidConnectPeripheral:(CBPeripheral *)peripheral;
- (void)BLEManagerDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;
- (void)BLEManagerReceiveData:(NSData *) value fromPeripheral:(CBPeripheral *)peripheral andServiceUUID:(NSString *)serviceUUID andCharacteristicUUID:(NSString *)charUUID;

@end

@interface BLEManager : NSObject <CBCentralManagerDelegate,CBPeripheralManagerDelegate,CBPeripheralDelegate>
{
    CBCentralManager *centralManager;
}

@property (strong,nonatomic) NSMutableArray *discoveredPeripherals;
@property (strong,nonatomic) NSMutableArray *discoveredAdvertisements;

@property (strong,nonatomic) CBPeripheral *periperal;
@property (nonatomic, strong, readonly) CBPeripheral *currentPeriperal;
@property (nonatomic, assign, readonly) int blueToothPoweredOn;
@property (nonatomic, copy) BlueToothPoweredBlock poweredOnBlock;


@property (weak, nonatomic)    id<BLEManagerDelegate> delegate;
@property (nonatomic, weak)    id<BLEManagerDelegate> linkDelegate;

@property (nonatomic, assign) CGFloat minHeight;
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, assign, readonly) CGFloat inMinHeight;
@property (nonatomic, assign, readonly) CGFloat inMaxHeight;
// Yes: 厘米；No: 英尺
@property (nonatomic, assign) BOOL is_CM;
@property (nonatomic, assign) BOOL is_autoLink;
// 坐姿、站姿高度
@property (nonatomic, copy) NSString *yy_zuoziInfo;
@property (nonatomic, copy) NSString *yy_zhanziInfo;

//初始化对象
+ (BLEManager *)sharedManagerWithDelegate:(id<BLEManagerDelegate>)delegate; // inital
//重用对象（单例）
+ (BLEManager *)sharedManager; // singleton

//让对象失效
- (void)disableBLEManager; // disable delegate
// 断开连接
- (void)disConnected;
//检查设备蓝牙连接状态
- (BOOL)isConnecting;
//扫描装置
- (void)scanningForPeripherals;
//扫描所有设备的限制距离
- (void)scanningForPeripheralsWithDistance:(int)RSSI;
//停止扫描装置
- (void)stopScanningForPeripherals;
//连接指定设备
- (void)connectingPeripheral:(CBPeripheral *)peripheral;
//断开指定设备
- (void)disconnectPeripheral:(CBPeripheral *)peripheral;
//获取接收设备的信号强度
- (int)readRSSI:(CBPeripheral *)peripheral;
//扫描设置中的所有服务
- (void)scanningForServicesWithPeripheral:(CBPeripheral *)peripheral;

// after discovering services and characteristics
//写入数据到设备
- (NSError *)setValue:(NSData *) data forServiceUUID:(NSString *) serviceUUID andCharacteristicUUID:(NSString *) charUUID withPeripheral:(CBPeripheral *)peripheral;

// 写入数据到设备
//- (void)sendValue:(NSData *)data forServiceUUID:(NSString *) serviceUUID andCharacteristicUUID:(NSString *) charUUID withPeripheral:(CBPeripheral *)peripheral;

//从设备读取数据
- (NSData *)readValueForServiceUUID:(NSString *) serviceUUID andCharacteristicUUID:(NSString *) charUUID withPeripheral:(CBPeripheral *)peripheral;


// 数据转换方法
+ (NSString *)floatHeight:(CGFloat)height
                   needCm:(BOOL)needcm;

// 数据转换不限制设备的最低最高位置
+ (NSString *)floatHeightNotLimit:(CGFloat)height
                           needCm:(BOOL)needcm;

// 数据转换，不保留小数
+ (NSString *)floatHeightNotDecimalPoint:(CGFloat)height;

+ (CGFloat)autoInOrCm:(CGFloat)height
                 isIn:(NSString *)isIn
               needCm:(BOOL)needcm;

+ (CGFloat)isCmHeightNum:(NSString *)heightString;
+ (CGFloat)isInHeightNum:(NSString *)heightString;
@end
