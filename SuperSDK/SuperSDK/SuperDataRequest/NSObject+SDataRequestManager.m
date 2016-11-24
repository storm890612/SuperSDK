//
//  NSObject+SRequest.m
//  SuperSDK
//
//  Created by 刘超 on 16/7/18.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "NSObject+SDataRequestManager.h"
#import "SDataRequestManager.h"
#import "SWeakDataRequest.h"
#import <objc/runtime.h>
static NSString *s_dataRequests_key;

@implementation NSObject (SDataRequestManager)
@dynamic s_dataRequests;
- (SDataRequest *)s_sendRequestByName:(NSString *)name parameters:(NSDictionary *)parameters action:(SEL)action {
    SDataRequest *dataRequest = [SDataRequestManager sendDataRequestByName:name parameters:parameters target:self action:action];
    [self.s_dataRequests addObject:[SWeakDataRequest weakDataRequest:dataRequest]];
    return dataRequest;
}

- (SDataRequest *)s_registerDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters target:(id)target action:(SEL)action
{
    SDataRequest *dataRequest =  [SDataRequestManager registerDataRequestByName:name parameters:parameters target:target action:action];
    [self.s_dataRequests addObject:[SWeakDataRequest weakDataRequest:dataRequest]];
    return dataRequest;
}

- (SDataRequest *)s_sendDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters callBack:(SDataRequestCallBackBlock)callBack
{
    SDataRequest *dataRequest = [SDataRequestManager sendDataRequestByName:name parameters:parameters callBack:callBack];
    [self.s_dataRequests addObject:[SWeakDataRequest weakDataRequest:dataRequest]];
    return dataRequest;
}

- (SDataRequest *)s_registerDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters callBack:(SDataRequestCallBackBlock)callBack
{
    SDataRequest *dataRequest = [SDataRequestManager registerDataRequestByName:name parameters:parameters callBack:callBack];
    [self.s_dataRequests addObject:[SWeakDataRequest weakDataRequest:dataRequest]];
    return dataRequest;
}

- (void)s_removeDataRequest:(SDataRequest *)dataRequest
{
    [SDataRequestManager removeDataRequest:dataRequest];
}

- (void)s_cancelDataRequest:(SDataRequest *)dataRequest
{
    @synchronized (self) {
        [dataRequest cancel];
        NSInteger index = [self.s_dataRequests indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SWeakDataRequest *weakdataRequest = obj;
            BOOL  found = (weakdataRequest.dataRequest == dataRequest);
            *stop = found;
            return found;
        }];
        if (index != NSNotFound) {
            [self.s_dataRequests removeObjectAtIndex:index];
        }
    }
}

- (void)s_cancelAllRequest
{
    for (SWeakDataRequest *weakdataRequest in self.s_dataRequests) {
        SDataRequest *dataRequest = weakdataRequest.dataRequest;
        if (dataRequest) {
            [dataRequest cancel];
        }
    }
    [self.s_dataRequests removeAllObjects];
}
- (NSMutableArray *)s_dataRequests {
    NSMutableArray* object = objc_getAssociatedObject(self, &s_dataRequests_key);
    return object;
}
- (void)setS_parameters:(NSDictionary *)s_parameters {
    objc_setAssociatedObject(self, &s_dataRequests_key, s_parameters, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
