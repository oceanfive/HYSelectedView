//
//  HYSelectedButton.h
//  HYKit
//
//  Created by wuhaiyang on 2016/12/29.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//  筛选的选中按钮，---自定义按钮容器

#import <UIKit/UIKit.h>

@class HYSelectedButton;
@protocol HYSelectedButtonDelegate <NSObject>

@optional

/**
 点击筛选按钮的时候调用的代理方法
 
 @param hyButton HYSelectedButton
 
 ps：通过这个代理方法可以知道HYSelectedButton按钮的点击情况，选中or未选中
 
 */
- (void)hySelectedButton:(nullable HYSelectedButton * )hyButton;

@end


@interface HYSelectedButton : UIView

@property (nonatomic, weak, nullable) id<HYSelectedButtonDelegate> hySelectedButtonDelegate;

@property (nonatomic, copy, nullable) NSString *normalTitle; //普通状态下文字
@property (nonatomic, copy, nullable) NSString *selectedTitle; //选中状态下文字

@property (nonatomic, strong, nullable) UIColor *normalTitleColor; //普通状态下文字颜色
@property (nonatomic, strong, nullable) UIColor *selectedTitleColor; //选中状态下文字颜色

@property (nonatomic, strong, nullable) UIImage *normalImage; //普通状态下图片
@property (nonatomic, strong, nullable) UIImage *selectedImage; //选中状态下图片

@property (nonatomic, strong, nullable) UIFont *labelFont; //title文字字体， 默认 14.0f

@property (nonatomic, assign) CGFloat bottomHeight; // 底部的“横线”高度 , 默认 1.0f
@property (nonatomic, assign) CGFloat rightWidth; //右侧的“竖线”宽度，默认为1.0f

@property (nonatomic, strong, nullable) UIColor *normalBottomColor; //底部的“横线”普通状态下的颜色 ，默认 237 - 238 - 238
@property (nonatomic, strong, nullable) UIColor *selectedBottomColor; //底部的“横线”选中状态下的颜色 ，默认  106 - 183 -252

/**
 通过这个属性可以知道当前的button是否处于选中状态，也是传递的媒介
 UIButton ----- HYSelectedButton ----- HYSelectedView
 
 */
@property (nonatomic, assign) BOOL selected;


@end
