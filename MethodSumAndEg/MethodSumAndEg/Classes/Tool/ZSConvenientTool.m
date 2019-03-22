//
//  ZSConvenientTool.m
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/13.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import "ZSConvenientTool.h"
#import "PinYin4Objc.h"
#import "PinyinHelper.h"

// 字符类型 - 汉字、字母、数字
typedef NS_ENUM(NSInteger, CharacterType) {
    CharacterTypeChinese,
    CharacterTypeLetter,
    CharacterTypeSpecial
};

//定义宏定义，是方便可以倒序排列
#define kOrderedAscending   NSOrderedAscending
#define kOrderedDescending  NSOrderedDescending
#define kOrderedSame        NSOrderedSame

@implementation ZSConvenientTool

// 将中文转换成拼音
+ (NSString *)transformToPinyinWithStr:(NSString *)singleStr {
    HanyuPinyinOutputFormat *outputFormat = [[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithToneNumber];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeUppercase];
    NSString *outputPinyin = [PinyinHelper toHanyuPinyinStringWithNSString:singleStr withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
    NSLog(@"pinyin - %@", outputPinyin);
    return outputPinyin;
}

// 判断字符类型，进行比较: CharacterTypeChinese < CharacterTypeLetter < CharacterTypeSpecial
+ (CharacterType)cTypeWithStr:(NSString *)singleStr {
    CharacterType cType;
    NSString *upperStr = [singleStr uppercaseString];
    unichar ch = [upperStr characterAtIndex:0];
    if (0x4E00 <= ch && ch <= 0x9FA5) {  //汉字
        cType = CharacterTypeChinese;
    } else if ('A' <= ch && ch <= 'Z') { //a-z & A-Z
        cType = CharacterTypeLetter;
    } else {
        cType = CharacterTypeSpecial;
    }
    return cType;
}

//转换成大写 - 对于汉字，用于排列拼音； 对于字母，用于排列不区分大小写的字母。
//汉字    -> 带声调的大写拼音:  林(LIN2) = 淋(LIN2) < 令(LIN4) < 王(WANG2)
//字母    -> 大写字母       :  l(L) = L(L) < w(W) < Z(Z)
//特殊字符 -> 不做处理
+ (NSString *)uppercaseWithStr:(NSString *)singleStr cType:(CharacterType)cType {
    NSString *uppercase = nil;
    if (cType == CharacterTypeChinese) {
        uppercase = [self transformToPinyinWithStr:singleStr];
    } else if (cType == CharacterTypeLetter) {
        uppercase = [singleStr uppercaseString];
    } else if (cType == CharacterTypeSpecial) {
        uppercase = singleStr;
    }
    return uppercase;
}

//真实的名称 - 用于unicode比较大小
//汉字    -> 不做处理 : 林(\u6797) < 淋(\u6dcb) < 霖(\u9716)
//字母    -> 不做处理 : L(\u004c) < l(\u006c)
//特殊字符 -> 不做处理
+ (NSString *)realLetterWithStr:(NSString *)singleStr cType:(CharacterType)cType {
    NSString *realLetter = nil;
    if (cType == CharacterTypeChinese) {
        realLetter = singleStr;
    } else if (cType == CharacterTypeLetter) {
        realLetter = singleStr;
    } else if (cType == CharacterTypeSpecial) {
        realLetter = singleStr;
    }
    return realLetter;
}

/** 对数组中的联系人模型进行排列：中文 > 英文 > 特殊字符
 dataArr    - 要排列的数组（包含数组模型）
 realName   - 模型属性名称
 contactsId - 模型属性Id - 用于当2个名称完全一致时的排列顺序。
 */
+ (NSArray *)sortContactAddressWithDataArr:(NSArray <NSObject *>*)dataArr RealName:(NSString *)realName contactsId:(NSString *)contactsId {
    NSLog(@"^^^^^排序前 = %@", dataArr);
    
    NSArray *sortedArr = [dataArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        NSComparisonResult result;
        
        NSInteger index = 0;
        while (YES) {
            NSString *realName1 = [obj1 valueForKey:realName];
            NSString *realName2 = [obj2 valueForKey:realName];
            NSString *contactsId1 = [NSString stringWithFormat:@"%@", [obj1 valueForKey:contactsId]];
            NSString *contactsId2 = [NSString stringWithFormat:@"%@", [obj2 valueForKey:contactsId]];
            //取出单个字符
            NSString *singleStr1 = nil;
            NSString *singleStr2 = nil;
            if (index < realName1.length) singleStr1 = [realName1 substringWithRange:NSMakeRange(index, 1)];
            if (index < realName2.length) singleStr2 = [realName2 substringWithRange:NSMakeRange(index, 1)];
            // 当遍历完所有时，以contactID升序排列
            if (singleStr1.length == 0 && singleStr2.length == 0) {
                NSComparisonResult conIdResult = [contactsId1 compare:contactsId2];
                if (conIdResult == NSOrderedAscending) {
                    result = kOrderedAscending;
                    break;
                } else if (conIdResult == NSOrderedDescending) {
                    result = kOrderedDescending;
                    break;
                } else {
                    result = kOrderedSame;
                    break;
                }
            } else if (singleStr1.length == 0) {
                result = kOrderedAscending;
                break;
            } else if (singleStr2.length == 0) {
                result = kOrderedDescending;
                break;
            } else {  //两者都有时
                
                //单个字符对比的依据
                //1.字符类型
                //从小到大排：汉字 -> 字母 -> 特殊字符
                CharacterType cType1 = [self cTypeWithStr:singleStr1];
                CharacterType cType2 = [self cTypeWithStr:singleStr2];
                if (cType1 < cType2) {
                    result = kOrderedAscending;
                    break;
                } else if (cType1 > cType2) {
                    result = kOrderedDescending;
                    break;
                } else {
                    //2.大写字母
                    //从小到大排
                    NSString *upper1 = [self uppercaseWithStr:singleStr1 cType:cType1];
                    NSString *upper2 = [self uppercaseWithStr:singleStr2 cType:cType2];
                    NSComparisonResult upperResult = [upper1 compare:upper2];
                    if (upperResult == NSOrderedAscending) {
                        result = kOrderedAscending;
                        break;
                    } else if (upperResult == NSOrderedDescending) {
                        result = kOrderedDescending;
                        break;
                    } else {
                        //3.realLetter
                        //从小到大排
                        NSString *realLetter1 = [self realLetterWithStr:singleStr1 cType:cType1];
                        NSString *realLetter2 = [self realLetterWithStr:singleStr2 cType:cType2];
                        NSComparisonResult realResult = [realLetter1 compare:realLetter2];
                        if (realResult == NSOrderedAscending) {
                            result = kOrderedAscending;
                            break;
                        } else if (realResult == NSOrderedDescending) {
                            result = kOrderedDescending;
                            break;
                        } else {
                            // 对比下一个字符
                        }
                    }
                    
                }
            }
            index++;
        }
        return result;
    }];
    
    NSLog(@"^^^^^排序后 = %@", sortedArr);
    return sortedArr;
}

@end
