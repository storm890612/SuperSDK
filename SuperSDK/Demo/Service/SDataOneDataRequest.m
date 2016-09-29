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
- (NSString *)requestMethod
{
    return @"GET";
}

- (NSString *)URLString
{
    return @"http://www.baidu.com";
}
- (void)loadData
{
//    NSError *serializationError;
//    NSURLRequest *request = [self.HTTPSessionManager.requestSerializer requestWithMethod:@"GET" URLString:@"http://httpbin.org/get" parameters:self.parameters error:&serializationError];
//    
//    __block NSURLSessionDataTask *dataTask = nil;
//    dataTask = [self.HTTPSessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
//        if (error) {
//            
//        } else {
//        }
//    }];
//
    [self.HTTPSessionManager GET:@"http://httpbin.org/get" parameters:self.parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
    [self.dataTask resume];
//    [self submitData:@{@"dataOne":self.parameters[@"name"]}];

}
@end
