//
//  UIImage+BMScan.h
//  BMScanDemo
//
//  Created by __liangdahong on 2017/4/30.
//  Copyright © http://idhong.com All rights reserved.
//  Copyright © https://github.com/asiosldh/BMScan All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BMScan)

//改变图片颜色
- (instancetype)bm_imageWithColor:(UIColor *)color;

/**
 加载 BMScan.bundle 中的图片

 @param name 图片名称
 @return UIImage
 */
+ (instancetype)bm_loadImageWithName:(NSString *)name;

@end
