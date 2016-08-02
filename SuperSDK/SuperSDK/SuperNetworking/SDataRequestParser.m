//
//  SDataRequestParser.m
//  SuperSDK
//
//  Created by 刘超 on 16/8/2.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SDataRequestParser.h"
@implementation SDataRequestParser
+ (instancetype)sharedDataRequestParser {
    static SDataRequestParser *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [SDataRequestParser new];
    });
    return obj;
}
+ (void)setPrefix:(NSString *)prefix suffix:(NSString *)suffix{
    SDataRequestParser *parser = [self sharedDataRequestParser];
    parser.prefix = prefix;
    parser.suffix = suffix;
}
+ (NSString *)addPrefixAndSuffixByDataRequestName:(NSString *)dataRequestName {
    NSString *name = dataRequestName;
    if ([SDataRequestParser sharedDataRequestParser].prefix.length > 0 &&
        ![name hasPrefix:[SDataRequestParser sharedDataRequestParser].prefix]) {
        name = [[SDataRequestParser sharedDataRequestParser].prefix stringByAppendingString:name];
    }
    if ([SDataRequestParser sharedDataRequestParser].suffix.length > 0 &&
        ![name hasSuffix:[SDataRequestParser sharedDataRequestParser].suffix]) {
        name = [name stringByAppendingString:[SDataRequestParser sharedDataRequestParser].suffix];
    }
    return name;
}
@end
