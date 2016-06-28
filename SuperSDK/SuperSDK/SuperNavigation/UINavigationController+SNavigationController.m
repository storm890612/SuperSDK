//
//  NavigationController+SMNavigationController.m
//  SuperSDK
//
//  Created by 刘超 on 16/6/29.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "UINavigationController+SNavigationController.h"


@implementation UINavigationController (SNavigationController)


- (void)gotoPage:(NSString *)pageName
{
    [self gotoPage:pageName param:nil animated:YES];
}
- (void)gotoPage:(NSString *)pageName param:(NSDictionary *)param
{
    [self gotoPage:pageName param:param animated:YES];
}
- (void)gotoPage:(NSString *)pageName param:(NSDictionary *)param animated:(BOOL)animated
{
//    UIViewController *vc = [[SDKAppConfig shareAppConfig] viewControllerWithName:pageName param:param];
//    if (!vc) {
//        return;
//    }
//    vc.switchType = PageSwitchPush;
//    if (self.afterPushHideTabbar) {
//        if ([self.visibleViewController isEqual:[self.viewControllers firstObject]]) {
//            self.visibleViewController.hidesBottomBarWhenPushed = YES;
//        }
//    }
//    [self pushViewController:vc animated:animated];
//    self.navigationBarHidden = vc.isHideNavigationBar;
}
#pragma mark-----BackPage
- (void)backPage
{
    [self backPageWithParam:nil animated:YES];
}
- (void)backPageWithAnimated:(BOOL)animated
{
    [self backPageWithParam:nil animated:animated];
}
- (void)backPageWithParam:(NSDictionary *)param
{
    [self backPageWithParam:param animated:YES];
}
- (void)backPageWithParam:(NSDictionary *)param animated:(BOOL)animated
{
//    NSArray *viewControllers = self.viewControllers;
//    if (viewControllers.count > 1) {
//        SDKViewController *vc = viewControllers[viewControllers.count - 2];
//        vc.switchType = PageSwitchPop;
//        [vc setValue:param forKey:popParam];
//        if (self.afterPushHideTabbar) {
//            if ([vc isEqual:[viewControllers firstObject]]) {
//                vc.hidesBottomBarWhenPushed = NO;
//            }
//        }
//        if ([self popToViewController:vc animated:animated]) {
//            self.navigationBarHidden = vc.isHideNavigationBar;
//        }
//    }
}
#pragma mark-----backToRootPage

- (void)backToRootPage
{
    [self backToRootPageWithWithParam:nil animated:YES];
}
- (void)backToRootPageWithAnimated:(BOOL)animated
{
    [self backToRootPageWithWithParam:nil animated:animated];
}
- (void)backToRootPageWithParam:(NSDictionary *)param
{
    [self backToRootPageWithWithParam:param animated:YES];
}
- (void)backToRootPageWithWithParam:(NSDictionary *)param animated:(BOOL)animated
{
//    NSArray *viewControllers = self.viewControllers;
//    SDKViewController *vc = [viewControllers firstObject];
//    vc.switchType = PageSwitchPop;
//    [vc setValue:param forKey:popParam];
//    if (self.afterPushHideTabbar) {
//        vc.hidesBottomBarWhenPushed = NO;
//    }
//    if ([self popToViewController:vc animated:animated]) {
//        self.navigationBarHidden = vc.isHideNavigationBar;
//    }
}
#pragma mark-----backToPage

- (void)backToPage:(NSString *)pageName
{
    [self backToPage:pageName param:nil animated:YES];
}
- (void)backToPage:(NSString *)pageName animated:(BOOL)animated
{
    [self backToPage:pageName param:nil animated:animated];
}
- (void)backToPage:(NSString *)pageName param:(NSDictionary *)param
{
    [self backToPage:pageName param:param animated:YES];
}
- (void)backToPage:(NSString *)pageName param:(NSDictionary *)param animated:(BOOL)animated
{
//    NSArray *viewControllers = self.viewControllers;
//    SDKViewController *vc;
//    for (NSInteger i = viewControllers.count - 1; i > 0; i--) {
//        vc = [viewControllers objectAtIndex:i];
//        if ([pageName isEqualToString:vc.pageName]) {
//            break;
//        }
//    }
//    vc.switchType = PageSwitchPop;
//    [vc setValue:param forKey:popParam];
//    if (self.afterPushHideTabbar) {
//        if ([vc isEqual:[viewControllers firstObject]]) {
//            vc.hidesBottomBarWhenPushed = NO;
//        }
//    }
//    if ([self popToViewController:vc animated:animated]) {
//        self.navigationBarHidden = vc.isHideNavigationBar;
//    }
}

@end
