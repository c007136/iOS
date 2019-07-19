//
//  ViewController.m
//  ChuXichun
//
//  Created by miniu on 15/9/27.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "ViewController.h"
#import "CocoaAsyncSocket.h"
#import "NSString+Helper.h"
#import "UIButton+Common.h"
#import "UIColor+Extensions.h"
#import "LoginViewController.h"

@interface ViewController () <AsyncSocketDelegate>

// datas
@property (nonatomic, strong) NSArray            * pjHost;
@property (nonatomic, assign) NSInteger          port;

// UI
@property (nonatomic, strong) UIButton           * play;
@property (nonatomic, strong) UIButton           * pause;
@property (nonatomic, strong) UIButton           * openPj;
@property (nonatomic, strong) UIButton           * closePj;
@property (nonatomic, strong) UIButton           * openComputer;
@property (nonatomic, strong) UIButton           * closeComputer;
@property (nonatomic, strong) UIButton           * button1;
@property (nonatomic, strong) UIButton           * button2;
@property (nonatomic, strong) UIButton           * button3;
@property (nonatomic, strong) UIButton           * button4;
@property (nonatomic, strong) UIButton           * button5;
@property (nonatomic, strong) UIButton           * button6;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.openPj];
    [self.view addSubview:self.closePj];
    [self.view addSubview:self.play];
    [self.view addSubview:self.pause];
    [self.view addSubview:self.openComputer];
    [self.view addSubview:self.closeComputer];
    
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    [self.view addSubview:self.button3];
    [self.view addSubview:self.button4];
    [self.view addSubview:self.button5];
    [self.view addSubview:self.button6];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGFloat buttonHeight = 60;
    CGFloat buttonSpace = 80;
    CGFloat buttonWidth = (kWindowWidth-100)/3;
    self.button1.frame = CGRectMake(150, 30, buttonWidth, buttonHeight);
    self.button2.frame = CGRectMake(150, 30+buttonSpace*1, buttonWidth, buttonHeight);
    self.button3.frame = CGRectMake(150, 30+buttonSpace*2, buttonWidth, buttonHeight);
    self.button4.frame = CGRectMake(150, 30+buttonSpace*3, buttonWidth, buttonHeight);
    self.button5.frame = CGRectMake(150, 30+buttonSpace*4, buttonWidth, buttonHeight);
    self.button6.frame = CGRectMake(150, 30+buttonSpace*5, buttonWidth, buttonHeight);
    
    buttonWidth = (kWindowWidth-50*5)/4;
    buttonHeight = 80;
    
    self.play.frame = CGRectMake(650, 150, buttonWidth, buttonHeight);
    self.pause.frame = CGRectMake(650, 350, buttonWidth, buttonHeight);
    
    self.openPj.frame = CGRectMake(50, kWindowHeight-120, buttonWidth, buttonHeight);
    self.closePj.frame = CGRectMake(buttonWidth*1+50*2, kWindowHeight-120, buttonWidth, buttonHeight);
    self.openComputer.frame = CGRectMake(buttonWidth*2+50*3, kWindowHeight-120, buttonWidth, buttonHeight);
    self.closeComputer.frame = CGRectMake(buttonWidth*3+50*4, kWindowHeight-120, buttonWidth, buttonHeight);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSTimeInterval time = [NSDate timeIntervalSinceReferenceDate] - [[[NSUserDefaults standardUserDefaults] objectForKey:@"pjTime"] doubleValue];
    if (time > 120) {
        self.openPj.enabled = YES;
        self.closePj.enabled = YES;
    }
}

#pragma mark - AsyncUdpSocketDelegate
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"didConnectToHost : %@ and port is %ld", host, (long)port);
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"willDisconnectWithError : %@", err);
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"onSocketDidDisconnect");
}

- (BOOL)onSocketWillConnect:(AsyncSocket *)sock
{
    NSLog(@"onSocketWillConnect");
    return YES;
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"socketDidDisconnect ...");
}

- (void)onSocket:(AsyncSocket *)socket didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"didReadData");
    NSString * message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString * sendString = @"";
    NSString * random = @"";
    if ([message hasPrefix:@"PJLINK"] )
    {
        NSRange range;
        range.location = 7;
        range.length = 1;
        NSString * protocol = [message substringWithRange:range];
        if ([protocol isEqualToString:@"1"])
        {
            NSRange range;
            range.location = 9;
            range.length = 8;
            random = [message substringWithRange:range];
            random = [random stringByAppendingString:@"panasonic"];
            random = [random md5];
        }
    }
    
    // open pj
    if ( 1 == tag )
    {
        Byte byte[] = {0x25, 0x31, 0x50, 0x4f, 0x57, 0x52, 0x20, 0x31, 0x0d};
        NSData * commandData = [[NSData alloc] initWithBytes:byte length:9];
        NSString * commandString = [[NSString alloc] initWithData:commandData encoding:NSUTF8StringEncoding
                                    ];
        sendString = [random stringByAppendingString:commandString];
    }
    // close pj
    else if ( 2 == tag )
    {
        Byte byte[] = {0x25, 0x31, 0x50, 0x4f, 0x57, 0x52, 0x20, 0x30, 0x0d};
        NSData * commandData = [[NSData alloc] initWithBytes:byte length:9];
        NSString * commandString = [[NSString alloc] initWithData:commandData encoding:NSUTF8StringEncoding];
        sendString = [random stringByAppendingString:commandString];
    }
    
    [socket writeData:[sendString dataUsingEncoding:NSUTF8StringEncoding] withTimeout:SOCKET_TIMEOUT tag:tag];
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"didWriteDataWithTag tag : %ld", tag);
}

#pragma mark - AsyncUdpSocketDelegate
- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    NSLog(@"onUdpSocket...didNotSendDataWithTag:%ld, error:%@", tag, error);
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    NSLog(@"onUdpSocket...didSendDataWithTag:%ld", tag);
}

- (void)onUdpSocketDidClose:(AsyncUdpSocket *)sock
{
    NSLog(@"onUdpSocketDidClose");
}

#pragma mark - event
- (void)clickPlay
{
    Byte byte[] = {
        0x10, 0x00, 0x00, 0x00,
        0x12, 0x27, 0x00, 0x00,
        0x11, 0x00, 0x00, 0x00,
        0x01, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x01, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00};
    NSData * data = [[NSData alloc] initWithBytes:byte length:46];
    
    AsyncUdpSocket * socket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    [socket sendData:data toHost:@"192.168.1.111" port:48889 withTimeout:-1 tag:0];
}

- (void)clickPause
{
    Byte byte[] = {
        0x10, 0x00, 0x00, 0x00,
        0x12, 0x27, 0x00, 0x00,
        0x11, 0x00, 0x00, 0x00,
        0x01, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00};
    NSData * data = [[NSData alloc] initWithBytes:byte length:46];
    
    AsyncUdpSocket * socket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    [socket sendData:data toHost:@"192.168.1.111" port:48889 withTimeout:-1 tag:0];
}

- (void)clickOpenPj
{
    for (NSString * host in self.pjHost)
    {
        AsyncSocket * socket = [[AsyncSocket alloc] initWithDelegate:self];
        [socket connectToHost:host onPort:self.port error:nil];
        [socket readDataWithTimeout:SOCKET_TIMEOUT tag:1];
    }
    
    [self pjTime];
}

- (void)clickClosePj
{
    for (NSString * host in self.pjHost) {
        AsyncSocket * socket = [[AsyncSocket alloc] initWithDelegate:self];
        [socket connectToHost:host onPort:self.port error:nil];
        [socket readDataWithTimeout:SOCKET_TIMEOUT tag:2];
    }
    
    [self pjTime];
}

- (void)pjTime
{
    self.openPj.enabled = NO;
    self.closePj.enabled = NO;
    [[NSUserDefaults standardUserDefaults] setObject:@([NSDate timeIntervalSinceReferenceDate]) forKey:@"pjTime"];
}

- (void)clickOpenComputer
{
    Byte macAddres[] = {0x40, 0x8d, 0x5c, 0x14, 0x88, 0xcf};
    
    Byte byte[200] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
    for (int i = 0; i < 16; i++) {
        memcpy(byte+6*(i+1), macAddres, 6);
    }
    
    NSData * data = [[NSData alloc] initWithBytes:byte length:102];
    AsyncUdpSocket * socket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    [socket enableBroadcast:YES error:nil];
    [socket sendData:data toHost:@"255.255.255.255" port:48889 withTimeout:-1 tag:0];
    
    /////////////////////
    
    Byte macAddres1[] = {0xfc, 0xaa, 0x14, 0xc4, 0xcc, 0x97};
    
    Byte byte1[200] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
    for (int i = 0; i < 16; i++) {
        memcpy(byte1+6*(i+1), macAddres1, 6);
    }
    
    NSData * data1 = [[NSData alloc] initWithBytes:byte1 length:102];
    AsyncUdpSocket * socket1 = [[AsyncUdpSocket alloc] initWithDelegate:self];
    [socket1 enableBroadcast:YES error:nil];
    [socket1 sendData:data1 toHost:@"255.255.255.255" port:48889 withTimeout:-1 tag:0];
}

- (void)clickCloseComputer
{
    NSString * string = @"pc_off";
    
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    AsyncUdpSocket * socket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    [socket sendData:data toHost:@"192.168.1.11" port:48888 withTimeout:-1 tag:0];
    
    ///////
    
    AsyncUdpSocket * socket1 = [[AsyncUdpSocket alloc] initWithDelegate:self];
    [socket1 sendData:data toHost:@"192.168.1.11" port:48888 withTimeout:-1 tag:0];
}

- (void)clickButton1
{
    Byte byte[] = {
        0x10, 0x00, 0x00, 0x00,
        0x12, 0x27, 0x00, 0x00,
        0x11, 0x00, 0x00, 0x00,
        0x01, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x04, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00};
    NSData * data = [[NSData alloc] initWithBytes:byte length:46];
    
    AsyncUdpSocket * socket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    [socket sendData:data toHost:@"192.168.1.111" port:48889 withTimeout:-1 tag:0];
}

- (void)clickButton2
{
    Byte byte[] = {
        0x10, 0x00, 0x00, 0x00,
        0x12, 0x27, 0x00, 0x00,
        0x11, 0x00, 0x00, 0x00,
        0x01, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x04, 0x00,
        0x00, 0x00, 0x38, 0x7c,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00};
    NSData * data = [[NSData alloc] initWithBytes:byte length:46];
    
    AsyncUdpSocket * socket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    [socket sendData:data toHost:@"192.168.1.111" port:48889 withTimeout:-1 tag:0];
}

- (void)clickButton3
{
    Byte byte[] = {
        0x10, 0x00, 0x00, 0x00,
        0x12, 0x27, 0x00, 0x00,
        0x11, 0x00, 0x00, 0x00,
        0x01, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x04, 0x00,
        0x00, 0x00, 0xc8, 0xf5,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00};
    NSData * data = [[NSData alloc] initWithBytes:byte length:46];
    
    AsyncUdpSocket * socket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    [socket sendData:data toHost:@"192.168.1.111" port:48889 withTimeout:-1 tag:0];
}

- (void)clickButton4
{
    Byte byte[] = {
        0x10, 0x00, 0x00, 0x00,
        0x12, 0x27, 0x00, 0x00,
        0x11, 0x00, 0x00, 0x00,
        0x01, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x04, 0x00,
        0x00, 0x00, 0xb8, 0x82,
        0x01, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00};
    NSData * data = [[NSData alloc] initWithBytes:byte length:46];
    
    AsyncUdpSocket * socket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    [socket sendData:data toHost:@"192.168.1.111" port:48889 withTimeout:-1 tag:0];
}

- (void)clickButton5
{
    Byte byte[] = {
        0x10, 0x00, 0x00, 0x00,
        0x12, 0x27, 0x00, 0x00,
        0x11, 0x00, 0x00, 0x00,
        0x01, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x04, 0x00,
        0x00, 0x00, 0x60, 0xee,
        0x01, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00};
    NSData * data = [[NSData alloc] initWithBytes:byte length:46];
    
    AsyncUdpSocket * socket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    [socket sendData:data toHost:@"192.168.1.111" port:48889 withTimeout:-1 tag:0];
}

- (void)clickButton6
{
    Byte byte[] = {
        0x10, 0x00, 0x00, 0x00,
        0x12, 0x27, 0x00, 0x00,
        0x11, 0x00, 0x00, 0x00,
        0x01, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x04, 0x00,
        0x00, 0x00, 0x90, 0x63,
        0x02, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00, 0x00};
    NSData * data = [[NSData alloc] initWithBytes:byte length:46];
    
    AsyncUdpSocket * socket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    [socket sendData:data toHost:@"192.168.1.111" port:48889 withTimeout:-1 tag:0];
}

#pragma mark - getter and setter
- (NSArray *)pjHost
{
    return @[
             @"192.168.1.131",
             @"192.168.1.132",
             @"192.168.1.133",
             @"192.168.1.134",
             @"192.168.1.135",
             @"192.168.1.136",
             ];
}

- (NSInteger)port
{
    if (0 == _port) {
        _port = 4352;
    }
    return _port;
}

- (UIButton *)play
{
    if (nil == _play) {
        _play = [[UIButton alloc] initWithTitle:@"开始播放"];
        [_play addTarget:self action:@selector(clickPlay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _play;
}

- (UIButton *)pause
{
    if (nil == _pause) {
        _pause = [[UIButton alloc] initWithTitle:@"暂停播放"];
        [_pause addTarget:self action:@selector(clickPause) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pause;
}

- (UIButton *)openPj
{
    if (nil == _openPj) {
        _openPj = [[UIButton alloc] initWithTitle:@"开启投影" normalColor:[UIColor normalButtonBlueColor] highlightedColor:[UIColor highlightedButtonBlueColor]];
        [_openPj addTarget:self action:@selector(clickOpenPj) forControlEvents:UIControlEventTouchUpInside];
        _openPj.enabled = NO;
    }
    return _openPj;
}

- (UIButton *)closePj
{
    if (nil == _closePj) {
        _closePj = [[UIButton alloc] initWithTitle:@"关闭投影" normalColor:[UIColor normalButtonBlueColor] highlightedColor:[UIColor highlightedButtonBlueColor]];
        [_closePj addTarget:self action:@selector(clickClosePj) forControlEvents:UIControlEventTouchUpInside];
        _closePj.enabled = NO;
    }
    return _closePj;
}

- (UIButton *)openComputer
{
    if (nil == _openComputer) {
        _openComputer = [[UIButton alloc] initWithTitle:@"开启电脑" normalColor:[UIColor normalButtonBlueColor] highlightedColor:[UIColor highlightedButtonBlueColor]];
        [_openComputer addTarget:self action:@selector(clickOpenComputer) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openComputer;
}

- (UIButton *)closeComputer
{
    if (nil == _closeComputer) {
        _closeComputer = [[UIButton alloc] initWithTitle:@"关闭电脑" normalColor:[UIColor normalButtonBlueColor] highlightedColor:[UIColor highlightedButtonBlueColor]];
        [_closeComputer addTarget:self action:@selector(clickCloseComputer) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeComputer;
}

- (UIButton *)button1
{
    if (nil == _button1) {
        _button1 = [[UIButton alloc] initWithTitle:@"西湖西溪"];
        [_button1 addTarget:self action:@selector(clickButton1) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1;
}

- (UIButton *)button2
{
    if (nil == _button2) {
        _button2 = [[UIButton alloc] initWithTitle:@"公园"];
        [_button2 addTarget:self action:@selector(clickButton2) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2;
}

- (UIButton *)button3
{
    if (nil == _button3) {
        _button3 = [[UIButton alloc] initWithTitle:@"学校"];
        [_button3 addTarget:self action:@selector(clickButton3) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button3;
}

- (UIButton *)button4
{
    if (nil == _button4) {
        _button4 = [[UIButton alloc] initWithTitle:@"银泰"];
        [_button4 addTarget:self action:@selector(clickButton4) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button4;
}

- (UIButton *)button5
{
    if (nil == _button5) {
        _button5 = [[UIButton alloc] initWithTitle:@"地铁"];
        [_button5 addTarget:self action:@selector(clickButton5) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button5;
}

- (UIButton *)button6
{
    if (nil == _button6) {
        _button6 = [[UIButton alloc] initWithTitle:@"项目"];
        [_button6 addTarget:self action:@selector(clickButton6) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button6;
}

@end
