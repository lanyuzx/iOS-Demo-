//
//  ViewController.m
//  AutoAdLabelScroll
//
//  Created by 陈华荣 on 16/4/6.
//  Copyright © 2016年 陈华荣. All rights reserved.
//

#import "LLTextLoopController.h"
#import "HRAdView.h"
#import "DetailViewController.h"

@interface LLTextLoopController ()
@property (nonatomic, strong) HRAdView *adView;

@end

@implementation LLTextLoopController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@"111111111111111111111111111111111111111111111111111",@"22222222",@"33333333"];
    
    HRAdView * view = [[HRAdView alloc]initWithTitles:array];
    view.frame = CGRectMake(5, 64, self.view.frame.size.width-10, 44);
    view.textAlignment = NSTextAlignmentLeft;//默认
    view.isHaveTouchEvent = YES;
    view.labelFont = [UIFont boldSystemFontOfSize:17];
    view.color = [UIColor redColor];
    view.time = 2.0f;
    view.defaultMargin = 10;
    view.numberOfTextLines = 2;
    view.edgeInsets = UIEdgeInsetsMake(8, 8,8, 10);
    __weak typeof(self) weakself = self;
    view.clickAdBlock = ^(NSUInteger index){
        DetailViewController *vc = [[DetailViewController alloc]init];
        
        vc.text = [NSString stringWithFormat:@"%@",array[index]];
        [weakself.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@",array[index]);
    };
    view.headImg = [UIImage imageNamed:@"laba.png"];
    [self.view addSubview:view];
    self.adView = view;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.layer.borderWidth = 1.0f;
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds  = YES;
    UIButton *beginScrollBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 200, 80, 40)];
    [beginScrollBtn addTarget:self action:@selector(startScroll:) forControlEvents:UIControlEventTouchDown];
    [beginScrollBtn setBackgroundColor:[UIColor darkGrayColor]];
    [beginScrollBtn setTitle:@"开始" forState:UIControlStateNormal];
    [beginScrollBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:beginScrollBtn];
    
    
    UIButton *endScrollBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-110, 200, 80, 40)];
    [endScrollBtn addTarget:self action:@selector(endScroll:) forControlEvents:UIControlEventTouchDown];
    [endScrollBtn setBackgroundColor:[UIColor darkGrayColor]];
    [endScrollBtn setTitle:@"结束" forState:UIControlStateNormal];
    [endScrollBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:endScrollBtn];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    [self.adView beginScroll];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.adView closeScroll];
    
}


- (void)startScroll:(UIButton *)sender{
    /**
     *  手动控制滚动
     */
    [self.adView beginScroll];
    [self scaleTheView:sender];
}

- (void)endScroll:(UIButton *)sender{
    /**
     *  停止滚动
     */
    [self.adView closeScroll];
    [self scaleTheView:sender];
    
}

- (void)scaleTheView:(UIButton *)button{
    
    [UIView animateWithDuration:0.2f animations:^{
        CGFloat value = 0.8f;
        button.transform = CGAffineTransformMakeScale(value, value);
    }completion:^(BOOL finished) {
        CGFloat value = 1.0f;
        button.transform = CGAffineTransformMakeScale(value, value);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
