//
//  SDataRequestParser.h
//  SuperSDK
//
//  Created by 刘超 on 16/8/2.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SDataRequestParser : NSObject
// 如果设置了前缀或者后缀，会自己给名字添加前缀和后缀
@property (nonatomic,   copy) NSString *prefix;
@property (nonatomic,   copy) NSString *suffix;

+ (instancetype)sharedDataRequestParser;
+ (void)setPrefix:(NSString *)prefix suffix:(NSString *)suffix;
// 会自动添加前缀和后缀
+ (NSString *)addPrefixAndSuffixByDataRequestName:(NSString *)dataRequestName;
@end
