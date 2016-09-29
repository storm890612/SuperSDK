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
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    self.buttonTwo.frame = CGRectMake(CGRectGetMinX(self.buttonOne.frame), CGRectGetMaxY(self.buttonOne.frame) + 30, buttonWidth, buttonHeight);
}

- (void)getDataOne
{
    [SDataRequestManager sendDataRequestByName:@"SDataOneDataRequest" parameters:nil callBack:^(SDataRequest *dataRequest) {
        NSLog(@"dataOneBlock = %@",dataRequest.responseData);
    }];
}

- (void)getDataTwo
{
    SDataRequest *dataRequestOne = [self s_registerDataRequestByName:@"SDataOneDataRequest" parameters:nil target:self action:@selector(dataOne:)];
    SDataRequest *dataRequestTwo = [self s_registerDataRequestByName:@"SDataTwoDataRequest" parameters:@{@"name":@"getDataTwo"} target:self action:@selector(dataTwo:)];
    [dataRequestOne addDependency:dataRequestTwo];
    [dataRequestOne start];
}

- (void)dataOne:(SDataRequest *)dataRequest
{
    NSLog(@"dataOne = %@",dataRequest.responseData);
}

- (void)dataTwo:(SDataRequest *)dataRequest
{
    NSLog(@"dataTwo = %@",dataRequest.responseData);
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

- (UIButton *)buttonTwo
{
    if (!_buttonTwo) {
        _buttonTwo = [UIButton new];
        [_buttonTwo setTitle:@"getDataTwo" forState:UIControlStateNormal];
        [_buttonTwo addTarget:self action:@selector(getDataTwo) forControlEvents:UIControlEventTouchUpInside];
        [_buttonTwo setBackgroundColor:[UIColor redColor]];
    }
    return _buttonTwo;
}

@end
