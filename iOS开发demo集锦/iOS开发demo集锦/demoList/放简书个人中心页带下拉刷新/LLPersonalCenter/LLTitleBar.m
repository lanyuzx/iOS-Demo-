//
//  LLTitleBar.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/14.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLTitleBar.h"
#import "Masonry.h"
@interface LLTitleBar ()

@property (nonatomic, strong) UIView *sliderView;

@property (nonatomic, weak) UIButton *selectedButton;

@end
@implementation LLTitleBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    
}

#pragma mark - Event Response
- (void)titleButtonClicked:(UIButton *)button
{
    _selectedIndex = button.tag;
    
    if (self.selectedButton)
    {
        self.selectedButton.selected = YES;
    }
    button.selected = NO;
    self.selectedButton = button;
    
    if (self.buttonSelected)
    {
        self.buttonSelected(button.tag);
    }
    
    NSString* title = self.titles[button.tag];
    CGFloat sliderWidth = button.titleLabel.font.pointSize * title.length;
    [self.sliderView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(sliderWidth));
        make.height.equalTo(@4);
        make.centerX.equalTo(button);
        make.bottom.equalTo(self).offset(-3);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}

#pragma mark - Private Method

#pragma mark - Setters And Getters

- (UIView *)sliderView
{
    if (!_sliderView)
    {
        UIView* sliderView = [[UIView alloc] init];
        sliderView.backgroundColor = [UIColor yellowColor];
        sliderView.layer.cornerRadius = 2;
        sliderView.clipsToBounds = YES;
        _sliderView = sliderView;
    }
    return _sliderView;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    UIButton* button = self.subviews[selectedIndex];
    [self titleButtonClicked:button];
}

- (void)setTitles:(NSArray *)titles
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _titles = titles;
    CGFloat width = [UIScreen mainScreen].bounds.size.width / titles.count;
    
    for ( int i = 0; i<titles.count; i++ )
    {
        UIButton* titleButton = [self titleButton:titles[i]];
        titleButton.tag = i;
        [self addSubview:titleButton];
        [titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset(width * i);
            make.width.equalTo(@(width));
        }];
        if (i != 0)
        {
            titleButton.selected = YES;
        }else{
            self.selectedButton = titleButton;
        }
    }
    
    
    UIButton* button = self.subviews[0];
    NSString* title = titles[0];
    CGFloat sliderWidth = button.titleLabel.font.pointSize * title.length;
    [self addSubview:self.sliderView];
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(sliderWidth));
        make.height.equalTo(@4);
        make.centerX.equalTo(button);
        make.bottom.equalTo(self).offset(-3);
    }];
    [self layoutIfNeeded];
}

- (UIButton *)titleButton:(NSString *)title
{
    UIButton* titleButton = [[UIButton alloc] init];
    [titleButton addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [titleButton setTitle:title forState:UIControlStateNormal];
    
    return titleButton;
}


@end
