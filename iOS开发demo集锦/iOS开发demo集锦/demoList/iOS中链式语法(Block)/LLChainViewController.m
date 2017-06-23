//
//  ViewController.m
//  iOS中的链式语法
//
//  Created by 周尊贤 on 2017/6/6.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLChainViewController.h"
#import "LLRedView.h"
@interface LLChainViewController ()

@end

@implementation LLChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
      self.view.backgroundColor = [UIColor whiteColor];
   //调用
    LLRedView * read =  LLRedView.makeDo()
    .frameBlock(CGRectMake(0, 0, 120, 120))
    .colorBlock([UIColor redColor])
    .typeBlock(1000)
    .titleBlock(@"摸摸哒😆");
    
    [self.view addSubview:read];
    
  
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
