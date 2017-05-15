//
//  LLJSPersonCenterController.m
//  iOS开发demo集锦
//
//  Created by 周尊贤 on 2017/5/15.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLJSPersonCenterController.h"
#import "HomePageViewController.h"
@interface LLJSPersonCenterController ()

@end

@implementation LLJSPersonCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [UIButton new ];
    [btn setTitle:@"跳转仿简书个人中心停靠" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(CGRectGetMaxX(self.view.frame) /2 - 60, CGRectGetMaxY(self.view.frame)/2, 120, 35);
    [btn addTarget:self action:@selector(pushJSVc) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushJSVc {
    
    HomePageViewController * homePage = [HomePageViewController new];
    homePage.title = @"跳转仿简书个人中心停靠";
    [self.navigationController pushViewController:homePage animated:true];
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
