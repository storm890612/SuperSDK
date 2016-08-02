//
//  SNetworkingManager.m
//  SuperSDK
//
//  Created by 刘超 on 16/7/10.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SDataRequestManager.h"
#import "STools.h"
#import "SDataRequestParser.h"
#import "SDataRequestCallBackItem.h"
@interface SDataRequestManager () <SDataRequestDelegate>
@property (nonatomic, assign) NSInteger dataRequestCount;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSMutableDictionary *dataRequestCallBackMap;
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

+ (SDataRequest *)sendDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters target:(id)target action:(SEL)action {
    return [[self sharedManager] sendDataRequestByName:name parameters:parameters target:target action:action];
}
- (SDataRequest *)sendDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters target:(id)target action:(SEL)action {
    SDataRequest *dataRequest = [self registerDataRequestByName:name parameters:parameters target:target action:action];
    [dataRequest start];
    return dataRequest;
}
+ (SDataRequest *)registerDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters target:(id)target action:(SEL)action {
    return [[self sharedManager] registerDataRequestByName:name parameters:parameters target:target action:action];
}
- (SDataRequest *)registerDataRequestByName:(NSString *)name parameters:(NSDictionary *)parameters target:(id)target action:(SEL)action {
    NSString *dataRequsetName = [SDataRequestParser addPrefixAndSuffixByDataRequestName:name];
    SDataRequest *dataRequest = (SDataRequest *)NSClassFromString(dataRequsetName);
    dataRequest.businessParameters = parameters;
    dataRequest.delegate = self;
    dataRequest.dataRequestID = self.dataRequestCount++;
    SDataRequestCallBackItem *callBackItem = [SDataRequestCallBackItem dataRequestCallBackItemWithTarget:target action:action];
    [self.dataRequestCallBackMap setObject:callBackItem forKey:[NSString stringWithFormat:@"%ld",dataRequest.dataRequestID]];
    return dataRequest;
}
- (void)didEndDataRequest:(SDataRequest *)dataRequest {
    NSString *dataRequestID = [NSString stringWithFormat:@"%ld",dataRequest.dataRequestID];
    SDataRequestCallBackItem *callBackItem = self.dataRequestCallBackMap[dataRequestID];
    SMsgSend(SMsgTarget(callBackItem.callBackTarget),
             callBackItem.callBackAction,
             dataRequest);
}
- (NSMutableDictionary *)dataRequestCallBackMap {
    if (!_dataRequestCallBackMap) {
        _dataRequestCallBackMap = [NSMutableDictionary new];
    }
    return _dataRequestCallBackMap;
}
@end
