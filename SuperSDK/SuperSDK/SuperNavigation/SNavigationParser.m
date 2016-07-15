//
//  SNavigationParser.m
//  SuperSDK
//
//  Created by 刘超 on 16/6/30.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import "SNavigationParser.h"
@implementation NSString (SNavigationParser)
- (BOOL)isURL {
    return [self hasPrefix:@"http"];
}
- (void)getPageName:(NSString **)pageName pageParameters:(NSDictionary **)pageParameters {
    NSString *name = nil;
    NSMutableDictionary *parameters = nil;
    
    if (![self hasPrefix:[SNavigationParser sharedNavigationParser].URLSchemes]) {
        return;
    }
    NSRange range1 = [self rangeOfString:@"://"];
    if (range1.length == 0) {
        return;
    }
    
    NSInteger location = range1.location + range1.length;
    NSRange range2 = [self rangeOfString:@"?"];
    if (range2.length == 0) { // 没有参数
        name = [self substringWithRange:NSMakeRange(location, self.length - location)];
    } else {
        name = [self substringWithRange:NSMakeRange(location, self.length - location - range2.location)];
        NSString *URLQuery = [self substringFromIndex:range2.location + range2.length];
        NSArray *URLParametersArray = [URLQuery componentsSeparatedByString:@"&"];
        parameters = [[NSMutableDictionary alloc] init];
        for (NSString *parametersString in URLParametersArray) {
            NSRange range = [parametersString rangeOfString:@"="];
            NSString *key = [parametersString substringToIndex:range.location];
            NSString *value = [parametersString substringFromIndex:range.location + 1]; // +1 是为了去掉 "="
            [parameters setObject:value forKey:key];
        }
    }
    [name addPrefixAndSuffix];
    *pageName = name;
    *pageParameters = parameters;
}
- (NSString *)addPrefixAndSuffix {
    NSString *name = self;
    if ([SNavigationParser sharedNavigationParser].prefix.length > 0 &&
        ![name hasPrefix:[SNavigationParser sharedNavigationParser].prefix]) {
        name = [[SNavigationParser sharedNavigationParser].prefix stringByAppendingString:name];
    }
    if ([SNavigationParser sharedNavigationParser].suffix.length > 0 &&
        ![name hasSuffix:[SNavigationParser sharedNavigationParser].suffix]) {
        name = [name stringByAppendingString:[SNavigationParser sharedNavigationParser].suffix];
    }
    return name;
}
@end
@implementation SNavigationParser
+ (instancetype)sharedNavigationParser {
    static SNavigationParser *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [SNavigationParser new];
    });
    return obj;
}

@end
