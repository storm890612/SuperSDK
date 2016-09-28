//
//  SDataRequest+AFNetworking.h
//  SuperSDK
//
//  Created by 刘超 on 16/9/28.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SDataRequest.h"
#import "SHTTPSessionManager.h"
@interface SDataRequest (AFNetworking)

- (SHTTPSessionManager *)HTTPSessionManager;

@property NSURLRequestCachePolicy requestCachePolicy;

@property NSTimeInterval timeoutIntervalForRequest;

@property NSTimeInterval timeoutIntervalForResource;

@property NSURLRequestNetworkServiceType networkServiceType;

@property BOOL allowsCellularAccess;

@end