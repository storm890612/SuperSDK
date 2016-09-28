//
//  SDemoBaseDataRequest.m
//  SuperSDK
//
//  Created by 刘超 on 16/9/26.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SDemoBaseDataRequest.h"

@implementation SDemoBaseDataRequest
- (void)willStartDataRequest
{
    // 加密参数
}
- (void)didEndDataRequest
{
    // 解密结果
    self.responseData = [NSDictionary new];
}

@end
