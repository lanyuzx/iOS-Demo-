//
//  LLTaoBaoOrderViewController.m
//  测试
//
//  Created by 周尊贤 on 2017/5/18.
//  Copyright © 2017年 毛织网. All rights reserved.
//

#import "LLTaoBaoOrderViewController.h"
#import "LLListModel.h"
#import "NSObject+BAMJParse.h"
#import "LLCartVoListModel.h"
#import "LLOrderHeaderView.h"
#import "LLOrderTableViewCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "LLOrderFooterView.h"
@interface LLTaoBaoOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray <LLListModel *>* orderListArr;
@property (nonatomic,strong) UITableView * tabView;
@end

@implementation LLTaoBaoOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tabView];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.orderListArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LLListModel * listModel = self.orderListArr[section];
    return listModel.cartVoList.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LLOrderHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LLOrderHeaderView"];
    headerView.model = self.orderListArr[section];
    
    return headerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    LLOrderFooterView * footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LLOrderFooterView"];
    footerView.model = self.orderListArr[section];

    return footerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LLOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLOrderTableViewCell"];
    LLListModel * listModel = self.orderListArr[indexPath.section];
    cell.model = listModel.cartVoList[indexPath.row];
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   LLListModel * listModel = self.orderListArr[indexPath.section];
    LLCartVoListModel * model = listModel.cartVoList[indexPath.row];
    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[LLOrderTableViewCell class] contentViewWidth:CGRectGetWidth(self.view.frame)];
}


 /// MARK: ---- 懒加载
-(UITableView *)tabView {
    if (_tabView == nil) {
        _tabView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tabView.delegate = self;
        _tabView.dataSource = self;
        [_tabView registerClass:[LLOrderTableViewCell class] forCellReuseIdentifier:@"LLOrderTableViewCell"];
        [_tabView registerClass:[LLOrderHeaderView class] forHeaderFooterViewReuseIdentifier:@"LLOrderHeaderView"];
        [_tabView registerClass:[LLOrderFooterView class] forHeaderFooterViewReuseIdentifier:@"LLOrderFooterView"];
    }
    return _tabView;
}
-(NSArray *)orderListArr {
    
    if (_orderListArr == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"shopping_json.txt" ofType:nil];
        NSData * data = [NSData dataWithContentsOfFile:path];
        if (data != nil) {
             NSDictionary * orderDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            _orderListArr =[LLListModel BAMJParse:orderDict[@"data"][@"list"]] ;
        }
       
    }
    return _orderListArr;

}

@end
