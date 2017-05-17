//
//  BMScanDefaultDataSource.h
//  BMScanDemo
//
//  Created by __liangdahong on 2017/4/29.
//  Copyright © http://idhong.com All rights reserved.
//  Copyright © https://github.com/asiosldh/BMScan All rights reserved.
//

#import <Foundation/Foundation.h>

@class BMScanController;
@protocol BMScanDataSource;

/**
 参考系统动画 fillMode
 */
typedef NS_ENUM(NSUInteger, BMScanLinViewAnimation) {
    BMScanLinViewAnimationTypeCAFillModeForwards,
    BMScanLinViewAnimationTypeCAFillModeBackwards,
    BMScanLinViewAnimationTypeCAFillModeBoth,
    BMScanLinViewAnimationTypeCAFillModeRemoved,
};

/**
 扫描线条类型

 - BMScanLinTypeLin: 扫描线
 - BMScanLinTypeReticular1: 网状1
 - BMScanLinTypeReticular2: 网状2
 */
typedef NS_ENUM(NSUInteger, BMScanLin) {
    BMScanLinTypeLin,
    BMScanLinTypeReticular1,
    BMScanLinTypeReticular2,
};

/**
 BMScanDefaultCotroller 的数据源协议
 */
@protocol BMScanDefaultDataSource <BMScanDataSource>

@optional

/**
 扫描区域 X 值

 @param scanController 扫描控制器
 @return X 值
 */
- (CGFloat)areaXInscanController:(BMScanController *)scanController;

/**
 扫描区域 Y 值
 
 @param scanController 扫描控制器
 @return Y 值
 */
- (CGFloat)areaYInscanController:(BMScanController *)scanController;

/**
 扫描区域 Width 值
 
 @param scanController 扫描控制器
 @return Width 值
 */
- (CGFloat)areaWidthInscanController:(BMScanController *)scanController;

/**
 扫描区域 Height 值
 
 @param scanController 扫描控制器
 @return Height 值
 */
- (CGFloat)areaXHeightInscanController:(BMScanController *)scanController;

#pragma mark -

/**
 标题距扫描区域的距离

 @param scanController 扫描控制器
 @return 距离
 */
- (CGFloat)areaTitleDistanceHeightInscanController:(BMScanController *)scanController;

#pragma mark -

/**
 非扫描区域的颜色

 @param scanController 扫描控制器
 @return 颜色值
 */
- (UIColor *)areaColorInscanController:(BMScanController *)scanController;

/**
 脚颜色

 @param scanController 扫描控制器
 @return 颜色值
 */
- (UIColor *)feetColorInscanController:(BMScanController *)scanController;

/**
 左上脚颜色
 
 @param scanController 扫描控制器
 @return 颜色值
 */
- (UIColor *)leftTopColorInscanController:(BMScanController *)scanController;

/**
 左下脚颜色
 
 @param scanController 扫描控制器
 @return 颜色值
 */
- (UIColor *)leftBottonColorInscanController:(BMScanController *)scanController;

/**
 右上脚颜色
 
 @param scanController 扫描控制器
 @return 颜色值
 */
- (UIColor *)rightTopInscanController:(BMScanController *)scanController;

/**
 右下脚颜色
 
 @param scanController 扫描控制器
 @return 颜色值
 */
- (UIColor *)rightBottonInscanController:(BMScanController *)scanController;

/**
 扫描线条颜色（扫描条或者什么网均可自定义颜色）

 @param scanController 扫描控制器
 @return 颜色值
 */
- (UIColor *)scanfLinInscanController:(BMScanController *)scanController;

/**
 扫描线条动画

 @param scanController 扫描控制器
 @return 动画值
 */
- (BMScanLinViewAnimation)scanLinViewAnimationInscanController:(BMScanController *)scanController;

/**
 扫描线条类型

 @param scanController 扫描控制器
 @return 扫描线条类型
 */
- (BMScanLin)scanLinInscanController:(BMScanController *)scanController;

@end
