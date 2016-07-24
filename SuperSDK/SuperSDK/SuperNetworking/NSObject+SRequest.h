//
//  NSObject+SRequest.h
//  SuperSDK
//
//  Created by 刘超 on 16/7/18.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRequest.h"
@interface NSObject (SRequest)
- (SRequest *)sendRequestByName:(NSString *)name parameters:(NSDictionary *)parameters action:(SEL)action;
- (void)cancelAllRequest;
@end
