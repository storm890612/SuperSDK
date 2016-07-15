//
//  STools.h
//  SuperSDK
//
//  Created by 刘超 on 16/6/29.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>

// 运行时objc_msgSend
#define SMsgSend(...) ((void (*)(void *, SEL, id ))objc_msgSend)(__VA_ARGS__)
#define SMsgTarget(target) (__bridge void *)(target)
@interface STools : NSObject
+ (void)addUserAgentWithName:(NSString *)name;

@end
