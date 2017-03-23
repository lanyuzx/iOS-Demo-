//
//  ViewController.m
//  cell的加载方式
//
//  Created by 周尊贤 on 16/10/27.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

#import "LLLoadingCellController.h"
#import "LLTempModel.h"
#import "LLHeadFootView.h"
@interface LLLoadingCellController ()<UITableViewDelegate,UITableViewDataSource,headFootViewDelegate>
@property(nonatomic,strong)UITableView * tabView;
@property(nonatomic,strong)NSMutableArray * modelArr;
@property(nonatomic,strong)NSMutableArray * cellArr;

@property (nonatomic,strong)  UILabel * starlLoading;

@property (nonatomic,strong)  UILabel * endLoading;

@end

@implementation LLLoadingCellController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i =0; i<15; i++) {
        LLTempModel * model = [[LLTempModel alloc]init];
        model.name = @"懒懒";
        model.isClick = false;
        model.headViewEnum = loadingBefore;
        [self.modelArr addObject:model];
    }
    [self.view addSubview:self.tabView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.modelArr.count;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    LLTempModel * model = self.modelArr[section];
    if (model.isClick == true) {
          if (model.headViewEnum == loadIng) {
            return 1;
        }else if(model.headViewEnum == loadingCompleted)  {
            
            if (self.cellArr.count !=0) {
                
                 return self.cellArr.count+ 1;
            }
        
           
        }else {
            return 0;
        }
        
       
    }else {
        return 0;
    }
    
    return 0;

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    LLHeadFootView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LLHeadFootView"];
    if (headView == nil) {
        headView = [[LLHeadFootView alloc]initWithReuseIdentifier:@"LLHeadFootView"];
    }
    headView.delegate = self;
    headView.section = section;
    headView.model = self.modelArr[section];
    return headView;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 66;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell * cell;
    
      LLTempModel * model = self.modelArr[indexPath.section];
    if (model.headViewEnum == loadIng) {
        if (indexPath.row ==0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            for (UIView * v in cell.contentView.subviews) {
                [v removeFromSuperview];
            }
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            }
            
           self.starlLoading.text = @"加载中";
            [cell.contentView addSubview:   self.starlLoading];
               self.starlLoading.frame = CGRectMake(cell.contentView.frame.size.width / 2, cell.contentView.frame.size.height /2 - 35/2, 120, 35);
        }
    }else if (model.headViewEnum == loadingCompleted){
        cell = [tableView dequeueReusableCellWithIdentifier:@"tabView"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tabView"];
        }
       
        if (indexPath.row == self.cellArr.count) {
        cell.textLabel.text = @"";
            self.endLoading.text = @"加载完成";
            [cell.contentView addSubview:   self.endLoading];
            self.endLoading.frame = CGRectMake(cell.contentView.frame.size.width / 2, cell.contentView.frame.size.height /2 - 35/2 , 120, 35);
            
        }else {
           
            cell.textLabel.text = self.cellArr[indexPath.row];
        }
        
        
           
    }
    
   
   
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LLTempModel * model = self.modelArr[indexPath.section];
    
    if (model.isClick ) {
        
        if (model.headViewEnum == loadIng) {
            return 44;
        }else  if(model.headViewEnum == loadingCompleted){
            
            if (indexPath.row == self.cellArr.count) {
                return 60;
            }else {
             return 99;
            }
        
        }
       
    }else {
        return 0;
    }
    return 0;

}

-(void)headFootViewDelegateClick:(LLTempModel *)modle :(NSInteger)section :(LLHeadFootView *)headView{
    
   
    for (LLTempModel * tempModel in self.modelArr) {
        tempModel.isClick = false;
    }
    LLTempModel * moddel = self.modelArr[section];
    moddel.isClick = !modle.isClick;
    modle.headViewEnum =loadIng;
    
    if (moddel.isClick) {

        [self.tabView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              moddel.headViewEnum = loadingCompleted;
                [self.cellArr removeAllObjects];
                for (int i = 0; i<4; i++) {
                    [self.cellArr addObject:[NSString stringWithFormat:@"dispatch_after%zd",i]];
                }
                NSIndexSet * pathSet = [NSIndexSet indexSetWithIndex:section];
                [self.tabView reloadSections:pathSet withRowAnimation:UITableViewRowAnimationNone];

        });
    }else {
        moddel = loadingBefore;
      
         NSIndexSet * pathSet = [NSIndexSet indexSetWithIndex:section];
        [self.tabView reloadSections:pathSet withRowAnimation:UITableViewRowAnimationNone];
    }
    
   
    
    

}

-(UITableView *)tabView {
    if (_tabView == nil) {
        _tabView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tabView.dataSource = self;
        _tabView.delegate = self;
    }
    return _tabView;

}

-(NSMutableArray *)modelArr {
    
    if (_modelArr == nil) {
        _modelArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _modelArr;

}

-(NSMutableArray *)cellArr {
    if (_cellArr == nil) {
        _cellArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _cellArr;
    

}
-(UILabel *)starlLoading {
    if (_starlLoading ==nil) {
        _starlLoading = [[UILabel alloc]init];
    }
    return _starlLoading;

}

-(UILabel *)endLoading {
    
    if (_endLoading == nil) {
        _endLoading = [[UILabel alloc]init];
    }
    return _endLoading;
}


@end
