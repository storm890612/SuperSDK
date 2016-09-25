//
//  SNetworkingManager.m
//  SuperSDK
//
//  Created by 刘超 on 16/7/10.
//  Copyright © 2016年 SuperMan. All rights reserved.
//
#import <objc/message.h>

// 运行时objc_msgSend
#define SMsgSend(...) ((void (*)(void *, SEL, id ))objc_msgSend)(__VA_ARGS__)
#define SMsgTarget(target) (__bridge void *)(target)

#import "SDataRequestManager.h"
#import "SDataRequestParser.h"
#import "SDataRequestCallBackItem.h"
#import "SDataRequest.h"
@interface SDataRequestManager () <SDataRequestDelegate>
@property (nonatomic, strong) NSMutableDictionary *dataRequestMap;
@property (nonatomic, strong) NSMutableDictionary *dataRequestCallBackItemMap;
@property (nonatomic, strong) NSMutableDictionary *dataRequestCallBackBlockMap;
@property (nonatomic, assign) NSInteger dataRequestCount;

@end
@implementation SDataRequestManager
+ (instancetype)sharedManager {
    static SDataRequestManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [self new];
    });
    return _sharedManager;
}

+ (SDataRequest *)sendDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters target:(id)target action:(SEL)action
{
    return [[self sharedManager] sendDataRequestByName:name parameters:parameters target:target action:action];
}
- (SDataRequest *)sendDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters target:(id)target action:(SEL)action
{
    SDataRequest *dataRequest = [self registerDataRequestByName:name parameters:parameters target:target action:action];
    [dataRequest start];
    return dataRequest;
}

+ (SDataRequest *)registerDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters target:(id)target action:(SEL)action
{
    return [[self sharedManager] registerDataRequestByName:name parameters:parameters target:target action:action];
}
- (SDataRequest *)registerDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters target:(id)target action:(SEL)action
{
    SDataRequest *dataRequest = [self registerDataRequestByName:name parameters:parameters];
    SDataRequestCallBackItem *callBackItem = [SDataRequestCallBackItem dataRequestCallBackItemWithTarget:target action:action];
    [self.dataRequestCallBackItemMap setObject:callBackItem forKey:[NSString stringWithFormat:@"%ld",dataRequest.dataRequestID]];
    return dataRequest;
}

+ (SDataRequest *)sendDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters callBack:(SDataRequestCallBackBlock)callBack
{
    return [[self sharedManager] sendDataRequestByName:name parameters:parameters callBack:callBack];
}
- (SDataRequest *)sendDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters callBack:(SDataRequestCallBackBlock)callBack
{
    SDataRequest *dataRequest = [self registerDataRequestByName:name parameters:parameters callBack:callBack];
    [dataRequest start];
    return dataRequest;
}

+ (SDataRequest *)registerDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters callBack:(SDataRequestCallBackBlock)callBack
{
    return [[self sharedManager] registerDataRequestByName:name parameters:parameters callBack:callBack];
}
- (SDataRequest *)registerDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters callBack:(SDataRequestCallBackBlock)callBack
{
    SDataRequest *dataRequest = [self registerDataRequestByName:name parameters:parameters];
    SDataRequestCallBackBlock callBackBlock = [callBack copy];
    [self.dataRequestCallBackBlockMap setObject:callBackBlock forKey:[NSString stringWithFormat:@"%ld",dataRequest.dataRequestID]];
    return dataRequest;
}

- (SDataRequest *)registerDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters
{
    Class dataRequestClass = NSClassFromString(name);
    SDataRequest *dataRequest = [[dataRequestClass alloc] init];
    dataRequest.businessParameters = parameters;
    dataRequest.delegate = self;
    dataRequest.dataRequestID = self.dataRequestCount++; // 写法不严谨，但是能满足99%的APP吧……
    [self.dataRequestMap setObject:dataRequest forKey:[NSString stringWithFormat:@"%ld",dataRequest.dataRequestID]];
    return dataRequest;
}
+ (void)removeDataRequest:(SDataRequest *)dataRequest
{
    NSString *dataRequestID = [NSString stringWithFormat:@"%ld",dataRequest.dataRequestID];
    [[SDataRequestManager sharedManager].dataRequestMap removeObjectForKey:dataRequestID];
    [[SDataRequestManager sharedManager].dataRequestCallBackItemMap removeObjectForKey:dataRequestID];
    [[SDataRequestManager sharedManager].dataRequestCallBackBlockMap removeObjectForKey:dataRequestID];
}

- (void)didEndDataRequest:(SDataRequest *)dataRequest
{
    NSString *dataRequestID = [NSString stringWithFormat:@"%ld",dataRequest.dataRequestID];
    SDataRequestCallBackBlock callBackBlock = self.dataRequestCallBackBlockMap[dataRequestID];
    if (callBackBlock) {
        callBackBlock(dataRequest);
        [self.dataRequestCallBackBlockMap removeObjectForKey:dataRequestID];
        [self.dataRequestMap removeObjectForKey:dataRequestID];
        return;
    }
    SDataRequestCallBackItem *callBackItem = self.dataRequestCallBackItemMap[dataRequestID];
    if ([callBackItem.callBackTarget respondsToSelector:callBackItem.callBackAction]) {
        SMsgSend(SMsgTarget(callBackItem.callBackTarget),
                 callBackItem.callBackAction,
                 dataRequest);
        [self.dataRequestCallBackItemMap removeObjectForKey:dataRequestID];
        [self.dataRequestMap removeObjectForKey:dataRequestID];
    }
}

- (NSArray *)allDataRequests
{
    return self.dataRequestMap.allValues;
}
- (NSMutableDictionary *)dataRequestMap
{
    if (!_dataRequestMap) {
        _dataRequestMap = [NSMutableDictionary new];
    }
    return _dataRequestMap;
}
- (NSMutableDictionary *)dataRequestCallBackItemMap
{
    if (!_dataRequestCallBackItemMap) {
        _dataRequestCallBackItemMap = [NSMutableDictionary new];
    }
    return _dataRequestCallBackItemMap;
}
- (NSMutableDictionary *)dataRequestCallBackBlockMap
{
    if (!_dataRequestCallBackBlockMap) {
        _dataRequestCallBackBlockMap = [NSMutableDictionary new];
    }
    return _dataRequestCallBackBlockMap;
}
@end
