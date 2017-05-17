//
//  BMScanDelegate.h
//  BMScanDemo
//
//  Created by ___liangdahong on 2017/4/28.
//  Copyright © http://idhong.com All rights reserved.
//  Copyright © https://github.com/asiosldh/BMScan All rights reserved.
//

#import <Foundation/Foundation.h>

@class BMScanController;

/**
 扫描协议
 */
@protocol BMScanDelegate <NSObject>

@required

/**
 扫描到内容时回调

 @param scanController 控制器
 @param valueString 扫描到的内容
 */
- (void)scanController:(BMScanController *)scanController captureWithValueString:(NSString *)valueString;

@end
