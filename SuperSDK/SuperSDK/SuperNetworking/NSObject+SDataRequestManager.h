//
//  NSObject+SRequest.h
//  SuperSDK
//
//  Created by 刘超 on 16/7/18.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDataRequest.h"
@interface NSObject (SDataRequestManager)
@property (nonatomic, strong) NSMutableArray *s_dataRequests;
- (SDataRequest *)s_sendRequestByName:(NSString *)name parameters:(NSDictionary *)parameters action:(SEL)action;

- (SDataRequest *)s_registerDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters target:(id)target action:(SEL)action;

- (SDataRequest *)s_sendDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters callBack:(SDataRequestCallBackBlock)callBack;

- (SDataRequest *)s_registerDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters callBack:(SDataRequestCallBackBlock)callBack;

- (void)s_removeDataRequest:(SDataRequest *)dataRequest;

- (void)s_cancelDataRequest:(SDataRequest *)dataRequest;

- (void)s_cancelAllRequest;
@end
