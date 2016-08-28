//
//  SWeakDataRequest.m
//  SuperSDK
//
//  Created by 刘超 on 16/8/28.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SWeakDataRequest.h"
@implementation SWeakDataRequest
+ (instancetype)weakDataRequest:(SDataRequest *)dataRequest {
    SWeakDataRequest *weakDataRequest = [SWeakDataRequest new];
    weakDataRequest.dataRequest = dataRequest;
    return weakDataRequest;
}
@end
