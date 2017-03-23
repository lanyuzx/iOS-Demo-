# iOS-Demo-开发中遇到的需求,抽成demo进行分享 (长期更新)
<br> 2017 -03-23号更新,新增如下: </br>
* MVVM设计模式 控制代码如下
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
```
* 根据标题宽度来决定一屏现实多少个标题

<br> 2017 -03-15号更新,新增如下: </br>
* 小马哥百思不得姐
* iOS瀑布流
* 下拉刷新gif图片
* 侧滑栏
<br>  2017 -03-14号更新,新增如下: </br>
* 时间日历
* 购物车动画
* AFN3.0封请求封装 接口并使用YYCache混存到本地
* 自定义可拖动试图(明哥写)
* AFN3.0同步网络同步请求的实现使用信号机智,,调用一定要使用异步
* SDAutoLayout的简单实用,一行代码搞定tabView的行高
