//
//  ViewController.m
//  Bluetooth
//
//  Created by muyu on 2017/4/6.
//  Copyright © 2017年 muyu. All rights reserved.
//
//  http://www.jianshu.com/p/34231894cf58

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>


typedef NS_ENUM(NSUInteger, GlucoseMeterType)
{
    GlucoseMeterTypeNone,
    GlucoseMeterTypeDefalt,         // 公司自己生产的糖+设备
    GlucoseMeterTypeTaiDoc,         // 泰博血糖仪
};



@interface ViewController () <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager  *centralManager;
@property (nonatomic, strong) CBPeripheral      *peripheral;

@property (nonatomic, assign) GlucoseMeterType   glucoseMeterType;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 200, 40)];
    [button setTitle:@"导入" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)onButtonClicked:(id)sender
{
    NSUInteger a = 0x51;
    NSUInteger b = 0x28;
    NSUInteger c = 0xA3 & 0xFF;
    NSLog(@"b is %@ and c is %@", @(b), @(c));
    
    NSUInteger sum = a + b + c;
    NSLog(@"sum is %lX", sum);
    sum = sum & 0xFF;
    NSLog(@"sum is %lX", sum);
    
//    NSData *data = [self hexToBytes:@"4279"];
//    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"string is %@", string);
    
    
    NSLog(@"ddd %@", self.centralManager);
}

#pragma mark - event


#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state)
    {
        case CBManagerStateUnknown:
            NSLog(@"CBManagerStateUnknown");
            break;
        case CBManagerStateResetting:
            NSLog(@"CBManagerStateResetting");
            break;
        case CBManagerStateUnsupported:
            NSLog(@"CBManagerStateUnsupported");
            break;
        case CBManagerStateUnauthorized:
            NSLog(@"CBManagerStateUnauthorized");
            break;
        case CBManagerStatePoweredOff:
            NSLog(@"CBManagerStatePoweredOff");
            break;
        case CBManagerStatePoweredOn:
            NSLog(@"CBManagerStatePoweredOn");
            [self.centralManager scanForPeripheralsWithServices:nil options:nil];
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSString *advertisementString = [advertisementData objectForKey:@"kCBAdvDataLocalName"];
    NSLog(@"peripheral name is %@ advertisementString : %@", peripheral.name, advertisementString);
    
    if ([advertisementString isEqualToString:@"Glucometer Mate"])
    {
        [self.centralManager stopScan];
        NSLog(@"discover peripheral is success : %@", peripheral);
        self.peripheral = peripheral;
        
        // 连接外设
        self.glucoseMeterType = GlucoseMeterTypeDefalt;
        [self.centralManager connectPeripheral:self.peripheral options:nil];
    }
    else if ([advertisementString hasPrefix:@"TAIDOC"])
    {
        [self.centralManager stopScan];
        NSLog(@"discover peripheral is success : %@", peripheral);
        self.peripheral = peripheral;
        
        // 连接外设
        self.glucoseMeterType = GlucoseMeterTypeTaiDoc;
        [self.centralManager connectPeripheral:self.peripheral options:nil];
    }
}

// 连接外设成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"connect success %@", peripheral);
    
    self.peripheral.delegate = self;
    
    [self.peripheral discoverServices:nil];
}

// 连接外设失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    NSLog(@"connect fail %@", peripheral);
}

// 与外设断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    NSLog(@"did disconnect %@", peripheral);
}

#pragma mark - CBPeripheralDelegate

// 发现service
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error
{
    if (error != nil)
    {
        NSLog(@"didDiscoverServices failed. error is %@", error);
        return;
    }
    
    if (self.glucoseMeterType == GlucoseMeterTypeNone) {
        return;
    }
    
    if (self.glucoseMeterType == GlucoseMeterTypeDefalt)
    {
        for (NSInteger i = 0; i < peripheral.services.count; i++)
        {
            CBService *service = [peripheral.services objectAtIndex:i];
            NSLog(@"service is %@ data desc is %@", service, service.UUID.data.description);
            
            NSString *subString = [service.UUID.data.description substringToIndex:5];
            if ([subString isEqualToString:@"<6ed0"]) {
                [peripheral discoverCharacteristics:nil forService:service];
                return;
            }
        }
    }
    else if (self.glucoseMeterType == GlucoseMeterTypeTaiDoc)
    {
        for (NSInteger i = 0; i < peripheral.services.count; i++)
        {
            CBService *service = [peripheral.services objectAtIndex:i];
            NSLog(@"service is %@ data desc is %@", service, service.UUID.data.description);
            
            if (service.UUID.data.description.length > 9)
            {
                NSString *subString = [service.UUID.data.description substringToIndex:9];
                if ([subString isEqualToString:@"<00001523"]) {
                    //[peripheral discoverCharacteristics:nil forService:service];
                    //return;
                }
            }
            else if ([service.UUID.data.description isEqualToString:@"<180a>"])
            {
                [peripheral discoverCharacteristics:nil forService:service];
            }
        }
    }
}

// 发现外设服务里的特征的时候调用的代理方法(这个是比较重要的方法，你在这里可以通过事先知道UUID找到你需要的特征，订阅特征，或者这里写入数据给特征也可以)
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error
{
    if (error != nil)
    {
        NSLog(@"didDiscoverCharacteristicsForService failed. error is %@", error);
        return;
    }
    
    if (self.glucoseMeterType == GlucoseMeterTypeDefalt)
    {
        for (CBCharacteristic *c in service.characteristics)
        {
            NSLog(@"characteristic is %@ desc is %@", c, c.UUID.data.description);
            
            NSString *subString = [c.UUID.data.description substringToIndex:5];
            if ([subString isEqualToString:@"<82d6"])
            {
                NSLog(@"discover characteristics finished");
                [self.peripheral setNotifyValue:YES forCharacteristic:c];
            }
            // 获取mac地址
            else if ([subString isEqualToString:@"<186b"])
            {
                [self.peripheral readValueForCharacteristic:c];
            }
        }
    }
    else if (self.glucoseMeterType == GlucoseMeterTypeTaiDoc)
    {
        for (CBCharacteristic *c in service.characteristics)
        {
            NSLog(@"characteristic is %@ desc is %@", c, c.UUID.data.description);
            
            if (c.UUID.data.description.length > 9)
            {
                NSString *subString = [c.UUID.data.description substringToIndex:9];
                if ([subString isEqualToString:@"<00001524"]) {
                    [self.peripheral setNotifyValue:YES forCharacteristic:c];
                    return;
                }
            }
            
            [self.peripheral readValueForCharacteristic:c];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    if (error != nil)
    {
        NSLog(@"didUpdateNotificationStateForCharacteristic error is %@", error);
        return;
    }
    
    NSLog(@"didUpdateNotificationStateForCharacteristic characteristic is %@ vaule is %@", characteristic, characteristic.value);
    
    if (self.glucoseMeterType == GlucoseMeterTypeDefalt)
    {
    }
    else if (self.glucoseMeterType == GlucoseMeterTypeTaiDoc)
    {
        // read device model
        NSData *data = [self hexToBytes:@"512800000000A31C"];
        [peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    if (error != nil)
    {
        NSLog(@"didUpdateValueForCharacteristic error is %@", error);
        return;
    }
    
    NSLog(@"didUpdateValueForCharacteristic characteristic is %@ vaule is %@", characteristic, characteristic.value);
    
    
    if (self.glucoseMeterType == GlucoseMeterTypeDefalt)
    {
        NSString *subString = [characteristic.UUID.data.description substringToIndex:5];
        if ([subString isEqualToString:@"<186b"])
        {
            NSLog(@"get mac success, value is %@", characteristic.value);
        }
    }
    else if (self.glucoseMeterType == GlucoseMeterTypeTaiDoc)
    {
        NSLog(@"characteristic value is %@", characteristic.value);
    }
}

#pragma mark - private method

- (NSData *)hexToBytes:(NSString *)str
{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= str.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [str substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

#pragma mark - getter and setter

- (CBCentralManager *)centralManager
{
    if (_centralManager == nil) {
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return _centralManager;
}

@end
