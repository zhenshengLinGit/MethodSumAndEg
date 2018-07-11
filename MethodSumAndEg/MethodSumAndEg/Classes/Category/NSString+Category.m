//
//  NSString+Category.m
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/7/10.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Category)

@end

#pragma mark - ********************  CommonTool  ***********************
@implementation NSString (CommonTool)

/**
 去掉首尾的空格，并将换行符替换为空格，用于列表cell的显示
 */
- (NSString *)deleteBlankspaceAndNewline {
    
    // 去除首尾的空格和换行
    NSString *deleteStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // 用空格替换换行符
    NSString *replaceStr = @" ";
    deleteStr = [deleteStr stringByReplacingOccurrencesOfString:@"\r" withString:replaceStr];
    deleteStr = [deleteStr stringByReplacingOccurrencesOfString:@"\r\n" withString:replaceStr];
    deleteStr = [deleteStr stringByReplacingOccurrencesOfString:@"\n" withString:replaceStr];
    return deleteStr;
}

/**
 分离字符串
 
 @param separateStr  以什么字符串进行分离
 @param sepLenght    以多少长度为单位进行分离
 */
- (NSString *)separateWithStr:(NSString *)separateStr separateLen:(NSInteger)sepLenght {
    
    if (self.length == 0 || sepLenght == 0) return self;
    if (separateStr == nil) separateStr = @"";
    NSMutableString *newGCallNum = [NSMutableString string];
    NSInteger lenght = self.length;
    for (NSInteger loc = 0; loc < lenght; ) {
        NSInteger rangeLenght = (lenght-loc)>=sepLenght?sepLenght:(lenght-loc);
        [newGCallNum appendString:[self substringWithRange:NSMakeRange(loc, rangeLenght)]];
        [newGCallNum appendString:separateStr];
        loc+=rangeLenght;
    }
    [newGCallNum deleteCharactersInRange:NSMakeRange(newGCallNum.length-separateStr.length, separateStr.length)];
    
    return newGCallNum;
}

/**
 字符串的MD5
 */
- (NSString *)MD5Hash {
    if(self.length == 0) {
        return nil;
    }
    
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
}

/**
 根据内容获取字符串的size
 
 @param font 字体
 @param maxW 最长的宽度
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    // 获得系统版本
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0) {
        return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    } else {
        return [self sizeWithFont:font constrainedToSize:maxSize];
    }
}

@end

#pragma mark - ********************  HTML ***********************
@implementation NSString (HTML)

/**
 移除html编码的特殊字符，返回纯文本
 */
-(NSString *)replaceHtmlSpecialChars{
    
    NSMutableString *mutableStr = [self mutableCopy];
    //转码多次的变成一次转码，如&amp;amp;nbsp; --->&nbsp
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:@"&(amp)+;" options:0 error:nil];
    [regEx replaceMatchesInString:mutableStr options:0 range:NSMakeRange(0, mutableStr.length) withTemplate:@"&"];
    
    //替换转码特殊字符。
    //TODO: 使用编码表换成对应的原字符，而不是删除
    regEx = [[NSRegularExpression alloc] initWithPattern:@"&[^&]+;" options:0 error:nil];
    [regEx replaceMatchesInString:mutableStr options:0 range:NSMakeRange(0, mutableStr.length) withTemplate:@""];
    
    [mutableStr replaceOccurrencesOfString:@"br/" withString:@"\n" options:0 range:NSMakeRange(0, mutableStr.length)];
    return [mutableStr removeXMLTags];
}

/**
 去除尖括号标签内的所有内容
 */
-(NSString *)removeXMLTags{
    
    NSMutableString *temp = [self mutableCopy];
    NSRange tagRange = NSMakeRange(0, 0);
    BOOL isInTag = NO;
    NSInteger deletedLength = 0;
    
    for (int i = 0; i<self.length; i++) {
        if ([self characterAtIndex:i] == '<') {
            tagRange.location = i - deletedLength;
            tagRange.length = 1;
            isInTag = YES;
        }else if(isInTag){
            tagRange.length += 1;
            if ([self characterAtIndex:i] == '>') {
                [temp deleteCharactersInRange:tagRange];
                deletedLength += tagRange.length;
                isInTag = NO;
            }
        }
    }
    return [temp copy];
}

@end

#pragma mark - ********************  FormatCheck ***********************
@implementation NSString (FormatCheck)

/**
 是否不包含forbidString里的任何一个字符
 */
-(BOOL)notContainCharsAt:(NSString *)forbidString{
    return [self notContainCharsAt:forbidString andCharGroup:0];
}

/**
 是否不包含forbidString里的任何一个字符，也不包含charGroup里的类型
 */
-(BOOL)notContainCharsAt:(NSString *)forbidString andCharGroup:(FormatCheckCharGroupType)charGroup{
    
    NSMutableString *regex = [[NSMutableString alloc] initWithString:@"^[^"];
    [self buildRegex:regex fromCheckString:forbidString charGroup:charGroup];
    [regex appendString:@"]*$"];
    return [self isMatchREgex:regex];
}

/**
 只包含allowString和charGroup组里的字符
 */
-(BOOL)onlyContainCharsAt:(NSString *)allowString andCharGroup:(FormatCheckCharGroupType)charGroup{
    
    NSMutableString *regex = [[NSMutableString alloc] initWithString:@"^["];
    [self buildRegex:regex fromCheckString:allowString charGroup:charGroup];
    [regex appendString:@"]*$"];
    return [self isMatchREgex:regex];
}

/**
 是否匹配正则到结果
 */
-(BOOL)isMatchREgex:(NSString *)regexString{
    NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:regexString options:(0) error:nil];
    return [regEx matchesInString:self options:0 range:NSMakeRange(0, self.length)].count > 0;
}

/**
 拼接正则表达式
 
 @param regex      初始正则
 @param checkSring 要拼接成正则的字符串集合
 @param charGroup  额外拼接的字符组类型
 */
-(void)buildRegex:(NSMutableString *)regex fromCheckString:(NSString *)checkSring charGroup:(FormatCheckCharGroupType)charGroup{
    
    // 特殊字符，额外加上“\\”
    NSString *specialChars = @"*.?+$^[](){}|\\/【】（）-";
    // 遍历字符串集合
    for (int i = 0; i<checkSring.length; i++) {
        NSString *forbidChar = [checkSring substringWithRange:NSMakeRange(i, 1)];
        if ([specialChars containsString:forbidChar]) {
            [regex appendString:@"\\"];
        }
        [regex appendString:forbidChar];
    }
    // 拼接字符组类型
    if (charGroup & FormatCheckCharGroupTypeAlphabet) {
        [regex appendString:@"a-zA-Z"];
    }
    if (charGroup & FormatCheckCharGroupTypeChinese) {
        [regex appendString:@"\\u4e00-\\u9fa5"];
    }
    if (charGroup & FormatCheckCharGroupTypeNumber) {
        [regex appendString:@"0-9"];
    }
}

/**
 判断是否全是空格
 */
- (BOOL)isAllEmpty {
    if (self.length == 0) {
        return NO;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

-(BOOL)validatePhone
{
    NSString *phone = self;
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phone] == YES)
        || ([regextestcm evaluateWithObject:phone] == YES)
        || ([regextestct evaluateWithObject:phone] == YES)
        || ([regextestcu evaluateWithObject:phone] == YES))
    {
        if([regextestcm evaluateWithObject:phone] == YES) {
            NSLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:phone] == YES) {
            NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:phone] == YES) {
            NSLog(@"China Unicom");
        } else {
            NSLog(@"Unknow");
        }
        return YES;
    }else{
        return NO;
    }
}

/**
 判断有效座机
 */
-(BOOL)validateLandline {
    NSString *phone=self;
    NSLog(@"------%@",phone);
    NSString * PHS = @"[0-9-()（）]{7,18}";
    
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    if ([regextestphs evaluateWithObject:phone] == YES) {
        NSLog(@"China 座机");
        return YES;
    }
    return NO;
}

/**
 判断有效用户名
 以字母或者数字开头，只能包含"字母"、"数字"、"-"、"_"、"."字符，总字符数>=4
 */
-(BOOL)isLegalUserName {
    NSString *phone=self;
    
    if ([phone validatePhone]) {
        return NO;
    }
    NSString *regex =@"^[a-zA-Z0-9]{1}[-a-zA-Z0-9_\\.]{3,23}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:phone]) {
        return YES;
    }
    return NO;
}

/**
 判断有效用户名称：
 包含：汉字、英文、数字、 （空格)、%（英）、()（英）、[]（英）、~（英）、`（英）、&（英）、_（英）、
 -（英）、+（英）、%（中）、（）（中）、【】（中）、~（中）、·（中）、&（中）、-（中）、+
 （中）、《》（中）
 */
-(BOOL)isLegalNickName {
    return [self onlyContainCharsAt:@" %()[]~`&_-+%（）【】《》~·" andCharGroup:(FormatCheckCharGroupTypeAll)];
}

/**
 在isLegalNickName的基础上，不包含空格
 */
-(BOOL)isLegalNickNameExceptSpaces {
    return [self onlyContainCharsAt:@"%()[]~`&_-+%（）【】《》~·" andCharGroup:(FormatCheckCharGroupTypeAll)];
}

/**
 判断有效身份证号码
 */
-(BOOL)isLegalIdentityCardNo{
    NSString *identityCard = self;
    //判断是否是18位，末尾是否是x
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if(![identityCardPredicate evaluateWithObject:identityCard]){
        return NO;
    }
    //判断生日是否合法
    NSRange range = NSMakeRange(6,8);
    NSString *datestr = [identityCard substringWithRange:range];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyyMMdd"];
    if([formatter dateFromString:datestr]==nil){
        return NO;
    }
    
    //判断校验位
    if(identityCard.length==18)
    {
        NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
        NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
        for(int i=0;i<17;i++){
            idCardWiSum+=[[identityCard substringWithRange:NSMakeRange(i,1)] intValue]*[idCardWi[i] intValue];
        }
        
        int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
        NSString *idCardLast=[identityCard substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast intValue]==[idCardY[idCardMod] intValue]){
                return YES;
            }else{
                return NO;
            }
        }
    }
    return NO;
}

/**
 判断有效邮箱地址
 */
-(BOOL)isEmailAdress {
    NSString *phone=self;
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:phone];
}

/**
 判断是否包含中文
 */
-(BOOL)containsChinese {
    NSString *regex = @"[\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}

/**
 判断有效密码 - 长度>=8,<=20位，并且同时包含数字和字母
 */
-(BOOL)judgePassWordLegal {
    NSString *phone=self;
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result = [pred evaluateWithObject:phone];
    return result;
}

/**
 判断是否是emoji表情
 */
-  (BOOL)stringContainsEmoji {
    NSString *string = self;
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    return returnValue;
}

/**
 判断是否是纯数字
 */
-(BOOL)isPureNumber {
    NSString *regex = @"[0-9]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}

/**
 判断是否是纯字母
 
 @param catipalAndLower 0不区分大小写、1大写、2小写
 */
-(BOOL)isPureLetter:(NSInteger)catipalAndLower {
    if (catipalAndLower != 0 &&
        catipalAndLower != 1 &&
        catipalAndLower != 2) {
        return NO;
    }
    NSString *regex = @"";
    if (catipalAndLower == 0) {
        regex = @"[a-zA-Z]+";
    } else if (catipalAndLower == 1) {
        regex = @"[A-Z]+";
    } else if (catipalAndLower == 2) {
        regex = @"[a-z]+";
    }
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}

/**
 是否为合法的网站
 */
-(BOOL)isLegalWebsite {
    
    NSError *error;
    // 正则1
    NSString *regulaStr =@"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    // 正则2
    regulaStr =@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    for (NSTextCheckingResult *match in arrayOfAllMatches){
        NSString *substringForMatch = [self substringWithRange:match.range];
        NSLog(@"网址匹配 %@",substringForMatch);
        return YES;
    }
    return NO;
}

@end
