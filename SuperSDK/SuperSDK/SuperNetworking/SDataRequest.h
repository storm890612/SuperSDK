//
//  SRequest.h
//  SuperSDK
//
//  Created by 刘超 on 16/7/11.
//  Copyright © 2016年 SuperMan. All rights reserved.
//
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, SDataRequestState) {
    SDataRequestStateWaiting,
    SDataRequestStateCommunicating,
    SDataRequestStateCancel,
    SDataRequestStateSuccessful,
    SDataRequestStateFailure
};
@protocol SDataRequestProtocol <NSObject>
@required

/*
 加载数据，SDataRequest不关心你是如何得到数据，网络请求也好，本地数据库也好，拿到数据就好了。
 加载完成数据之后要把
 */
- (void)loadData;
- (void)cancel;

@optional

- (void)willStartRequest;
- (void)didEndRequest;

@end
@interface SDataRequest : NSObject<SDataRequestProtocol>
@property (nonatomic, readonly, assign) SDataRequestState state;                      // 请求的状态
@property (nonatomic, strong) NSDictionary *baseParameters;             // 所有请求的基础参数
@property (nonatomic, strong) NSDictionary *businessParameters;         // 某个业务请求的具体参数
@property (nonatomic, readonly, strong) id responseData;                          // 请求返回的对象
//@property (nonatomic, strong) id cachedURLResponseObject;               // 请求返回的对象，的缓存

- (void)start;



@end
