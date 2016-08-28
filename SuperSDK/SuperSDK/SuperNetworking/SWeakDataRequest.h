//
//  SWeakDataRequest.h
//  SuperSDK
//
//  Created by 刘超 on 16/8/28.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SDataRequest;
@interface SWeakDataRequest : NSObject
@property (nonatomic, weak) SDataRequest *dataRequest;
+ (instancetype)weakDataRequest:(SDataRequest *)dataRequest;
@end
