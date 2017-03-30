//
//  ViewController.m
//  FTT_RoundView
//
//  Created by cmcc on 16/8/29.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "LLAnimitaController.h"
#import "BtnModel.h"
#import "FTT_Roundview.h"
@interface LLAnimitaController ()
@property (nonatomic , strong) UIButton *button;
@property (nonatomic , strong) FTT_Roundview *romate ;
@property (nonatomic , strong) NSMutableArray *datasource ;
@end

@implementation LLAnimitaController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    FTT_Roundview *romate = [[FTT_Roundview alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    romate.center = self.view.center;
    self.romate = romate;
    _datasource = [NSMutableArray new];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"BtnList.plist" ofType:nil];
    NSArray *contentArray = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *item  in contentArray) {
        BtnModel *model = [[BtnModel alloc]init];
        [model setValuesForKeysWithDictionary:item];
        [_datasource addObject:model];
    }
    NSMutableArray *titleArray = [NSMutableArray new];
    NSMutableArray *imageArray = [NSMutableArray new];
    for (BtnModel *model  in _datasource) {
        
        [titleArray addObject:model.title];
        [imageArray addObject:model.Image1];
        
    }
    [romate BtnType:FTT_RoundviewTypeCustom BtnWitch:100 adjustsFontSizesTowidth:YES msaksToBounds:YES conrenrRadius:50 image:imageArray TitileArray:titleArray titileColor:[UIColor blackColor]];
    //__weak typeof(self) *weakself = self;
    romate.back = ^(NSInteger num ,NSString *name ) {
        [self pushView:num name:name];
    };
    [self.view addSubview:romate];
    
    _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _button.center = self.view.center;
    _button.backgroundColor = [UIColor yellowColor];
    _button.layer.cornerRadius = 25;
    [_button addTarget:self action:@selector(showItems:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_button];
}
- (void)showItems:(UIButton *)sender{
    [_romate show];
    
    
}
// 跳转界面
- (void)pushView:(NSInteger)num name:(NSString *)name {
    NSMutableArray *classArray = [NSMutableArray new];
    for (BtnModel *model  in _datasource) {
        [classArray addObject:model.ClassName];
    }
    Class class = NSClassFromString(classArray[num]);
    UIViewController *vc = [[class alloc]init];
    vc.title = name;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

@end
