//
//  SDataOneDataRequest.m
//  SuperSDK
//
//  Created by 刘超 on 16/9/26.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SDataOneDataRequest.h"
#import "SHTTPSessionManager.h"
@implementation SDataOneDataRequest

- (void)loadData
{
    self.HTTPSessionManager.session.configuration.timeoutIntervalForRequest = 10;
    self.HTTPSessionManager.session.
    [self.HTTPSessionManager GET:@"http://httpbin.org/get" parameters:self.parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}
@end
