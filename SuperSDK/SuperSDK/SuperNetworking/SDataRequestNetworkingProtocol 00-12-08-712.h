//
//  SDataRequestNetworkingProtocol.h
//  SuperSDK
//
//  Created by 刘超 on 16/9/27.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SDataRequestNetworkingProtocol <NSObject>
@required
@property (nonatomic, assign) n *label;

@end
@protocol SDataRequestDelegate <NSObject>
@property (nonatomic, strong) UILabel *label;
- (void)didEndDataRequest:(SDataRequest *)dataRequest;

@end
