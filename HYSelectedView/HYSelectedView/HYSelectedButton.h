//
//  HYSelectedButton.h
//  HaiZiGuoParents
//
//  Created by wuhaiyang on 2016/12/29.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//  搜索的选中按钮，---自定义按钮容器

#import <UIKit/UIKit.h>

@class HYSelectedButton;

@protocol HYSelectedButtonDelegate <NSObject>

@optional

/**
 选中的时候调用的方法
 
 @param hyButton HYSelectedButton
 */
- (void)hySelectedButton:(nullable HYSelectedButton * )hyButton;

@end

@interface HYSelectedButton : UIView

@property (nonatomic, weak, nullable) id<HYSelectedButtonDelegate> hySelectedButtonDelegate;

@property (nonatomic, copy, nullable) NSString *normalTitle;
@property (nonatomic, copy, nullable) NSString *selectedTitle;

@property (nonatomic, strong, nullable) UIColor *normalTitleColor;
@property (nonatomic, strong, nullable) UIColor *selectedTitleColor;

@property (nonatomic, strong, nullable) UIImage *normalImage;
@property (nonatomic, strong, nullable) UIImage *selectedImage;

@property (nonatomic, strong, nullable) UIFont *labelFont; // 默认 14.0

@property (nonatomic, assign) CGFloat bottomHeight; // 底部的“横线”高度 , 默认 1.0f
@property (nonatomic, assign) CGFloat rightWidth; //右侧的“竖线”宽度，默认为1.0f
@property (nonatomic, strong, nullable) UIColor *normalBottomColor; //底部的“横线”颜色 ，默认 237 - 238 - 238
@property (nonatomic, strong, nullable) UIColor *selectedBottomColor; //底部的“横线”颜色 ，默认  106 - 183 -252

/**
 通过这个属性可以知道当前的button是否处于选中状态，也是传递的媒介
 UIButton ----- HYSelectedButton ----- HYSelectedView
 
 */
@property (nonatomic, assign) BOOL selected;

@end
