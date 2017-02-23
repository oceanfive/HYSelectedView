//
//  HYSelectedView.h
//  HaiZiGuoParents
//
//  Created by wuhaiyang on 2016/12/29.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//  自定义筛选控件

#import <UIKit/UIKit.h>

@class HYSelectedView, HYSelectedButton;

@protocol HYSelectedViewDelegate <NSObject>

@optional

/**
 选中数据的时候调用的代理方法
 
 @param hyView hyView
 @param result 数据，titles中的每一个元素作为key值，value值为选中的某一个具体的数据
 */
- (void)hySelectedView:(nullable HYSelectedView * )hyView result:(nullable NSDictionary *)result;

@end

@interface HYSelectedView : UIView

/**
 初始化方法
 
 @param frame frame
 @param titles 数组，内部放着显示的title
 @param dict 数据源，titles中的每一个元素作为key值，对应的数组数据源为value值
 @return HYSelectedView
 
 例子：
 - (HYSelectedView *)selectedView{
    if (!_selectedView) {
        NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
        [dataDict setValue:@[@"全部", @"北京市"] forKey:@"城市"];
        [dataDict setValue:@[@"全部", @"分类1"]  forKey:@"分类"];
        [dataDict setValue:@[@"默认", @"从高到低", @"从低到高"] forKey:@"销量"];
        _selectedView = [[HYSelectedView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)  titles:@[@"城市", @"分类", @"销量"] dataDict:dataDict];
        _selectedView.hySelectedViewDelegate = self;
        [self.view addSubview:_selectedView];
    }
    return _selectedView;
 }
 
 注意点：
 1、此控件不要放在tableview的header使用，否则数据在传递的时候会产生错误
 2、view的添加顺序：此控件需要最后添加，保证显示在“最上面”，否则可能出现被其他view遮挡的情况；也有可能产生tableview滚动的时候此控件不会“消失”的bug
 
 */
- (nullable instancetype)initWithFrame:(CGRect)frame titles:(nullable NSArray *)titles dataDict:(nullable NSMutableDictionary *)dict;

/**
 代理
 */
@property (nonatomic, weak, nullable) id<HYSelectedViewDelegate> hySelectedViewDelegate;

/**
 选中的数据信息，数据也可以通过代理方法获得
 ps: titles中的每一个元素作为key值，value值为选中的某一个具体的数据
 */
@property (nonatomic, strong, nullable) NSDictionary *resultDict;

/**
 上部分筛选工具条的高度，默认为40.0f
 */
@property (nonatomic, assign) CGFloat toolBarHeight;

/**
 显示的tableview的高度，默认为200.0f
 */
@property (nonatomic, assign) CGFloat tableViewHeight;

/**
 tableview每一行cell的高度，默认为40.0f
 */
@property (nonatomic, assign) CGFloat cellHeight;

/**
 tableview的cell中的文字颜色---普通状态下
 */
@property (nonatomic, strong, nullable) UIColor *normalTitleColor;

/**
 tableview的cell中的文字颜色---选中状态下
 */
@property (nonatomic, strong, nullable) UIColor *selectedTitleColor;

/**
 tableview分割线的颜色
 */
@property (nonatomic, strong, nullable) UIColor *lineColor;

@end
