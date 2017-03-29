//
//  ViewController.m
//  Demo
//
//  Created by 张德雄 on 16/6/3.
//  Copyright © 2016年 GroupFly. All rights reserved.
//

#import "LLShoppingViewController.h"

#import "MerchandiseBasicInfoTableViewCell.h"
#import "MerchandiseShopBasicInfoTableViewCell.h"
#import "MerchandiseCommentTableViewCell.h"

#define SCREEN_BOUNDS   [UIScreen mainScreen].bounds
#define SCREEN_SIZE     [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#define HEADER_VIEW_HEIGHT      400.0f      // 顶部商品图片高度
#define END_DRAG_SHOW_HEIGHT    80.0f       // 结束拖拽最大值时的显示
#define BOTTOM_VIEW_HEIGHT      44.0f       // 底部视图高度（加入购物车＼立即购买）

@interface LLShoppingViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *navigationView;    // 导航栏
@property (weak, nonatomic) IBOutlet UIView *allContentView;    // 所有内容的View
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;          // 头视图

@property (weak, nonatomic) IBOutlet UIWebView *detailWebView;  // 商品详情
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UIView *popTopView;               // 弹出顶部视图
@property (strong, nonatomic) UIView *popView;                  // 弹出底部视图
@property (strong, nonatomic) UIView *maskView;                 // 遮罩视图
@property (strong, nonatomic) UILabel *topTitleLabel;           // 顶部标题
@property (strong, nonatomic) UILabel *titleLabel;              // 规格标题

@property (strong, nonatomic) UILabel *topMsgLabel;             // 顶部提示信息
@property (strong, nonatomic) UILabel *bottomMsgLabel;          // 底部提示信息

@property (copy, nonatomic) NSString *popTitle;                 // 点击的代理

@end

@implementation LLShoppingViewController
{
    CGFloat minY;
    CGFloat maxY;
    // 顶部视图布尔值，在Close方法中用到，判断动画不一样
    BOOL isTop;
    // 顶部视图弹出开关，只有当isShowTop为假时，才会显示，否则不显示
    BOOL isShowTop;
    // 图文详情开关，
    BOOL isShowDetail;
    // 倒计时
    NSTimer *showTimer;
    NSDate *endDate;
    NSCalendar *calendar;
    NSDateComponents *dateComponent;
    int unit;
}

- (UIView *)popTopView {
    if (!_popTopView) {
        _popTopView = [[UIView alloc] initWithFrame:CGRectMake(0, -SCREEN_HEIGHT / 2.0f, SCREEN_WIDTH, SCREEN_HEIGHT / 2.0f)];
        _popTopView.backgroundColor = [UIColor colorWithRed:1.000 green:0.988 blue:0.960 alpha:1.000];
        // 标题
        _topTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44.0f)];
        _topTitleLabel.textAlignment = NSTextAlignmentCenter;
        _topTitleLabel.textColor = [UIColor whiteColor];
        _topTitleLabel.backgroundColor = [UIColor redColor];
        _topTitleLabel.text = @"我的喜爱";
        [_popTopView addSubview:_topTitleLabel];
    }
    return _popTopView;
}

- (UIView *)popView {
    if (!_popView) {
        _popView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT / 2.0f)];
        _popView.backgroundColor = [UIColor colorWithRed:1.000 green:0.988 blue:0.960 alpha:1.000];
        // 标题
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44.0f)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = [UIColor redColor];
        [_popView addSubview:_titleLabel];
    }
    _titleLabel.text = _popTitle;
    return _popView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:SCREEN_BOUNDS];
        _maskView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.400];
        _maskView.alpha = 0.0f;
        
        // 添加点击背景按钮
        UIButton *btn = [[UIButton alloc] initWithFrame:SCREEN_BOUNDS];
        [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [_maskView addSubview:btn];
    }
    return _maskView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupHeadView];
    // 倒计时
    showTimer = [NSTimer timerWithTimeInterval:0.1
                                        target:self
                                      selector:@selector(timeDecreasing)
                                      userInfo:nil
                                       repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:showTimer forMode:NSRunLoopCommonModes];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载图文详情
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self.detailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.hao123.com"]]];
    });
    self.detailWebView.scrollView.delegate = self;
    // 注册Nib
    [self registerNib];
    
    _topMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -END_DRAG_SHOW_HEIGHT, SCREEN_WIDTH, END_DRAG_SHOW_HEIGHT)];
    _topMsgLabel.font = [UIFont systemFontOfSize:13.0f];
    _topMsgLabel.textAlignment = NSTextAlignmentCenter;
    _topMsgLabel.text = @"下拉查看我的喜爱";
    [self.tableView addSubview:_topMsgLabel];
    
    _bottomMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -END_DRAG_SHOW_HEIGHT, SCREEN_WIDTH, END_DRAG_SHOW_HEIGHT)];
    _bottomMsgLabel.font = [UIFont systemFontOfSize:13.0f];
    _bottomMsgLabel.textAlignment = NSTextAlignmentCenter;
    _bottomMsgLabel.text = @"下拉返回商品详情";
    [self.detailWebView.scrollView addSubview:_bottomMsgLabel];
    
    // 配置倒计时
    calendar = [NSCalendar currentCalendar];
    unit =  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitNanosecond;
    dateComponent = [[NSDateComponents alloc] init];
    dateComponent.day = 2;  // 2天后结束
    endDate = [calendar dateByAddingComponents:dateComponent toDate:[NSDate date] options:0];
}

- (void)registerNib {
    [self.tableView registerNib:[UINib nibWithNibName:kMerchandiseBasicInfoTableViewCellIdentifier bundle:nil] forCellReuseIdentifier:kMerchandiseBasicInfoTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:kMerchandiseShopBasicInfoTableViewCellIdentifier bundle:nil] forCellReuseIdentifier:kMerchandiseShopBasicInfoTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:kMerchandiseCommentTableViewCellIdentifier bundle:nil] forCellReuseIdentifier:kMerchandiseCommentTableViewCellIdentifier];
}

- (void)setupHeadView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.headView.bounds];
    // 添加多张图片
    for (int i=0; i<5; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, HEADER_VIEW_HEIGHT)];
        imageView.image = [UIImage imageNamed:@(i+1).stringValue];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 5, HEADER_VIEW_HEIGHT);
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.headView addSubview:self.scrollView];
}

// 返回按钮
- (IBAction)back:(id)sender {
    if (isShowDetail) {
        [UIView animateWithDuration:0.4 animations:^{
            self.allContentView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            isShowDetail = NO;
        }];
    }
}

- (void)timeDecreasing {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    MerchandiseBasicInfoTableViewCell *cell = (MerchandiseBasicInfoTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    dateComponent = [calendar components:unit fromDate:[NSDate date] toDate:endDate options:0];
    // 活动结束
    if(dateComponent.hour<=0 && dateComponent.minute<=0 && dateComponent.second<=0 && dateComponent.nanosecond<=0) {
        if (showTimer) {
            [showTimer invalidate];
            showTimer = nil;
        }
        cell.isEnd = YES;
    } else {
        cell.isEnd = NO;
    }
    // 更新时间
    [cell updateActivityDateWithComponent:dateComponent];
}

#pragma mark - UITableView DataSource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            MerchandiseBasicInfoTableViewCell *basicInfoCell = [tableView dequeueReusableCellWithIdentifier:kMerchandiseBasicInfoTableViewCellIdentifier forIndexPath:indexPath];
            __weak typeof(self) weakSelf = self;
            basicInfoCell.block = ^(NSInteger index){
                switch (index) {
                    case 0:
                        weakSelf.popTitle = @"分享";
                        break;
                    case 1:
                        weakSelf.popTitle = @"聚划算";
                        break;
                    case 2:
                        weakSelf.popTitle = @"领取优惠券";
                        break;
                }
                [weakSelf open];
            };
            return basicInfoCell;
        }
            break;
        case 2: {
            MerchandiseShopBasicInfoTableViewCell *shopInfoCell = [tableView dequeueReusableCellWithIdentifier:kMerchandiseShopBasicInfoTableViewCellIdentifier forIndexPath:indexPath];
            __weak typeof(self) weakSelf = self;
            shopInfoCell.block = ^(NSInteger index){
                switch (index) {
                    case 0:
                        weakSelf.popTitle = @"查看分类";
                        break;
                    case 1:
                        weakSelf.popTitle = @"进店逛逛";
                        break;
                }
                [weakSelf open];
            };
            return shopInfoCell;
        }
            break;
        case 1: {
            MerchandiseCommentTableViewCell *commentCell = [tableView dequeueReusableCellWithIdentifier:kMerchandiseCommentTableViewCellIdentifier forIndexPath:indexPath];
            return commentCell;
        }
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 260.0f;
            break;
        case 1:
            return 200.0f;
            break;
        case 2:
            return 180.0f;
            break;
        default:
            return 0.0f;
            break;
    }
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    if (scrollView == self.tableView) {
        // 重新赋值，就不会有淘宝用力拖拽时的回弹
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, 0);
        if (self.tableView.contentOffset.y >= 0 &&  self.tableView.contentOffset.y <= HEADER_VIEW_HEIGHT) {
            self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, -offset / 2.0f);
            self.navigationView.alpha = offset / HEADER_VIEW_HEIGHT;
        } else if (self.tableView.contentOffset.y < 0) {
            self.navigationView.alpha = 0.0f;
            if (offset <= -END_DRAG_SHOW_HEIGHT) {
                _topMsgLabel.text = @"释放查看我的喜爱";
            } else {
                _topMsgLabel.text = @"下拉查看我的喜爱";
            }
        } else {
            self.navigationView.alpha = 1.0f;
        }
    } else {
        // WebView中的ScrollView
        if (offset <= -END_DRAG_SHOW_HEIGHT) {
            _bottomMsgLabel.text = @"释放返回商品详情";
        } else {
            _bottomMsgLabel.text = @"下拉返回商品详情";
        }
    }
}

/**
 *  每次拖拽都会回调
 *  @param decelerate YES时，为滑动减速动画，NO时，没有滑动减速动画
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate) {
        CGFloat offset = scrollView.contentOffset.y;
        if (scrollView == self.tableView) {
            if (offset < 0) {
                minY = MIN(minY, offset);
            } else {
                maxY = MAX(maxY, offset);
            }
        } else {
            minY = MIN(minY, offset);
        }
        
        // 顶部视图
        if (minY <= -END_DRAG_SHOW_HEIGHT && !isShowTop && !isShowDetail) {
            isShowTop = YES;
            isTop = YES;
            [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
            [[UIApplication sharedApplication].keyWindow addSubview:self.popTopView];
            
            [UIView animateWithDuration:0.25 animations:^{
                self.maskView.alpha = 1.0;
                self.popTopView.transform = CGAffineTransformTranslate(self.popTopView.transform, 0, SCREEN_HEIGHT / 2.0f);
            } completion:^(BOOL finished) {
                minY = 0.0f;
                _topMsgLabel.text = @"下拉查看我的喜爱";
            }];
        }
        
        // 滚到图文详情
        if (maxY >= self.tableView.contentSize.height - SCREEN_HEIGHT + END_DRAG_SHOW_HEIGHT + BOTTOM_VIEW_HEIGHT) {
            isShowDetail = NO;
            [UIView animateWithDuration:0.4 animations:^{
                self.allContentView.transform = CGAffineTransformTranslate(self.allContentView.transform, 0, - (SCREEN_HEIGHT - BOTTOM_VIEW_HEIGHT));
            } completion:^(BOOL finished) {
                maxY = 0.0f;
                isShowDetail = YES;
            }];
        }
        
        // 滚到商品详情
        if (minY <= -END_DRAG_SHOW_HEIGHT && isShowDetail) {
            [UIView animateWithDuration:0.4 animations:^{
                self.allContentView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                minY = 0.0f;
                isShowDetail = NO;
                _bottomMsgLabel.text = @"下拉返回商品详情";
            }];
        }
    }
}

/**
 *  带有滑动减速动画效果时，才会调用
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"END Decelerating");
}

#pragma mark - 选择商品规格

- (IBAction)showCool:(id)sender {
    self.popTitle = @"加入购物车";
    [self open];
}

- (IBAction)goBuy:(id)sender {
    self.popTitle = @"立即购买";
    [self open];
}

- (void)open {
    isTop = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.popView];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.view.layer.transform = [self firstStepTransform];
        self.maskView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.layer.transform = [self secondStepTransform];
            self.popView.transform = CGAffineTransformTranslate(self.popView.transform, 0, -SCREEN_HEIGHT / 2.0f);
        }];
    }];
}

- (void)close {
    if (isTop) { // 关闭顶部视图动画
        isShowTop = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.maskView.alpha = 0.0;
            self.popTopView.transform = CGAffineTransformIdentity;
        }completion:^(BOOL finished) {
            [self.maskView removeFromSuperview];
            [self.popTopView removeFromSuperview];
        }];
    } else {    // 关闭顶部视图动画
        [UIView animateWithDuration:0.3 animations:^{
            self.view.layer.transform = [self firstStepTransform];
            self.popView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.view.layer.transform = CATransform3DIdentity;
                self.maskView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self.maskView removeFromSuperview];
                [self.popView removeFromSuperview];
            }];
        }];
    }
}

// 动画1
- (CATransform3D)firstStepTransform {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -500.0;
    transform = CATransform3DScale(transform, 0.98, 0.98, 1.0);
    transform = CATransform3DRotate(transform, 5.0 * M_PI / 180.0, 1, 0, 0);
    transform = CATransform3DTranslate(transform, 0, 0, -30.0);
    return transform;
}


// 动画2
- (CATransform3D)secondStepTransform {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = [self firstStepTransform].m34;
    transform = CATransform3DTranslate(transform, 0, SCREEN_HEIGHT * -0.08, 0);
    transform = CATransform3DScale(transform, 0.8, 0.8, 1.0);
    return transform;
}

@end
