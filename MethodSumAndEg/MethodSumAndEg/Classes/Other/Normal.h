//
//  Normal.h
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/22.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#ifndef Normal_h
#define Normal_h

/********************************  字符串相关  ****************************************/
#define KNormalStr @"乌云在我们心里搁下一块阴影，我聆听沉寂已久的心情，清晰透明，就像美丽的风景，总在回忆里才看的清"

/********************************  size的相关  ****************************************/
//常规
#define KNormalFontSize(CGFloat)  [UIFont systemFontOfSize:CGFloat weight:-1]
//中等
#define KMiddleFontSize(CGFloat)  [UIFont systemFontOfSize:CGFloat]
//加粗
#define KBoldFontSize(CGFloat)    [UIFont boldSystemFontOfSize:CGFloat]
//length为UI给的像素，以px为单位
#define kScaleLen(length) ((length)/3.0f)

#endif /* Normal_h */
