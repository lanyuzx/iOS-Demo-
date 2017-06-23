//
//  HRAdView.m
//  AutoAdLabelScroll
//
//  Created by 陈华荣 on 16/4/6.
//  Copyright © 2016年 陈华荣. All rights reserved.
//

#import "HRAdView.h"
#define ViewWidth  self.bounds.size.width
#define ViewHeight  self.bounds.size.height

@interface HRAdView ()

/**
 *  文字广告条前面的图标
 */
@property (nonatomic, strong) UIImageView *headImageView;

/**
 轮流显示的第一个Label
 */
@property (nonatomic, strong) UILabel *oneLabel;

/**
 轮流显示的第二个Label
 */
@property (nonatomic, strong) UILabel *twoLabel;

/**
 *  计时器
 */
@property (nonatomic, strong) NSTimer *timer;

@end


@implementation HRAdView
{
    NSUInteger index;
    CGFloat margin;
    BOOL isBegin;
}

- (instancetype)initWithTitles:(NSArray *)titles {
    
    self = [super init];
    
    if (self) {
        margin = 0;
        self.clipsToBounds = YES;
        self.adTitles = titles;
        self.headImg = nil;
        self.labelFont = [UIFont systemFontOfSize:16];
        self.color = [UIColor blackColor];
        self.time = 2.0f;
        self.textAlignment = NSTextAlignmentLeft;
        self.isHaveTouchEvent = NO;
        self.edgeInsets = UIEdgeInsetsZero;
        self.defaultMargin = 0;
        index = 0;
        
        if (!_headImageView) {
            _headImageView = [UIImageView new];
        }
        
        if (!_oneLabel) {
            _oneLabel = [self createLabel];
            if (self.adTitles.count > 0) {
                _oneLabel.text = [NSString stringWithFormat:@"%@", self.adTitles[index]];
            }
            [self addSubview:_oneLabel];
        }
        
        if (!_twoLabel) {
            _twoLabel = [self createLabel];
            [self addSubview:_twoLabel];
        }
    }
    return self;
}

- (UILabel *)createLabel {
    UILabel *label = [UILabel new];
    label.font = self.labelFont;
    label.textColor = self.color;
    label.textAlignment = self.textAlignment;
    label.numberOfLines = self.numberOfTextLines;
    return label;
}

- (void)timeRepeat {
    if (self.adTitles.count <= 1) {
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    
    __block UILabel *currentLabel;
    __block UILabel *hidenLabel;
    __weak typeof(self) weakself = self;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel *label = obj;
            NSString *string = weakself.adTitles[index];
            if ([label.text isEqualToString:string]) {
                currentLabel = label;
            }else{
                hidenLabel = label;
            }
        }
    }];
    
    if (index != self.adTitles.count - 1) {
        index++;
    } else {
        index = 0;
    }
    
    hidenLabel.text = [NSString stringWithFormat:@"%@", self.adTitles[index]];
    [UIView animateWithDuration:1 animations:^{
        hidenLabel.frame = CGRectMake(margin, 0, ViewWidth - margin, ViewHeight);
        currentLabel.frame = CGRectMake(margin, -ViewHeight, ViewWidth - margin, ViewHeight);
    } completion:^(BOOL finished) {
        currentLabel.frame = CGRectMake(margin, ViewHeight, ViewWidth - margin, ViewHeight);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.headImg) {
        [self addSubview:self.headImageView];
        
        self.headImageView.frame = CGRectMake(self.edgeInsets.left,
                                              self.edgeInsets.top,
                                              ViewHeight - self.edgeInsets.top - self.edgeInsets.bottom,
                                              ViewHeight - self.edgeInsets.top - self.edgeInsets.bottom
                                              );
        margin = CGRectGetMaxX(self.headImageView.frame) + self.defaultMargin;
    } else {
        if (self.headImageView) {
            [self.headImageView removeFromSuperview];
            self.headImageView = nil;
        }
        margin = self.defaultMargin;
    }
    
    self.oneLabel.frame = CGRectMake(margin, 0, ViewWidth - margin, ViewHeight);
    self.twoLabel.frame = CGRectMake(margin, ViewHeight, ViewWidth - margin, ViewHeight);
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:self.time target:self selector:@selector(timeRepeat) userInfo:self repeats:YES];
    }
    return _timer;
}

- (void)beginScroll {
    if (self.timer.isValid) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)closeScroll {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    _edgeInsets = edgeInsets;
}

- (void)setIsHaveTouchEvent:(BOOL)isHaveTouchEvent {
    if (isHaveTouchEvent) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickEvent:)];
        [self addGestureRecognizer:tapGestureRecognizer];
    } else {
        self.userInteractionEnabled = NO;
    }
}

- (void)setTime:(NSTimeInterval)time {
    _time = time;
    if (self.timer.isValid) {
        [self.timer isValid];
        self.timer = nil;
    }
}

- (void)setHeadImg:(UIImage *)headImg {
    _headImg = headImg;
    
    self.headImageView.image = headImg;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    
    self.oneLabel.textAlignment = _textAlignment;
    self.twoLabel.textAlignment = _textAlignment;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    self.oneLabel.textColor = _color;
    self.twoLabel.textColor = _color;
}

- (void)setLabelFont:(UIFont *)labelFont {
    _labelFont = labelFont;
    self.oneLabel.font = _labelFont;
    self.twoLabel.font = _labelFont;
}

- (void)setNumberOfTextLines:(NSInteger)numberOfTextLines {
    _numberOfTextLines = numberOfTextLines;
    self.oneLabel.numberOfLines = _numberOfTextLines;
    self.twoLabel.numberOfLines = _numberOfTextLines;
}

- (void)clickEvent:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self.adTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (index % 2 == 0 && [self.oneLabel.text isEqualToString:obj]) {
            if (self.clickAdBlock) {
                self.clickAdBlock(index);
            }
        } else if (index % 2 != 0 && [self.twoLabel.text isEqualToString:obj]) {
            if (self.clickAdBlock) {
                self.clickAdBlock(index);
            }
        }
    }];
}


@end
