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
- (void)gotoPage:(NSString *)pageName parameters:(NSDictionary *)parameters;
- (void)gotoPage:(NSString *)pageName parameters:(NSDictionary *)parameters animated:(BOOL)animated;

- (void)backPage;
- (void)backPageWithAnimated:(BOOL)animated;
- (void)backPageWithParameters:(NSDictionary *)parameters;
- (void)backPageWithParameters:(NSDictionary *)parameters animated:(BOOL)animated;

- (void)backToRootPage;
- (void)backToRootPageWithAnimated:(BOOL)animated;
- (void)backToRootPageWithParameters:(NSDictionary *)parameters;
- (void)backToRootPageWithWithParameters:(NSDictionary *)parameters animated:(BOOL)animated;

- (void)backToPage:(NSString *)pageName;
- (void)backToPage:(NSString *)pageName animated:(BOOL)animated;
- (void)backToPage:(NSString *)pageName parameters:(NSDictionary *)parameters;
- (void)backToPage:(NSString *)pageName parameters:(NSDictionary *)parameters animated:(BOOL)animated;

- (void)backPageToIndex:(NSInteger)index;
- (void)backPageToIndex:(NSInteger)index animated:(BOOL)animated;
- (void)backPageToIndex:(NSInteger)index parameters:(NSDictionary *)parameters;
- (void)backPageToIndex:(NSInteger)index parameters:(NSDictionary *)parameters animated:(BOOL)animated;
@end
