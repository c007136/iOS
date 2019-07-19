//
//  ViewController.m
//  HTTPS
//
//  Created by miniu on 15/8/17.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  http://oncenote.com/2014/10/21/Security-1-HTTPS/

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSURLConnection          * connection;

@end

@implementation ViewController

#pragma mark - life circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.connection start];
}

#pragma mark - NSURLConnectionDelegate and NSURLConnectionDataDelegate
//- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
//    
//    //1)获取trust object
//    SecTrustRef trust = challenge.protectionSpace.serverTrust;
//    SecTrustResultType result;
//    
//    //2)SecTrustEvaluate对trust进行验证
//    OSStatus status = SecTrustEvaluate(trust, &result);
//    if (status == errSecSuccess &&
//        (result == kSecTrustResultProceed ||
//         result == kSecTrustResultUnspecified)) {
//            
//            //3)验证成功，生成NSURLCredential凭证cred，告知challenge的sender使用这个凭证来继续连接
//            NSURLCredential *cred = [NSURLCredential credentialForTrust:trust];
//            [challenge.sender useCredential:cred forAuthenticationChallenge:challenge];
//            NSLog(@"connection is success");
//            
//        } else {
//            
//            //5)验证失败，取消这次验证流程
//            [challenge.sender cancelAuthenticationChallenge:challenge];
//            NSLog(@"connection is failed");
//            
//        }
//}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"connectionDelegate success--- \nstring is %@", string);
}

#pragma mark - getter and setter
- (NSURLConnection *)connection
{
    if (_connection == nil) {
        NSURL * httpsURL = [NSURL URLWithString:@"https://app.miniu98.com/index.json"];
        NSURLRequest * httpsRequest = [NSURLRequest requestWithURL:httpsURL];
        _connection = [[NSURLConnection alloc] initWithRequest:httpsRequest delegate:self];
    }
    return _connection;
}

@end
