//
//  UIButton_Demo.m
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/22.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import "UIButton_Demo.h"
#import "UIButton+Category.h"

@interface UIButton_Demo ()

@property (nonatomic,strong) UIButton *normalBtn;

@end

@implementation UIButton_Demo

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.normalBtn];
    [self setupMasonry];
}

- (void)setupMasonry {
    if (self.normalBtn.superview) {
        [self.normalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(10);
            make.right.lessThanOrEqualTo(self).offset(-10);
//            make.width.mas_equalTo(300);
        }];
    }
}

- (void)buttonClick:(UIButton *)btn {
    if (btn == self.normalBtn) {
        // 更改图片和文字的排列方式，并更新约束
        CGSize updateSize = [self.normalBtn layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyleTop) imageTitleSpace:5];
        [self.normalBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(10);
            make.size.mas_equalTo(updateSize);
        }];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"点击了UIButton_Demo");
}

#pragma mark - lazy load
-(UIButton *)normalBtn {
    if (!_normalBtn) {
        NSString *showStr = nil;
//        showStr = [NSString stringWithFormat:@"%@%@%@%@",KNormalStr,KNormalStr,KNormalStr,KNormalStr];
//        showStr = @"测试文字的排列方式";
        showStr = @"点击我，更改图文的排列方式";
        _normalBtn = [[UIButton alloc] init];
        _normalBtn.backgroundColor = [UIColor cyanColor];
        [_normalBtn setTitle:showStr forState:UIControlStateNormal];
        [_normalBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _normalBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_normalBtn setImage:[UIImage imageNamed:@"tab_5_pre@3x"] forState:(UIControlStateNormal)];
        [_normalBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        // 内容的对齐方式
//        _normalBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        _normalBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        
#pragma - 不推荐使用的属性
        //button设置numberOfLines时，并不会像UILabel一样，可以根据行数自适应size。button默认就一行的高度。
//        _normalBtn.titleLabel.numberOfLines = 1;
        //textAlignment属性控制无效，应该使用buttuon的contentHorizontalAlignment属性控制对齐方式
//        _normalBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _normalBtn;
}

@end
