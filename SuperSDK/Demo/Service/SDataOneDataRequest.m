//
//  SDataOneDataRequest.m
//  SuperSDK
//
//  Created by 刘超 on 16/9/26.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SDataOneDataRequest.h"
#import "SHTTPSessionManager.h"
@implementation SDataOneDataRequest
- (NSString *)requestMethod
{
    return @"GET";
}

- (NSString *)URLString
{
    return @"http://httpbin.org/get";
}
- (void)loadData
{
    [self.dataTask resume];
}
@end
