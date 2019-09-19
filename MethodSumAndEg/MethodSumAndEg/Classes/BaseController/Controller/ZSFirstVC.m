//
//  ZSFirstVC.m
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/2.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import "ZSFirstVC.h"
#import "ZSPushTestViewController.h"

@interface ZSFirstVC ()

@end

@implementation ZSFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if (self.navigationController.navigationBar.hidden == true) {
//        [self.navigationController setNavigationBarHidden:NO animated:NO];
//    }
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self createBorderView];
    ZSPushTestViewController *pushVC = [[ZSPushTestViewController alloc] init];
    [self.navigationController pushViewController:pushVC animated:true];
}

// 自定义view的单个边框和圆角
- (void)createBorderView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *borderView = [[UIView alloc] init];
    borderView.frame = CGRectMake(1, 1, 300, 100);
    [borderView addBorderWithColor:[UIColor blackColor] andWidth:1 andPostion:POSITIONAll];
    borderView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:borderView];
    
    UIView *borderCornerView = [[UIView alloc] init];
    borderCornerView.frame = CGRectMake(1, 120, 300, 100);
    [borderCornerView addBorderWithColor:[UIColor blackColor] andWidth:4 andPostion:TOP|LEFT|RIGHT|BOTTOM corners:UIRectCornerAllCorners radius:2];
    borderCornerView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:borderCornerView];
}

@end
