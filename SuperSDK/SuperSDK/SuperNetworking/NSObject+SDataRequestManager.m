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
- (void)s_cancelAllRequest {
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
