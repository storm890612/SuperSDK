//
//  SNavigationParser.h
//  SuperSDK
//
//  Created by 刘超 on 16/6/30.
//  Copyright © 2016年 SuperMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (SNavigationParser)
- (BOOL)isURL;
// 获取URLSchemes里面的pageName 和 param
- (void)getPageName:(NSString **)pageName pageParam:(NSDictionary **)pageParam;
// 会自动添加前缀和后缀
- (NSString *)addPrefixAndSuffix;
@end
@interface SNavigationParser : NSObject
// 如果设置了前缀或者后缀，会自己给名字添加前缀和后缀
@property (nonatomic,   copy) NSString *prefix;
@property (nonatomic,   copy) NSString *suffix;

@property (nonatomic,   copy) NSString *URLSchemes;


+ (instancetype)sharedNavigationParser;

@end
