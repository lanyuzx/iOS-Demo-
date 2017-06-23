//
//  LLLEEAlterViewController.m
//  iOS开发demo集锦
//
//  Created by 周尊贤 on 2017/6/8.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLLEEAlterViewController.h"
#import "ActionSheetTableViewController.h"
#import "AlertTableViewController.h"
@interface LLLEEAlterViewController ()

@end

@implementation LLLEEAlterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * alterBtn = [UIButton new];
    alterBtn.tag = 10;
    [alterBtn setTitle:@"弹框示例" forState:UIControlStateNormal];
    [alterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    alterBtn.backgroundColor = [UIColor orangeColor];
    alterBtn.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 60, CGRectGetMidY(self.view.frame)-35, 120, 35);
    [self.view addSubview:alterBtn];
    [alterBtn addTarget:self action:@selector(alterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * sheetBtn = [UIButton new];
    sheetBtn.tag = 20;
    [sheetBtn setTitle:@"actionSheet示例" forState:UIControlStateNormal];
    [sheetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sheetBtn.backgroundColor = [UIColor orangeColor];
    sheetBtn.frame = CGRectMake(CGRectGetMidX(alterBtn.frame) - 100, CGRectGetMaxY(alterBtn.frame) + 50, 200, 35);
    [self.view addSubview:sheetBtn];
    [sheetBtn addTarget:self action:@selector(alterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)alterBtnClick:(UIButton*)btn{
    
    if (btn.tag == 10) {
        [self.navigationController pushViewController:[AlertTableViewController new] animated:true];
    }else{
        [self.navigationController pushViewController:[ActionSheetTableViewController new] animated:true];
    }
    
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
