//
//  HYSelectedButton.m
//  HaiZiGuoParents
//
//  Created by wuhaiyang on 2016/12/29.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//  HYSelectedButton = button + myImageView + myLabel + bottomView + rightView;

#import "HYSelectedButton.h"

@interface HYSelectedButton ()

@property (nonatomic, strong) UIButton *button;  //内部封装的button，知道button的状态，是否选中等
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIImageView *myImageView;
@property (nonatomic, strong) UILabel *myLabel;
@property (nonatomic, strong) UIView *rightView;

@end

@implementation HYSelectedButton

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.button.selected = NO;  //默认是未选中状态
    self.selected = self.button.selected; //默认是未选中状态
    [self addSubview:self.button];
    
    self.myLabel = [[UILabel alloc] init];
    self.myLabel.font = self.labelFont;
    self.myLabel.textAlignment = NSTextAlignmentCenter;
    self.myLabel.textColor = self.button.selected ? self.selectedTitleColor : self.normalTitleColor;
    self.myLabel.text = self.button.selected ? self.selectedTitle : self.normalTitle;
    [self addSubview:self.myLabel];
    
    self.myImageView = [[UIImageView alloc] init];
    self.myImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.myImageView.image = self.button.selected ? self.selectedImage : self.normalImage;
    [self addSubview:self.myImageView];
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = self.button.selected ? self.selectedBottomColor : self.normalBottomColor;
    [self addSubview:self.bottomView];
    
    self.rightView = [[UIView alloc] init];
    self.rightView.backgroundColor = self.normalBottomColor;
    [self addSubview:self.rightView];
    
    self.bottomHeight = 1.0f;
    self.rightWidth = 1.0f;
    self.backgroundColor = [UIColor whiteColor];
}

#pragma mark - lazy - getter

- (UIFont *)labelFont{
    if (!_labelFont) {
        _labelFont = [UIFont systemFontOfSize:14.0];
    }
    return _labelFont;
}

- (UIImage *)normalImage{
    if (!_normalImage) {
        _normalImage = [UIImage imageNamed:@"分类筛选_03.png"];
    }
    return _normalImage;
}

- (UIImage *)selectedImage{
    if (!_selectedImage) {
        _selectedImage = [UIImage imageNamed:@"分类筛选三角_03.png"];
    }
    return _selectedImage;
}

- (UIColor *)normalBottomColor{
    if (!_normalBottomColor) {
        _normalBottomColor = [UIColor colorWithRed:237/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    }
    return _normalBottomColor;
}

- (UIColor *)selectedBottomColor{
    if (!_selectedBottomColor) {
        _selectedBottomColor = [UIColor colorWithRed:106/255.0f green:183/255.0f blue:252/255.0f alpha:1.0f];
    }
    return _selectedBottomColor;
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

- (void)setNormalTitle:(NSString *)normalTitle{
    _normalTitle = normalTitle;
    if (self.selectedTitle.length==0) {  //设置普通状态下时，如果选中状态未设置，则同时设置选中状态下的文字
        self.selectedTitle = normalTitle;
    }
    self.myLabel.text = self.button.selected ? self.selectedTitle : self.normalTitle; //给myLabel设置显示文字
}

- (void)setSelectedTitle:(NSString *)selectedTitle{
    _selectedTitle = selectedTitle;
    self.myLabel.text = self.button.selected ? self.selectedTitle : self.normalTitle; //给myLabel设置显示文字
}

#pragma mark - layout

- (void)layoutSubviews{
    [super layoutSubviews];
    self.button.frame = self.bounds;
    self.myLabel.frame = self.bounds;
    CGFloat rheight = 11.0f; //右侧箭头高度
    CGFloat rwidth = 11.0f;  //右侧箭头宽度
    self.myImageView.frame = CGRectMake(self.bounds.size.width - rwidth - 15.0f, (self.bounds.size.height - rheight) / 2, rwidth, rheight);
    self.bottomView.frame = CGRectMake(0, self.frame.size.height - self.bottomHeight, self.frame.size.width, self.bottomHeight);
    CGFloat margin = 5.0f;
    self.rightView.frame = CGRectMake(self.bounds.size.width - self.rightWidth, margin, self.rightWidth, self.bounds.size.height - 2 * margin);
}

/**
 按钮点击事件
 */
- (void)buttonClick:(UIButton *)button{
    self.button.selected = !self.button.selected;
    self.selected = self.button.selected;   //设置是否选中，HYSelectedButton 为媒介，需要设置
    self.bottomView.backgroundColor = self.button.selected ? self.selectedBottomColor : self.normalBottomColor;
    self.myImageView.image = self.button.selected ? self.selectedImage : self.normalImage;
    self.myLabel.text = self.button.selected ? self.selectedTitle : self.normalTitle;
    self.myLabel.textColor = self.button.selected ? self.selectedTitleColor : self.normalTitleColor;
    if ([self.hySelectedButtonDelegate respondsToSelector:@selector(hySelectedButton:)]) {
        [self.hySelectedButtonDelegate hySelectedButton:self];
    }
}

#pragma mark - selected 属性连接着内部的button的selected属性
/**
 setter -----
 人为设置的时候使用
 */
- (void)setSelected:(BOOL)selected{
    _selected = selected;
    self.button.selected = selected;
    self.bottomView.backgroundColor = self.button.selected ? self.selectedBottomColor : self.normalBottomColor;
    self.myImageView.image = self.button.selected ? self.selectedImage : self.normalImage;
    self.myLabel.text = self.button.selected ? self.selectedTitle : self.normalTitle;
    self.myLabel.textColor = self.button.selected ? self.selectedTitleColor : self.normalTitleColor;
}

/**
 getter -----
 */
- (BOOL)isSelected{
    return self.button.selected;
}

@end
