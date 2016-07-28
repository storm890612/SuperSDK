//
//  SRequest.m
//  SuperSDK
//
//  Created by 刘超 on 16/7/11.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SDataRequest.h"
@interface SDataRequest ()

@end
@implementation SDataRequest
- (void)start {
    [self willStartRequest];
    self.state = SDataRequestStateCommunicating;
    [self loadData];
}
- (void)cancel {
    
}
- (void)loadData {
    // 子类需要重写此方法加载数据
}

- (void)setState:(SDataRequestState)state {
    _state = state;
    if (_state == SDataRequestStateCancel ||
        _state == SDataRequestStateSuccessful ||
        _state == SDataRequestStateFailure) {
        [self didEndRequest];
    }
}
@end
