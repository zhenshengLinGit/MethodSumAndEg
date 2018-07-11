//
//  NSString+Category.h
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/7/10.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

@end

#pragma mark - ********************  CommonTool  ***********************
@interface NSString (CommonTool)

/**
 去掉首尾的空格，并将换行符替换为空格，用于列表cell的显示
 */
- (NSString *)deleteBlankspaceAndNewline;

/**
 分离字符串
 
 @param separateStr  以什么字符串进行分离
 @param sepLenght    以多少长度为单位进行分离
 */
- (NSString *)separateWithStr:(NSString *)separateStr separateLen:(NSInteger)sepLenght;

/**
 字符串的MD5
 */
- (NSString *)MD5Hash;

/**
 根据内容获取字符串的size

 @param font 字体
 @param maxW 最长的宽度
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

@end

#pragma mark - ********************  HTML ***********************
@interface NSString (HTML)

/**
 移除html编码的特殊字符，返回纯文本
 */
-(NSString *)replaceHtmlSpecialChars;

/**
 去除尖括号标签内的所有内容
 */
-(NSString *)removeXMLTags;

@end

#pragma mark - ********************  FormatCheck ***********************
/** 字符组类型 */
typedef NS_ENUM(NSInteger, FormatCheckCharGroupType) {
    FormatCheckCharGroupTypeNone     =  0,
    FormatCheckCharGroupTypeAlphabet =  1 << 0,       //字母
    FormatCheckCharGroupTypeChinese  =  1 << 2,       //中文
    FormatCheckCharGroupTypeNumber   =  1 << 3,       //数字
    FormatCheckCharGroupTypeAll = FormatCheckCharGroupTypeAlphabet | FormatCheckCharGroupTypeChinese | FormatCheckCharGroupTypeNumber,
};

@interface NSString (FormatCheck)

/**
 是否不包含forbidString里的任何一个字符
 */
-(BOOL)notContainCharsAt:(NSString *)forbidString;

/**
 是否不包含forbidString里的任何一个字符，也不包含charGroup里的类型
 */
-(BOOL)notContainCharsAt:(NSString *)forbidString andCharGroup:(FormatCheckCharGroupType)charGroup;

/**
 只包含allowString和charGroup组里的字符
 */
-(BOOL)onlyContainCharsAt:(NSString *)allowString andCharGroup:(FormatCheckCharGroupType)charGroup;

/**
 是否匹配正则到结果
 */
-(BOOL)isMatchREgex:(NSString *)regex;

/**
 判断是否全是空格
 */
- (BOOL)isAllEmpty;

/**
 判断有效电话
 */
-(BOOL)validatePhone;

/**
 判断有效座机
 */
-(BOOL)validateLandline;

/**
 判断有效用户名
 以字母或者数字开头，只能包含"字母"、"数字"、"-"、"_"、"."字符，总字符数>=4
 */
-(BOOL)isLegalUserName;

/**
 判断有效用户名称：
 包含：汉字、英文、数字、 （空格)、%（英）、()（英）、[]（英）、~（英）、`（英）、&（英）、_（英）、
 -（英）、+（英）、%（中）、（）（中）、【】（中）、~（中）、·（中）、&（中）、-（中）、+
 （中）、《》（中）
 */
-(BOOL)isLegalNickName;

/**
 在isLegalNickName的基础上，不包含空格
 */
-(BOOL)isLegalNickNameExceptSpaces;

/**
 判断有效身份证号码
 */
-(BOOL)isLegalIdentityCardNo;

/**
 判断有效邮箱地址
 */
-(BOOL)isEmailAdress;

/**
 判断是否包含中文
 */
-(BOOL)containsChinese;

/**
 判断有效密码 - 长度>=8,<=20位，并且同时包含数字和字母
 */
-(BOOL)judgePassWordLegal;

/**
 判断是否是emoji表情
 */
-  (BOOL)stringContainsEmoji;

/**
 判断是否是纯数字
 */
-(BOOL)isPureNumber;

/**
 判断是否是纯字母

 @param catipalAndLower 0不区分大小写、1大写、2小写
 */
-(BOOL)isPureLetter:(NSInteger)catipalAndLower;

/**
 是否为合法的网站
 */
-(BOOL)isLegalWebsite;

@end
