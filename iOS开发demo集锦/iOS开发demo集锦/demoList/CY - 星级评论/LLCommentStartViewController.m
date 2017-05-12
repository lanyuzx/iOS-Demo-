//
//  LLCommentStartViewController.m
//  iOS开发demo集锦
//
//  Created by 周尊贤 on 2017/5/12.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLCommentStartViewController.h"
#import "HCSStarRatingView.h"
@interface LLCommentStartViewController ()
{
    HCSStarRatingView * starView ;
    UILabel * label;

}
@end

@implementation LLCommentStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    starView = [[HCSStarRatingView alloc]initWithFrame:CGRectMake(20, 100, 280, 50)];
    
    starView.maximumValue = 5;//默认5
    starView.minimumValue = 1;//默认0,不能选择比minimumValue小的星星值，当你没有选择星星时value也是minimumValue
    //    starView.value = 3;//当前值，默认0
    
    //是否允许半星，默认NO
    starView.allowsHalfStars = YES;
    
    //是否是否允许精确选择 可以根据选择位置进行精确，默认NO
    starView.accurateHalfStars = YES;
    
    //星星的颜色
    starView.tintColor = [UIColor colorWithRed:232/255.0 green:156/255.0 blue:39/255.0 alpha:1.0];//默认蓝色
    
    //设置空星时的图片
    starView.emptyStarImage = [[UIImage imageNamed:@"heart-empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];//UIImageRenderingModeAlwaysTemplate 始终根据Tint Color绘制图片，忽略图片的颜色信息。
    //设置全星时的图片
    starView.filledStarImage = [[UIImage imageNamed:@"heart-full"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [starView addTarget:self action:@selector(didChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:starView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(100, 180, 100, 40)];
    label.text = [NSString stringWithFormat:@"%f",starView.value];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didChange:(HCSStarRatingView*)sender{
    //    NSLog(@"starView.value:%f",starView.value);
    label.text = [NSString stringWithFormat:@"%f",sender.value];
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
