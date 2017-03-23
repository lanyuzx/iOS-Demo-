//
//  ViewController.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/14.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "ViewController.h"
#import "LLDemoModel.h"
#import "LLDemoHeaderFooterView.h"
#import "LLDataSource.h"
#import "NetWoringCacheViewController.h"
#import "ZXShopCartViewController.h"
#import "LLCalendarViewController.h"
#import "TestViewController.h"
#import "LLSDCycleScrollView.h"
#import "LLButtonViewController.h"
#import "LLPersnonalCenterController.h"
#import "LLSynchronousRequestController.h"
#import "LLSDAutoLayoutController.h"
#import "XMGTabBarController.h"
#import "ZZXClothesCollectionViewController.h"
#import "ZZXWaterfalllayout.h"
#import "LLRefreshTableViewController.h"
#import "LLLoadingCellController.h"
#import "LLSideBarViewController.h"
#import "DDMenuController.h"
#import "LLLeftViewController.h"
#import "LLRightViewController.h"
#import "LLSwitchBaseViewController.h"
#import "LLMVVMViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)  NSMutableArray * demoTitleArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"iOS Demo 集锦";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[LLDemoHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"LLDemoHeaderFooterView"];
    [self setupData];
    self.tableView.tableFooterView = [UIView new];
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupData{
    
 __weak typeof(self) _self = self;
  [LLDataSource init:^(NSArray *resultArr) {
      _self.demoTitleArr = [NSMutableArray arrayWithArray:resultArr];
      [_self.tableView reloadData];
  }];
    

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.demoTitleArr.count;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LLDemoModel * model = self.demoTitleArr[section];
    return model.demoArr.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLDemoModel * model = self.demoTitleArr[indexPath.section];
    if (model.headFootClick) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = model.demoArr[indexPath.row];
        
        return cell;
    }else {
        
        return [UITableViewCell new];
    
    }

   

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLDemoModel * model = self.demoTitleArr[indexPath.section];
    
    if (model.headFootClick) {
        return 44;
    }else {
        return 0.0001;
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LLDemoHeaderFooterView * headFootView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LLDemoHeaderFooterView"];
    LLDemoModel * model = self.demoTitleArr[section];
    headFootView.model =model;
    headFootView.block = ^(LLDemoHeaderFooterView * headFootView) {
        model.headFootClick = !model.headFootClick;
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:section];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    };
    return headFootView;

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 55;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//时间日历
            LLCalendarViewController * calenVc = [LLCalendarViewController new];
            calenVc.title = @"时间日历";
            [self.navigationController pushViewController:calenVc animated:true];
            
        }else if (indexPath.row == 1)//购物车动画
        {
            ZXShopCartViewController  * shopVc = [ZXShopCartViewController new];
             shopVc.title = @"购物车动画";
            [self.navigationController pushViewController:shopVc animated:true];
        
        }else if (indexPath.row == 2) {//接口缓存使用YYCace
            
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"NetWoringCacheViewController" bundle:nil];
            NetWoringCacheViewController * netVc = sb.instantiateInitialViewController;
                netVc.title = @"AFN3.0封装 接口并缓存使用YYCace";
                [self.navigationController pushViewController:netVc animated:true];
           
        
        }else if (indexPath.row == 3) { //仿简书个人中心页带下拉刷新
            
            LLPersnonalCenterController * personVc = [LLPersnonalCenterController new];
            [self.navigationController pushViewController:personVc animated:true];
        
        }else if (indexPath.row ==4) {
            TestViewController * dragVc = [TestViewController new];
            dragVc.title = @"可拖动试图";
            [self.navigationController pushViewController:dragVc animated:true];
        
        }else if (indexPath.row == 5) {//优秀的轮播图
            LLSDCycleScrollView * sdcycleVc = [LLSDCycleScrollView new];
            [self.navigationController pushViewController:sdcycleVc animated:true];
        
        }else if (indexPath.row == 6) {//完全自定义按钮
            
            LLButtonViewController * buttonVc = [LLButtonViewController new];
            [self.navigationController pushViewController:buttonVc animated:true];
        
        }else if (indexPath.row == 7) { //使用GDC实现网络同步请求
            LLSynchronousRequestController * SynchronousVc = [LLSynchronousRequestController new];
            SynchronousVc.title = @"使用GDC实现网络同步请求";
            [self.navigationController pushViewController:SynchronousVc animated:true];
        
        }else if (indexPath.row == 8) {//SDAutolayout的简单实用,一行代码计算行高
            LLSDAutoLayoutController * layoutVc = [LLSDAutoLayoutController new];
            layoutVc.title = @"SDAutolayout的简单实用,一行代码计算行高";
            [self.navigationController pushViewController:layoutVc animated:true];
        
        }
    }else if (indexPath.section == 1) { //2017-03-15
    
        if (indexPath.row == 0) {
            XMGTabBarController * tabBarVc = [XMGTabBarController new];
            //tabBarVc.title = @"百思不得姐项目小马哥MVC";
            [self presentViewController:tabBarVc animated:true completion:nil];
        }else if (indexPath.row == 1) { //iOS瀑布流
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"ZZXClothesCollectionViewController" bundle:nil];
            ZZXClothesCollectionViewController * layoutVc = sb.instantiateInitialViewController;
            layoutVc.title = @"iOS瀑布流";
            [self.navigationController pushViewController:layoutVc animated:true];
            
            
        
        }else if (indexPath.row ==2 ){
            
            LLRefreshTableViewController * refrshVc = [[LLRefreshTableViewController alloc]initWithStyle:UITableViewStylePlain];
            refrshVc.title = @"下拉刷新Gif图";
            [self.navigationController pushViewController:refrshVc animated:true];
        
        }else if (indexPath.row == 3) {
            LLLoadingCellController * loadingVc = [[LLLoadingCellController alloc]init];
            loadingVc.title = @"cell的不同加载方式,根据不同的可重用cell实现";
            [self.navigationController pushViewController:loadingVc animated:true];
        }else if (indexPath.row == 4) {
            
            LLSideBarViewController * sideBarVc = [LLSideBarViewController new];
            DDMenuController * ddVc = [[DDMenuController alloc]initWithRootViewController:sideBarVc];
                                       
            ddVc.leftViewController = [LLLeftViewController new];
            ddVc.rightViewController = [LLRightViewController new];
            sideBarVc.title = @"侧滑栏";
            [self presentViewController:ddVc animated:true completion:nil];
            
            
        
        
        }
    
    
    }else if (indexPath.section == 2) { // 2017-03-23更新
        
        if (indexPath.row == 0) {
            
            LLSwitchBaseViewController * switchVc = [LLSwitchBaseViewController new];
            switchVc.title = @"自定义标题切换";
            [self.navigationController pushViewController:switchVc animated:true];
        }else if (indexPath.row == 1) {//简单的MVVM设计模式
            LLMVVMViewController * mvvmVc = [LLMVVMViewController new];
            mvvmVc.title = @"简单的MVVM设计模式";
            [self.navigationController pushViewController:mvvmVc animated:true];
        }
    
    
    }

}

-(NSMutableArray *)demoTitleArr {
    if (_demoTitleArr == nil) {
        _demoTitleArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _demoTitleArr;
}



@end
