//
//  SWebViewController.m
//  SuperSDK
//
//  Created by 刘超 on 16/6/29.
//  Copyright © 2016年 SuperMan. All rights reserved.
//
#import <JavaScriptCore/JavaScriptCore.h>
#import <objc/runtime.h>
#import "SWebViewController.h"
@interface SWebViewController ()
@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) UIBarButtonItem *closeItem;

@end

@implementation SWebViewController

#pragma mark - private
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

- (void)goBack
{
	[self.webView goBack];
}
- (void)refresh
{
	[self.webView reload];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self setBackButton];
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blueColor];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // hunwanjia://login
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@"://"];
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"hunwanjia"]) {
        
        return NO;
    }
    return YES;
}
#pragma mark - public

- (void)loadRequest
{
    if (self.URLString.length > 0) {
        // cookie
        /*
         NSMutableDictionary *properties = [[NSMutableDictionary alloc] init];
         [properties setValue:@"tokenValue" forKey:NSHTTPCookieValue];
         [properties setValue:@"tokenName" forKey:NSHTTPCookieName];
         [properties setValue:[NSURL URLWithString:self.URLString].host forKey:NSHTTPCookieDomain];
         [properties setValue:[NSDate dateWithTimeIntervalSinceNow:60*60*24*365] forKey:NSHTTPCookieExpires];
         [properties setValue:@"/" forKey:NSHTTPCookiePath];
         NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:properties];
         NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
         [cookieStorage setCookie:cookie];
         */
        
         NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.URLString]];
         [request addValue:@"tokenValue" forHTTPHeaderField:@"token"];
         [self.webView loadRequest:request];
    }
}

#pragma mark -
#pragma mark Constructor And Destructor

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBackButton];
    
    if (nil == self.webView) {
        self.webView = [[UIWebView alloc] init];
        self.webView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
        self.webView.multipleTouchEnabled = NO;
        self.webView.scalesPageToFit = YES;
        self.webView.delegate = self;
        self.webView.autoresizesSubviews = YES;
        [self.view addSubview:self.webView];
    }
	[self loadRequest];
}
- (void)setBackButton {
     if ([self.webView canGoBack]) {
         [self.navigationItem setLeftBarButtonItems:@[self.backItem, self.closeItem]];
     } else {
         [self.navigationItem setLeftBarButtonItems:@[self.backItem]];
     }
}
- (void)touchBack:(UIBarButtonItem *)item {
    if ([self.webView canGoBack]) {
        [self goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)touchClose:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.webView.frame = self.view.bounds;
}
- (void)dealloc {
    self.webView.delegate = nil;
    self.webView = nil;
}
- (UIBarButtonItem *)backItem {
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(touchBack:)];
    }
    return _backItem;
}
- (UIBarButtonItem *)closeItem {
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain  target:self action:@selector(touchClose:)];
    }
    return _closeItem;
}
@end
