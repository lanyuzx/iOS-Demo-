# iOS-demo-
开发中各种小demo集锦,如果你遇到你要用到的,请start
2017-03-14更新内容:
时间日历 \n
购物车动画 A
FN3.0封装支持接口的缓存  
仿简书个人中心页带下拉刷新  
自定义可拖动试图  
优秀的图片轮播器  
自定义按钮  
AFN3.0网络同步请求的实现 
SDAutolaout的简单使用一句话计算行高

///////***********************/2017 -03-23****************
新增简单的MVVM设计模式


/////////控制器代码
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

/////////
