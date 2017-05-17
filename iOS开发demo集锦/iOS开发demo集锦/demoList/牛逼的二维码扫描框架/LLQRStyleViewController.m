//
//  LLQRStyleViewController.m
//  iOS开发demo集锦
//
//  Created by 周尊贤 on 2017/5/17.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLQRStyleViewController.h"
#define kw  [[UIScreen mainScreen] bounds].size.width
#define kh  [[UIScreen mainScreen] bounds].size.height
@interface LLQRStyleViewController ()

@end

@implementation LLQRStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scanController:(BMScanController *)scanController captureWithValueString:(NSString *)valueString {
    
    [self closureScanning];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [scanController startScanning];
    });
}

- (CGFloat)areaXInscanController:(BMScanController *)scanController {
    
    return (kw  - 200)/2.0;
}

- (CGFloat)areaYInscanController:(BMScanController *)scanController {
    return 100;
}

- (CGFloat)areaWidthInscanController:(BMScanController *)scanController {
    
    return 200;
}

- (CGFloat)areaXHeightInscanController:(BMScanController *)scanController {
    
    return 200;
}
- (CGFloat)areaTitleDistanceHeightInscanController:(BMScanController *)scanController {
    return 10;
}

- (UIColor *)areaColorInscanController:(BMScanController *)scanController {
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:arc4random_uniform(100)/100.0];
}

- (UIColor *)feetColorInscanController:(BMScanController *)scanController {
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}

- (UIColor *)scanfLinInscanController:(BMScanController *)scanController {
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}

- (BMScanLinViewAnimation)scanLinViewAnimationInscanController:(BMScanController *)scanController {
    return arc4random_uniform(4);
}

- (BMScanLin)scanLinInscanController:(BMScanController *)scanController {
    return self.scanLin;
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
