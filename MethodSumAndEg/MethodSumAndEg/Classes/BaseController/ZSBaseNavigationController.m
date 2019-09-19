//
//  ZSBaseNavigationController.m
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/2.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import "ZSBaseNavigationController.h"

@interface ZSBaseNavigationController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *fullScreenPopGestureRecorgnizer;

@end

@implementation ZSBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addFullScreenPopGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addFullScreenPopGesture {
    self.interactivePopGestureRecognizer.enabled = NO;
    id target = self.interactivePopGestureRecognizer.delegate;
    self.fullScreenPopGestureRecorgnizer = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:self.fullScreenPopGestureRecorgnizer];
    self.fullScreenPopGestureRecorgnizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.fullScreenPopGestureRecorgnizer) {
        if (self.viewControllers.count <= 1) {
            return NO;
        }
        CGPoint velocity = [self.fullScreenPopGestureRecorgnizer velocityInView:self.view];
        if (velocity.x <= 0) {
            return NO;
        }
    }
    return YES;
}
@end
