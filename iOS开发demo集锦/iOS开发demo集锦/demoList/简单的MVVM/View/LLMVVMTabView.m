//
//  LLMVVMTabView.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/23.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLMVVMTabView.h"
#import "LLMVVMModel.h"
#import "LLMVVMViewModel.h"
#import "MJRefresh.h"
#import "LLMVVMTableViewCell.h"
@interface LLMVVMTabView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign)  NSInteger  pageIndex;
@end
@implementation LLMVVMTabView

-(void)setModelArr:(NSArray *)modelArr {
    
    _modelArr = modelArr;
    
    [self reloadData];

}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        
        [self  registerClass:[LLMVVMTableViewCell class] forCellReuseIdentifier:@"LLMVVMTableViewCell"];
         __weak typeof(self) weak = self;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weak.pageIndex = 1;
            weak.blockHeader(weak.pageIndex);
        }];
        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weak.pageIndex++;
             weak.blockFooter(weak.pageIndex);
           
        }];

    }
    
    return self;
}

/// MARK: ---- 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LLMVVMTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLMVVMTableViewCell"];
    LLMVVMModel * model = self.modelArr[indexPath.row];
    cell.model = model;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.block(self.modelArr[indexPath.row]);
    
    
}

@end
