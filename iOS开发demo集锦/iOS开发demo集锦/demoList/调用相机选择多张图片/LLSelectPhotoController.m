//
//  ViewController.m
//  相片相机
//
//  Created by ZJF on 16/5/31.
//  Copyright © 2016年 ZJF. All rights reserved.
//

#import "LLSelectPhotoController.h"
#import "postPicViewController.h"


@interface LLSelectPhotoController ()

@end

@implementation LLSelectPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * btn = [UIButton new];
    [btn setTitle:@"选择照片" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor]];
    btn.frame = CGRectMake(CGRectGetWidth(self.view.frame) / 2 - 100, CGRectGetHeight(self.view.frame) / 2, 200, 35);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)btn:(UIButton *)sender {
    
    
    postPicViewController * p = [[postPicViewController alloc]init];
    
    
    [self.navigationController pushViewController:p animated:NO];
    
    
}
@end
