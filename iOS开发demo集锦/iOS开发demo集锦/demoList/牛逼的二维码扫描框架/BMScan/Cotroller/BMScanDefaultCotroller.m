
//
//  BMScanDefaultCotroller.m
//  BMScanDemo
//
//  Created by ___liangdahong on 2017/4/28.
//  Copyright © http://idhong.com All rights reserved.
//  Copyright © https://github.com/asiosldh/BMScan All rights reserved.
//

#import "BMScanDefaultCotroller.h"
#import "BMDefaultUIView.h"
#import "UIImage+BMScan.h"
#import "BMScanDataSource.h"
#import "BMScanDelegate.h"

@interface BMScanDefaultCotroller ()

@property (strong, nonatomic) BMDefaultUIView *scanSettingView;
@property (weak, nonatomic) id <BMScanDefaultDataSource> dataSource; ///< 数据源代理（配置信息）

@end

@implementation BMScanDefaultCotroller


@dynamic dataSource;

#pragma mark -

- (instancetype)init {
    if (self = [super init]) {
        self.dataSource = self;
    }
    return self;
}

#pragma mark - 生命周期

- (void)dealloc {
    NSLog(@"dealloc - BMScanDefaultCotroller");
}

- (void)viewDidLoad {

    [super viewDidLoad];
    [self.view insertSubview:self.scanSettingView atIndex:1];
    self.scanSettingView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.scanSettingView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.scanSettingView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottonConstraint = [NSLayoutConstraint constraintWithItem:self.scanSettingView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.scanSettingView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    [self.view addConstraints:@[topConstraint, leftConstraint, bottonConstraint, rightConstraint]];
    
    self.scanSettingView.feetImageView1.image = [UIImage bm_loadImageWithName:@"bm_scan_image_qr_corner_001_@2x"];
    self.scanSettingView.feetImageView2.image = [UIImage bm_loadImageWithName:@"bm_scan_image_qr_corner_002_@2x"];
    self.scanSettingView.feetImageView3.image = [UIImage bm_loadImageWithName:@"bm_scan_image_qr_corner_003_@2x"];
    self.scanSettingView.feetImageView4.image = [UIImage bm_loadImageWithName:@"bm_scan_image_qr_corner_004_@2x"];
    self.scanSettingView.scanfLinView.image   = [UIImage bm_loadImageWithName:@"bm_scan_image_qr_scan_line@2x"];

    if ([self.dataSource respondsToSelector:@selector(areaYInscanController:)]) {
        self.scanSettingView.topLayoutConstraint.constant = [self.dataSource areaYInscanController:self];
    }

    if ([self.dataSource respondsToSelector:@selector(areaXInscanController:)]) {
        self.scanSettingView.leftLayoutConstraint.constant = [self.dataSource areaXInscanController:self];
    }
    
    if ([self.dataSource respondsToSelector:@selector(areaWidthInscanController:)]) {
        self.scanSettingView.widthLayoutConstraint.constant = [self.dataSource areaWidthInscanController:self];
    }
    
    if ([self.dataSource respondsToSelector:@selector(areaXHeightInscanController:)]) {
        self.scanSettingView.heightLayoutConstraint.constant = [self.dataSource areaXHeightInscanController:self];
    }
    
    if ([self.dataSource respondsToSelector:@selector(areaTitleDistanceHeightInscanController:)]) {
        self.scanSettingView.titleLabelBottonLayoutConstraint.constant = [self.dataSource areaTitleDistanceHeightInscanController:self];
    }
    
    if ([self.dataSource respondsToSelector:@selector(areaColorInscanController:)]) {
        UIColor *color = [self.dataSource areaColorInscanController:self];
        [self.scanSettingView.backgroundViewArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.backgroundColor =  color;
        }];
    }

    if ([self.dataSource respondsToSelector:@selector(feetColorInscanController:)]) {
        UIColor *color = [self.dataSource feetColorInscanController:self];
        [self.scanSettingView.feetViewArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.image = [obj.image bm_imageWithColor:color];
        }];
    }

    if ([self.dataSource respondsToSelector:@selector(leftTopColorInscanController:)]) {
        self.scanSettingView.feetImageView1.image = [self.scanSettingView.feetImageView1.image bm_imageWithColor:[self.dataSource leftTopColorInscanController:self]];
    }

    if ([self.dataSource respondsToSelector:@selector(leftBottonColorInscanController:)]) {
        self.scanSettingView.feetImageView3.image = [self.scanSettingView.feetImageView3.image bm_imageWithColor:[self.dataSource leftBottonColorInscanController:self]];
    }
    
    if ([self.dataSource respondsToSelector:@selector(rightTopInscanController:)]) {
        self.scanSettingView.feetImageView2.image = [self.scanSettingView.feetImageView2.image bm_imageWithColor:[self.dataSource rightTopInscanController:self]];
    }

    if ([self.dataSource respondsToSelector:@selector(rightBottonInscanController:)]) {
        self.scanSettingView.feetImageView4.image = [self.scanSettingView.feetImageView4.image bm_imageWithColor:[self.dataSource rightBottonInscanController:self]];
    }
    
    if ([self.dataSource respondsToSelector:@selector(scanfLinInscanController:)]) {
        self.scanSettingView.scanfLinView.image = [self.scanSettingView.scanfLinView.image bm_imageWithColor:[self.dataSource scanfLinInscanController:self]];
    }

    if ([self.dataSource respondsToSelector:@selector(scanLinViewAnimationInscanController:)]) {
        self.scanSettingView.scanLinViewAnimation = [self.dataSource scanLinViewAnimationInscanController:self];
    }
    
    if ([self.dataSource respondsToSelector:@selector(scanLinInscanController:)]) {
        BMScanLin scanLin = [self.dataSource scanLinInscanController:self];
        self.scanSettingView.scanLin = scanLin;
        if (scanLin == BMScanLinTypeLin) {
            return;
        }
        if (scanLin == BMScanLinTypeReticular1) {
            self.scanSettingView.scanImageView1.image = [UIImage bm_loadImageWithName:@"qrcode_scan_full_net"];
        } else if (scanLin == BMScanLinTypeReticular2) {
            self.scanSettingView.scanImageView1.image = [UIImage bm_loadImageWithName:@"qrcode_scan_part_net"];
        }
        if ([self.dataSource respondsToSelector:@selector(scanfLinInscanController:)]) {
            UIColor *color = [self.dataSource scanfLinInscanController:self];
            self.scanSettingView.scanImageView1.image = [self.scanSettingView.scanImageView1.image bm_imageWithColor:color];
        }
    }
}

#pragma mark - getters setters

- (BMDefaultUIView *)scanSettingView {
    if (!_scanSettingView) {
        _scanSettingView = [BMDefaultUIView defaultUIView];
    }
    return _scanSettingView;
}

- (UILabel *)scanfTitleLabel {
    return self.scanSettingView.scanTitleLabel;
}

#pragma mark - 系统delegate

#pragma mark - 自定义delegate

- (void)scanController:(BMScanController *)scanController captureWithValueString:(NSString *)valueString {
    [self closureScanning];
}

- (CGRect)rectOfInterestInScanController:(BMScanController *)scanController {
    [self.view layoutIfNeeded];
    return self.scanSettingView.scanfAreaView.frame;
}

- (CGFloat)areaXInscanController:(BMScanController *)scanController {
    return [self addConstraint];
}

- (CGFloat)areaYInscanController:(BMScanController *)scanController {
    return [self addConstraint];
}

#pragma mark - 公有方法

- (CGFloat)addConstraint {
    
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:self.scanSettingView.areaView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.scanSettingView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:self.scanSettingView.areaView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.scanSettingView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.scanSettingView addConstraints:@[c1, c2]];
    return 0;
}

- (void)startScanning {
    [super startScanning];
    [self.scanSettingView startAnimation];
}

- (void)closureScanning {
    [super closureScanning];
    [self.scanSettingView stopAnimation];
}

#pragma mark - 私有方法
#pragma mark - 事件响应

@end
