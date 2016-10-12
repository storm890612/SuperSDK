//
//  SDemoBaseDataRequest.m
//  SuperSDK
//
//  Created by 刘超 on 16/9/26.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SDemoBaseDataRequest.h"

@interface SDemoBaseDataRequest ()
{
    NSURLSessionDataTask *_dataTask;
}
@end


@implementation SDemoBaseDataRequest

@synthesize dataTask;

- (void)willStartDataRequest
{
    // 加密参数
}
- (void)didEndDataRequest
{
    // 解密结果
    NSDictionary *data = [self decodingData:self.responseData];
    self.responseData = [self packageData:data];
}
- (NSDictionary *)decodingData:(NSDictionary *)data
{
    return data;
}

- (id)packageData:(NSDictionary *)data
{
    return data;
}

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
            id responseObject = [self.HTTPSessionManager.responseSerializer responseObjectForResponse:cachedResponse.response data:cachedResponse.data error:nil];
            completionHandler([self packageData:[self decodingData:responseObject]]);
        }
    }];
}

- (BOOL)needCustomCacheData
{
    return YES;
}

- (NSURLSessionDataTask *)dataTask
{
    if (!_dataTask) {
        NSError *serializationError;
        NSURLRequest *request = [self.HTTPSessionManager.requestSerializer requestWithMethod:[self requestMethod] URLString:[self URLString] parameters:self.parameters error:&serializationError];
        
        if (serializationError) {
            self.error = serializationError;
            [self submitData:nil];
            return nil;
        }
        
        _dataTask = [self.HTTPSessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
            if (error) {
                self.error = error;
                [self submitData:nil];
            } else {
                if ([self needCustomCacheData]) {
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
                    NSCachedURLResponse *cachedURLResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:jsonData userInfo:nil storagePolicy:NSURLCacheStorageAllowed];
                    [self.HTTPSessionManager.session.configuration.URLCache storeCachedResponse:cachedURLResponse forDataTask:_dataTask];
                }
                self.error = nil;
                [self submitData:responseObject];
            }
        }];
        
    }
    return _dataTask;
}



- (NSURLRequestCachePolicy)requestCachePolicy
{
    return NSURLRequestUseProtocolCachePolicy;
}

- (NSTimeInterval)timeoutIntervalForRequest
{
    return 20;
}

- (NSTimeInterval)timeoutIntervalForResource
{
    return 20;
}

- (NSURLRequestNetworkServiceType)networkServiceType
{
    return NSURLNetworkServiceTypeDefault;
}

- (BOOL)allowsCellularAccess
{
    return YES;
}

@end
