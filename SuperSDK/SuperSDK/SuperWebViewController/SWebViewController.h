//
//  SWebViewController.h
//  SuperSDK
//
//  Created by 刘超 on 16/6/29.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWebViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic,   copy) NSString *URLString;
- (void)loadRequest;
- (void)refresh;
@end
