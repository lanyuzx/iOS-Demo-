//
//  LLQRZDYViewController.m
//  iOS开发demo集锦
//
//  Created by 周尊贤 on 2017/5/17.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLQRZDYViewController.h"
#import "BMColorSelectVC.h"
#import "BMZDYScanVC.h"
@interface LLQRZDYViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSelect;
@property (weak, nonatomic) IBOutlet UIButton *scanLinColor;
@property (weak, nonatomic) IBOutlet UIButton *scanFootColor;
@end

@implementation LLQRZDYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:0 target:self action:@selector(okClick)];
}

- (void)okClick {
    BMZDYScanVC *VC = [BMZDYScanVC new];
    VC.scanLin = self.typeSelect.selectedSegmentIndex;
    VC.footColor = self.scanFootColor.backgroundColor;
    VC.linColor = self.scanLinColor.backgroundColor;
    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)typeSelectClick:(id)sender {
}

- (IBAction)scanLin:(id)sender {
    BMColorSelectVC *vc = [BMColorSelectVC new];
    vc.color = self.scanLinColor.backgroundColor;
    vc.colorSelectBlock = ^(UIColor *color){
        self.scanLinColor.backgroundColor = color;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)scanFoot:(id)sender {
    BMColorSelectVC *vc = [BMColorSelectVC new];
    vc.color = self.scanFootColor.backgroundColor;
    vc.colorSelectBlock = ^(UIColor *color){
        self.scanFootColor.backgroundColor = color;
    };
    [self.navigationController pushViewController:vc animated:YES];
    
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
