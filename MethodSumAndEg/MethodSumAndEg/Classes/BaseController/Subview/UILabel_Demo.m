//
//  UILabel_Demo.m
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/22.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import "UILabel_Demo.h"
#import "ExtensibleLabel.h"
#import "TTTAttributedLabel.h"
#import "UILabel+Category.h"

@interface UILabel_Demo () <TTTAttributedLabelDelegate>

@property (nonatomic,strong) UILabel *normalLabel;
@property (nonatomic,strong) ExtensibleLabel *extensibleLabel;
@property (nonatomic,strong) TTTAttributedLabel *attributedLabel;

@end

@implementation UILabel_Demo

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.normalLabel];
//    [self addSubview:self.extensibleLabel];
//    [self addSubview:self.attributedLabel];
    [self setupMasonry];
}

- (void)setupMasonry {
    if (self.normalLabel.superview) {
        [self.normalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(10);
            make.right.lessThanOrEqualTo(self).offset(-10);
        }];
    }
    if (self.extensibleLabel.superview) {
        [self.extensibleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(10);
            make.right.lessThanOrEqualTo(self).offset(-10);
        }];
    }
    if (self.attributedLabel.superview) {
        [self.attributedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(10);
            make.right.lessThanOrEqualTo(self).offset(-10);
        }];
    }
}

#pragma mark - touches event
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"点击了UILabel_Demo");
    
    if (self.normalLabel.superview) {
        [self operateNormalLabel];
    }
    else if (self.attributedLabel.superview) {
        [self operateAttributedLabel];
    }
}

- (void)operateNormalLabel {
    // 重置label
    [self.normalLabel removeFromSuperview];
    self.normalLabel = nil;
    [self createUI];
    
    // 测试attributedText的样式变化
    NSString *changeStr = @"改变";
    self.normalLabel.text = [NSString stringWithFormat:@"测试样式的%@，睁大眼睛看看", changeStr];
    NSInteger selectedCase = 0;
    if (selectedCase == 0) {
        // 原始的模样
        
    }
    else if (selectedCase == 1) {
        // 改变文中的字体大小
        [self.normalLabel GC_changeFontWithTextFont:KMiddleFontSize(18) changeRange:NSMakeRange(2, 2)];
        
    }
    else if (selectedCase == 2) {
        // 改变字间距
        [self.normalLabel GC_changeSpaceWithTextSpace:5 changeRange:NSMakeRange(1, 1)];
        
    }
    else if (selectedCase == 3) {
        // 改变行间距
        [self.normalLabel GC_changeLineSpaceWithTextLineSpace:5];
        
    }
    else if (selectedCase == 4) {
        // 改变颜色
        [self.normalLabel GC_changeColorWithTextColor:[UIColor redColor] changeRange:NSMakeRange(2, 2)];
        
    }
    else if (selectedCase == 5) {
        // 改变背景颜色
        [self.normalLabel GC_changeBgColorWithBgTextColor:[UIColor blueColor] changeText:changeStr];
        
    }
    else if (selectedCase == 6) {
        // 改变连笔字 - 中文用不到，在英文中可能出现相邻字母连笔的情况
        int number = 1;
        [self.normalLabel GC_changeLigatureWithTextLigature:@(number) changeText:changeStr];
        
    }
    else if (selectedCase == 7) {
        // 改变删除线
        int number = NSUnderlineStyleDouble;
        [self.normalLabel GC_changeStrikethroughStyleWithTextStrikethroughStyle:@(number) changeText:changeStr];
        [self.normalLabel GC_changeStrikethroughColorWithTextStrikethroughColor:[UIColor redColor] changeText:changeStr];
        
    }
    else if (selectedCase == 8) {
        // 改变下划线
        int number = NSUnderlineStyleDouble;
        [self.normalLabel GC_changeUnderlineStyleWithTextStrikethroughStyle:@(number) changeText:changeStr];
        [self.normalLabel GC_changeUnderlineColorWithTextStrikethroughColor:[UIColor redColor] changeText:changeStr];
        
    }
    else if (selectedCase == 9) {
        // 改变字的笔画宽度
        int number = 5;
        [self.normalLabel GC_changeStrokeWidthWithTextStrikethroughWidth:@(number) changeText:changeStr];
        [self.normalLabel GC_changeStrokeColorWithTextStrikethroughColor:[UIColor redColor] changeText:changeStr];
        
    }
    else if (selectedCase == 10) {
        // 改变阴影
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = CGSizeMake(5, 5);
        shadow.shadowBlurRadius = 2;
        shadow.shadowColor = [UIColor redColor];
        [self.normalLabel GC_changeShadowWithTextShadow:shadow changeText:changeStr];
        
    }
    else if (selectedCase == 11) {
        // 改变文本效果
        [self.normalLabel GC_changeTextEffectWithTextEffect:NSTextEffectLetterpressStyle changeText:changeStr];
        
    }
    else if (selectedCase == 12) {
        // 改变文本附件，用于图文混排，如插入图片
        NSTextAttachment *attach = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
        attach.bounds = CGRectMake(0, 0, 30, 30);
        attach.image = [UIImage imageNamed:@"tab_1_pre"];
        [self.normalLabel GC_changeAttachmentWithTextAttachment:attach changeText:@"变"];
        
    }
    else if (selectedCase == 13) {
        // 增加链接，这里注意的是，UILabel是无法响应点击的，UITextView可以通过代理方法shouldInteractWithURL响应。如果要实现UILabel的点击响应，则需要借助自己实现点击事件。
        // 默认有下划线
        NSString *textLink = @"www.baidu.com";
        [self.normalLabel GC_changeLinkWithTextLink:textLink changeText:changeStr];
        
    }
    else if (selectedCase == 14) {
        // 改变字的基准线
        int number = 5;
        [self.normalLabel GC_changeBaselineOffsetWithTextBaselineOffset:@(number) changeText:changeStr];
        
    }
    else if (selectedCase == 15) {
        // 改变字的倾斜程度
        int number = 1;
        [self.normalLabel GC_changeObliquenessWithTextObliqueness:@(number) changeText:changeStr];
        
    }
    else if (selectedCase == 16) {
        // 改变字的拉伸
        int number = 1;
        [self.normalLabel GC_changeExpansionsWithTextExpansion:@(number) changeText:changeStr];
        
    }
    else if (selectedCase == 17) {
        // 改变字的书写方向
        // The values of the NSNumber objects should be 0, 1, 2, or 3, for LRE, RLE, LRO, or RLO respectively
        int number = 3;
        [self.normalLabel GC_changeWritingDirectionWithTextExpansion:@[@(number)] changeText:self.normalLabel.text];
        
    }
    else if (selectedCase == 18) {
        // 改变字的排版方向 0水平 1竖直（实测无效果）
        int number = 1;
        [self.normalLabel GC_changeVerticalGlyphFormWithTextVerticalGlyphForm:@(number) changeText:self.normalLabel.text];
        
    }
    else if (selectedCase == 19) {
        // 改变字的间距
        [self.normalLabel GC_changeCTKernWithTextCTKern:@(5)];
        
    }
}

- (void)operateAttributedLabel {
    // 创建带有颜色和链接的文字
    NSString *text_1 = @"红色";
    NSString *text_2 = @"拥抱了";
    NSString *text_3 = @"紫色";
    NSString *text = [NSString stringWithFormat:@"%@%@%@", text_1, text_2, text_3];
    NSRange text_1_range = [text rangeOfString:text_1];
    NSRange text_2_range = [text rangeOfString:text_2];
    NSRange text_3_range = [text rangeOfString:text_3];
    UIColor *text_1_color = [UIColor redColor];
    UIColor *text_2_color = [UIColor blackColor];
    UIColor *text_3_color = [UIColor purpleColor];
    NSURL *text_1_url = [NSURL URLWithString:@"text1:address"];
    NSURL *text_3_url = [NSURL URLWithString:@"text3:address"];
    @WeakObj(self);
    [self.attributedLabel setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        @StrongObj(self);
        //设定可点击文字的的大小
        UIFont *contentFont = self.attributedLabel.font;
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)contentFont.fontName, contentFont.pointSize, NULL);
        if (font) {
            //设置可点击文本的大小
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:text_1_range];
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:text_3_range];
            //设置可点击文本的颜色
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName
                                            value:(id)[text_1_color CGColor]
                                            range:text_1_range];
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName
                                            value:(id)[text_2_color CGColor]
                                            range:text_2_range];
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName
                                            value:(id)[text_3_color CGColor]
                                            range:text_3_range];
            CFRelease(font);
        }
        return mutableAttributedString;
    }];
    // 设置链接-设置链接后，range区域的样式取决于linkAttributes属性
    // 此时，如果点击了链接文字，则会callback下面的attributedLabel:didSelectLinkWithURL:代理方法
    [self.attributedLabel addLinkToURL:text_1_url withRange:text_1_range];
    [self.attributedLabel addLinkToURL:text_3_url withRange:text_3_range];
}

#pragma mark - TTTAttributedLabelDelegate
-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    NSLog(@"点击了链接，地址为：%@", url);
}

#pragma mark - lazy load
-(UILabel *)normalLabel {
    if (!_normalLabel) {
        _normalLabel = [[UILabel alloc] init];
        _normalLabel.backgroundColor = [UIColor whiteColor];
        _normalLabel.textColor = [UIColor blackColor];
        _normalLabel.font = [UIFont systemFontOfSize:15];
        _normalLabel.numberOfLines = 0;
    }
    return _normalLabel;
}

-(ExtensibleLabel *)extensibleLabel {
    if (!_extensibleLabel) {
        _extensibleLabel = [[ExtensibleLabel alloc] init];
        _extensibleLabel.backgroundColor = [UIColor cyanColor];
        _extensibleLabel.text = KNormalStr;
        _extensibleLabel.textColor = [UIColor blueColor];
        _extensibleLabel.font = [UIFont systemFontOfSize:15];
        _extensibleLabel.numberOfLines = 0;
        
        // 设置Label的四周间距
        _extensibleLabel.edgeInsets = UIEdgeInsetsMake(10, 20, 30, 40);
    }
    return _extensibleLabel;
}

-(TTTAttributedLabel *)attributedLabel {
    if (!_attributedLabel) {
        _attributedLabel = ({
            TTTAttributedLabel *label = [TTTAttributedLabel new];
            label.delegate = self;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:16];
            label.numberOfLines = 1;
            label.lineBreakMode = NSLineBreakByTruncatingTail;
            //链接去掉分割线
            NSMutableDictionary *mutableLinkAttributes =
            [@{(NSString *)kCTUnderlineStyleAttributeName:@(NO)}mutableCopy];
            NSMutableDictionary *mutableActiveLinkAttributes =
            [@{(NSString *)kCTUnderlineStyleAttributeName:@(NO)}mutableCopy];
            //链接颜色
            UIColor *commonLinkColor = [UIColor blueColor];
            if ([NSMutableParagraphStyle class]) {
                [mutableLinkAttributes setObject:commonLinkColor forKey:(NSString *)kCTForegroundColorAttributeName];
                [mutableActiveLinkAttributes setObject:commonLinkColor forKey:(NSString *)kCTForegroundColorAttributeName];
            } else {
                [mutableLinkAttributes setObject:(__bridge id)[commonLinkColor CGColor] forKey:(NSString *)kCTForegroundColorAttributeName];
                [mutableActiveLinkAttributes setObject:(__bridge id)[commonLinkColor CGColor] forKey:(NSString *)kCTForegroundColorAttributeName];
            }
            //点击时候的背景色
            [mutableActiveLinkAttributes setValue:(__bridge id)[[UIColor whiteColor] CGColor] forKey:(NSString *)kTTTBackgroundFillColorAttributeName];
            //设置链接
            label.linkAttributes = [NSDictionary dictionaryWithDictionary:mutableLinkAttributes];
            label.activeLinkAttributes = [NSDictionary dictionaryWithDictionary:mutableActiveLinkAttributes];
            label;
        });
    }
    return _attributedLabel;
}

@end
