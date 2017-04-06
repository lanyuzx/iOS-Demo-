# iOS-Demo-开发中遇到的需求,抽成demo进行分享 (长期更新)
## 2017 -04-05号更新,新增如下:
* iOS股票折线图
* 新增仿京东商品选择器
## 2017 -03-29号更新,新增如下:
* 调用相机选择图片
* 断点下载功能
* 模仿淘宝购物界面
* 模仿淘宝选衣服
* 时间轴
* 动画贝塞尔曲线
* 仿新浪微博照片选择器
## 2017 -03-23号更新,新增如下:
* MVVM设计模式 控制代码如下 逻辑试图与控制器分开,控制器只干自己的事情
```Objective-C
- (void)viewDidLoad {
    [super viewDidLoad];
     self.pageIndex = 1;
    [self.view addSubview:self.tabView];
    [self setupData];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    NSLog(@"%s",__func__);
    NSLog(@"***********------------*************");
    NSLog(@"*******************MVVM使用很多的回掉方法,一定要注意循环引用问题*********************");
    NSLog(@"***********------------*************");
}
-(void)setupData {
    
    __weak typeof(self) weak = self;
   [[LLMVVMViewModel shareViewModel]setupRequsetDate:self.pageIndex :^(id sucess) {
       weak.tabView.modelArr = sucess;
       [weak.tabView.mj_header endRefreshing];
       [weak.tabView.mj_footer endRefreshing];
   } :^(id error) {
       
   }];

}
 /// MARK: ---- 懒加载

-(LLMVVMTabView *)tabView {
         if (_tabView == nil) {
        _tabView = [[LLMVVMTabView alloc]initWithFrame:CGRectMake(0, 0, LLScreenW, LLScreenH ) style:UITableViewStylePlain];
      
             __weak typeof(self) weak = self;

        //tabViewcell的点击跳转方法
       _tabView.block = ^(LLMVVMModel * model) {
            [[LLMVVMViewModel shareViewModel]movieDetailWithPublicModel:model WithViewController:weak];
        };
             
             //下拉刷新方法
             _tabView.blockHeader = ^(NSInteger pageNum) {
                 weak.pageIndex = pageNum;
                 [weak setupData];
             };
             //上拉加载的回掉方法
             _tabView.blockFooter = ^(NSInteger pageNum) {
                 weak.pageIndex = pageNum;
                 [weak setupData];
             };
             
           }
    return _tabView;

}

```
* 根据标题宽度来决定一屏现实多少个标题
* 首页动画较为实用仿工商银行首页
* tabView旋转90度横向滚动使用
## 2017 -03-15号更新,新增如下: 
* 小马哥百思不得姐
* iOS瀑布流
* 下拉刷新gif图片
* 侧滑栏
## 2017 -03-14号更新,新增如下:
* 时间日历
* 购物车动画
* AFN3.0封请求封装 接口并使用YYCache混存到本地
* 自定义可拖动试图(明哥写)
* AFN3.0同步网络同步请求的实现使用信号机智,,调用一定要使用异步
* SDAutoLayout的简单实用,一行代码搞定tabView的行高
