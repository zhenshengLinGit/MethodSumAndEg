//
//  ZSConst.h
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/4.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#ifndef ZSConst_h
#define ZSConst_h

/********************************  机型、系统判断相关  ****************************************/
#define SYSVERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
#define Is_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define Is_iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define CurrentModeRespond [UIScreen instancesRespondToSelector:@selector(currentMode)]
#define iPHone5     (CurrentModeRespond ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPHone6     (CurrentModeRespond ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPHone6Plus (CurrentModeRespond ?CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPHoneX     (CurrentModeRespond ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

/********************************  颜色相关  ****************************************/
#define RGBAColor(r, g, b ,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGBColor(r, g, b)      RGBAColor(r, g, b, 1.0f)
#define RandomColor            RGBAColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255), 1.0)

/********************************  尺寸相关  ****************************************/
#define KScreenWidth                   ([UIScreen mainScreen].bounds.size.width)
#define KScreenHeight                  ([UIScreen mainScreen].bounds.size.height)
#define KNavgationBarH                 (iPHoneX ? (88.0) : (64.0))
#define KTabBarH                       (iPHoneX ? (83.0) : (49.0))
#define KStatusBarH                    (iPHoneX ? 44.0 : 20.0)
#define kScreenScaleLen(length)        (KScreenHeight*length/736)  //以plus按比例，length以pt为单位

/********************************  其他  ****************************************/
// 属性弱化宏
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
// 属性强化宏
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

#endif /* ZSConst_h */
