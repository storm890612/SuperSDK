//
//  SRequest.m
//  SuperSDK
//
//  Created by 刘超 on 16/7/11.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SDataRequest.h"
@interface SDataRequest ()

@property (nonatomic, readwrite, assign) SDataRequestState state;                // 请求的状态
@property (nonatomic, strong) NSMutableArray *dependencyDataRequests;

@end

@implementation SDataRequest

- (NSDictionary *)parameters
{
    NSMutableDictionary *mutableParameters = [NSMutableDictionary new];
    if (self.baseParameters) {
        [mutableParameters addEntriesFromDictionary:self.baseParameters];
    }
    if (self.businessParameters) {
        [mutableParameters addEntriesFromDictionary:self.businessParameters];
    }
    return [mutableParameters copy];
}

- (void)submitData:(id)data
{
    @synchronized (self) {
        if (self.state == SDataRequestStateExecuting) {
            self.responseData = [self decryptionData:data];
            self.state = SDataRequestStateFinished;
        }
    }
}

- (id)encryptionData:(id)data
{
    return data;
}

- (id)decryptionData:(id)data
{
    return data;
}

- (void)start
{
    [self willStartDataRequest];
    self.state = SDataRequestStateExecuting;
    [self loadData];
}

- (void)cancel
{
    // 子类需要重写此方法
    self.state = SDataRequestStateCancel;
}

- (void)loadData
{
    // 子类需要重写此方法加载数据
}

- (void)willStartDataRequest
{
    // 子类需要重写此方法
}

- (void)didEndDataRequest
{
    // 子类需要重写此方法
}

- (void)addDependency:(SDataRequest *)dataRequest
{
    [self.dependencyDataRequests addObject:dataRequest];
}

- (void)removeDependency:(SDataRequest *)dataRequest
{
    [self.dependencyDataRequests removeObject:dataRequest];
}

- (void)beginDependencyDataRequest
{
    for (SDataRequest *dataRequest in self.dependencyDataRequests) {
        [dataRequest start];
    }
    [self.dependencyDataRequests removeAllObjects];
}

- (void)setState:(SDataRequestState)state
{
    // 只能进行一次结束状态赋值 如果已经 结束、取消 其中任何一种情况就不能再次赋值了
    @synchronized (self) {
        // 只能回调一次didEndDataRequest
        if (state > 1 && _state <= 1) {
            _state = state;
            [self didEndDataRequest];
            [self.delegate didEndDataRequest:self];
            [self beginDependencyDataRequest];
        } else if (state <= 1) {
            _state = state;
        }
    }
}
- (NSMutableArray *)dependencyDataRequests
{
    if (!_dependencyDataRequests) {
        _dependencyDataRequests = [NSMutableArray new];
    }
    return _dependencyDataRequests;
}
@end
