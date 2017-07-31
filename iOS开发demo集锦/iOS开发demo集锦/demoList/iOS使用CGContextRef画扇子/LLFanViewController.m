//
//  LLFanViewController.m
//  iOS开发demo集锦
//
//  Created by 周尊贤 on 2017/7/31.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLFanViewController.h"
#import "LLFanView.h"
@interface LLFanViewController ()

@end

@implementation LLFanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LLFanView * drawView = [[LLFanView alloc]initWithFrame:CGRectMake(0, 120, [UIScreen mainScreen].bounds.size.width, 180)];
    [self.view addSubview:drawView];
    drawView.block = ^(NSString * title){
        
        UIAlertView * altertView = [[UIAlertView alloc]initWithTitle:@"提示" message: title delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [altertView show];
        
    };
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
