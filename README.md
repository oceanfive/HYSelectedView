# 自定义筛选控件HYSelectedView
# 一、前言：
#### 此控件为一个筛选控件，实现了筛选控件的基本功能。
# 二、效果图
[![筛选控件效果图](http://ok0lwc348.bkt.clouddn.com/%E7%AD%9B%E9%80%89%E6%8E%A7%E4%BB%B6.png "筛选控件效果图")](http://ok0lwc348.bkt.clouddn.com/%E7%AD%9B%E9%80%89%E6%8E%A7%E4%BB%B6.png "筛选控件效果图")
# 三、使用：
###   1、调用初始化方法：
   `- (nullable instancetype)initWithFrame:(CGRect)frame titles:(nullable NSArray *)titles dataDict:(nullable NSMutableDictionary *)dict;`
   
   备注： 
   @param frame frame
   @param titles 数组，内部放着显示的title
   @param dict 数据源，titles中的每一个元素作为key值，对应的数组数据源为value值

###   2、设置代理：
   `@property (nonatomic, weak, nullable) id<HYSelectedViewDelegate> hySelectedViewDelegate;`
   
###   3、实现代理方法：
   `- (void)hySelectedView:(nullable HYSelectedView * )hyView result:(nullable NSDictionary *)result;`
   
   备注： 
   选中数据的时候调用的代理方法
   @param hyView hyView
   @param result 数据，titles中的每一个元素作为key值，value值为选中的某一个具体的数据
   
   
# 四、代码：
[GitHub代码链接](https://github.com/oceanfive/HYSelectedView.git "github代码地址")
