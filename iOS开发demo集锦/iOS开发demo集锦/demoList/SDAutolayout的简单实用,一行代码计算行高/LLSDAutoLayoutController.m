//
//  ViewController.m
//  仿微信cell小弹框
//
//  Created by JYD on 2017/2/4.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLSDAutoLayoutController.h"
#import "TableViewCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "LLModel.h"
@interface LLSDAutoLayoutController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LLSDAutoLayoutController

{
    NSMutableArray * _textArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _textArray = [NSMutableArray array];
  NSArray * textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，https://github.com/gsdios/SDAutoLayout大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，https://github.com/gsdios/SDAutoLayout等于把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    for (int i =0; i<100; i++) {
        
        int random = arc4random_uniform(4);
        LLModel * model = [LLModel new];
        model.text = textArray[random];
        switch (random) {
            case 0:
                model.photoArr = @[@"图片一"];
                break;
            case 1:
                 model.photoArr = @[@"图片一",@"图片一"];
                break;
            case 2:
                  model.photoArr = @[@"图片一",@"图片一",@"图片一"];
                break;
            case 3:
                 model.photoArr = @[@"图片一",@"图片一",@"图片一",@"图片一"];
                break;
                default:
                break;
        }
        [_textArray addObject:model];
  
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UILabel *label = [[UILabel alloc] init];
        label.text = @"保存成功O(∩_∩)O~";
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
        label.layer.cornerRadius = 5;
        label.clipsToBounds = YES;
        label.bounds = CGRectMake(0, 0, 150, 30);
        label.center = self.view.center;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:17];
        [[UIApplication sharedApplication].keyWindow addSubview:label];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:label];
        [label performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
    

    });

    
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _textArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ViewController"];
    if (cell == nil) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ViewController"];
    }else {
    

    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _textArray[indexPath.row];
     [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    return cell;


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LLModel * model = _textArray[indexPath.row];
//    CGFloat height = [model.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil].size.height;
//    return height + 40;
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    
    CGFloat height = [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[TableViewCell class] contentViewWidth:[self cellContentViewWith]];
    return height;

    
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
@end
