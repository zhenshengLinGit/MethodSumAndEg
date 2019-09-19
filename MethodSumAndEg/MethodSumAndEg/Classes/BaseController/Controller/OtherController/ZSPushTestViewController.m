//
//  ZSPushTestViewController.m
//  MethodSumAndEg
//
//  Created by 80263956 on 2019/8/30.
//  Copyright © 2019 zhenshenglin. All rights reserved.
//

#import "ZSPushTestViewController.h"
#import "ZSPushTestTwoViewController.h"

@interface ZSPushTestViewController () 

@end

@implementation ZSPushTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pushButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerNavigationBarHidden];
    self.view.backgroundColor = UIColor.cyanColor;
}

- (void)pushButton {
    ZSPushTestTwoViewController *push = [[ZSPushTestTwoViewController alloc] init];
    [self.navigationController pushViewController:push animated:true];
}

@end
