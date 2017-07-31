//
//  LLDownSelecteController.m
//  iOS开发demo集锦
//
//  Created by 周尊贤 on 2017/7/31.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLDownSelecteController.h"
#import "LLDownSelectedView.h"
@interface LLDownSelecteController ()
@property (nonatomic, weak) LLDownSelectedView *down;
@end

@implementation LLDownSelecteController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LLDownSelectedView *down = [[LLDownSelectedView alloc]initWithFrame:CGRectMake(30, 100, 100, 40)];
   
    down.listArray = @[@"选择项1",@"选择项2", @"选择项3",@"选择项4",@"选择项5", @"选择项6",@"选择项7",@"选择项8", @"选择项9"];
    down.placeholder = @"选择项";
     
    down.layer.cornerRadius = 10;
    down.layer.masksToBounds = true;
  //  down.layer.borderColor = [UIColor redColor].CGColor;
    //down.layer.borderWidth = 4;
    [self.view addSubview:down];
    self.down = down;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.down close];
//    
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
