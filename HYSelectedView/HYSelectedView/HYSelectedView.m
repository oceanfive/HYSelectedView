//
//  HYSelectedView.h
//  HYKit
//
//  Created by wuhaiyang on 2016/12/29.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//

#import "HYSelectedView.h"
#import "HYSelectedButton.h"

#define kTagBae 100 // HYSelectedButton tag标签基数
#define kTagTableViewBase 200 // UITableView tag标签基数
#define kTagCellLabel 10


@interface HYSelectedView ()<HYSelectedButtonDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *toolBar; //上部分容器
@property (nonatomic, strong) UIView *bottomView; //下部分容器
@property (nonatomic, strong) UIView *coverView; //遮罩view,解决手势冲突
@property (nonatomic, strong) NSArray *titles; //titles显示数组,有序的,可以通过这个属性配合tag基数值渠道所有的控件
@property (nonatomic, strong) NSMutableDictionary *dataDict; //每一个title对应的数据
@property (nonatomic, strong) NSMutableDictionary *tempDict; //暂存数据源
@property (nonatomic, assign) CGFloat allHeight; //self本身的高度，全部展示的时候
@property (nonatomic, strong) NSIndexPath *selIndexPath; //当前选中的indexPath,默认选中第0组第0行

@end


@implementation HYSelectedView

#pragma mark - getter
- (NSMutableDictionary *)tempDict{
    if (!_tempDict) {
        _tempDict = [NSMutableDictionary dictionary];
    }
    return _tempDict;
}

- (UIColor *)normalTitleColor{
    if (!_normalTitleColor) {
        _normalTitleColor = [UIColor blackColor];
    }
    return _normalTitleColor;
}

- (UIColor *)selectedTitleColor{
    if (!_selectedTitleColor) {
        _selectedTitleColor = [UIColor colorWithRed:106/255.0f green:183/255.0f blue:252/255.0f alpha:1.0f];
    }
    return _selectedTitleColor;
}

- (UIColor *)lineColor{
    if (!_lineColor) {
        _lineColor = [UIColor colorWithRed:237/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    }
    return _lineColor;
}


- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles dataDict:(NSMutableDictionary *)dict{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor]; //不会遮挡后面父控件的显示的内容，形成“透明效果”
        self.userInteractionEnabled = YES;
        
        self.titles = titles;
        self.dataDict = dict;
        
        self.toolBar = [[UIView alloc] init];
        self.toolBar.backgroundColor = [UIColor clearColor];
        [self addSubview:self.toolBar];
        
        self.bottomView = [[UIView alloc] init];
        self.bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.bottomView.userInteractionEnabled = YES;
        [self addSubview:self.bottomView];
        
        //解决手势冲突，手势直接加载self或者self.bottomView身上会产生手势冲突
        self.coverView = [[UIView alloc] init];
        self.coverView.backgroundColor = [UIColor clearColor];
        self.coverView.userInteractionEnabled = YES;
        [self.bottomView addSubview:self.coverView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [self.coverView addGestureRecognizer:tap];
        
        for (int i = 0; i < self.titles.count; i++) {
            
            HYSelectedButton *button = [[HYSelectedButton alloc] init];
            button.normalTitle = self.titles[i];
            button.tag = kTagBae + i;
            button.hySelectedButtonDelegate = self;
            button.backgroundColor = [UIColor whiteColor];
            [self.toolBar addSubview:button];
            
            UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.tag = i + kTagTableViewBase;
            tableView.alwaysBounceVertical = NO;
            tableView.alwaysBounceHorizontal = NO;
            tableView.backgroundColor = [UIColor whiteColor];
            tableView.userInteractionEnabled = YES;
            tableView.bounces = NO;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self.bottomView addSubview:tableView];
            
        }
        
        self.toolBarHeight = 40.0f;
        self.tableViewHeight = 200.0f;
        self.cellHeight = 40.0f;
        self.allHeight = [[UIScreen mainScreen] bounds].size.height - 64.0f;
        self.selIndexPath = [NSIndexPath indexPathForRow:0 inSection:0]; //默认选中第0组第0行
        
    }
    return self;
}

#pragma mark - 布局

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    bounds.size.height = self.toolBarHeight;
    self.toolBar.frame = bounds;
    
    self.bottomView.frame = CGRectMake(0, CGRectGetHeight(self.toolBar.frame), self.toolBar.frame.size.width, self.bounds.size.height-self.toolBar.frame.size.height);
    
    self.coverView.frame = CGRectMake(0, self.tableViewHeight, self.bottomView.frame.size.width, self.bottomView.frame.size.height - self.tableViewHeight);
    
    CGFloat width = self.toolBar.frame.size.width/self.titles.count; //每一个HYSelectedButton的宽度
    
    for (int i = 0; i < self.titles.count; i++) {
        HYSelectedButton *button = [self viewWithTag:i + kTagBae];
        button.frame = CGRectMake(i * width, 0, width, self.toolBar.frame.size.height);
        
        UITableView *tableView = [self viewWithTag:i + kTagTableViewBase];
        tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bottomView.frame), self.tableViewHeight);
        tableView.hidden = button.selected?NO:YES; //HYSelectedButton默认是未选中，隐藏状态的
    }
    
}


#pragma mark - HYSelectedButtonDelegate
- (void)hySelectedButton:(HYSelectedButton *)hyButton{
    for (int i = 0; i < self.titles.count; i++) {
        NSInteger selectedBtnTag = i + kTagBae;
        HYSelectedButton *button = [self viewWithTag:selectedBtnTag];
        if (hyButton.tag != button.tag) {  //把其他的HYSelectedButton设置为未选中状态
            button.selected = NO;
        }
        NSInteger tableTag = i + kTagTableViewBase;
        UITableView *tableView = [self viewWithTag:tableTag];
        tableView.hidden = button.selected?NO:YES; //把其他的tableview设置为隐藏状态，“自己的”根据selected是否隐藏
    }
    [self refreshLayout:hyButton]; //重新设置本身frame，否则下部分容器无法显示，（子控件超过父控件的部分无法显示）
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *key = self.titles[tableView.tag-kTagTableViewBase];
    NSArray *value = [self.dataDict valueForKey:key];
    return value.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        //        label.textColor = self.normalTitleColor;
        label.font = [UIFont systemFontOfSize:12.0];
        CGRect bounds = cell.contentView.bounds;
        bounds.origin.x += 15;
        //        bounds.size.width /= 3;
        label.frame = bounds;
        label.tag = kTagCellLabel;
        label.userInteractionEnabled = YES;
        [cell.contentView addSubview:label];
        
    }
    //解决滚动过程“分割线”会消失的bug，先移除操作
    UIView *view = [cell viewWithTag:123];
    [view removeFromSuperview];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.tag = 123;
    CGFloat margin = 5.0f;
    lineView.frame = CGRectMake(margin, cell.bounds.size.height-1.0f, [[UIScreen mainScreen] bounds].size.width - 2 * margin, 1.0f);
    lineView.backgroundColor = self.lineColor;
    [cell.contentView addSubview:lineView];
    
    NSString *key = self.titles[tableView.tag-kTagTableViewBase];
    NSArray *value = [self.dataDict valueForKey:key];
    
    UILabel *label = [cell.contentView viewWithTag:kTagCellLabel];
    label.text = value[indexPath.row];
    label.textColor = self.selIndexPath.row==indexPath.row?self.selectedTitleColor:self.normalTitleColor; //解决tableview滚动过程中文字颜色重用的bug
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selIndexPath = indexPath;
    
    NSInteger num = tableView.tag - kTagTableViewBase; //知道点击了哪个tableview以及对应的 num 值
    NSString *key = self.titles[num]; //知道点击的tableview所对应的title
    NSArray *value = [self.dataDict valueForKey:key]; //取出相应的title对应的数据源
    [self.tempDict setValue:value[indexPath.row] forKey:key]; //给临时数据赋值
    
    //获取选中的tableview所对应的行数
    NSInteger number = value.count;
    for (int i = 0; i < number; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
        UILabel *label = [cell.contentView viewWithTag:kTagCellLabel]; //取出每一行的cell中的label控件
        label.textColor = (path.row==indexPath.row)?self.selectedTitleColor:self.normalTitleColor;
    }
    
    //传递数据
    if (_hySelectedViewDelegate && [_hySelectedViewDelegate respondsToSelector:@selector(hySelectedView:result:)]) {
        [_hySelectedViewDelegate hySelectedView:self result:self.tempDict];
    }
    
    HYSelectedButton *button = [self viewWithTag:num + kTagBae]; //把选中的tableview对应的HYSelectedButton设置为未选中状态
    button.selected = NO;
    [self refreshLayout:button]; //刷新布局
}


#pragma mark - getter
- (NSDictionary *)resultDict{
    return self.tempDict;
}


#pragma mark - 重新布局控件 - 可以自己给自己设置frame
- (void)refreshLayout:(HYSelectedButton *)hyButton{
    CGRect rect = self.frame;
    if (hyButton.selected) {
        rect.size.height = self.allHeight;
        self.frame = rect;
    }else {
        rect.size.height = self.toolBarHeight;
        self.frame = rect;
    }
}


#pragma mark - 点击手势
- (void)tapClick:(UITapGestureRecognizer *)gesture{
    [self dismiss];
}


/**
 消失方法
 */
- (void)dismiss{
    for (int i = 0; i < self.titles.count; i++) {
        NSInteger selectedBtnTag = i + kTagBae;
        HYSelectedButton *button = [self viewWithTag:selectedBtnTag];
        button.selected = NO;
        [self refreshLayout:button];
    }
}

@end
