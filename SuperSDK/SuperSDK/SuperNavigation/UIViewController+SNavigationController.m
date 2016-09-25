//
//  UIViewController+SNavigationController.m
//  SuperSDK
//
//  Created by 刘超 on 16/7/5.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "UIViewController+SNavigationController.h"
#import <objc/runtime.h>
static NSString *s_parameters_key = @"s_parameters_key";
@implementation UIViewController (SNavigationController)
@dynamic s_parameters;
// 每次取值都会清空这个对象，请自己保存在自己的业务类里面
- (NSDictionary *)s_parameters
{
    NSDictionary* object = objc_getAssociatedObject(self, &s_parameters_key);
    objc_setAssociatedObject(self, &s_parameters_key, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return object;
}
- (void)setS_parameters:(NSDictionary *)s_parameters
{
    objc_setAssociatedObject(self, &s_parameters_key, s_parameters, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
