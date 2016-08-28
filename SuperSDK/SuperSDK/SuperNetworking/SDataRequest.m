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
@property (nonatomic, readwrite, strong) id responseData;                        // 请求返回的对象
@property (nonatomic, readwrite,   copy) NSDictionary *parameters;               // 请求的全部参数
@property (nonatomic, strong) NSMutableArray *dependencyDataRequests;
@end
@implementation SDataRequest
- (void)submitData:(id)data {
    @synchronized (self) {
        if (self.state == SDataRequestStateExecuting) {
            self.responseData = data;
            self.state = SDataRequestStateFinished;
            for (SDataRequest *dataRequest in self.dependencyDataRequests) {
                [dataRequest start];
            }
        }
    }
}
- (void)start {
    [self willStartDataRequest];
    self.state = SDataRequestStateExecuting;
    [self loadData];
}
- (void)cancel {
    // 子类需要重写此方法
    self.state = SDataRequestStateCancel;
}
- (void)loadData {
    // 子类需要重写此方法加载数据
}
- (void)willStartDataRequest {
    // 子类需要重写此方法加载数据
}
- (void)didEndDataRequest {
    // 子类需要重写此方法加载数据
}

- (void)addDependency:(SDataRequest *)dataRequest {
    [self.dependencyDataRequests addObject:dataRequest];
}
- (void)removeDependency:(SDataRequest *)dataRequest {
    [self.dependencyDataRequests removeObject:dataRequest];
}

- (void)setState:(SDataRequestState)state {
    // 只能进行一次结束状态赋值 如果已经 结束、取消、超时 其中任何一种情况就不能再次赋值了
    @synchronized (self) {
        // 只能回调一次didEndDataRequest
        if (state > 1 && _state <= 1) {
            _state = state;
            [self didEndDataRequest];
            [self.delegate didEndDataRequest:self];
        } else if (state <= 1) {
            _state = state;
        }
    }

}
@end