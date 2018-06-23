//
//  ScrollView_Demo.m
//  MethodSumAndEg
//
//  Created by zhenshenglin on 2018/6/22.
//  Copyright © 2018年 zhenshenglin. All rights reserved.
//

#import "ScrollView_Demo.h"
#define secsionCount 6

#pragma mark ----------------------- DynamicHScrollView  -----------------------
// 高度动态变化的scrollview演示
@interface DynamicHScrollView : UIView

#pragma mark - scollView高度可以动态变化时的规范写法
/*
 1、由于scrollview高度不确定，所以需要通过子控件的内容来确定高度。
 2、scrollView增加一个容器view，其他子view全部添加在容器view里边，这样就可以通过依赖容器view更方便的动态更改scrollView的高度
 */
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *scrollContainerV;
@property (nonatomic,strong) UILabel *contentLabel;

// 中间区域能够滚动的最大高度 - 不设置的话，默认为内容的高度
@property (nonatomic,assign) CGFloat maxScrollH;
// 改变了内容后，scrollview高度动态变化
@property (nonatomic,copy) NSString *content;

@end


#pragma mark ----------------------- ScrollView_Demo  -----------------------
@interface ScrollView_Demo () <
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic,strong) NSMutableString *content;
@property (nonatomic,strong) UITableView *normalTableView;
@property (nonatomic,strong) DynamicHScrollView *dynamicHScrollView;

@end

@implementation ScrollView_Demo

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.content = [NSMutableString stringWithString:KNormalStr];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:self.normalTableView];
    [self addSubview:self.dynamicHScrollView];
    [self setupMasonry];
}

- (void)setupMasonry {
    if (self.normalTableView.superview) {
        [self.normalTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    if (self.dynamicHScrollView.superview) {
        [self.dynamicHScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(100);
            make.right.equalTo(self).offset(-100);
            make.height.mas_equalTo(400);
        }];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"点击了ScrollView_Demo");
    
    [self.content appendString:KNormalStr];
    self.dynamicHScrollView.content = self.content;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return secsionCount;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd-%zd", indexPath.section, indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 这个属性只能控制cell之间的分割线
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 100, 0, 0);
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:edgeInsets];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:edgeInsets];
    }
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20+section*5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *view = [[UILabel alloc] init];
//    view.text = @"这是组头";
    view.backgroundColor = [UIColor yellowColor];
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UILabel *view = [[UILabel alloc] init];
    view.text = @"这是组尾";
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark - lazy load
-(UITableView *)normalTableView {
    if (!_normalTableView) {
        _normalTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _normalTableView.delegate = self;
        _normalTableView.dataSource = self;
        _normalTableView.separatorColor = [UIColor redColor];
        //控制分割线的间距，注意只能控制cell之间的分割线，而不能控制grouped样式的section上下两边的分割线（暂时无法找到可以控制的方法）。
        _normalTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _normalTableView.separatorInset = UIEdgeInsetsZero;
        _normalTableView.layoutMargins = UIEdgeInsetsZero;
        #pragma mark - tableview的规范写法
        /* PS:iOS11之后，tableview的规范写法，同时兼容iOS10（如果不规范，可能会造成顶部底部，组组间距莫名留白的问题）
         1、同时设置三个属性为0：
             estimatedRowHeight、
             estimatedSectionHeaderHeight、
             estimatedSectionFooterHeight
         2、同时实现四个代理方法：
             heightForHeaderInSection、
             heightForFooterInSection、
             viewForHeaderInSection、
             viewForFooterInSection
         */
        _normalTableView.estimatedRowHeight = 0;
        _normalTableView.estimatedSectionHeaderHeight = 0;
        _normalTableView.estimatedSectionFooterHeight = 0;
    }
    return _normalTableView;
}

-(DynamicHScrollView *)dynamicHScrollView {
    if (!_dynamicHScrollView) {
        _dynamicHScrollView = [[DynamicHScrollView alloc] init];
        _dynamicHScrollView.content = self.content;
        _dynamicHScrollView.maxScrollH = 200;
    }
    return _dynamicHScrollView;
}

@end


@implementation DynamicHScrollView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.maxScrollH = CGFLOAT_MAX;
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.scrollContainerV];
    [self.scrollContainerV addSubview:self.contentLabel];
    
    [self setupMasonry];
}

- (void)setupMasonry {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
    }];
    [self.scrollContainerV mas_makeConstraints:^(MASConstraintMaker *make) {
        // 由于约束的是scrollview，所以还需要给定width，才能确定出scrollview的contentSize的宽度
        // 以下约束代表：contentSize的宽度 = 0 + self.scrollView.width + 0
        make.left.right.width.equalTo(self.scrollView);
        // 以下约束代表：contentSize的高度 = 0 + 内容的高度 + 0
        make.top.bottom.equalTo(self.scrollView);
        make.bottom.equalTo(self.contentLabel);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.scrollContainerV);
    }];
    // 此时，scrollview的contentSize都已经约束好了，而且width也确定了，唯一未知的就是height。故更新height即可
}

-(void)setContent:(NSString *)content {
    _content = content;
    self.contentLabel.text = content;
    if (self.maxScrollH == CGFLOAT_MAX) {
        [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            //依赖子控件的高度
            make.height.equalTo(self.scrollContainerV);
        }];
    } else {
        [self layoutIfNeeded];
        CGFloat updateH = self.scrollContainerV.bottom;
        updateH = updateH <= self.maxScrollH ? updateH : self.maxScrollH;
        [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            //固定高度
            make.height.mas_equalTo(updateH);
        }];
        
//        // 错误示范1:使用mas_lessThanOrEqualTo约束后，会将scrollview的contentSize的高度确定，从而影响了容器view，影响了Label的高度
//        [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.equalTo(self);
//            make.height.equalTo(self.scrollContainerV);
//            make.height.mas_lessThanOrEqualTo(self.maxScrollH);
//        }];
        // 错误示范2：使用bottom约束的话，只会确定contentSize，对scrollview本身的高度无法确定，计算的高度会错乱
//        [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.equalTo(self);
//            make.bottom.mas_equalTo(self.scrollContainerV.mas_bottom);
//        }];
    }
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor cyanColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

-(UIView *)scrollContainerV {
    if (!_scrollContainerV) {
        _scrollContainerV = [[UIView alloc] init];
    }
    return _scrollContainerV;
}

-(UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor colorWithHexString:@"#3a3a3a"];
        _contentLabel.font = KMiddleFontSize(kScaleLen(42));
    }
    return _contentLabel;
}

@end


