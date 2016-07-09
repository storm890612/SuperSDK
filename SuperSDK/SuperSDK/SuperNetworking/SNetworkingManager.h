//
//  SNetworkingManager.h
//  SuperSDK
//
//  Created by 刘超 on 16/7/10.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNetworkingManager : NSObject
+ (void)requestByName:(NSString *)name param:(NSDictionary *)param target:(id)target successAction:(SEL)successAction failureAction:(SEL)failureAction;

@end
