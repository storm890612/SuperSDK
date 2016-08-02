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
// 获取URLSchemes里面的pageName 和 Parameters
- (void)getPageName:(NSString **)pageName pageParameters:(NSDictionary **)pageParameters;
// 会自动添加前缀和后缀
@end
@interface SNavigationParser : NSObject
// 如果设置了前缀或者后缀，会自己给名字添加前缀和后缀
@property (nonatomic,   copy) NSString *prefix;
@property (nonatomic,   copy) NSString *suffix;

@property (nonatomic,   copy) NSString *URLSchemes;

+ (instancetype)sharedNavigationParser;
+ (void)setPrefix:(NSString *)prefix suffix:(NSString *)suffix URLSchemes:(NSString *)URLSchemes;
+ (NSString *)addPrefixAndSuffixByPageName:(NSString *)pageName;

@end
