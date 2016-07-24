//
//  SNetworkingManager.h
//  SuperSDK
//
//  Created by 刘超 on 16/7/10.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRequest.h"

@interface SRequestManager : NSObject
+ (instancetype)sharedManager;
+ (SRequest *)sendRequestByName:(NSString *)name parameters:(NSDictionary *)parameters target:(id)target action:(SEL)action;

@end
