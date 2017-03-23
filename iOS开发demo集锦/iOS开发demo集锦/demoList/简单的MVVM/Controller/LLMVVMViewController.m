//
//  LLMVVMViewController.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/23.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLMVVMViewController.h"
#import "LLSwitchHead.h"
#import "LLMVVMViewModel.h"
#import "LLMVVMModel.h"
#import "LLMVVMTabView.h"
#import "MJRefresh.h"
@interface LLMVVMViewController ()
@property (nonatomic,strong)  LLMVVMTabView * tabView;
@property (nonatomic,assign)  NSInteger  pageIndex;
@end

@implementation LLMVVMViewController

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


@end
