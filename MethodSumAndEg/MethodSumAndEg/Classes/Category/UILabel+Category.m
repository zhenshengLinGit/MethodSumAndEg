//
//  UILabel+Category.m
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/7/6.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import "UILabel+Category.h"
#import <CoreText/CoreText.h>

@implementation UILabel (Category)

@end

@implementation UILabel (GCAttributedString)

//获取斜体
UIFont *GetVariationOfFontWithTrait(UIFont *baseFont, CTFontSymbolicTraits trait)
{
    CGFloat fontSize = [baseFont pointSize];
    CFStringRef baseFontName = (__bridge CFStringRef)[baseFont fontName];
    CTFontRef baseCTFont = CTFontCreateWithName(baseFontName, fontSize, NULL);
    CTFontRef ctFont = CTFontCreateCopyWithSymbolicTraits(baseCTFont, 0, NULL, trait, trait);
    NSString *variantFontName = CFBridgingRelease(CTFontCopyName(ctFont, kCTFontPostScriptNameKey));
    
    UIFont *variantFont = [UIFont fontWithName:variantFontName size:fontSize];
    CFRelease(ctFont);
    CFRelease(baseCTFont);
    return variantFont;
};

#pragma mark - 改变字段字体
- (void)GC_changeFontWithTextFont:(UIFont *)textFont
{
    [self GC_changeFontWithTextFont:textFont changeText:self.text];
}
- (void)GC_changeFontWithTextFont:(UIFont *)textFont changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSCaseInsensitiveSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSFontAttributeName value:textFont range:textRange];
    }
    self.attributedText = attributedString;
}
- (void)GC_changeFontWithTextFont:(UIFont *)textFont changeRange:(NSRange)range
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    if (range.location != NSNotFound) {
        @try {
            [attributedString addAttribute:NSFontAttributeName value:textFont range:range];
        } @catch (NSException *exception) {
            NSLog(@"GC_changeFontWithTextFont异常");
        }
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字段间距
- (void)GC_changeSpaceWithTextSpace:(CGFloat)textSpace
{
    [self GC_changeSpaceWithTextSpace:textSpace changeText:self.text];
}
- (void)GC_changeSpaceWithTextSpace:(CGFloat)textSpace changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSCaseInsensitiveSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:(id)kCTKernAttributeName value:@(textSpace) range:textRange];
    }
    self.attributedText = attributedString;
}

- (void)GC_changeSpaceWithTextSpace:(CGFloat)textSpace changeRange:(NSRange)range
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    if (range.location != NSNotFound) {
        @try {
            [attributedString addAttribute:(id)kCTKernAttributeName value:@(textSpace) range:range];
        } @catch (NSException *exception) {
            NSLog(@"GC_changeSpaceWithTextSpace异常");
        }
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变行间距
- (void)GC_changeLineSpaceWithTextLineSpace:(CGFloat)textLineSpace
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:textLineSpace];
    [self GC_changeParagraphStyleWithTextParagraphStyle:paragraphStyle];
}
#pragma mark - 段落样式
- (void)GC_changeParagraphStyleWithTextParagraphStyle:(NSParagraphStyle *)paragraphStyle
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    [self setAttributedText:attributedString];
}

#pragma mark - 改变字段颜色
- (void)GC_changeColorWithTextColor:(UIColor *)textColor
{
    [self GC_changeColorWithTextColor:textColor changeText:self.text];
}
- (void)GC_changeColorWithTextColor:(UIColor *)textColor changeText:(NSString *)text
{
    [self GC_changeColorWithTextColor:textColor changeTexts:@[text]];
}

- (void)GC_changeColorWithTextColor:(UIColor *)textColor changeTexts:(NSArray <NSString *>*)texts
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    for (NSString *text in texts) {
        NSRange textRange = [self.text rangeOfString:text options:NSCaseInsensitiveSearch];
        if (textRange.location != NSNotFound) {
            [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:textRange];
        }
    }
    self.attributedText = attributedString;
}

- (void)GC_changeColorWithTextColor:(UIColor *)textColor changeRange:(NSRange)range{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    if (range.location != NSNotFound) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字段背景颜色
- (void)GC_changeBgColorWithBgTextColor:(UIColor *)bgTextColor
{
    [self GC_changeBgColorWithBgTextColor:bgTextColor changeText:self.text];
}
- (void)GC_changeBgColorWithBgTextColor:(UIColor *)bgTextColor changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSBackgroundColorAttributeName value:bgTextColor range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字段连笔字 value值为1或者0
- (void)GC_changeLigatureWithTextLigature:(NSNumber *)textLigature
{
    [self GC_changeLigatureWithTextLigature:textLigature changeText:self.text];
}
- (void)GC_changeLigatureWithTextLigature:(NSNumber *)textLigature changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSLigatureAttributeName value:textLigature range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字间距
- (void)GC_changeKernWithTextKern:(NSNumber *)textKern
{
    [self GC_changeKernWithTextKern:textKern changeText:self.text];
}
- (void)GC_changeKernWithTextKern:(NSNumber *)textKern changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSKernAttributeName value:textKern range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的删除线 textStrikethroughStyle 为NSUnderlineStyle
- (void)GC_changeStrikethroughStyleWithTextStrikethroughStyle:(NSNumber *)textStrikethroughStyle
{
    [self GC_changeStrikethroughStyleWithTextStrikethroughStyle:textStrikethroughStyle changeText:self.text];
}
- (void)GC_changeStrikethroughStyleWithTextStrikethroughStyle:(NSNumber *)textStrikethroughStyle changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSStrikethroughStyleAttributeName value:textStrikethroughStyle range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的删除线颜色
- (void)GC_changeStrikethroughColorWithTextStrikethroughColor:(UIColor *)textStrikethroughColor
{
    [self GC_changeStrikethroughColorWithTextStrikethroughColor:textStrikethroughColor changeText:self.text];
}
- (void)GC_changeStrikethroughColorWithTextStrikethroughColor:(UIColor *)textStrikethroughColor changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSStrikethroughColorAttributeName value:textStrikethroughColor range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的下划线 textUnderlineStyle 为NSUnderlineStyle
- (void)GC_changeUnderlineStyleWithTextStrikethroughStyle:(NSNumber *)textUnderlineStyle
{
    [self GC_changeUnderlineStyleWithTextStrikethroughStyle:textUnderlineStyle changeText:self.text];
}
- (void)GC_changeUnderlineStyleWithTextStrikethroughStyle:(NSNumber *)textUnderlineStyle changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSUnderlineStyleAttributeName value:textUnderlineStyle range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的下划线颜色
- (void)GC_changeUnderlineColorWithTextStrikethroughColor:(UIColor *)textUnderlineColor
{
    [self GC_changeUnderlineColorWithTextStrikethroughColor:textUnderlineColor changeText:self.text];
}
- (void)GC_changeUnderlineColorWithTextStrikethroughColor:(UIColor *)textUnderlineColor changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSUnderlineColorAttributeName value:textUnderlineColor range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的颜色
- (void)GC_changeStrokeColorWithTextStrikethroughColor:(UIColor *)textStrokeColor
{
    [self GC_changeStrokeColorWithTextStrikethroughColor:textStrokeColor changeText:self.text];
}
- (void)GC_changeStrokeColorWithTextStrikethroughColor:(UIColor *)textStrokeColor changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSStrokeColorAttributeName value:textStrokeColor range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的描边
- (void)GC_changeStrokeWidthWithTextStrikethroughWidth:(NSNumber *)textStrokeWidth
{
    [self GC_changeStrokeWidthWithTextStrikethroughWidth:textStrokeWidth changeText:self.text];
}
- (void)GC_changeStrokeWidthWithTextStrikethroughWidth:(NSNumber *)textStrokeWidth changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSStrokeWidthAttributeName value:textStrokeWidth range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的阴影
- (void)GC_changeShadowWithTextShadow:(NSShadow *)textShadow
{
    [self GC_changeShadowWithTextShadow:textShadow changeText:self.text];
}
- (void)GC_changeShadowWithTextShadow:(NSShadow *)textShadow changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSShadowAttributeName value:textShadow range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的特殊效果
- (void)GC_changeTextEffectWithTextEffect:(NSString *)textEffect
{
    [self GC_changeTextEffectWithTextEffect:textEffect changeText:self.text];
}
- (void)GC_changeTextEffectWithTextEffect:(NSString *)textEffect changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSTextEffectAttributeName value:textEffect range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的文本附件
- (void)GC_changeAttachmentWithTextAttachment:(NSTextAttachment *)textAttachment
{
    [self GC_changeAttachmentWithTextAttachment:textAttachment changeText:self.text];
}
- (void)GC_changeAttachmentWithTextAttachment:(NSTextAttachment *)textAttachment changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSAttachmentAttributeName value:textAttachment range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的链接
- (void)GC_changeLinkWithTextLink:(NSString *)textLink
{
    [self GC_changeLinkWithTextLink:textLink changeText:self.text];
}
- (void)GC_changeLinkWithTextLink:(NSString *)textLink changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSLinkAttributeName value:textLink range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的基准线偏移 value>0坐标往上偏移 value<0坐标往下偏移
- (void)GC_changeBaselineOffsetWithTextBaselineOffset:(NSNumber *)textBaselineOffset
{
    [self GC_changeBaselineOffsetWithTextBaselineOffset:textBaselineOffset changeText:self.text];
}
- (void)GC_changeBaselineOffsetWithTextBaselineOffset:(NSNumber *)textBaselineOffset changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSBaselineOffsetAttributeName value:textBaselineOffset range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的倾斜 value>0向右倾斜 value<0向左倾斜
- (void)GC_changeObliquenessWithTextObliqueness:(NSNumber *)textObliqueness
{
    [self GC_changeObliquenessWithTextObliqueness:textObliqueness changeText:self.text];
}
- (void)GC_changeObliquenessWithTextObliqueness:(NSNumber *)textObliqueness changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSObliquenessAttributeName value:textObliqueness range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字粗细 0就是不变 >0加粗 <0加细
- (void)GC_changeExpansionsWithTextExpansion:(NSNumber *)textExpansion
{
    [self GC_changeExpansionsWithTextExpansion:textExpansion changeText:self.text];
}
- (void)GC_changeExpansionsWithTextExpansion:(NSNumber *)textExpansion changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSExpansionAttributeName value:textExpansion range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字方向 NSWritingDirection
- (void)GC_changeWritingDirectionWithTextExpansion:(NSArray *)textWritingDirection changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSWritingDirectionAttributeName value:textWritingDirection range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的水平或者竖直 1竖直 0水平
- (void)GC_changeVerticalGlyphFormWithTextVerticalGlyphForm:(NSNumber *)textVerticalGlyphForm changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSVerticalGlyphFormAttributeName value:textVerticalGlyphForm range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的两端对齐
- (void)GC_changeCTKernWithTextCTKern:(NSNumber *)textCTKern
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    [attributedString addAttribute:(id)kCTKernAttributeName value:textCTKern range:NSMakeRange(0, self.text.length-1)];
    self.attributedText = attributedString;
}

@end
