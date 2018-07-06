//
//  UITextField_Demo.m
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/23.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import "UITextField_Demo.h"

@interface UITextField_Demo () <
UITextFieldDelegate
>

@property (nonatomic,strong) UITextField *normalTextField;

@end

@implementation UITextField_Demo

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.normalTextField];
    
    [self setupMasonry];
}

- (void)setupMasonry {
    if (self.normalTextField.superview) {
        [self.normalTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.height.mas_equalTo(kScaleLen(99));
        }];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"点击了UITextField_Demo");
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //这里返回NO，使textField不弹出键盘。此时可以做其他响应，如弹出pickerView选择器
    return NO;
}

#pragma mark - lazy load
-(UITextField *)normalTextField {
    if (!_normalTextField) {
        _normalTextField = [[UITextField alloc] init];
        _normalTextField.backgroundColor = [UIColor whiteColor];
        _normalTextField.font = KMiddleFontSize(kScaleLen(42));
        _normalTextField.textColor = [UIColor colorWithHexString:@"#3a3a3a"];
        _normalTextField.placeholder = @"个";
        _normalTextField.layer.borderWidth = KBorderLineWidth;
        _normalTextField.layer.borderColor = [UIColor colorWithHexString:@"#dadada"].CGColor;
        _normalTextField.delegate = self;
        //设置左边占位符
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScaleLen(24), kScaleLen(99))];
        _normalTextField.leftView = leftView;
        _normalTextField.leftViewMode = UITextFieldViewModeAlways;
        //设置右边占位符
        UIImage *image = [UIImage imageNamed:@"product_add_type"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, (kScaleLen(99)-image.size.height)/2, image.size.width, image.size.height);
        _normalTextField.rightView = imageView;
        _normalTextField.rightViewMode = UITextFieldViewModeAlways;
        
        //设置光标在右边输入
        _normalTextField.textAlignment = NSTextAlignmentRight;
    }
    return _normalTextField;
}

@end
