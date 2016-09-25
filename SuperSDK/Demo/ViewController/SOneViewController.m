//
//  SOneViewController.m
//  SuperSDK
//
//  Created by 刘超 on 16/9/25.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SOneViewController.h"

@interface SOneViewController ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation SOneViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"pageOne";
    [self.view addSubview:self.button];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat buttonWidth = 100;
    self.button.frame = CGRectMake((self.view.frame.size.width - buttonWidth) / 2.0, 100, buttonWidth, 50);
}

- (void)gotoPageTwo
{
    [self.navigationController gotoPage:@"SUIViewControllerOne" parameters:@{@"title" : @"pageTwo"}];
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton new];
        [_button setTitle:@"gotoPageTwo" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(gotoPageTwo) forControlEvents:UIControlEventTouchUpInside];
        [_button setBackgroundColor:[UIColor redColor]];
    }
    return _button;
}


@end
