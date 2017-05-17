//
//  LLQRDefaultController.m
//  iOS开发demo集锦
//
//  Created by 周尊贤 on 2017/5/17.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLQRDefaultController.h"

@interface LLQRDefaultController ()

@end

@implementation LLQRDefaultController

-(void)scanController:(BMScanController *)scanController captureWithValueString:(NSString *)valueString {
    
    [self closureScanning];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [scanController startScanning];
    });


}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
