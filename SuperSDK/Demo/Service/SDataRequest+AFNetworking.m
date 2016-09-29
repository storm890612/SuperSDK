//
//  SDataRequest+AFNetworking.m
//  SuperSDK
//
//  Created by 刘超 on 16/9/28.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SDataRequest+AFNetworking.h"
#import "SHTTPSessionManager.h"
#import <objc/runtime.h>

static NSString *s_dataTask_key = @"s_dataTask_key";

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

- (NSString *)requestMethod
{
    return nil;
}

- (NSString *)URLString
{
    return nil;
}

- (id)cacheData
{
    [self.HTTPSessionManager.session.configuration.URLCache getCachedResponseForDataTask:self.dataTask completionHandler:^(NSCachedURLResponse * _Nullable cachedResponse) {
        
    }];
    return nil;
}

- (NSURLSessionDataTask *)dataTask
{
    NSURLSessionDataTask* object = objc_getAssociatedObject(self, &s_dataTask_key);
    if (!object) {
        NSError *serializationError;
        NSURLRequest *request = [self.HTTPSessionManager.requestSerializer requestWithMethod:[self requestMethod] URLString:[self URLString] parameters:self.parameters error:&serializationError];
        
        if (serializationError) {
            self.error = serializationError;
            [self submitData:nil];
            return nil;
        }
        
        __block NSURLSessionDataTask *dataTask = nil;
        dataTask = [self.HTTPSessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
            if (error) {
                self.error = error;
                [self submitData:nil];
            } else {
                self.error = nil;
                [self submitData:responseObject];
            }
        }];
        
        objc_setAssociatedObject(self, &s_dataTask_key, dataTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return object;
}
- (void)setDataTask:(NSURLSessionDataTask *)dataTask
{
    objc_setAssociatedObject(self, &s_dataTask_key, dataTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSURLRequestCachePolicy)requestCachePolicy
{
    return NSURLRequestReloadRevalidatingCacheData;
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
