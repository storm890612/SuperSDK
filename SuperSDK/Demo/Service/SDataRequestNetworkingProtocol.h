//
//  SDataRequestNetworkingProtocol.h
//  SuperSDK
//
//  Created by 刘超 on 16/10/12.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHTTPSessionManager.h"

@protocol SDataRequestNetworkingProtocol <NSObject>
@required
@property (atomic, readonly, strong)NSURLSessionDataTask *dataTask;

- (SHTTPSessionManager *)HTTPSessionManager;

- (NSString *)requestMethod;

- (NSString *)URLString;

@optional

- (BOOL)needCustomCacheData;

- (void)cacheDataWithCompletionHandler:(void (^) (id cacheData))completionHandler;

- (NSURLRequestCachePolicy)requestCachePolicy;

- (NSTimeInterval)timeoutIntervalForRequest;

- (NSTimeInterval)timeoutIntervalForResource;

- (NSURLRequestNetworkServiceType)networkServiceType;

- (BOOL)allowsCellularAccess;

@end
