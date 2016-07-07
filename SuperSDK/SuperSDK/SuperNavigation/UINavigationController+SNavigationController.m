//
//  NavigationController+SMNavigationController.m
//  SuperSDK
//
//  Created by 刘超 on 16/6/29.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "UINavigationController+SNavigationController.h"
#import "SNavigationParser.h"
#import "SWebViewController.h"
static NSString *s_param_key = @"s_param";
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
    NSString *vcName;
    NSDictionary *vcParam;

    UIViewController *vc;
    if ([pageName isURL]) {
        SWebViewController *webVC = [SWebViewController new];
        webVC.URLString = pageName;
        vc = webVC;
    } else {
        [pageName getPageName:&vcName pageParam:&vcParam];
        if (vcName.length == 0) {
            vcName = [pageName addPrefixAndSuffix];
        }
        vc = (UIViewController *)NSClassFromString(vcName);
    }
    
    if (!vc) {
        return;
    }
    if (vcParam) {
        [vc setValue:vcParam forKey:s_param_key];
    } else {
        [vc setValue:param forKey:s_param_key];
    }
    [self pushViewController:vc animated:animated];
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
    NSArray *viewControllers = self.viewControllers;
    if (viewControllers.count > 1) {
        UIViewController *vc = viewControllers[viewControllers.count - 2];
        [vc setValue:param forKey:s_param_key];
        [self popToViewController:vc animated:animated];
    }
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
    NSArray *viewControllers = self.viewControllers;
    UIViewController *vc = [viewControllers firstObject];
    [vc setValue:param forKey:s_param_key];
    [self popToViewController:vc animated:animated];
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
    NSArray *viewControllers = self.viewControllers;
    UIViewController *vc;
    NSString *vcName;
    NSDictionary *vcParam;
    [pageName getPageName:&vcName pageParam:&vcParam];
    if (vcName.length == 0) {
        vcName = [pageName addPrefixAndSuffix];
    }

    for (NSInteger i = viewControllers.count - 1; i > 0; i--) {
        vc = [viewControllers objectAtIndex:i];
        if ([vcName isEqualToString:NSStringFromClass([vc class])]) {
            break;
        }
    }
    [vc setValue:param forKey:s_param_key];
    [self popToViewController:vc animated:animated];

}
#pragma mark-----backPageToIndex

- (void)backPageToIndex:(NSInteger)index
{
    [self backPageToIndex:index param:nil animated:YES];
}
- (void)backPageToIndex:(NSInteger)index animated:(BOOL)animated
{
    [self backPageToIndex:index param:nil animated:animated];
}
- (void)backPageToIndex:(NSInteger)index param:(NSDictionary *)param
{
    [self backPageToIndex:index param:param animated:YES];
}
- (void)backPageToIndex:(NSInteger)index param:(NSDictionary *)param animated:(BOOL)animated
{
    NSArray *viewControllers = self.viewControllers;
    if (viewControllers.count <= index) {
        return;
    }
    UIViewController *vc = viewControllers[index];
    [vc setValue:param forKey:s_param_key];
    [self popToViewController:vc animated:animated];
}
@end
