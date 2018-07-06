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
//    [self addSubview:self.extensibleLabel];
    [self addSubview:self.attributedLabel];
    [self setupMasonry];
}

- (void)setupMasonry {
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"点击了UILabel_Demo");
    
    if (self.attributedLabel.superview) {
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
        
        // 改变文字的间距
        [self.attributedLabel GC_changeSpaceWithTextSpace:5 changeRange:NSMakeRange(text_2_range.location+text_2_range.length-1, 1)];
    }
}

#pragma mark - TTTAttributedLabelDelegate
-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    NSLog(@"点击了链接，地址为：%@", url);
}

#pragma mark - lazy load
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
