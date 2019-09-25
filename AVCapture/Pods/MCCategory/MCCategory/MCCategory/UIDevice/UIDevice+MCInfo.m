//
//  UIDevice+MCInfo.m
//  Pods
//
//  Created by muyu on 2017/3/7.
//
//  https://www.theiphonewiki.com/wiki/Models

#import "UIDevice+MCInfo.h"
#import <sys/utsname.h>

@implementation UIDevice (MCInfo)

#pragma mark - Public Method

+ (NSString *)mc_deviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];    
    return deviceString;
}

+ (NSString *)mc_deviceIDFV
{
    NSString *bundleID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSString *keychianID = [bundleID stringByAppendingString:@".mcDeviceIDFV"];
    NSString *idfv = [UIDevice loadKeychain:keychianID];
    if (idfv == nil) {
        idfv = [UIDevice currentDevice].identifierForVendor.UUIDString;
        [UIDevice saveKeychian:keychianID data:idfv];
    }
    
    return idfv;
}

#pragma mark - Private Method

+ (id)loadKeychain:(NSString *)service
{
    id ret = nil;
    NSMutableDictionary * keychainQuery = [UIDevice getKeychainQuery:service];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)saveKeychian:(NSString *)service data:(id)data
{
    NSMutableDictionary * keychainQuery = [UIDevice getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

@end
