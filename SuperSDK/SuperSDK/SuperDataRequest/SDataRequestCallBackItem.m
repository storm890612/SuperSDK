//
//  SDataRequestCallBackItem.m
//  SuperSDK
//
//  Created by 刘超 on 16/8/3.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SDataRequestCallBackItem.h"

@implementation SDataRequestCallBackItem
+ (instancetype)dataRequestCallBackItemWithTarget:(id)target action:(SEL)action {
    SDataRequestCallBackItem *callBackItem = [SDataRequestCallBackItem new];
    callBackItem.callBackTarget = target;
    callBackItem.callBackAction = action;
    return callBackItem;
}
@end
