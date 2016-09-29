//
//  SDataTwoDataRequest.m
//  SuperSDK
//
//  Created by 刘超 on 16/9/26.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SDataTwoDataRequest.h"

@implementation SDataTwoDataRequest
- (void)loadData
{
    sleep(2);

    [self submitData:@{@"dataTwo":self.parameters[@"name"]}];
}
@end
