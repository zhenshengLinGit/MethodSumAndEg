//
//  ZSTabBarController.m
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/2.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import "ZSTabBarController.h"

@interface ZSTabBarController ()

@end

@implementation ZSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTabMenu];
}

- (void)createTabMenu {
    NSMutableArray *viewControllers = [NSMutableArray array];
    NSArray *vcArr = [NSArray arrayWithObjects:
                      [[ZSFirstVC alloc] init],
                      [[ZSSecondVC alloc] init],
                      [[ZSThirtVC alloc] init],
                      [[ZSFourthVC alloc] init],
                      [[ZSFirstVC alloc] init],
                      nil];
    NSArray *imageArr = [NSArray arrayWithObjects:
                      [UIImage imageNamed:@"tab_1"],
                      [UIImage imageNamed:@"tab_2"],
                      [UIImage imageNamed:@"tab_3"],
                      [UIImage imageNamed:@"tab_4"],
                      [UIImage imageNamed:@"tab_5"],
                      nil];
    NSArray *selectedImageArr = [NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"tab_1_pre"],
                                 [UIImage imageNamed:@"tab_2_pre"],
                                 [UIImage imageNamed:@"tab_3_pre"],
                                 [UIImage imageNamed:@"tab_4_pre"],
                                 [UIImage imageNamed:@"tab_5_pre"],
                                 nil];
    NSArray *titlesArray=[[NSArray alloc] initWithObjects:@"AA",@"BB",@"CC", @"DD",@"EE",nil];
    for (NSInteger i = 0; i < vcArr.count; i++) {
        ZSBaseNavigationController *navVc = [[ZSBaseNavigationController alloc] initWithRootViewController:[vcArr objectAtIndex:i]];
        navVc.tabBarItem.image = imageArr[i];
        navVc.tabBarItem.selectedImage = selectedImageArr[i];
        navVc.tabBarItem.title = titlesArray[i];
        [viewControllers addObject:navVc];
    }
    self.viewControllers = viewControllers;
}

@end
