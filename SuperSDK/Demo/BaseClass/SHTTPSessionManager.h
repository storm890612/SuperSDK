//
//  SHTTPSessionManager.h
//  SuperSDK
//
//  Created by 刘超 on 16/9/27.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface SHTTPSessionManager : AFHTTPSessionManager
+ (instancetype)sharedManager;
@end
