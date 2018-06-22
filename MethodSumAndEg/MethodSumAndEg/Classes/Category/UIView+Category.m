//
//  UIView+Category.m
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/4.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import "UIView+Category.h"
#import <objc/runtime.h>

static NSString *GCRoundLayerKey = @"GCRoundLayerKey";

@implementation UIView (Category)

@end

#pragma mark - ********************  frame相关  ***********************
@implementation UIView (Frame)

// Retrieve and set the origin
- (CGPoint) origin
{
    return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint
{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}

// Retrieve and set the size
- (CGSize) size
{
    return self.frame.size;
}

- (void) setSize: (CGSize) aSize
{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint) bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) topRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}


// Retrieve and set height, width, top, bottom, left, right
- (CGFloat) height
{
    return self.frame.size.height;
}

- (void) setHeight: (CGFloat) newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat) width
{
    return self.frame.size.width;
}

- (void) setWidth: (CGFloat) newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat) top
{
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat) left
{
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

// Move via offset
- (void) moveBy: (CGPoint) delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

// Scaling
- (void) scaleBy: (CGFloat) scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}

@end


#pragma mark - ********************  样式相关  ***********************
@implementation UIView (Style)

/** 给view上下左右添加边框并设置圆角，注意：此时view的frame必须已经确定 */
-(void)addBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth andPostion:(Position)position corners:(UIRectCorner)corners radius:(CGFloat)radius{
    
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    shape.fillColor = [UIColor clearColor].CGColor;
    shape.strokeColor = color.CGColor;
    shape.lineWidth = borderWidth;
    shape.frame = CGRectMake(borderWidth/2.0, borderWidth/2.0, self.bounds.size.width-borderWidth, self.bounds.size.height-borderWidth);
    [self.layer addSublayer:shape];
    
    CAShapeLayer *oldLayer = objc_getAssociatedObject(self, &GCRoundLayerKey);
    if (oldLayer) [oldLayer removeFromSuperlayer];
    objc_setAssociatedObject(self, &GCRoundLayerKey, shape, OBJC_ASSOCIATION_RETAIN);
    
    //去掉圆角外多余的
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    mask.frame = self.bounds;
    self.layer.mask = mask;
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    
    CGFloat width = shape.frame.size.width;
    CGFloat height = shape.frame.size.height;
    
    //上边
    if (position & TOP) {
        [path moveToPoint:CGPointMake(radius, 0)];
        [path addLineToPoint:CGPointMake(width-radius, 0)];
    }
    //右边
    if (position & RIGHT) {
        [path moveToPoint:CGPointMake(width, radius)];
        [path addLineToPoint:CGPointMake(width, height-radius)];
    }
    //左边
    if (position & LEFT) {
        [path moveToPoint:CGPointMake(0, radius)];
        [path addLineToPoint:CGPointMake(0, height-radius)];
    }
    //底边
    if (position & BOTTOM) {
        [path moveToPoint:CGPointMake(radius, height)];
        [path addLineToPoint:CGPointMake(width-radius, height)];
    }
    
    UIRectCorner maskCorner = 0;
    
    //右上角
    if ((position & TOP) && (position & RIGHT) && (corners & UIRectCornerTopRight)) { //使用圆角
        
        [path moveToPoint:CGPointMake(width, radius)];
        [path addArcWithCenter:CGPointMake(width-radius, radius) radius:radius startAngle:0 endAngle:-M_PI_2 clockwise:0];
        
        maskCorner |= UIRectCornerTopRight;
    }else {
        if (position & RIGHT){
            [path moveToPoint:CGPointMake(width, radius)];
            [path addLineToPoint:CGPointMake(width, 0)];
        }
        if (position & TOP) {
            [path moveToPoint:CGPointMake(width, 0)];
            [path addLineToPoint:CGPointMake(width-radius, 0)];
        }
    }
    
    //左上角
    if ((position & TOP) && (position & LEFT) && (corners & UIRectCornerTopLeft)) {
        
        [path moveToPoint:CGPointMake(radius, 0)];
        [path addArcWithCenter:CGPointMake(radius, radius) radius:radius startAngle:-M_PI_2 endAngle:M_PI clockwise:0];
        
        maskCorner |= UIRectCornerTopLeft;
    }else{
        if (position & TOP) {
            [path moveToPoint:CGPointMake(radius, 0)];
            [path addLineToPoint:CGPointMake(0, 0)];
        }
        if (position & LEFT) {
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(0, radius)];
        }
    }
    
    //左下角
    if ((position & BOTTOM) && (position & LEFT) && (corners & UIRectCornerBottomLeft)) {
        
        [path moveToPoint:CGPointMake(0, height-radius)];
        [path addArcWithCenter:CGPointMake(radius, height-radius) radius:radius startAngle:M_PI endAngle:M_PI_2 clockwise:0];
        
        maskCorner |= UIRectCornerBottomLeft;
    }else{
        if (position & LEFT) {
            [path moveToPoint:CGPointMake(0, height-radius)];
            [path addLineToPoint:CGPointMake(0, height)];
        }
        if (position & BOTTOM) {
            [path moveToPoint:CGPointMake(0, height)];
            [path addLineToPoint:CGPointMake(radius, height)];
        }
    }
    
    //右下角
    if ((position & BOTTOM) && (position & RIGHT) && (corners & UIRectCornerBottomLeft)) {
        
        [path moveToPoint:CGPointMake(width-radius, height)];
        [path addArcWithCenter:CGPointMake(width-radius, height-radius) radius:radius startAngle:M_PI_2 endAngle:0 clockwise:0];
        
        maskCorner |= UIRectCornerBottomRight;
    }else{
        if (position & BOTTOM) {
            [path moveToPoint:CGPointMake(width-radius, height)];
            [path addLineToPoint:CGPointMake(width, height)];
        }
        if (position & RIGHT) {
            [path moveToPoint:CGPointMake(width, height)];
            [path addLineToPoint:CGPointMake(width, height-radius)];
        }
    }
    
    shape.path = [path CGPath];
    mask.path = [[UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:maskCorner cornerRadii:CGSizeMake(radius, radius)] CGPath];
}

/** 给view上下左右添加边框 */
- (void)addBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth andPostion:(Position)position{
    
    if (position & TOP){
        CALayer *border = [self createCALayerWithColor:color];
        border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    }
    
    if (position & BOTTOM){
        CALayer *border = [self createCALayerWithColor:color];
        border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    }
    if (position & LEFT){
        CALayer *border = [self createCALayerWithColor:color];
        border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
    }
    
    if (position & RIGHT) {
        CALayer *border = [self createCALayerWithColor:color];
        border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
    }
}

- (CALayer*)createCALayerWithColor: (UIColor *) color {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    [self.layer addSublayer:border];
    return border;
}

@end


#pragma mark - ********************  其他  ***********************
@implementation UIView (Other)

/** 通过响应者链条获取当前View的控制器对象 */
-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

@end








