//
//  SHTTPSessionManager.m
//  SuperSDK
//
//  Created by 刘超 on 16/9/27.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SHTTPSessionManager.h"

@implementation SHTTPSessionManager
+ (instancetype)sharedManager
{
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [[NSURLSessionConfiguration alloc] init];
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil sessionConfiguration:configuration];
    });
    //manager.session.configuration
    return (SHTTPSessionManager *)manager;
}
@end