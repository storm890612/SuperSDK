//
//  SDataRequestCallBackItem.h
//  SuperSDK
//
//  Created by 刘超 on 16/8/3.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDataRequestCallBackItem : NSObject
@property (nonatomic, strong) id    callBackTarget;
@property (nonatomic, assign) SEL   callBackAction;
+ (instancetype)dataRequestCallBackItemWithTarget:(id)target action:(SEL)action;
@end
