//
//  BLEManager.m
//  BTLE
//
//  Created by Nick Yang on 10/10/15.
//  Copyright (c) 2015 Nick Yang. All rights reserved.
//

#import "BLEManager.h"
#import "AppDelegate.h"

#define CALLBACK_NONE 0
#define CALLBACK_RSSI 1
#define CALLBACK_SEND 2
#define CALLBACK_READ 3
#define CALLBACK_WRRS 4

@interface BLEManager()

@property (strong,nonatomic) CBPeripheral *currentPeriperal;
@property (nonatomic, strong) NSMutableDictionary<NSString *, CBCharacteristic *> *currentCharacteristicDict;
@property (nonatomic, assign) int blueToothPoweredOn;
@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, assign) BOOL isConnecting;

@end

@implementation BLEManager

@synthesize discoveredPeripherals;
@synthesize discoveredAdvertisements;
@dynamic yy_zuoziInfo;
@dynamic yy_zhanziInfo;

static BLEManager *manager = nil;

int settedRSSI = defaultRSSI;

int lockCallBack = CALLBACK_NONE;

int currentRSSI;
NSData *currentData = nil;

NSError *writeResCode = nil;

NSString *currentService = nil;
NSString *currentCharacteristic = nil;

+ (BLEManager *)sharedManager {
    return [self sharedManagerWithDelegate:nil];
}

+ (BLEManager *)sharedManagerWithDelegate:(id<BLEManagerDelegate>)delegate {
    if(manager == nil) {
        manager = [[BLEManager alloc] initWithDelegate:delegate];
    }else if (delegate) {
        manager.delegate = delegate;
    }
    return manager;
}

- (void)disableBLEManager {
    NSLog(@"disableBLEManager");
    self.delegate = nil;
//    if(manager != nil && self.delegate != nil)
//    {
//        [self.delegate BLEManagerDisabledDelegate];
//    }
//    self.delegate = nil;
//    centralManager = nil;
//    manager = nil;
}

// 断开连接
- (void)disConnected {
    NSLog(@"断开连接");
    [self disconnectPeripheral:self.currentPeriperal];
}

- (id) initWithDelegate:(id<BLEManagerDelegate>)delegate
{
    self = [super init];
    if(self)
    {
        _is_CM = YES;
        self.isConnecting = NO;
        self.delegate = delegate;
        discoveredPeripherals = [[NSMutableArray alloc] init];
		discoveredAdvertisements = [[NSMutableArray alloc] init];
    }
    return  self;
}

# pragma mark - CBCentralManager Methods
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStatePoweredOff: {
            [SVProgressHUD showErrorWithStatus:LocationLanguage(@"trunOnBluetooth", @"蓝牙没有开启，在设置中打开蓝牙")];
            _blueToothPoweredOn = 1;
            self.isConnecting = NO;
            if (_poweredOnBlock) {
                _poweredOnBlock(1);
            }
        }
            break;
        case CBCentralManagerStatePoweredOn: {
            
            [centralManager scanForPeripheralsWithServices:nil options:nil];
            [NSTimer scheduledTimerWithTimeInterval:timeInverval target:self selector:@selector(scanBleTimeout:) userInfo:nil repeats:NO];
            _blueToothPoweredOn = 0;
            if (_poweredOnBlock) {
                _poweredOnBlock(0);
            }
        }
            break;
        case CBCentralManagerStateResetting:
            break;
        case CBCentralManagerStateUnauthorized: {
            [SVProgressHUD showErrorWithStatus:LocationLanguage(@"notAvailablePermission", @"未开启蓝牙权限，请在手机设置中打开")];
            _blueToothPoweredOn = 2;
            self.isConnecting = NO;
            if (_poweredOnBlock) {
                _poweredOnBlock(2);
            }
        }
            break;
        case CBCentralManagerStateUnknown:
            break;
        case CBCentralManagerStateUnsupported:
            [SVProgressHUD showErrorWithStatus:LocationLanguage(@"notSupportBluetooth", @"当前设备不支持蓝牙")];
//            [mainView makeToast:@"当前设备不支持蓝牙"];
            break;
        default:
            break;
    }


    
//    if (central.state == CBCentralManagerStatePoweredOn) {
//        [centralManager scanForPeripheralsWithServices:nil options:nil];
//        [NSTimer scheduledTimerWithTimeInterval:timeInverval target:self selector:@selector(scanBleTimeout:) userInfo:nil repeats:NO];
//    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"peripheral:%@",peripheral);
//    NSLog(@"advertisementData:%@",advertisementData);
//    NSLog(@"RSSI:%@",RSSI);
    
    if(peripheral.identifier == nil || RSSI.intValue < settedRSSI) {
        return;
    }
    NSString *deviceName = peripheral.name;
    if (deviceName.length == 0 || ![deviceName.lowercaseString hasPrefix:@"cbox_"]) {
        return;
    }
        
    for(int i = 0; i < discoveredPeripherals.count; i++){
        CBPeripheral *p = [self.discoveredPeripherals objectAtIndex:i];
            
        if([peripheral.identifier.UUIDString isEqualToString:p.identifier.UUIDString]){
            [self.discoveredPeripherals replaceObjectAtIndex:i withObject:peripheral];
//            NSLog(@"Duplicate UUID found updating...");
            return;
        }
    }
	
	
	
	    //查看数组中是否已经包含advertisementData
		if ([discoveredAdvertisements containsObject:advertisementData]) {
			return;
		}
		
	
	
	
	
    [self.discoveredPeripherals addObject:peripheral];
	[self.discoveredAdvertisements addObject:advertisementData];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"didConnectPeripheral");
    self.currentCharacteristicDict = @{}.mutableCopy;
    self.isConnecting = YES;
    self.currentPeriperal = peripheral;
    
    if (self.linkDelegate != self.delegate) {
        if ([self.linkDelegate respondsToSelector:@selector(BLEManagerDidConnectPeripheral:)]) {
            [self.linkDelegate BLEManagerDidConnectPeripheral:peripheral];
        }
    }
    if ([self.delegate respondsToSelector:@selector(BLEManagerDidConnectPeripheral:)]) {
        [self.delegate BLEManagerDidConnectPeripheral:peripheral];
    }
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"didDisconnectPeripheral %@", error);
    lockCallBack = CALLBACK_NONE;
    self.isConnecting = NO;
    writeResCode = [NSError errorWithDomain:@"" code:0 userInfo:@""];
    
    if (self.linkDelegate != self.delegate) {
        if ([self.linkDelegate respondsToSelector:@selector(BLEManagerDisconnectPeripheral:error:)]) {
            [self.linkDelegate BLEManagerDisconnectPeripheral:peripheral error:error];
        }
    }
    if ([self.delegate respondsToSelector:@selector(BLEManagerDisconnectPeripheral:error:)]) {
        [self.delegate BLEManagerDisconnectPeripheral:peripheral error:error];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    for(CBService *service in peripheral.services){
//        NSLog(@"service.UUID:%@",service.UUID.UUIDString);
//        if([currentService isEqualToString:service.UUID.UUIDString]){
//            NSArray *arr = [[NSArray alloc] initWithObjects:[CBUUID UUIDWithString:currentCharacteristic], nil];
//            [peripheral discoverCharacteristics:arr forService:service];
//        }
        
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(nonnull CBService *)service error:(nullable NSError *)error {
    NSLog(@"service.UUID:%@",service.UUID.UUIDString);
    for(CBCharacteristic *characteristic in service.characteristics){
        NSLog(@"characteristic.UUID:%@, current:%@",characteristic.UUID.UUIDString,currentCharacteristic);
    }
    if (self.linkDelegate != self.delegate) {
        if ([self.linkDelegate respondsToSelector:@selector(BLEManagerReceiveAllService:)]) {
            [self.linkDelegate BLEManagerReceiveAllService:service];
        }
    }
    if ([self.delegate respondsToSelector:@selector(BLEManagerReceiveAllService:)]) {
        [self.delegate BLEManagerReceiveAllService:service];
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"didUpdateValueForCharacteristic");
//    NSLog(@"error(%d):%@", (int)error.code, [error localizedDescription]);
//    NSLog(@"data:%@", characteristic.value);
    
    switch (lockCallBack) {
        case CALLBACK_NONE:
            currentData = nil;
            currentService = nil;
            currentCharacteristic = nil;
            if ([self.delegate respondsToSelector:@selector(BLEManagerReceiveData:fromPeripheral:andServiceUUID:andCharacteristicUUID:)]) {
                [self.delegate BLEManagerReceiveData:characteristic.value fromPeripheral:peripheral andServiceUUID:characteristic.service.UUID.UUIDString andCharacteristicUUID:characteristic.UUID.UUIDString];
            }
            break;
        case CALLBACK_SEND:
        case CALLBACK_READ:
            currentData = characteristic.value;
            break;
        default:
            break;
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"didWriteValueForCharacteristic");
//    NSLog(@"charUUID:%@, error:%@", characteristic.UUID.UUIDString, [error localizedDescription]);
    writeResCode = error == nil ? [NSError errorWithDomain:@"" code:0 userInfo:@""] : error;
}

- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral
                          error:(NSError *)error {
    
    NSLog(@"peripheral RSSI:%d",peripheral.RSSI.intValue);
    if(lockCallBack == CALLBACK_RSSI){
        currentRSSI = (int)peripheral.RSSI.integerValue;
    }
}

- (void)setIsConnecting:(BOOL)isConnecting {
    _isConnecting = isConnecting;
    if (isConnecting == NO) {
        self.currentPeriperal = nil;
    }
    _maxHeight = -1;
    _minHeight = -1;
}

- (void)scanningForPeripherals
{
    settedRSSI = defaultRSSI;
    [discoveredPeripherals removeAllObjects];
	[discoveredAdvertisements removeAllObjects];
    if (centralManager == nil) {
        centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }else {
        centralManager.delegate = self;
        [centralManager scanForPeripheralsWithServices:nil options:nil];
        [NSTimer scheduledTimerWithTimeInterval:timeInverval target:self selector:@selector(scanBleTimeout:) userInfo:nil repeats:NO];
    }
}

- (void)scanningForPeripheralsWithDistance:(int)RSSI
{
    settedRSSI = RSSI;
    [discoveredPeripherals removeAllObjects];
	[discoveredAdvertisements removeAllObjects];
    if (centralManager == nil) {
        centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }else {
        centralManager.delegate = self;
        [centralManager scanForPeripheralsWithServices:nil options:nil];
        [NSTimer scheduledTimerWithTimeInterval:timeInverval target:self selector:@selector(scanBleTimeout:) userInfo:nil repeats:NO];
    }
}

- (void)scanBleTimeout:(NSTimer*)timer
{
    if (centralManager != NULL){
        [centralManager stopScan];
        if ([self.delegate respondsToSelector:@selector(BLEManagerReceiveAllPeripherals:andAdvertisements:)]) {
            [self.delegate BLEManagerReceiveAllPeripherals:self.discoveredPeripherals andAdvertisements:self.discoveredAdvertisements];
        }
    }else{
        NSLog(@"CM is Null!");
    }
    NSLog(@"scanTimeout");
}

- (void)stopScanningForPeripherals
{
    [centralManager stopScan];
}

- (void)connectingPeripheral:(CBPeripheral *)peripheral {
    self.is_autoLink = NO;
    if(centralManager != nil) {
        peripheral.delegate = self;
        [centralManager connectPeripheral:peripheral options:nil];
        [centralManager stopScan];
    }else {
        centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
}

- (void)disconnectPeripheral:(CBPeripheral *)peripheral {
    [centralManager stopScan];
    if (peripheral == nil){
        NSLog(@"connectPeripheral is NULL");
        return;
    }else if (peripheral.state == CBPeripheralStateConnected){
        [centralManager cancelPeripheralConnection:peripheral];
    }
}

- (int)readRSSI:(CBPeripheral *)peripheral
{
    if(peripheral.state != CBPeripheralStateConnected)
    {
        [self.delegate BLEManagerDisconnectPeripheral:peripheral error:nil];
        return 0;
    }else
    {
        [self waitingCallBack];
        lockCallBack = CALLBACK_RSSI;
        
        [peripheral readRSSI];
        
        int returnRSSI = 0;
        while(currentRSSI == 0 && lockCallBack == CALLBACK_RSSI){
             [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        lockCallBack = CALLBACK_NONE; // reset lockCallBack
        
        returnRSSI = currentRSSI;
        currentRSSI = 0;
        return returnRSSI;
    }
}

- (void)scanningForServicesWithPeripheral:(CBPeripheral *)peripheral{
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
}

- (NSError *) setValue:(NSData *) data forServiceUUID:(NSString *) serviceUUID andCharacteristicUUID:(NSString *) charUUID withPeripheral:(CBPeripheral *)peripheral
{
    if(_isConnecting){
        peripheral.delegate = self;
        CBCharacteristic *characteristic = [self findCharacteristicWithServiceUUID:serviceUUID andCharacteristicUUID:charUUID andPeripheral:peripheral];
        if(characteristic == nil) return [NSError errorWithDomain:@"" code:0 userInfo:@""];
        NSLog(@"data:%@",data);
        NSLog(@"char.UUID:%@",characteristic.UUID.UUIDString);
        
        [self waitingCallBack];
        
        CBCharacteristicProperties properties = characteristic.properties;
        CBCharacteristicWriteType writeType = CBCharacteristicWriteWithoutResponse;
        if((properties & CBCharacteristicPropertyBroadcast) == CBCharacteristicPropertyBroadcast){
            NSLog(@"CBCharacteristicPropertyBroadcast");
        }
        if((properties & CBCharacteristicPropertyRead) == CBCharacteristicPropertyRead){
            NSLog(@"CBCharacteristicPropertyRead");
        }
        if((properties & CBCharacteristicPropertyWriteWithoutResponse) == CBCharacteristicPropertyWriteWithoutResponse){
            NSLog(@"CBCharacteristicPropertyWriteWithoutResponse");
            writeResCode = [NSError errorWithDomain:@"" code:0 userInfo:@""];
        }
        if((properties & CBCharacteristicPropertyWrite) == CBCharacteristicPropertyWrite){
            NSLog(@"CBCharacteristicPropertyWrite");
            writeType = CBCharacteristicWriteWithResponse;
            lockCallBack = CALLBACK_WRRS;
        }
        if((properties & CBCharacteristicPropertyNotify) == CBCharacteristicPropertyNotify){
            NSLog(@"CBCharacteristicPropertyNotify");
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
        if((properties & CBCharacteristicPropertyIndicate) == CBCharacteristicPropertyIndicate){
            NSLog(@"CBCharacteristicPropertyIndicate");
        }
        if((properties & CBCharacteristicPropertyAuthenticatedSignedWrites) == CBCharacteristicPropertyAuthenticatedSignedWrites){
            NSLog(@"CBCharacteristicPropertyAuthenticatedSignedWrites");
        }
        if((properties & CBCharacteristicPropertyExtendedProperties) == CBCharacteristicPropertyExtendedProperties){
            NSLog(@"CBCharacteristicPropertyExtendedProperties");
        }
        
        [peripheral writeValue:data forCharacteristic:characteristic type:writeType];
        
        while(writeResCode == nil){
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        lockCallBack = lockCallBack == CALLBACK_WRRS ? CALLBACK_NONE : lockCallBack; // reset lockCallBack
 
        NSError *rtn;
        rtn = writeResCode;
        writeResCode = nil;
        return rtn;
    }
    return [NSError errorWithDomain:@"" code:0 userInfo:@""];
}

- (NSData *)readValueForServiceUUID:(NSString *) serviceUUID andCharacteristicUUID:(NSString *) charUUID withPeripheral:(CBPeripheral *)peripheral
{
    if(_isConnecting){
        CBCharacteristic *characteristic = [self findCharacteristicWithServiceUUID:serviceUUID andCharacteristicUUID:charUUID andPeripheral:peripheral];
        if(characteristic == nil) return nil;
        
        [self waitingCallBack];
        lockCallBack = CALLBACK_READ;
        [peripheral readValueForCharacteristic:characteristic];
        
        NSData *returnedData = nil;
        while(currentData == nil && lockCallBack == CALLBACK_READ){
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        lockCallBack = CALLBACK_NONE; // reset lockCallBack
        
        returnedData = currentData;
        currentData = nil;
        return returnedData;
    }
    return  nil;
}

- (CBCharacteristic *)findCharacteristicWithServiceUUID:(NSString *) serviceUUID andCharacteristicUUID:(NSString *) charUUID andPeripheral:(CBPeripheral *)peripheral
{
    peripheral.delegate = self;
    NSLog(@"peripheral.name:%@", peripheral.name);
    for(CBService *servie in peripheral.services){
        if([serviceUUID isEqualToString:servie.UUID.UUIDString]){
            NSLog(@"service.UUID:%@", servie.UUID.UUIDString);
            for(CBCharacteristic *characteristic in servie.characteristics){
                if([charUUID isEqualToString:characteristic.UUID.UUIDString]){
                    NSLog(@"char.UUID:%@",characteristic.UUID.UUIDString);
                    return characteristic;
                }
            }
        }
    }
    return nil;
    
}

- (void)waitingCallBack
{
    while(lockCallBack != CALLBACK_NONE){
        sleep(1);
    }
}

// 写入数据到设备
- (void)sendValue:(NSData *)data forServiceUUID:(NSString *) serviceUUID andCharacteristicUUID:(NSString *) charUUID withPeripheral:(CBPeripheral *)peripheral {
    [self.lock lock];
    static NSTimeInterval sendTime = 0;
    static int sendCode = 0;
    if (_isConnecting) {
        peripheral.delegate = self;
        NSString *keyStr = [NSString stringWithFormat:@"%@-%@", serviceUUID, charUUID];
        CBCharacteristic *characteristic = self.currentCharacteristicDict[keyStr];
        if (characteristic == nil) {
            characteristic = [self findCharacteristicWithServiceUUID:serviceUUID andCharacteristicUUID:charUUID andPeripheral:peripheral];
            if(characteristic == nil) {
                [self.lock unlock];
                return;
            }
            self.currentCharacteristicDict[keyStr] = characteristic;
        }
        CBCharacteristicProperties properties = characteristic.properties;
        if((properties & CBCharacteristicPropertyNotify) == CBCharacteristicPropertyNotify){
            NSLog(@"CBCharacteristicPropertyNotify");
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
        NSLog(@"data:%@", data);
        NSLog(@"char.UUID:%@", characteristic.UUID.UUIDString);
        
        [peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
        
        NSTimeInterval curTime = [[NSDate date] timeIntervalSince1970] * 1000;
        NSLog(@"控制发送时间: %f --------- %f --------- %d", curTime, curTime - sendTime, sendCode += 1);
        if (curTime - sendTime > 110) {
            NSLog(@"11111111111111111111111111");
        }
        sendTime = curTime;
    }
    [self.lock unlock];
}

#pragma mark - 高度计算
// 向下取小数点保留一位
+ (NSString *)floatHeight:(CGFloat)height
                   needCm:(BOOL)needcm {
    CGFloat reHeight = height + 0.00001;
    if([BLEManager sharedManager].minHeight == -1 || [BLEManager sharedManager].maxHeight == -1) {
        NSLog(@"还未初始化到最低最高---高度");
    }else {
        if (needcm) {
            if (height <= [BLEManager sharedManager].minHeight) {
                reHeight = [BLEManager sharedManager].minHeight;
            }else if (height >= [BLEManager sharedManager].maxHeight) {
                reHeight = [BLEManager sharedManager].maxHeight;
            }
        }else {
            if (height <= [BLEManager sharedManager].inMinHeight) {
                reHeight = [BLEManager sharedManager].inMinHeight;
            }else if (height >= [BLEManager sharedManager].inMaxHeight) {
                reHeight = [BLEManager sharedManager].inMaxHeight;
            }
        }
    }
    NSString *reStr = [NSString stringWithFormat:@"%f", reHeight];
    NSArray<NSString *> *reArray = [reStr componentsSeparatedByString:@"."];

    NSString *result;
    if (reArray.count == 1) {
       result = [NSString stringWithFormat:@"%@.%@", reArray[0], @"0"];
    }else {
       NSString *pStr = reArray[0];
       NSString *sStr = [reArray[1] substringToIndex:1];
       result = [NSString stringWithFormat:@"%@.%@", pStr, sStr];
    }
    NSLog(@"result %f -> %@", height, result);
    return result;
}

// 数据转换不限制设备的最低最高位置
+ (NSString *)floatHeightNotLimit:(CGFloat)height
                           needCm:(BOOL)needcm {
    CGFloat reHeight = height + 0.00001;
    if([BLEManager sharedManager].minHeight == -1 || [BLEManager sharedManager].maxHeight == -1) {
        NSLog(@"还未初始化到最低最高---高度");
    }
    NSString *reStr = [NSString stringWithFormat:@"%f", reHeight];
    NSArray<NSString *> *reArray = [reStr componentsSeparatedByString:@"."];

    NSString *result;
    if (reArray.count == 1) {
       result = [NSString stringWithFormat:@"%@.%@", reArray[0], @"0"];
    }else {
       NSString *pStr = reArray[0];
       NSString *sStr = [reArray[1] substringToIndex:1];
       result = [NSString stringWithFormat:@"%@.%@", pStr, sStr];
    }
    NSLog(@"result %f -> %@", height, result);
    return result;
}

// 数据转换，不保留小数
+ (NSString *)floatHeightNotDecimalPoint:(CGFloat)height {
    CGFloat reHeight = height + 0.00001;
    return [NSString stringWithFormat:@"%d", (int)reHeight];
}

// 高度自动转换
+ (CGFloat)autoInOrCm:(CGFloat)height
                 isIn:(NSString *)isIn
               needCm:(BOOL)needcm {
    CGFloat sendHeight = height + 0.00001;
    if (needcm) {
        if ([isIn isEqualToString:@"1"]) {
            sendHeight = [self inToCmheight:height];
        }
    }else {
        if (![isIn isEqualToString:@"1"]) {
            sendHeight = [self cmToInHeight:height];
        }
    }
    sendHeight = floorf(sendHeight * 100) / 100 + 0.00001;
    return sendHeight;
}

+ (CGFloat)cmToInHeight:(CGFloat)ccm {
    ccm +=  0.00001;
    CGFloat inHeight = (ccm * 10 * 100 + 127) / 2540.0;
    inHeight = floorf(inHeight * 10) / 10 + 0.00001;
    return inHeight;
}

+ (CGFloat)inToCmheight:(CGFloat)iin {
    iin +=  0.00001;
    CGFloat cmHeight = (iin * 10 * 254 + 50)/1000.0;
    cmHeight = floorf(cmHeight * 10) / 10 + 0.00001;
    return cmHeight;
}

#pragma mark - 最小值和最大值的英尺
+ (CGFloat)isCmHeightNum:(NSString *)heightString {
    CGFloat height = [heightString floatValue] * 10 + 0.00001;
    CGFloat cm_HEIGHT_MIN = [BLEManager sharedManager].minHeight * 10;
    CGFloat cm_HEIGHT_MAX = [BLEManager sharedManager].maxHeight * 10;
    if (height >= cm_HEIGHT_MIN - 4 && height <= cm_HEIGHT_MAX + 4) {
        if (height < cm_HEIGHT_MIN) {
            return [BLEManager sharedManager].minHeight;
        }else if (height > cm_HEIGHT_MAX){
            return [BLEManager sharedManager].maxHeight;
        }
        height = height / 10.0 + 0.00001;
        return height;
    }
    return 0;
}
+ (CGFloat)isInHeightNum:(NSString *)heightString {
    CGFloat height = [heightString floatValue] * 10 + 0.00001;
    CGFloat in_HEIGHT_MIN = [BLEManager sharedManager].inMinHeight * 10;
    CGFloat in_HEIGHT_MAX = [BLEManager sharedManager].inMaxHeight * 10;
    if (height >= in_HEIGHT_MIN - 4 && height <= in_HEIGHT_MAX + 4) {
        if (height < in_HEIGHT_MIN) {
            return [BLEManager sharedManager].inMinHeight;
        }else if (height > in_HEIGHT_MAX){
            return [BLEManager sharedManager].inMaxHeight;
        }
        height = height / 10.0 + 0.00001;
        return height;
    }
    return 0;
}

- (CGFloat)inMinHeight {
    return [BLEManager cmToInHeight:self.minHeight];
}

- (CGFloat)inMaxHeight {
    return [BLEManager cmToInHeight:self.maxHeight];
}

- (CGFloat)minHeight {
    if (_minHeight == -1 || _minHeight == NSNotFound) {
        return -1;
    }
    return _minHeight;
}

- (CGFloat)maxHeight {
    if (_maxHeight == -1 || _maxHeight == NSNotFound) {
        return -1;
    }
    return _maxHeight;
}

- (NSLock *)lock {
    if (_lock) {
        _lock = [[NSLock alloc] init];
    }
    return _lock;
}

- (NSString *)yy_zuoziInfo {
    NSString *deviceId = @"";
    if ([BLEManager sharedManager].currentPeriperal) {
        deviceId = [BLEManager sharedManager].currentPeriperal.identifier.UUIDString;
    }
    NSString *str_zuozigaodu = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@", Zuozi_value, deviceId]];
    if (str_zuozigaodu == nil || str_zuozigaodu.length == 0) {
        str_zuozigaodu = @"70#0";
    }
    return str_zuozigaodu;
}

- (NSString *)yy_zhanziInfo {
    NSString *deviceId = @"";
    if ([BLEManager sharedManager].currentPeriperal) {
        deviceId = [BLEManager sharedManager].currentPeriperal.identifier.UUIDString;
    }
    NSString *str_zhanzigaodu = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@", Zhanzi_value, deviceId]];
    if (str_zhanzigaodu == nil || str_zhanzigaodu.length == 0) {
        str_zhanzigaodu = @"100#0";
    }
    return str_zhanzigaodu;
}

#pragma mark - setter
- (void)setYy_zuoziInfo:(NSString *)yy_zuoziInfo {
    NSString *deviceId = @"";
    if ([BLEManager sharedManager].currentPeriperal) {
        deviceId = [BLEManager sharedManager].currentPeriperal.identifier.UUIDString;
    }
    NSString *isIn = [BLEManager sharedManager].is_CM ? @"0" : @"1";
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f%@", [yy_zuoziInfo floatValue], isIn] forKey:[NSString stringWithFormat:@"%@%@", Zuozi_value, deviceId]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setYy_zhanziInfo:(NSString *)yy_zhanziInfo {
    NSString *deviceId = @"";
    if ([BLEManager sharedManager].currentPeriperal) {
        deviceId = [BLEManager sharedManager].currentPeriperal.identifier.UUIDString;
    }
    NSString *isIn = [BLEManager sharedManager].is_CM ? @"0" : @"1";
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f%@", [yy_zhanziInfo floatValue], isIn] forKey:[NSString stringWithFormat:@"%@%@", Zhanzi_value, deviceId]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
