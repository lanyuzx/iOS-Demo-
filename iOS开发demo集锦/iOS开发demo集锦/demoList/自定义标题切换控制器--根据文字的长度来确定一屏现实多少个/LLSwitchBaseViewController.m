//
//  LLSwitchViewController.m
//  自定义标题切换控制器
//
//  Created by JYD on 2017/3/22.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLSwitchBaseViewController.h"
#import "LLSwitchHead.h"
#import "UIView+Frame.h"
#import "LLSwitchViewController.h"
@interface LLSwitchBaseViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)  NSArray * titleArr;

@property (nonatomic,strong)  NSMutableArray  *titleWidths ;
@property (nonatomic,strong)  NSMutableArray * titleLableArr;

@property (nonatomic,assign)  CGFloat  titleMargin;

@property (nonatomic,strong)  UIScrollView * titleScroll;

@property (nonatomic,strong)  UIScrollView * contentScroll;

/** 下标视图 */
@property (nonatomic, strong) UIView *underLine;
/** 记录上一次内容滚动视图偏移量 */
@property (nonatomic, assign) CGFloat lastOffsetX;
@end

@implementation LLSwitchBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI {
    [self.view addSubview:self.titleScroll];
    [self.view addSubview:self.contentScroll];
    
    [self setUpTitleWidth];
    [self setUpAllTitle];
    

}

// 设置所有标题
- (void)setUpAllTitle
{
    
    // 遍历所有的子控制器
    NSUInteger count = self.titleArr.count;
    
    // 添加所有的标题
    CGFloat labelW = 0;
    CGFloat labelH = 45;
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    
    for (int i = 0; i < count; i++) {
        UILabel *label = [[UILabel alloc] init];
        
        label.tag = i;
        
        label.userInteractionEnabled = true;
        
        // 设置按钮的文字颜色
        label.textColor = [UIColor darkGrayColor];
        
        label.font = LLTitleFont;
        
        label.textAlignment = NSTextAlignmentCenter;
        // 设置按钮标题
        label.text = self.titleArr[i];
        
        // 设置按钮位置
        UILabel *lastLabel = [self.titleLableArr lastObject];
        //如果标题栏只有两个的话,则设置屏幕各占一半
        if (count < 3) {
            
            labelW = LLScreenW / 2;
            labelX = i * labelW;
        }else {
            labelW = [self.titleWidths[i] floatValue];
            labelX = _titleMargin + CGRectGetMaxX(lastLabel.frame);
            
        }

        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        // 监听标题的点击
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [label addGestureRecognizer:tap];
        
        // 保存到数组
        [self.titleLableArr addObject:label];
        
        [self.titleScroll addSubview:label];
        
        //添加对应的子控制器
        LLSwitchViewController * switchVc = [LLSwitchViewController new];
        switchVc.title = self.titleArr[i];
        [self addChildViewController:switchVc];
        //设置第一个
        if (i == 0) {
            [self titleClick:tap];
        }
        
       
        
    }
    
    // 设置标题滚动视图的内容范围
    UILabel *lastLabel = self.titleLableArr.lastObject;
    _titleScroll.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame), 0);
    _titleScroll.showsHorizontalScrollIndicator = NO;
    _contentScroll.contentSize = CGSizeMake(count * LLScreenW, 0);
    
}

// 标题按钮点击
- (void)titleClick:(UITapGestureRecognizer *)tap
{
 
    for (UILabel * lable in self.titleLableArr) {
        lable.textColor = [UIColor darkGrayColor];
    }
    // 获取对应标题label
    UILabel *label = (UILabel *)tap.view;
    //设置文字跟随滚动
    [self setLabelTitleCenter:label];
    //设置下表跟随滚动
    [self setUpUnderLine:label];
    // 获取当前角标
    NSInteger i = label.tag;
    
    // 选中label
    label.textColor = [UIColor purpleColor];
    // 内容滚动视图滚动到对应位置
    CGFloat offsetX = i * LLScreenW;
    LLSwitchViewController * switchVc = self.childViewControllers[i];
    [self.contentScroll addSubview:switchVc.view];
    switchVc.view.frame = self.contentScroll.bounds;
    
    self.contentScroll.contentOffset = CGPointMake(offsetX, 0);
    
    // 记录上一次偏移量,因为点击的时候不会调用scrollView代理记录，因此需要主动记录
    _lastOffsetX = offsetX;
    
    
}
// 设置下标的位置
- (void)setUpUnderLine:(UILabel *)label
{
   
    CGFloat underLineH = 2;
    
    self.underLine.yz_y = label.yz_height - underLineH;
    self.underLine.yz_height = underLineH;
    
    // 点击时候需要动画
    [UIView animateWithDuration:0.25 animations:^{
        
        if (self.titleArr.count  < 3) {
            self.underLine.yz_width = LLScreenW / 2;
            
        }else {
            self.underLine.yz_width = label.yz_width;
            
        }
        self.underLine.yz_centerX = label.yz_centerX;

    }];
    
}


// 让选中的按钮居中显示
- (void)setLabelTitleCenter:(UILabel *)label
{
    
    // 设置标题滚动区域的偏移量
    CGFloat offsetX = label.center.x - LLScreenW * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    // 计算下最大的标题视图滚动区域
    CGFloat maxOffsetX = self.titleScroll.contentSize.width - LLScreenW + _titleMargin;
    if (self.titleArr.count < 3) { //有两个标题情况,不设置
        maxOffsetX = self.titleScroll.contentSize.width - LLScreenW ;
        
    }

    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    // 滚动区域
    [self.titleScroll setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}
  /// MARK: ---- scrollViewDidEndDecelerating
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger offsetXInt = offsetX;
    NSInteger screenWInt = LLScreenW;
    
    NSInteger extre = offsetXInt % screenWInt;
    if (extre > LLScreenW * 0.5) {
        // 往右边移动
        offsetX = offsetX + (LLScreenW - extre);
        [self.contentScroll setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }else if (extre < LLScreenW * 0.5 && extre > 0){
        // 往左边移动
        offsetX =  offsetX - extre;
        [self.contentScroll setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    
    // 获取角标
    NSInteger i = offsetX / LLScreenW;
    UILabel * currentLable = self.titleLableArr[i];
    // 选中标题
    [self titleClick:currentLable.gestureRecognizers.firstObject ];

}

#pragma mark - 计算所有标题宽度
// 计算所有标题宽度
- (void)setUpTitleWidth
{
    // 判断是否能占据整个屏幕
    NSUInteger count = self.titleArr.count;

    CGFloat totalWidth = 0;
    
    // 计算所有标题的宽度
    for (NSString *title in self.titleArr) {
    
        CGRect titleBounds = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:LLTitleFont} context:nil];
        
        CGFloat width = titleBounds.size.width + 20;
        
        [self.titleWidths addObject:@(width)];
        
        totalWidth += width;
    }
    
    if (totalWidth > LLScreenW) {
        
        _titleMargin = LLMargin;
        
        self.titleScroll.contentInset = UIEdgeInsetsMake(0, 0, 0, _titleMargin);
        
        return;
    }
    
    CGFloat titleMargin = (LLScreenW - totalWidth) / (count + 1);
    
    _titleMargin = titleMargin < LLMargin? LLMargin: titleMargin;
    
    self.titleScroll.contentInset = UIEdgeInsetsMake(0, 0, 0, _titleMargin);
}



  /// MARK: ----  懒加载方法

- (NSMutableArray *)titleWidths {
    if (_titleWidths == nil) {
        _titleWidths = [NSMutableArray array];
    }
    return _titleWidths;
}
-(UIScrollView *)titleScroll {
    if (_titleScroll == nil) {
        _titleScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, LLScreenW, 45)];
    }
    return _titleScroll;
}
-(UIScrollView *)contentScroll {
    if (_contentScroll == nil) {
        _contentScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleScroll.frame), LLScreenW, LLScreenH - 64 - 45)];
        _contentScroll.delegate = self;
        _contentScroll.pagingEnabled = true;
    }
    return _contentScroll;

}
-(NSArray *)titleArr {
    
    if (_titleArr == nil) {
        _titleArr = @[@"要闻专题视频",@"你你你你我饿我饿我饿",@"每每大",@"懒懒的",@"很爱很爱"];
    }
    return _titleArr;
}
-(NSMutableArray *)titleLableArr {
    if (_titleLableArr == nil) {
        _titleLableArr = [NSMutableArray array];
    }
    return _titleLableArr;
}

- (UIView *)underLine
{
    if (_underLine == nil) {
        
        _underLine = [[UIView alloc] init];
        
        _underLine.backgroundColor = [UIColor redColor];
        
        [self.titleScroll addSubview:_underLine];

        
    }
    return _underLine ;
}

@end
