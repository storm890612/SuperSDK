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

static NSString *s_dataTask = @"s_dataTask";
static NSString *s_needCustomCacheData = @"s_needCustomCacheData";

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

- (void)cacheDataWithCompletionHandler:(void (^) (id cacheData))completionHandler;
{
    [self.HTTPSessionManager.session.configuration.URLCache getCachedResponseForDataTask:self.dataTask completionHandler:^(NSCachedURLResponse * _Nullable cachedResponse) {
        if (completionHandler) {
            completionHandler(cachedResponse.data);
        }
    }];
}

- (BOOL)needCustomCacheData
{
    return [objc_getAssociatedObject(self, &s_needCustomCacheData) boolValue];
}
- (void)setNeedCustomCacheData:(BOOL)needCustomCacheData
{
    objc_setAssociatedObject(self, &s_needCustomCacheData, @(needCustomCacheData), OBJC_ASSOCIATION_ASSIGN);
}


- (NSURLSessionDataTask *)dataTask
{
    __block NSURLSessionDataTask* object = objc_getAssociatedObject(self, &s_dataTask);
    if (!object) {
        NSError *serializationError;
        NSURLRequest *request = [self.HTTPSessionManager.requestSerializer requestWithMethod:[self requestMethod] URLString:[self URLString] parameters:self.parameters error:&serializationError];
        
        if (serializationError) {
            self.error = serializationError;
            [self submitData:nil];
            return nil;
        }
        
        object = [self.HTTPSessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
            if (error) {
                self.error = error;
                [self submitData:nil];
            } else {
                if ([self needCustomCacheData]) {
                    NSCachedURLResponse *cachedURLResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:responseObject userInfo:nil storagePolicy:NSURLCacheStorageAllowed];
                    [self.HTTPSessionManager.session.configuration.URLCache storeCachedResponse:cachedURLResponse forDataTask:object];
                }
                self.error = nil;
                [self submitData:responseObject];
            }
        }];
        objc_setAssociatedObject(self, &s_dataTask, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return object;
}
- (void)setDataTask:(NSURLSessionDataTask *)dataTask
{
    objc_setAssociatedObject(self, &s_dataTask, dataTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSURLRequestCachePolicy)requestCachePolicy
{
    return [SHTTPSessionManager sharedManager].session.configuration.requestCachePolicy;
}
- (void)setRequestCachePolicy:(NSURLRequestCachePolicy)requestCachePolicy
{
    [SHTTPSessionManager sharedManager].session.configuration.requestCachePolicy = requestCachePolicy;
}

- (NSTimeInterval)timeoutIntervalForRequest
{
    return [SHTTPSessionManager sharedManager].session.configuration.timeoutIntervalForRequest;
}
- (void)setTimeoutIntervalForRequest:(NSTimeInterval)timeoutIntervalForRequest
{
    [SHTTPSessionManager sharedManager].session.configuration.timeoutIntervalForRequest = timeoutIntervalForRequest;
}

- (NSTimeInterval)timeoutIntervalForResource
{
    return [SHTTPSessionManager sharedManager].session.configuration.timeoutIntervalForResource;
}
- (void)setTimeoutIntervalForResource:(NSTimeInterval)timeoutIntervalForResource
{
    [SHTTPSessionManager sharedManager].session.configuration.timeoutIntervalForResource = timeoutIntervalForResource;
}

- (NSURLRequestNetworkServiceType)networkServiceType
{
    return [SHTTPSessionManager sharedManager].session.configuration.networkServiceType;
}
- (void)setNetworkServiceType:(NSURLRequestNetworkServiceType)networkServiceType
{
    [SHTTPSessionManager sharedManager].session.configuration.networkServiceType = networkServiceType;
}

- (BOOL)allowsCellularAccess
{
    return [SHTTPSessionManager sharedManager].session.configuration.allowsCellularAccess;
}
- (void)setAllowsCellularAccess:(BOOL)allowsCellularAccess
{
    [SHTTPSessionManager sharedManager].session.configuration.allowsCellularAccess = allowsCellularAccess;
}
@end
