//
//  NavigationController+SMNavigationController.h
//  SuperSDK
//
//  Created by 刘超 on 16/6/29.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController(SNavigationController)
- (void)gotoPage:(NSString *)pageName;
- (void)gotoPage:(NSString *)pageName param:(NSDictionary *)param;
- (void)gotoPage:(NSString *)pageName param:(NSDictionary *)param animated:(BOOL)animated;

- (void)backPage;
- (void)backPageWithAnimated:(BOOL)animated;
- (void)backPageWithParam:(NSDictionary *)param;
- (void)backPageWithParam:(NSDictionary *)param animated:(BOOL)animated;

- (void)backToRootPage;
- (void)backToRootPageWithAnimated:(BOOL)animated;
- (void)backToRootPageWithParam:(NSDictionary *)param;
- (void)backToRootPageWithWithParam:(NSDictionary *)param animated:(BOOL)animated;

- (void)backToPage:(NSString *)pageName;
- (void)backToPage:(NSString *)pageName animated:(BOOL)animated;
- (void)backToPage:(NSString *)pageName param:(NSDictionary *)param;
- (void)backToPage:(NSString *)pageName param:(NSDictionary *)param animated:(BOOL)animated;

- (void)backPageToIndex:(NSInteger)index;
- (void)backPageToIndex:(NSInteger)index animated:(BOOL)animated;
- (void)backPageToIndex:(NSInteger)index param:(NSDictionary *)param;
- (void)backPageToIndex:(NSInteger)index param:(NSDictionary *)param animated:(BOOL)animated;
@end
