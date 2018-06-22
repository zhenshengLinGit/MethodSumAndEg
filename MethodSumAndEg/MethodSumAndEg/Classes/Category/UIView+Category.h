//
//  UIView+Category.h
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/4.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)

@end

#pragma mark - ********************  frame相关  ***********************
@interface UIView (Frame)

@property CGPoint origin;
@property CGSize size;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;
@property CGFloat height;
@property CGFloat width;
@property CGFloat top;
@property CGFloat left;
@property CGFloat bottom;
@property CGFloat right;
- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

@end


#pragma mark - ********************  样式相关  ***********************
typedef NS_OPTIONS ( NSUInteger, Position){
    TOP      = 1 << 0,
    LEFT     = 1 << 1,
    BOTTOM   = 1 << 2,
    RIGHT    = 1 << 3,
    POSITIONAll      = TOP | LEFT | BOTTOM | RIGHT,
};
@interface UIView (Style)

/** 给view上下左右添加边框并设置圆角，注意：此时view的frame必须已经确定，并且view的size固定死不变  ps：绘制出来的效果有点偏差*/
- (void)addBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth andPostion:(Position)position corners:(UIRectCorner)corners radius:(CGFloat)radius;
/** 给view上下左右添加边框 */
- (void)addBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth andPostion:(Position)position;

@end


#pragma mark - ********************  其他  ***********************
@interface UIView (Other)

/** 通过响应者链条获取当前View的控制器对象 */
-(UIViewController *)getCurrentViewController;

@end





