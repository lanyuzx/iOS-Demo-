//
//  BMColorSelectVC.h
//  BMScanDemo
//
//  Created by __liangdahong on 2017/5/16.
//  Copyright © 2017年 月亮小屋（中国）有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BMColorSelectBlock)(UIColor *color);

@interface BMColorSelectVC : UIViewController

@property (strong, nonatomic) UIColor *color;

@property (copy, nonatomic) BMColorSelectBlock colorSelectBlock;

@end
