//
//  UILabel_Demo.m
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/22.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import "UILabel_Demo.h"
#import "ExtensibleLabel.h"

@interface UILabel_Demo ()

@property (nonatomic,strong) ExtensibleLabel *extensibleLabel;

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
    [self addSubview:self.extensibleLabel];
    [self setupMasonry];
}

- (void)setupMasonry {
    if (self.extensibleLabel.superview) {
        [self.extensibleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(10);
            make.right.lessThanOrEqualTo(self).offset(-10);
        }];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"点击了UILabel_Demo");
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

@end
