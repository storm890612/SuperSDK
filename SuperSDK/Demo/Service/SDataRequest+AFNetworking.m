//
//  SDataRequest+AFNetworking.m
//  SuperSDK
//
//  Created by 刘超 on 16/9/28.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SDataRequest+AFNetworking.h"
#import "SHTTPSessionManager.h"
@implementation SDataRequest (AFNetworking)
- (SHTTPSessionManager *)HTTPSessionManager
{
    return [SHTTPSessionManager sharedManager];
}
- (NSURLSessionConfiguration *)configuration
{
    return [SHTTPSessionManager sharedManager].session.configuration;
}

@end
