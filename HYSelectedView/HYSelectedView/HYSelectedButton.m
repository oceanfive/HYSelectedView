//
//  HYSelectedButton.h
//  HYKit
//
//  Created by wuhaiyang on 2016/12/29.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//  HYSelectedButton = button + UILabel + UIImageView + UIView + UIView;

#import "HYSelectedButton.h"

@interface HYSelectedButton ()

@property (nonatomic, strong) UIButton *button;  //内部封装的button，知道button的状态，是否选中
@property (nonatomic, strong) UILabel *myLabel; //title
@property (nonatomic, strong) UIImageView *myImageView; //图片
@property (nonatomic, strong) UIView *bottomView; //底部“线”
@property (nonatomic, strong) UIView *rightView; //右侧"线"

@end


@implementation HYSelectedButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
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
    self.myLabel.textAlignment = NSTextAlignmentRight;
    self.myLabel.numberOfLines = 0;
    self.myLabel.textColor = self.button.selected?self.selectedTitleColor:self.normalTitleColor;
    self.myLabel.text = self.button.selected?self.selectedTitle:self.normalTitle;
    [self addSubview:self.myLabel];
    
    self.myImageView = [[UIImageView alloc] init];
    self.myImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.myImageView.image = self.button.selected?self.selectedImage:self.normalImage;
    [self addSubview:self.myImageView];
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = self.button.selected?self.selectedBottomColor:self.normalBottomColor;
    [self addSubview:self.bottomView];
    
    self.rightView = [[UIView alloc] init];
    self.rightView.backgroundColor = self.normalBottomColor;
    [self addSubview:self.rightView];
    
    self.bottomHeight = 1.0f;
    self.rightWidth = 1.0f;
    self.backgroundColor = [UIColor whiteColor];
}


#pragma mark - getter

- (UIFont *)labelFont{
    if (!_labelFont) {
        _labelFont = [UIFont systemFontOfSize:14.0];
    }
    return _labelFont;
}

- (UIImage *)normalImage{
    if (!_normalImage) {
        _normalImage = [UIImage imageNamed:@"向上_03"];
    }
    return _normalImage;
}

- (UIImage *)selectedImage{
    if (!_selectedImage) {
        _selectedImage = [UIImage imageNamed:@"向下_03"];
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
    if (self.selectedTitle.length==0) {  //设置普通状态下时，如果选中未设置，则同时设置选中状态下的文字
        self.selectedTitle = normalTitle;
    }
    self.myLabel.text = self.button.selected?self.selectedTitle:self.normalTitle;
}

- (void)setSelectedTitle:(NSString *)selectedTitle{
    _selectedTitle = selectedTitle;
    self.myLabel.text = self.button.selected?self.selectedTitle:self.normalTitle;
}


#pragma mark - 布局

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.button.frame = self.bounds;
    
    CGRect bounds = self.bounds;
    bounds.size.width *= 0.5;
    self.myLabel.frame = bounds;
    
    CGFloat rheight = 5.0f; //右侧箭头高度
    CGFloat rwidth = 5.0f;  //右侧箭头宽度
    self.myImageView.frame = CGRectMake(self.bounds.size.width/2+5.0f, (self.bounds.size.height-rheight)/2, rwidth, rheight);
    
    self.bottomView.frame = CGRectMake(0, self.frame.size.height-self.bottomHeight, self.frame.size.width, self.bottomHeight);
    
    CGFloat margin = 5.0f;
    self.rightView.frame = CGRectMake(self.bounds.size.width-self.rightWidth, margin, self.rightWidth, self.bounds.size.height - 2*margin);
    
}


/**
 按钮点击事件
 */
- (void)buttonClick:(UIButton *)button{
    self.button.selected = !self.button.selected;  //选中和普通状态进行切换
    self.selected = self.button.selected;   //设置是否选中，HYSelectedButton 为媒介，需要设置
    self.bottomView.backgroundColor = self.button.selected?self.selectedBottomColor:self.normalBottomColor;
    self.myImageView.image = self.button.selected?self.selectedImage:self.normalImage;
    self.myLabel.text = self.button.selected?self.selectedTitle:self.normalTitle;
    self.myLabel.textColor = self.button.selected?self.selectedTitleColor:self.normalTitleColor;
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
    self.bottomView.backgroundColor = self.button.selected?self.selectedBottomColor:self.normalBottomColor;
    self.myImageView.image = self.button.selected?self.selectedImage:self.normalImage;
    self.myLabel.text = self.button.selected?self.selectedTitle:self.normalTitle;
    self.myLabel.textColor = self.button.selected?self.selectedTitleColor:self.normalTitleColor;
}

/**
 getter -----
 
 */
- (BOOL)isSelected{
    return self.button.selected;
}

@end
