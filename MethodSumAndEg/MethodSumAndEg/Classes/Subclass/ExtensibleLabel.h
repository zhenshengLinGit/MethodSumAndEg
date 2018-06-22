//
//  ExtensibleLabel.h
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/22.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtensibleLabel : UILabel

/** 用于设置Label的四周间距，size的自适应依然有效 */
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@end
