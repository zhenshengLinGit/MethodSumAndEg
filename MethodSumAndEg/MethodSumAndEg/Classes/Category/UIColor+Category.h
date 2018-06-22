//
//  UIColor+Category.h
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/4.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

#pragma mark - ********************  other  ***********************
//从十六进制字符串获取颜色，color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
