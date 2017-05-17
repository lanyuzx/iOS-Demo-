//
//  BMZDYScanVC.m
//  BMScanDemo
//
//  Created by __liangdahong on 2017/5/16.
//  Copyright © 2017年 月亮小屋（中国）有限公司. All rights reserved.
//

#import "BMZDYScanVC.h"

@interface BMZDYScanVC ()

@end

@implementation BMZDYScanVC

- (void)scanController:(BMScanController *)scanController captureWithValueString:(NSString *)valueString {
    [self closureScanning];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [scanController startScanning];
    });
}

- (BMScanLin)scanLinInscanController:(BMScanController *)scanController {
    return self.scanLin;
}

- (UIColor *)scanfLinInscanController:(BMScanController *)scanController {
    return self.linColor;
}

- (UIColor *)feetColorInscanController:(BMScanController *)scanController {
    return self.footColor;
}

@end
