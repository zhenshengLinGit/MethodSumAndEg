//
//  NSString_Demo.m
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/7/10.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import "NSString_Demo.h"
#import "NSString+Category.h"

@interface NSString_Demo ()

@property (nonatomic,strong) UILabel *normalLabel;

@end

@implementation NSString_Demo

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.normalLabel];
    [self setupMasonry];
}

- (void)setupMasonry {
    if (self.normalLabel.superview) {
        [self.normalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(10);
            make.right.lessThanOrEqualTo(self).offset(-10);
        }];
    }
}

#pragma mark - touches event
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSString *showStr = @"测试字符串的处理";
    NSInteger selectedCase = 0;
    if (selectedCase == 0) {
        showStr = @"   1 2\n3 \n ";
    }
    else if (selectedCase == 1) {
        // 去掉首尾的空格，并将换行符替换为空格
        showStr = @"   1 2\n3 \n ";
        showStr = [showStr deleteBlankspaceAndNewline];
    }
    else if (selectedCase == 2) {
        // 过滤HTML所有特殊字符，只保留纯文字
        NSString *path = [[NSBundle mainBundle] pathForResource:@"textImageHtml" ofType:@"txt"];
        NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        showStr = [html replaceHtmlSpecialChars];
    }
    else if (selectedCase == 3) {
        // 判断是否是纯字母
        showStr = @"abcDEF";
        int para = 0;
        BOOL result = [showStr isPureLetter:para];
        NSLog(@"result = %zd", result);
    }
    else if (selectedCase == 4) {
        showStr = @"啦啦啦";
        NSString *filtStr = @"我wo1[（(【";
        int seleted = 0;
        BOOL result = NO;
        if (seleted == 0) {
            result = [showStr onlyContainCharsAt:filtStr andCharGroup:(FormatCheckCharGroupTypeAll)];
        } else if (seleted == 1) {
            result = [showStr notContainCharsAt:filtStr andCharGroup:(FormatCheckCharGroupTypeNumber)];
        }
        NSLog(@"result = %zd", result);
    }
    else if (selectedCase == 5) {
        
    }
    else if (selectedCase == 6) {
        
    }
    else if (selectedCase == 7) {
        
    }
    else if (selectedCase == 2) {
        
    }
    self.normalLabel.text = showStr;
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

@end
