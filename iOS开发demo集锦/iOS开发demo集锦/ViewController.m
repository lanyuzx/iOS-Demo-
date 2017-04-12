//
//  ViewController.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/14.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "ViewController.h"
#import "LLDemoModel.h"
#import "LLMainTableViewCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
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
#import "LLSelectPhotoController.h"
#import "ZFDownloadViewController.h"
#import "LLShoppingViewController.h"
#import "LLSelectClothesController.h"
#import "LLTimeLineController.h"
#import "LLAnimitaController.h"
#import "LLTransformTableViewController.h"
#import "LLBezierPathController.h"
#import "LLWeiboPhotoController.h"
#import "LLChartLineController.h"
#import "LLMemunViewController.h"
#import "LLFaceRecognitionController.h"
#import "LLEncryptionController.h"
#import "LLUDIDViewController.h"
#import "LLWaterFlowLayoutController.h"
#import "LLGPUImageViewController.h"
#import "SDupimageViewController.h"
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
    [self.tableView registerClass:[LLMainTableViewCell class] forCellReuseIdentifier:@"LLMainTableViewCell"];
    [self.tableView registerClass:[LLDemoHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"LLDemoHeaderFooterView"];
    [self setupData];
    self.tableView.tableFooterView = [UIView new];
    
    self.view.backgroundColor = [UIColor whiteColor];
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
        LLMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMainTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.indexPath = indexPath;
        cell.model = model;
        return cell;
    }else {
        
        return [UITableViewCell new];
    
    }

   

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLDemoModel * model = self.demoTitleArr[indexPath.section];
    
    if (model.headFootClick) {
        return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[LLMainTableViewCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width] +5;
    }else {
        return 0.0001;
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LLDemoHeaderFooterView * headFootView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LLDemoHeaderFooterView"];
    LLDemoModel * model = self.demoTitleArr[section];
    headFootView.model =model;
    __weak typeof(self) weak = self;
    headFootView.block = ^(LLDemoHeaderFooterView * headFootView) {
        model.headFootClick = !model.headFootClick;
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:section];
        [weak.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
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
        }else if (indexPath.row == 2) {//首页动画较为实用
            LLAnimitaController * AnimitaVc = [LLAnimitaController new];
            AnimitaVc.title = @"首页动画较为实用";
            [self.navigationController pushViewController:AnimitaVc animated:true];
        }else if (indexPath.row == 3) { //tabView旋转90度使用
            LLTransformTableViewController * TransformTable = [LLTransformTableViewController new];
            TransformTable.title = @"首页动画较为实用";
            [self.navigationController pushViewController:TransformTable animated:true];
        }
    
    
    }else if (indexPath.section == 3) {// 2017-03-29更新

        if (indexPath.row == 0) {
            
            LLSelectPhotoController * selectPhotoVc = [LLSelectPhotoController new];
            selectPhotoVc.title = @"调用相机选择多张图片";
            [self.navigationController pushViewController:selectPhotoVc animated:true];
        }else if (indexPath.row == 1) {//断点下载，支持后台下载，再次打开程序、异常退出记录下载进度
           UIStoryboard * sb = [UIStoryboard storyboardWithName:@"ZFDownloadViewController" bundle:nil];
            UITabBarController * tabVc = sb.instantiateInitialViewController;
           [self.navigationController pushViewController:tabVc animated:true];
        }else if (indexPath.row == 2) {//模仿淘宝部分购物界面
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LLShoppingViewController" bundle:nil];
            LLShoppingViewController * shopVC = sb.instantiateInitialViewController;
             [self.navigationController pushViewController:shopVC animated:true];

        }else if (indexPath.row == 3) {//模仿淘宝选衣服
            LLSelectClothesController * selectClothesVc = [LLSelectClothesController new];
            selectClothesVc.title = @"模仿淘宝选衣服";
            [self.navigationController pushViewController:selectClothesVc animated:true];
        }else if (indexPath.row == 4) {//时间轴
            LLTimeLineController * TimeLineVc = [LLTimeLineController new];
            TimeLineVc.title = @"时间轴";
            [self.navigationController pushViewController:TimeLineVc animated:true];
        }else if (indexPath.row == 5) {
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LLBezierPathController" bundle:nil];
            LLBezierPathController * BezierPathVC = sb.instantiateInitialViewController;
            BezierPathVC.title = @"动画的微妙之处之贝塞尔曲线一部分";

            [self.navigationController pushViewController:BezierPathVC animated:true];
        }else if (indexPath.row == 6){
            LLWeiboPhotoController *WeiboPhotoVc = [LLWeiboPhotoController new];
            WeiboPhotoVc.title = @"仿新浪微博图片选择器";
            [self.navigationController pushViewController:WeiboPhotoVc animated:true];
        }

    }else if (indexPath.section == 4) {// 2017-04-05更新
        if (indexPath.row == 0) {//ios股票曲线
            
            LLChartLineController *ChartLineVc = [LLChartLineController new];
            ChartLineVc.title = @"ios股票曲线";
            [self.navigationController pushViewController:ChartLineVc animated:true];
        }else if (indexPath.row ==1) {
            LLMemunViewController *MemunVc = [LLMemunViewController new];
            MemunVc.title = @"仿京东商品选择器";
            [self.navigationController pushViewController:MemunVc animated:true];

        }else if (indexPath.row ==2) {
            LLFaceRecognitionController *FaceRecognitionVc = [LLFaceRecognitionController new];
            FaceRecognitionVc.title = @"ios人脸识别";
            [self.navigationController pushViewController:FaceRecognitionVc animated:true];

        }else if (indexPath.row == 3) {
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LLEncryptionController" bundle:nil];
            LLBezierPathController * EncryptionVc = sb.instantiateInitialViewController;
           
            EncryptionVc.title = @"ios加密+盐";
            [self.navigationController pushViewController:EncryptionVc animated:true];
            

        }else if(indexPath.row == 4) {//获取设备标识符 UDID IDFA等等
            LLUDIDViewController *UDIDVc = [LLUDIDViewController new];
            UDIDVc.title = @"获取设备标识符 UDID IDFA等等";
            [self.navigationController pushViewController:UDIDVc animated:true];
            

        }else if (indexPath.row == 5) {//很好看的瀑布流展示效果图👍
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LLWaterFlowLayoutController" bundle:nil];
            LLWaterFlowLayoutController * WaterFlowLayout = sb.instantiateInitialViewController;
            
            WaterFlowLayout.title = @"很好看的瀑布流展示效果图👍";
            [self.navigationController pushViewController:WaterFlowLayout animated:true];

        }else if (indexPath.row == 6) {
            LLGPUImageViewController *GPUImage = [LLGPUImageViewController new];
            GPUImage.title = @"使用GPUImage实现人脸美白和人脸识别(磨皮，人脸检测) ";
            [self.navigationController pushViewController:GPUImage animated:true];
        }else if (indexPath.row == 7) {
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"SDupimage" bundle:nil];
            SDupimageViewController * upimage = sb.instantiateInitialViewController;
            
            upimage.title = @"新版上传照片";
            [self.navigationController pushViewController:upimage animated:true];
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
