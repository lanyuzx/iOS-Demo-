//
//  BMDefaultUIView.h
//  BMScanDemo
//
//  Created by ___liangdahong on 2017/4/28.
//  Copyright © http://idhong.com All rights reserved.
//  Copyright © https://github.com/asiosldh/BMScan All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMScanDefaultDataSource.h"

@interface BMDefaultUIView : UIView

@property (strong, nonatomic) UIImageView *scanImageView1; ///< 扫描imageView

@property (assign, nonatomic) BMScanLinViewAnimation scanLinViewAnimation; ///< 扫描线动画类型
@property (assign, nonatomic) BMScanLin scanLin; ///< 扫描线动画类型

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelBottonLayoutConstraint;
@property (weak, nonatomic) IBOutlet UIView *scanfAreaView;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray <UIView *> *backgroundViewArray;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray <UIImageView *>*feetViewArray;

@property (weak, nonatomic) IBOutlet UIImageView *feetImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *feetImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *feetImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *feetImageView4;
@property (weak, nonatomic) IBOutlet UIImageView *scanfLinView;
@property (weak, nonatomic) IBOutlet UILabel *scanTitleLabel;

@property (weak, nonatomic) IBOutlet UIView *areaView;

+ (instancetype)defaultUIView;

- (void)startAnimation;
- (void)stopAnimation;

@end
