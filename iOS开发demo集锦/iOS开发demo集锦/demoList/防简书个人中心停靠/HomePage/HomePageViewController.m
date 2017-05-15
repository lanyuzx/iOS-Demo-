//
//  HomePageViewController.m
//  WeiboHomePage
//
//  Created by Maple on 16/10/16.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import "HomePageViewController.h"
#import "LeftTableViewController.h"
#import "RightTableViewController.h"
#import "MiddleTableViewController.h"
//#import "WorksTopView.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width

#define topViewHeight  264
@interface HomePageViewController ()<BaseTableViewDelegate,UIScrollViewDelegate>
{
//    WorksTopView *topView;
    UIButton *btn;
}
/// tableHeaderView
@property (nonatomic, strong) UIView *headerView;
/// 分页栏
//@property (nonatomic, strong) HMSegmentedControl *segmentControl;
/// 用来显示用户名的导航栏，只有当分页栏定在顶部时，才显示
@property (nonatomic, weak) UIView *navigationView;
/// 记录正在展示的控制器
@property (nonatomic, weak) BaseTableViewController *showingVC;
/// 记录每个tableview的偏移量的字典
@property (nonatomic, strong) NSMutableDictionary *offsetDictonry;
/// 分页栏是否固定在顶部
@property (nonatomic, assign, getter=isFixed) BOOL fixed;
/// 状态栏的颜色
@property (nonatomic, assign, getter=isBlack) BOOL black;

@property (nonatomic,strong)UISegmentedControl *segment;
@property (nonatomic,strong)UILabel *NameLab;
@end

@implementation HomePageViewController

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupHeaderView];
    [self addController];
    [self setupNavigationView];
    [self loadUrl];
    [self segmentedControlChangedValue:self.segment];
}

- (void)loadUrl
{
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置导航栏背景为透明
    //  [self.navigationController.navigationBar setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
    //  // 隐藏导航栏底部黑线
    //  self.navigationController.navigationBar.shadowImage = [UIImage new];
    //    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 当都设置为nil的时候，导航栏会使用默认的样式，即还原导航栏样式
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}



#pragma mark - 初始化操作
- (void)setupHeaderView
{
    // 设置样式
    _headerView = [[UIView alloc]init];
    _headerView.frame = CGRectMake(0, 0,ScreenW ,topViewHeight+44);
    _headerView.backgroundColor = [UIColor redColor];
    NSArray *arr  = @[@"动态",@"店铺",@"文章"];
        self.segment = [[UISegmentedControl alloc]initWithItems:arr];
        self.segment.frame = CGRectMake(0, topViewHeight, ScreenW, 44);
        self.segment.backgroundColor = [UIColor whiteColor];
        if ([self.type isEqualToString:@"13"] || [self.type isEqualToString:@"3"]) {
//            _segment.indicator.backgroundColor = kGreenColor;
            //设置普通状态下(未选中)状态下的文字颜色和字体
            [self.segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
            //设置选中状态下的文字颜色和字体
            [self.segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
        }else
        {
            //设置普通状态下(未选中)状态下的文字颜色和字体
            [self.segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
        }
        
        
        self.segment.selectedSegmentIndex = 0;
        [self.segment addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
        [_headerView addSubview:self.segment];
        //    self.headerView = view;
        //    [self.view addSubview:view];
    
}



- (void)setupNavigationView
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    navigationView.backgroundColor = [UIColor blackColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, kScreenWidth, 20)];
    titleLabel.text = @"yyy";
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:titleLabel];
    self.NameLab = titleLabel;
    navigationView.alpha = 0;
    [self.view addSubview:navigationView];
    self.navigationView = navigationView;
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 30, 34, 30);
    [btn setTitle:@"       " forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"back_nav_01_normal"] forState:UIControlStateNormal];
//    [btn setTintColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)back:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addController
{
     NSLog(@"id1===>%@",self.customer_id);
    LeftTableViewController *vc1 = [[LeftTableViewController alloc] init];
    MiddleTableViewController *vc2 = [[MiddleTableViewController alloc] init];
    RightTableViewController *vc3 = [[RightTableViewController alloc] init];
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    [self addChildViewController:vc3];
}

#pragma mark - 事件处理
- (void)segmentedControlChangedValue:(UISegmentedControl *)segment
{
//    这里传值或者上面的传值都可以
    BaseTableViewController *vc = self.childViewControllers[segment.selectedSegmentIndex];
    vc.type = self.type;
    vc.customer_id = self.customer_id;
    [self setupTableView:vc];
}

#pragma mark - Private
/// 设置tableview相关属性
- (void)setupTableView:(BaseTableViewController *)tableViewVC
{
    self.showingVC.scrollDelegate = nil;
    [self.showingVC.view removeFromSuperview];
    tableViewVC.tableView.showsVerticalScrollIndicator = NO;
    tableViewVC.scrollDelegate = self;
    tableViewVC.view.frame = self.view.bounds;
    tableViewVC.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeaderHeight)];
    [self.view insertSubview:tableViewVC.tableView belowSubview:self.navigationView];
    
    /**********************以下是设置偏移量*********************************/
    // 取出当前展示的控制器的便宜量Y
    NSString *currentVCKey = [NSString stringWithFormat:@"%p", self.showingVC];
    CGFloat currentOffY = [self.offsetDictonry[currentVCKey] floatValue];
    // 取出将要展示控制器的偏移量Y
    NSLog(@"offy == >%f",currentOffY);
    NSString *newVCKey = [NSString stringWithFormat:@"%p", tableViewVC];
    CGFloat newOffY = [self.offsetDictonry[newVCKey] floatValue];
    // 最终偏移量
    CGFloat offY = 0;
    if(self.isFixed) // 固定
    {
        if(newOffY < kHeaderTopHeight - kTopBarHeight)
            newOffY = kHeaderTopHeight - kTopBarHeight;
        NSLog(@"newoffy==>%f",newOffY);
        tableViewVC.tableView.contentOffset = CGPointMake(0, newOffY);
        offY = newOffY;
        CGRect rect = self.headerView.frame;
        rect.origin.y = kTopBarHeight - kHeaderTopHeight;
        NSLog(@"rect.y === > %f",rect.origin.y);
        self.headerView.frame = rect;
        [self.view insertSubview:self.headerView belowSubview:self.navigationView];
    }
    else // 没固定时，偏移量与当前的偏移量保持一致
    {
        tableViewVC.tableView.contentOffset = CGPointMake(0, currentOffY);
        offY = currentOffY;
        [tableViewVC.tableView addSubview:self.headerView];
    }
    self.offsetDictonry[newVCKey] = @(offY);
    self.showingVC = tableViewVC;
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return self.isBlack ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
//}

#pragma mark - BaseTableViewDelegate
- (void)tableViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offY = scrollView.contentOffset.y;
    NSLog(@"999==>%f",offY);
    // 去除tableview的的contenSize不足以滚动时的bug
    if(offY == 200)
    {
        return;
    }

    // 分页栏到达顶部时,固定分页栏
    if (offY >= kHeaderTopHeight - kTopBarHeight)
    {
        if (scrollView.contentSize.height < kScreenHeight + kHeaderTopHeight - kTopBarHeight ) {
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, kScreenHeight + kHeaderTopHeight - kTopBarHeight - scrollView.contentSize.height, 0);
            NSLog(@"size ==> %f",kScreenHeight + kHeaderTopHeight - kTopBarHeight - scrollView.contentSize.height);
        }
        if(self.headerView.superview != self.view)
        {
            self.fixed = YES;
            // 固定headerView
            [self.view insertSubview:self.headerView belowSubview:self.navigationView];
            CGRect rect = self.headerView.frame;
            rect.origin.y = kTopBarHeight - kHeaderTopHeight;
            self.headerView.frame = rect;
        }
    }
    else
    {
        if(![self.headerView.superview isEqual:scrollView])
        {
            self.fixed = NO;
            // 还原headerView
            [scrollView addSubview:self.headerView];
            CGRect rect = self.headerView.frame;
            rect.origin.y = 0;
            self.headerView.frame = rect;
        }
    }
    
    // 控制导航条的显示
    if (offY > 0) {
       
        CGFloat alpha = offY / (kHeaderTopHeight - kTopBarHeight);
        self.navigationView.alpha = alpha;
        if (alpha > 0.6 && !self.isBlack) {
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            self.black = YES;
            [btn setTintColor:[UIColor whiteColor]];
            [self setNeedsStatusBarAppearanceUpdate];
        } else if (alpha <= 0.6 && self.isBlack) {
            self.black = NO;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            [self setNeedsStatusBarAppearanceUpdate];
            [btn setTintColor:[UIColor whiteColor]];
        }
    } else {
        self.navigationView.alpha = 0;
        [btn setTintColor:[UIColor whiteColor]];
        self.black = NO;
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
}

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView
{
    CGFloat offY = scrollView.contentOffset.y;
//    NSLog(@"offy1 == >%f",offY);
    NSString *key = [NSString stringWithFormat:@"%p", self.showingVC];
    self.offsetDictonry[key] = @(offY);
}

- (void)tableViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offY = scrollView.contentOffset.y;
//    if (scrollView.mj_footer.isRefreshing) {
        offY = 0;
//    }
    NSString *key = [NSString stringWithFormat:@"%p", self.showingVC];
    self.offsetDictonry[key] = @(offY);
}

- (void)tableViewDidScrollToTop:(UIScrollView *)scrollView
{
    // 滚动到顶部时，所有偏移量都置为0
    NSArray *allkeys = self.offsetDictonry.allKeys;
    for (NSString *key in allkeys)
    {
        self.offsetDictonry[key] = @(0);
    }
}

#pragma mark - getter
//- (CommonHeaderView *)headerView
//{
//  if(_headerView == nil)
//  {
//    _headerView = [CommonHeaderView viewFromXib];
//    _headerView.frame = CGRectMake(0, 0, kScreenWidth, kHeaderHeight);
//  }
//  return _headerView;
//}

- (NSMutableDictionary *)offsetDictonry
{
    if(_offsetDictonry == nil)
    {
        _offsetDictonry = [NSMutableDictionary dictionary];
        for (UIViewController *vc in self.childViewControllers)
        {
            // 默认偏移量非常小，用于判断是否第一次加载
            NSString *key = [NSString stringWithFormat:@"%p", vc];
            _offsetDictonry[key] = @(CGFLOAT_MIN);
        }
    }
    return _offsetDictonry;
}


@end
