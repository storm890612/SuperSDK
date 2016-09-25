//
//  STwoViewController.m
//  SuperSDK
//
//  Created by 刘超 on 16/9/25.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "STwoViewController.h"

@interface STwoViewController ()
@property (nonatomic, strong) UIButton *buttonOne;
@property (nonatomic, strong) UIButton *buttonTwo;

@end

@implementation STwoViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.s_parameters[@"title"];
    [self.view addSubview:self.buttonOne];
    [self.view addSubview:self.buttonTwo];

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat buttonWidth = 100;
    CGFloat buttonHeight = 50;
    self.buttonOne.frame = CGRectMake((self.view.frame.size.width - buttonWidth) / 2.0, 100, buttonWidth, buttonHeight);
    
    self.buttonOne.frame = CGRectMake(CGRectGetMinX(self.buttonOne.frame), CGRectGetMaxY(self.buttonOne.frame) + 30, buttonWidth, buttonHeight);
}

- (void)getDataOne
{
    [SDataRequestManager sendDataRequestByName:@"demo" parameters:@{@"":@""} callBack:^(SDataRequest *dataRequest) {
        
    }];
}

- (void)getDataTwo
{
    [self s_registerDataRequestByName:@"" parameters:@{} target:self action:@selector(dataOne:)];
}

- (void)dataOne:(SDataRequest *)dataRequest
{
    
}

- (void)dataTwo:(SDataRequest *)dataRequest
{
    
}

- (UIButton *)buttonOne
{
    if (!_buttonOne) {
        _buttonOne = [UIButton new];
        [_buttonOne setTitle:@"getDataOne" forState:UIControlStateNormal];
        [_buttonOne addTarget:self action:@selector(getDataOne) forControlEvents:UIControlEventTouchUpInside];
        [_buttonOne setBackgroundColor:[UIColor redColor]];
    }
    return _buttonOne;
}


@end
