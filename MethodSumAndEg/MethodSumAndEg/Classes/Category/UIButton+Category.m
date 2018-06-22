//
//  UIButton+Category.m
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/22.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)

@end


@implementation UIButton (ImageTitleSpacing)

- (CGSize)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                          imageTitleSpace:(CGFloat)space
{
    /**
     *  前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    // 只有当titleLabel和imageView都有值的，再去计算imageEdgeInsets和labelEdgeInsets
    if (self.currentTitle.length != 0 && self.currentImage != nil) {
        CGFloat spaceScale = 2.0;
        switch (style) {
            case MKButtonEdgeInsetsStyleTop:
            {
                imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/spaceScale, 0, 0, -labelWidth);
                labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/spaceScale, 0);
            }
                break;
            case MKButtonEdgeInsetsStyleLeft:
            {
                imageEdgeInsets = UIEdgeInsetsMake(0, -space/spaceScale, 0, space/spaceScale);
                labelEdgeInsets = UIEdgeInsetsMake(0, space/spaceScale, 0, -space/spaceScale);
            }
                break;
            case MKButtonEdgeInsetsStyleBottom:
            {
                imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/spaceScale, -labelWidth);
                labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/spaceScale, -imageWith, 0, 0);
            }
                break;
            case MKButtonEdgeInsetsStyleRight:
            {
                imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/spaceScale, 0, -labelWidth-space/spaceScale);
                labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/spaceScale, 0, imageWith+space/spaceScale);
            }
                break;
            default:
                break;
        }
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
    
    // 5. 计算button的size
    CGSize buttonSize = CGSizeZero;
    if (self.currentTitle.length != 0 && self.currentImage != nil) {
        
        NSDictionary *attrs = @{NSFontAttributeName : self.titleLabel.font};
        CGSize titleSize = [self.currentTitle sizeWithAttributes:attrs];
        switch (style) {
            case MKButtonEdgeInsetsStyleTop:
            case MKButtonEdgeInsetsStyleBottom: {
                // 高度加和
                buttonSize.height = titleSize.height + self.currentImage.size.height + space;
                // 宽度取最长
                buttonSize.width = MAX(titleSize.width, self.currentImage.size.width);
            }
                break;
            case MKButtonEdgeInsetsStyleLeft:
            case MKButtonEdgeInsetsStyleRight: {
                //宽度加和
                buttonSize.width = titleSize.width + self.currentImage.size.width + space;
                //高度取最长
                buttonSize.height = MAX(titleSize.height, self.currentImage.size.height);
            }
                break;
            default:
                break;
        }
    }
    
    return buttonSize;
}

@end
