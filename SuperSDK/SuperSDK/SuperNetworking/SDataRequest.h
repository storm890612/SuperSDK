//
//  SRequest.h
//  SuperSDK
//
//  Created by 刘超 on 16/7/11.
//  Copyright © 2016年 SuperMan. All rights reserved.
//
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, SDataRequestState) {
    SDataRequestStateWaiting        = 0,
    SDataRequestStateExecuting      = 1,
    SDataRequestStateCancel         = 2,
    SDataRequestStateFinished       = 3
};

/*
 SDataRequest不关心你是如何得到数据，网络请求也好，本地数据库也好，拿到数据就好了。
 加载完成数据之后要把数据提交
 */
@class SDataRequest;
@protocol SDataRequestDelegate <NSObject>
@required
- (void)didEndDataRequest:(SDataRequest *)dataRequest;
@end

@interface SDataRequest : NSObject
@property (nonatomic, assign) NSInteger dataRequestID;                          // 请求id
@property (nonatomic,   weak) id <SDataRequestDelegate> delegate;
@property (nonatomic,   copy) NSDictionary *baseParameters;                     // 所有请求的基础参数
@property (nonatomic,   copy) NSDictionary *businessParameters;                 // 某个业务请求的具体参数
@property (nonatomic, readonly,   copy) NSDictionary *parameters;               // 请求的全部参数
@property (nonatomic, readonly, assign) SDataRequestState state;                // 请求的状态
@property (nonatomic, strong) id responseData;                        // 请求返回的对象
@property (nonatomic, strong) NSError *error;                         // 请求错误对象

// 获取基础参数 需要子类重写
- (NSDictionary *)baseParameters;
// 请求的全部参数 默认自动组合 baseParameters 和 businessParameters
- (NSDictionary *)parameters;
// 拿到数据以后提交数据 会自动走注册的回调
- (void)submitData:(id)data;
// 开始
- (void)start;
// 获得数据的方法 需要子类重写，拿到数据后，调用 submitData:
- (void)loadData;
// 取消数据请求，需要子类重写，比如取消网络请求，或者加载本地数据太多，加载完成之前用户退出了数据使用页面。
- (void)cancel;
// 将要开始数据请求，一般做参数组装与加密
- (void)willStartDataRequest;
// 已经结束数据请求，这个方法只会走一遍 取消 结束 超时 都会走这个方法
- (void)didEndDataRequest;

- (void)addDependency:(SDataRequest *)dataRequest;
- (void)removeDependency:(SDataRequest *)dataRequest;

@end
