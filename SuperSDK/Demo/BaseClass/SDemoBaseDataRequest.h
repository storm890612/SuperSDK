//
//  SDemoBaseDataRequest.h
//  SuperSDK
//
//  Created by 刘超 on 16/9/26.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SDataRequest.h"
#import "SDataRequestNetworkingProtocol.h"
@interface SDemoBaseDataRequest : SDataRequest<SDataRequestNetworkingProtocol>
- (id)packageData:(NSDictionary *)data;
@end
