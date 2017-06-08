//
//  LanYaViewController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/1/3.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "LanYaViewController.h"
#import "PeripheralController.h"
#import "CentralController.h"

@interface LanYaViewController ()
{
    UIButton *peripheralButton;
    UIButton *centralButton;
}
@end

@implementation LanYaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    peripheralButton=[[UIButton alloc]initWithFrame:CGRectMake (20, 100, 200, 40)];
    [peripheralButton setBackgroundColor:[UIColor magentaColor]];
    [peripheralButton setTitle:@"外设" forState:UIControlStateNormal];
    [peripheralButton addTarget:self action:@selector(peripheralAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:peripheralButton];
    
    
    
    centralButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 180, 200, 40)];
    [centralButton setBackgroundColor:[UIColor magentaColor]];
    [centralButton setTitle:@"中心" forState:UIControlStateNormal];
    [centralButton addTarget:self action:@selector(centralAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:centralButton];

    // Do any additional setup after loading the view.
}


- (void)peripheralAction{
    
    PeripheralController *per = [[PeripheralController alloc]init];
    
    
    [self.navigationController pushViewController:per animated:YES];
    
    
}


- (void)centralAction{
    CentralController  *central = [[CentralController alloc]init];
    [self.navigationController pushViewController:central animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
