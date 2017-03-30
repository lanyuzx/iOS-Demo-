//
//  FTT_Roundview.m
//  iOS开发UINavigation系列
//
//  Created by cmcc on 16/8/24.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "FTT_Roundview.h"
#import "KTOneFingerRotationGestureRecognizer.h"


@interface FTT_Roundview ()
// 按钮数组
@property (nonatomic , strong) NSMutableArray *btnArray;

@property (nonatomic , assign) CGFloat rotationAngleInRadians;
// 是否展示
@property (nonatomic , assign) BOOL isShow;

@property (nonatomic , strong) NSMutableArray *nameArray ;

@end

@implementation FTT_Roundview

static FTT_Roundview *shareInstance;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.frame.size.width / 2 ;
        self.Witch = self.frame.size.width;
        self.backgroundColor = [UIColor redColor];
        _btnArray = [NSMutableArray new];
        _nameArray = [NSMutableArray new];
        [self addGestureRecognizer:[[KTOneFingerRotationGestureRecognizer alloc]initWithTarget:self action:@selector(changeMove:)]];
        _isShow = NO;
        
    }
    return self;
}




- (void)BtnType:(FTT_RoundviewType)type BtnWitch:(CGFloat)BtnWitch  adjustsFontSizesTowidth:(BOOL)sizeWith  msaksToBounds:(BOOL)msak conrenrRadius:(CGFloat)radius image:(NSMutableArray *)image TitileArray:(NSMutableArray *)titileArray titileColor:(UIColor *)titleColor {
    CGFloat corner = -M_PI * 2.0 / titileArray.count;
    CGFloat r = (self.Witch  - BtnWitch) / 2 ;
    CGFloat x = self.Witch  / 2 ;
    CGFloat y = self.Witch  / 2 ;
    _nameArray = titileArray;
    for (int i = 0 ; i < titileArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, BtnWitch, BtnWitch);
        btn.layer.masksToBounds = msak;
        btn.layer.cornerRadius = radius;
        CGFloat  num = (i + 3 - 0.1) * 1.0;
        btn.center = CGPointMake(x + r * cos(corner * num), y + r *sin(corner * num));
        btn.backgroundColor = self.BtnBackgroudColor;
        self.BtnWitch = BtnWitch;
        if (type == FTT_RoundviewTypeCustom) {
            UIImageView *imageview = [[UIImageView alloc]init];
            imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",image[i]]];
            imageview.contentMode = UIViewContentModeScaleAspectFit ;
            imageview.userInteractionEnabled = NO;
            imageview.frame = CGRectMake(25, 15, 50, 35);
            [btn addSubview:imageview];
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageview.frame) + 15, BtnWitch - 20 , 20)];
            lable.text = titileArray[i];
            lable.textColor = [UIColor blackColor];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.adjustsFontSizeToFitWidth = YES;
            lable.tag = i;
            [btn addSubview:lable];
            
        }else {
            [btn setTitle:titileArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:titleColor forState:UIControlStateNormal];
        }
        btn.tag = i;
        [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [_btnArray addObject:btn];
        
    }
}
/**
 *  是否展示视图
 */
- (void)show {
    if (_isShow) {
        [UIView animateWithDuration:0.5 animations:^{
            CGFloat corner = -M_PI * 2.0 / _btnArray.count;
            CGFloat r = (self.Witch  - self.BtnWitch) / 2 ;
            CGFloat x = self.Witch  / 2 ;
            CGFloat y = self.Witch  / 2 ;
            for (int i = 0 ; i < _btnArray.count ; i ++) {
                UIButton *btn = _btnArray[i];
                CGFloat  num = (i + 3 - 0.1) * 1.0;
                btn.center = CGPointMake(x + r * cos(corner * num), y + r *sin(corner * num));
                btn.alpha = 1 ;
            }
        }];
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            for (int i = 0; i < _btnArray.count; i++ ) {
                UIButton *btn = _btnArray[i];
                btn.center = CGPointMake(self.Witch   / 2 ,self.Witch   /2);
                btn.alpha = 0 ;
            }
        }];
    }
    _isShow = !_isShow;
}

/**
 *  按钮点击事件
 *
 *   */
- (void)btn: (UIButton *)btn {
    _isShow = YES ;
    NSInteger num1 = btn.tag;
    NSString *name = _nameArray[num1];
    [self show];
    self.back(num1,name);
  
}
/**
 *  移动后btn的位置
 *
 *
 */
- (void)changeMove:(KTOneFingerRotationGestureRecognizer *)retation {
    if (self.btnArray.count < 13) {
        if (self.rotationAngleInRadians == 0 && retation.rotation > 0) {
            return;
        }
    }
    self.transform = CGAffineTransformMakeRotation(self.rotationAngleInRadians+retation.rotation);
    for (UIButton *btn in _btnArray) {
        btn.transform = CGAffineTransformMakeRotation(-(self.rotationAngleInRadians+retation.rotation));
    }
    self.rotationAngleInRadians += retation.rotation;
}

@end
