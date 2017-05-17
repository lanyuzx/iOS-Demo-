//
//  LLAsyncNetWorkeViewController.m
//  iOS开发demo集锦
//
//  Created by 周尊贤 on 2017/5/17.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLAsyncNetWorkeViewController.h"
#import "PPNetworkHelper.h"
#import "MJRefresh.h"
@interface LLAsyncNetWorkeViewController ()<UITableViewDataSource>
@property (nonatomic,strong) id result1;
@property (nonatomic,strong) id result2;
@property (nonatomic,strong) id result3;

@end

@implementation LLAsyncNetWorkeViewController
static NSString *const dataUrl = @"http://api.budejie.com/api/api_open.php";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView * tabViewHeader = [UIView new];
    tabViewHeader.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200);
    tabViewHeader.backgroundColor = [UIColor redColor];
    UILabel * alterLable = [UILabel new];
    alterLable.text = @"详情结果看打印的log";
    alterLable.font = [UIFont boldSystemFontOfSize:18];
    alterLable.textColor = [UIColor whiteColor];
    alterLable.frame = CGRectMake(CGRectGetMidX(tabViewHeader.frame) - 100, 100 - 35, 200, 35);
    [tabViewHeader addSubview:alterLable];
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = tabViewHeader;
    NSDictionary *para = @{ @"a":@"list", @"c":@"data",@"client":@"iphone",@"page":@"0",@"per":@"10", @"type":@"29"};
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self setupNetWorkRequst:para];
    }];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
  
    [self setupNetWorkRequst:para];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 /// MARK: ---- 网络请求

-(void)setupNetWorkRequst:(NSDictionary *) param{
    
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_group_enter(dispatchGroup);
    [PPNetworkHelper GET:dataUrl parameters:param responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        dispatch_group_leave(dispatchGroup);
        self.result1 = responseObject;
        
    } failure:^(NSError *error) {
        dispatch_group_leave(dispatchGroup);
    }];
    
    dispatch_group_enter(dispatchGroup);
    [PPNetworkHelper GET:dataUrl parameters:param responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        dispatch_group_leave(dispatchGroup);
        self.result2 = responseObject;
        
    } failure:^(NSError *error) {
        dispatch_group_leave(dispatchGroup);
    }];
    
    dispatch_group_enter(dispatchGroup);
    [PPNetworkHelper GET:dataUrl parameters:param responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        dispatch_group_leave(dispatchGroup);
        self.result3 = responseObject;
        
    } failure:^(NSError *error) {
        dispatch_group_leave(dispatchGroup);
    }];
    
    [self dispatch_group_notify:dispatchGroup];
    
}


-(void)dispatch_group_notify:(dispatch_group_t) dispatchGroup{
    
    __weak typeof(self) weak = self;
    //监听三个异步网络 请求完成后,刷新UI界面
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        
        NSLog(@"%@",weak.result1);
        NSLog(@"%@",weak.result2);
        NSLog(@"%@",weak.result3);
        
        [weak.tableView.mj_header endRefreshing];
        
    });

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    cell.textLabel.text = @"dequeueReusableCellWithIdentifier";
    
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
