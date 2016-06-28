//
//  STools.m
//  SuperSDK
//
//  Created by 刘超 on 16/6/29.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "STools.h"
#import <UIKit/UIKit.h>
@implementation STools
+ (void)addUserAgentWithName:(NSString *)name {
    // 放在webview加载钱调用下面的方法并不好使，
    // 一般要遵守UserAgent的规范，下面的名字和版本就是一个一般的规范  名字/版本 (系统)
    NSDictionary *info= [[NSBundle mainBundle] infoDictionary];
    NSString *version = info[@"CFBundleShortVersionString"];
    NSString *myUserAgent = [NSString stringWithFormat:@" %@/%@ (ios)",name,version];
    NSString *oldUserAgent = [[UIWebView new] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString *userAgent;
    // 如果不存在
    if (![oldUserAgent commonPrefixWithString:myUserAgent options:NSBackwardsSearch]) {
        userAgent = [oldUserAgent stringByAppendingString:myUserAgent];
    } else {
        userAgent = oldUserAgent;
    }
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:userAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
