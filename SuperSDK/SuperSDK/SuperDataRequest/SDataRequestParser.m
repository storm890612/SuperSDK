//
//  SDataRequestParser.m
//  SuperSDK
//
//  Created by 刘超 on 16/8/2.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SDataRequestParser.h"
@implementation SDataRequestParser
+ (instancetype)sharedDataRequestParser {
    static SDataRequestParser *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [SDataRequestParser new];
    });
    return obj;
}
@end
