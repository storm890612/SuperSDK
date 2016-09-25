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
static NSString *s_parameters_key = @"s_parameters";
@implementation UINavigationController (SNavigationController)


- (void)gotoPage:(NSString *)pageName
{
    [self gotoPage:pageName parameters:nil animated:YES];
}
- (void)gotoPage:(NSString *)pageName parameters:(NSDictionary *)parameters
{
    [self gotoPage:pageName parameters:parameters animated:YES];
}
- (void)gotoPage:(NSString *)pageName parameters:(NSDictionary *)parameters animated:(BOOL)animated
{
    NSString *vcName;
    NSDictionary *vcParameters;

    UIViewController *vc;
    if ([pageName isURL]) {
        SWebViewController *webVC = [SWebViewController new];
        webVC.URLString = pageName;
        vc = webVC;
    } else if ([SNavigationParser sharedNavigationParser].URLSchemes.length > 0 &&
               [pageName hasPrefix:[SNavigationParser sharedNavigationParser].URLSchemes]) {
        [pageName getPageName:&vcName pageParameters:&vcParameters];
        Class viewControllerClass = NSClassFromString(vcName);
        vc = [[viewControllerClass alloc] init];
    } else {
        Class viewControllerClass = NSClassFromString(pageName);
        vc = [[viewControllerClass alloc] init];
    }
    if (!vc) {
        return;
    }
    if (vcParameters) {
        [vc setValue:vcParameters forKey:s_parameters_key];
    } else {
        [vc setValue:parameters forKey:s_parameters_key];
    }
    [self pushViewController:vc animated:animated];
}
#pragma mark-----BackPage
- (void)backPage
{
    [self backPageWithParameters:nil animated:YES];
}
- (void)backPageWithAnimated:(BOOL)animated
{
    [self backPageWithParameters:nil animated:animated];
}
- (void)backPageWithParameters:(NSDictionary *)parameters
{
    [self backPageWithParameters:parameters animated:YES];
}
- (void)backPageWithParameters:(NSDictionary *)parameters animated:(BOOL)animated
{
    NSArray *viewControllers = self.viewControllers;
    if (viewControllers.count > 1) {
        UIViewController *vc = viewControllers[viewControllers.count - 2];
        [vc setValue:parameters forKey:s_parameters_key];
        [self popToViewController:vc animated:animated];
    }
}
#pragma mark-----backToRootPage

- (void)backToRootPage
{
    [self backToRootPageWithWithParameters:nil animated:YES];
}
- (void)backToRootPageWithAnimated:(BOOL)animated
{
    [self backToRootPageWithWithParameters:nil animated:animated];
}
- (void)backToRootPageWithParameters:(NSDictionary *)parameters
{
    [self backToRootPageWithWithParameters:parameters animated:YES];
}
- (void)backToRootPageWithWithParameters:(NSDictionary *)parameters animated:(BOOL)animated
{
    NSArray *viewControllers = self.viewControllers;
    UIViewController *vc = [viewControllers firstObject];
    [vc setValue:parameters forKey:s_parameters_key];
    [self popToViewController:vc animated:animated];
}
#pragma mark-----backToPage

- (void)backToPage:(NSString *)pageName
{
    [self backToPage:pageName parameters:nil animated:YES];
}
- (void)backToPage:(NSString *)pageName animated:(BOOL)animated
{
    [self backToPage:pageName parameters:nil animated:animated];
}
- (void)backToPage:(NSString *)pageName parameters:(NSDictionary *)parameters
{
    [self backToPage:pageName parameters:parameters animated:YES];
}
- (void)backToPage:(NSString *)pageName parameters:(NSDictionary *)parameters animated:(BOOL)animated
{
    NSArray *viewControllers = self.viewControllers;
    UIViewController *vc;
    NSString *vcName;
    NSDictionary *vcParameters;
    [pageName getPageName:&vcName pageParameters:&vcParameters];
    if (vcName.length == 0) {
        vcName = pageName;
    }
    for (NSInteger i = viewControllers.count - 1; i > 0; i--) {
        vc = [viewControllers objectAtIndex:i];
        if ([vcName isEqualToString:NSStringFromClass([vc class])]) {
            break;
        }
    }
    [vc setValue:parameters forKey:s_parameters_key];
    [self popToViewController:vc animated:animated];
}
#pragma mark-----backPageToIndex

- (void)backPageToIndex:(NSInteger)index
{
    [self backPageToIndex:index parameters:nil animated:YES];
}
- (void)backPageToIndex:(NSInteger)index animated:(BOOL)animated
{
    [self backPageToIndex:index parameters:nil animated:animated];
}
- (void)backPageToIndex:(NSInteger)index parameters:(NSDictionary *)parameters
{
    [self backPageToIndex:index parameters:parameters animated:YES];
}
- (void)backPageToIndex:(NSInteger)index parameters:(NSDictionary *)parameters animated:(BOOL)animated
{
    NSArray *viewControllers = self.viewControllers;
    if (viewControllers.count <= index) {
        return;
    }
    UIViewController *vc = viewControllers[index];
    [vc setValue:parameters forKey:s_parameters_key];
    [self popToViewController:vc animated:animated];
}
@end
