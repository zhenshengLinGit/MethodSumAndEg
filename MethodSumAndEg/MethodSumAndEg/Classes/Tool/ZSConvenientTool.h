//
//  ZSConvenientTool.h
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/13.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSConvenientTool : NSObject

// 将中文转换成拼音
+ (NSString *)transformToPinyinWithStr:(NSString *)singleStr;

/** 对数组中的联系人模型进行排列：中文 > 英文 > 特殊字符
 dataArr    - 要排列的数组（包含数组模型）
 realName   - 模型属性名称
 contactsId - 模型属性Id - 用于当2个名称完全一致时的排列顺序。
 */
+ (NSArray *)sortContactAddressWithDataArr:(NSArray <NSObject *>*)dataArr RealName:(NSString *)realName contactsId:(NSString *)contactsId;

@end
