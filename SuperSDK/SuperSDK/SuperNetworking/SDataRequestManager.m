//
//  SNetworkingManager.m
//  SuperSDK
//
//  Created by 刘超 on 16/7/10.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SDataRequestManager.h"
#import "STools.h"
@implementation SDataRequestManager
+ (instancetype)sharedManager {
    static SDataRequestManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [self new];
    });
    
    return _sharedManager;
}
+ (SDataRequest *)sendRequestByName:(NSString *)name parameters:(NSDictionary *)parameters target:(id)target action:(SEL)action {
    
}
- (SDataRequest *)sendRequestByName:(NSString *)name parameters:(NSDictionary *)parameters target:(id)target action:(SEL)action {
    
}

@end
