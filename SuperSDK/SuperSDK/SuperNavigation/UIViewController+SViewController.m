//
//  UIViewController+SViewController.m
//  SuperSDK
//
//  Created by 刘超 on 16/7/5.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "UIViewController+SViewController.h"
#import <objc/runtime.h>
static NSString *s_paramKey;
@implementation UIViewController (SViewController)
@dynamic s_param;
// 每次取值都会清空这个对象，请自己保存在自己的业务类里面
- (NSDictionary *)s_param {
    NSDictionary* object = objc_getAssociatedObject(self, &s_paramKey);
    objc_setAssociatedObject(self, &s_paramKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return object;
}

- (void)setParam:(NSDictionary *)s_param {
    objc_setAssociatedObject(self, &s_paramKey, s_param, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
