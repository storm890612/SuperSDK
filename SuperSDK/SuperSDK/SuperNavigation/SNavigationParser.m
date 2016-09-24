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
    *pageName = name;
    *pageParameters = parameters;
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
+ (NSString *)replacePageName:(NSString *)pageName {
    // 取一个字典，然后查找替换，具体去哪取，看业务需求
    NSDictionary *pageNameDictionary = @{@"homePage":@"SHomeViewController"};
    NSString *newPageName = pageNameDictionary[pageName];
    return newPageName.length > 0 ? newPageName : pageName;
}
@end
