//
//  SNetworkingManager.h
//  SuperSDK
//
//  Created by 刘超 on 16/7/10.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SDataRequest;
typedef void(^SDataRequestCallBackBlock)(SDataRequest *dataRequest);

@interface SDataRequestManager : NSObject
@property (nonatomic, readonly,   copy) NSArray *allDataRequests;
+ (instancetype)sharedManager;

+ (SDataRequest *)sendDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters target:(id)target action:(SEL)action;

+ (SDataRequest *)registerDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters target:(id)target action:(SEL)action;

+ (SDataRequest *)sendDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters callBack:(SDataRequestCallBackBlock)callBack;

+ (SDataRequest *)registerDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters callBack:(SDataRequestCallBackBlock)callBack;

+ (void)removeDataRequest:(SDataRequest *)dataRequest;
@end
