//
//  ZSSecondVC.m
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/2.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import "ZSSecondVC.h"
#import "UILabel_Demo.h"
#import "UIButton_Demo.h"
#import "ScrollView_Demo.h"

@interface ZSSecondVC ()

@property (nonatomic,strong) UILabel_Demo *label_Demo;
@property (nonatomic,strong) UIButton_Demo *button_Demo;
@property (nonatomic,strong) ScrollView_Demo *scrollView_Demo;

@end

@implementation ZSSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // ps：这个时候self.view的frame才会被确定下来，viewDidLoad时的frame是不准确的
    NSLog(@"view的frame = %@", NSStringFromCGRect(self.view.frame));
}

- (void)createUI {
//    [self.view addSubview:self.label_Demo];
//    [self.view addSubview:self.button_Demo];
    [self.view addSubview:self.scrollView_Demo];
    
    [self setupMasonry];
}

- (void)setupMasonry {
    if (self.label_Demo.superview) {
        [self.label_Demo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    if (self.button_Demo.superview) {
        [self.button_Demo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    if (self.scrollView_Demo.superview) {
        [self.scrollView_Demo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}

-(UILabel_Demo *)label_Demo {
    if (!_label_Demo) {
        _label_Demo = [[UILabel_Demo alloc] init];
    }
    return _label_Demo;
}

-(UIButton_Demo *)button_Demo {
    if (!_button_Demo) {
        _button_Demo = [[UIButton_Demo alloc] init];
    }
    return _button_Demo;
}

-(ScrollView_Demo *)scrollView_Demo {
    if (!_scrollView_Demo) {
        _scrollView_Demo = [[ScrollView_Demo alloc] init];
    }
    return _scrollView_Demo;
}

@end
