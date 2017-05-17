//
//  BMScanDataSource.h
//  BMScanDemo
//
//  Created by ___liangdahong on 2017/4/28.
//  Copyright © http://idhong.com All rights reserved.
//  Copyright © https://github.com/asiosldh/BMScan All rights reserved.
//

#import <Foundation/Foundation.h>

@class BMScanController;

/**
 扫描数据源协议
 */
@protocol BMScanDataSource <NSObject>

@optional

/**
 设置可以识别区域

 @param scanController 扫描控制器
 @return 可识别区域
 */
- (CGRect)rectOfInterestInScanController:(BMScanController *)scanController;

@end
