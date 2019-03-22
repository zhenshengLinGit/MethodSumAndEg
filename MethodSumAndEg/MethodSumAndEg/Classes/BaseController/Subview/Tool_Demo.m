//
//  Tool_Demo.m
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/7/18.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import "Tool_Demo.h"
#import "ZSContactsModel.h"
#import "ZSConvenientTool.h"
#import "MJExtension.h"

@implementation Tool_Demo
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor lightGrayColor];
    [self setupMasonry];
}

- (void)setupMasonry {
}

#pragma mark - touches event
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self sortContacts];
}

// 根据联系人的姓名进行排列
- (void)sortContacts {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"contacts" ofType:@"plist"];
    NSArray *dicArr = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *contactsModelArr = [NSMutableArray array];
    for (NSDictionary *dict in dicArr) {
        ZSContactsModel *model = [ZSContactsModel mj_objectWithKeyValues:dict];
        [contactsModelArr addObject:model];
    }
    // 排序后的数组
    NSArray *sortArr = [ZSConvenientTool sortContactAddressWithDataArr:contactsModelArr RealName:@"name" contactsId:@"contactId"];
    NSLog(@"%zd", sortArr.count);
}

#pragma mark - lazy load

@end
