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

- (void)createUI {
//    [self.view addSubview:self.label_Demo];
    [self.view addSubview:self.button_Demo];
//    [self.view addSubview:self.scrollView_Demo];
}

-(UILabel_Demo *)label_Demo {
    if (!_label_Demo) {
        _label_Demo = [[UILabel_Demo alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    }
    return _label_Demo;
}

-(UIButton_Demo *)button_Demo {
    if (!_button_Demo) {
        _button_Demo = [[UIButton_Demo alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    }
    return _button_Demo;
}

-(ScrollView_Demo *)scrollView_Demo {
    if (!_scrollView_Demo) {
        _scrollView_Demo = [[ScrollView_Demo alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    }
    return _scrollView_Demo;
}

@end
