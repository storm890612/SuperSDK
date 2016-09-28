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
    SHTTPSessionManager *HTTPSessionManager = [SHTTPSessionManager sharedManager];
    HTTPSessionManager.session.configuration.requestCachePolicy = [self requestCachePolicy];
    HTTPSessionManager.session.configuration.timeoutIntervalForRequest = [self timeoutIntervalForRequest];
    HTTPSessionManager.session.configuration.timeoutIntervalForResource = [self timeoutIntervalForResource];
    HTTPSessionManager.session.configuration.networkServiceType = [self networkServiceType];
    HTTPSessionManager.session.configuration.allowsCellularAccess = [self allowsCellularAccess];

    return HTTPSessionManager;
}

- (NSURLRequestCachePolicy)requestCachePolicy
{
    return NSURLRequestUseProtocolCachePolicy;
}
- (void)setRequestCachePolicy:(NSURLRequestCachePolicy)requestCachePolicy
{
    [SHTTPSessionManager sharedManager].session.configuration.requestCachePolicy = requestCachePolicy;
}

- (NSTimeInterval)timeoutIntervalForRequest
{
    return 10;
}
- (void)setTimeoutIntervalForRequest:(NSTimeInterval)timeoutIntervalForRequest
{
    [SHTTPSessionManager sharedManager].session.configuration.timeoutIntervalForRequest = [self timeoutIntervalForRequest];
}

- (NSTimeInterval)timeoutIntervalForResource
{
    return 10;
}
- (void)setTimeoutIntervalForResource:(NSTimeInterval)timeoutIntervalForResource
{
    [SHTTPSessionManager sharedManager].session.configuration.timeoutIntervalForResource = [self timeoutIntervalForResource];
}

- (NSURLRequestNetworkServiceType)networkServiceType
{
    return NSURLNetworkServiceTypeDefault;
}
- (void)setNetworkServiceType:(NSURLRequestNetworkServiceType)networkServiceType
{
    [SHTTPSessionManager sharedManager].session.configuration.networkServiceType = [self networkServiceType];
}

- (BOOL)allowsCellularAccess
{
    return YES;
}
- (void)setAllowsCellularAccess:(BOOL)allowsCellularAccess
{
    [SHTTPSessionManager sharedManager].session.configuration.allowsCellularAccess = [self allowsCellularAccess];
}
@end
