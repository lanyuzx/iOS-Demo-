//
//  BMScanDefaultCotroller.h
//  BMScanDemo
//
//  Created by ___liangdahong on 2017/4/28.
//  Copyright © http://idhong.com All rights reserved.
//  Copyright © https://github.com/asiosldh/BMScan All rights reserved.
//

#import "BMScanController.h"
#import "BMScanDefaultDataSource.h"

@class BMScanDefaultCotroller;

/**
 包含UI 的扫描控制器
 */
@interface BMScanDefaultCotroller : BMScanController <BMScanDefaultDataSource>

@property (strong, nonatomic, readonly) UILabel *scanfTitleLabel; ///< 标题label

@end
