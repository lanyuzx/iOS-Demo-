//
//  LLCalendarViewController.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/14.
//  Copyright © 2017年 周尊贤. All rights reserved.
//
#define BA_Weak  __weak __typeof(self) weakSelf = self
#import "LLCalendarViewController.h"
#import "GFCalendar.h"
#import "getData.h"
@interface LLCalendarViewController ()
@property (nonatomic,strong)  GFCalendarView * calendarView;
@end

@implementation LLCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [UIButton new];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn setTitle:@"弹出日历" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(CGRectGetMidX(self.view.frame) -60, CGRectGetMidY(self.view.frame), 120, 35);
    [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)buttonClick{
    
    if (self.calendarView == nil) {
        NSDate * currentDate = [getData convertDateFromString:@"2017-03-14"];
          NSDate * endDate = [getData convertDateFromString:@"2016-03-14"];
      
        self.calendarView = [[GFCalendarView alloc]initWithFrameOrigin:  CGPointMake(0 , CGRectGetMidY(self.view.frame) - 100) width:self.view.frame.size.width  startdate:endDate enddate:currentDate];
      
        
        [self.view addSubview:self.calendarView];
        [self animationAlert:self.calendarView];
        //日历点击的回掉
        BA_Weak;
        self.calendarView.didSelectDayHandler = ^(NSInteger year, NSInteger month, NSInteger day) {
            [weakSelf.calendarView removeFromSuperview];
            weakSelf.calendarView = nil;
            UIAlertView * atlerView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"%zd年%zd月%zd日",year,month,day] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [atlerView show];
        };
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)animationAlert:(UIView *)view
{
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
    
    
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
