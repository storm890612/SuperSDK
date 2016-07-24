//
//  SRequest.h
//  SuperSDK
//
//  Created by 刘超 on 16/7/11.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, SRequestState) {
    SRequestStateWaiting,
    SRequestStateCommunicating,
    SRequestStateCancel,
    SRequestStateSuccessful,
    SRequestStateFailure
};

@interface SRequest : NSObject
@property (nonatomic, assign) SRequestState state;              // 请求的状态
@property (nonatomic, strong) NSDictionary *baseParameters;     // 所有请求的基础参数
@property (nonatomic, strong) NSDictionary *parameters;         // 某个业务请求的具体参数
@property (nonatomic, strong) id responseObject;                // 请求返回的对象
@property (nonatomic, strong) id cachedURLResponseObject;       // 请求返回的对象，的缓存

- (void)start;
- (void)cancel;
@end
