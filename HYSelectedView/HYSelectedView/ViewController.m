//
//  ViewController.m
//  HYSelectedView
//
//  Created by wuhaiyang on 2017/1/19.
//  Copyright © 2017年 wuhaiyang. All rights reserved.
//

#import "ViewController.h"
#import "HYSelectedView.h"

@interface ViewController ()<HYSelectedViewDelegate>

@property (nonatomic, strong) HYSelectedView *selectedView;

@end

@implementation ViewController

#pragma mark - lazy
- (HYSelectedView *)selectedView{
    if (!_selectedView) {
        NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
        [dataDict setValue:@[@"全部", @"北京市", @"上海市", @"天津市", @"深圳市", @"广州市"] forKey:@"城市"];
        [dataDict setValue:@[@"全部", @"分类1", @"分类2", @"分类3", @"分类4"]  forKey:@"分类"];
        [dataDict setValue:@[@"默认", @"从高到低", @"从低到高"] forKey:@"销量"];
        _selectedView = [[HYSelectedView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 40)  titles:@[@"城市", @"分类", @"销量"] dataDict:dataDict];
        _selectedView.hySelectedViewDelegate = self;
        [self.view addSubview:_selectedView];
    }
    return _selectedView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"筛选控件";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initColor];

}


- (void)initColor{
    self.selectedView.backgroundColor = [UIColor clearColor];
}


#pragma mark - HYSelectedViewDelegate

- (void)hySelectedView:(HYSelectedView *)hyView result:(NSDictionary *)result{
    NSLog(@"筛选结果为：%@", result);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
