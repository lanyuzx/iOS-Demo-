//
//  HWDownSelectedView.m
//  HWDownSelectedTF
//
//  Created by HanWei on 15/12/15.
//  Copyright © 2015年 AndLiSoft. All rights reserved.
//

#import "LLDownSelectedView.h"

/// 动画的时间
NSTimeInterval const animationDuration = 0.2f;

/// 分割线的颜色
#define kLineColor [UIColor colorWithRed:219/255.0 green:217/255.0 blue:216/255.0 alpha:1]

CGFloat angleValue(CGFloat angle) {
    return (angle * M_PI) / 180;
}

@interface LLDownSelectedView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITextField *contentLabel;
@property (nonatomic, strong) UIButton *clickBtn;
@property (nonatomic, strong) UIImageView *arrowImgView;
@property (nonatomic, strong) UIView *arrowImgBgView;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, assign) BOOL isOpen;
/// 执行打开关闭动画是否结束
@property (nonatomic, assign) BOOL beDone;

@end

@implementation LLDownSelectedView

#pragma mark - life cycle 
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _commintInit];
        [self updateConstraints];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _commintInit];
    }
    return self;
}

#pragma mark - private
- (void)_commintInit
{
    /// 默认设置
    //self.backgroundColor = [UIColor whiteColor];
    
    _font = [UIFont systemFontOfSize:14.f];
    _textColor = [UIColor blackColor];
    _textAlignment = NSTextAlignmentLeft;
    
    /// 默认不展开
    _isOpen = NO;
    
    /// 默认是完成动画的
    _beDone = YES;
    
    /// 初始化UI
    [self.arrowImgBgView addSubview:self.arrowImgView];
    [self addSubview:self.arrowImgBgView];
    [self addSubview:self.contentLabel];
    [self addSubview:self.clickBtn];
    
}

#pragma mark - action
- (void)clickBtnClicked
{
    //NSLog(@"btn clicked");
    
    if (!_beDone) return;
    
    /// 关闭页面上其他下拉控件
    for (UIView *subview in self.superview.subviews) {
        if ([subview isKindOfClass:[LLDownSelectedView class]] && subview != self) {
            LLDownSelectedView *donwnSelectedView = (LLDownSelectedView *)subview;
            if (donwnSelectedView.isOpen) {
                [donwnSelectedView close];
            }
        }
    }

    if (_isOpen) {
        [self close];
    } else {
        [self show];
    }
}

#pragma mark - public
- (void)show
{
    if (_isOpen || _listArray.count == 0) return;

    _beDone = NO;
    
    [self.superview addSubview:self.listTableView];
    /// 避免被其他子视图遮盖住
    [self.superview bringSubviewToFront:self.listTableView];
    CGRect frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame), CGRectGetWidth(self.frame), 0);
    [self.listTableView setFrame:frame];
    self.listTableView.rowHeight = CGRectGetHeight(self.frame);
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
    
                         if (self.listArray.count > 0) {
                             [self.listTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                                       atScrollPosition:UITableViewScrollPositionTop
                                                               animated:YES];
                         }
                         
                         CGRect frame = self.listTableView.frame;
                         NSInteger count = MIN(4, self.listArray.count);
                         frame.size.height = count * self.frame.size.height;
                         
                         /// 防止超出屏幕
                         if (frame.origin.y + frame.size.height > [UIScreen mainScreen].bounds.size.height) {
                             frame.size.height -= frame.origin.y + frame.size.height - [UIScreen mainScreen].bounds.size.height;
                         }
                         [self.listTableView setFrame:frame];
                         
                         self.arrowImgView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {

                         _beDone = YES;
                         _isOpen = YES;

                     }
     ];
}

- (void)close
{
    if (!_isOpen) return;
    
    _beDone = NO;
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         CGRect frame = self.listTableView.frame;
                         frame.size.height = 0.f;
                         [self.listTableView setFrame:frame];
                         
                         self.arrowImgView.transform = CGAffineTransformRotate(self.arrowImgView.transform, angleValue(-180));
                     }
                     completion:^(BOOL finished) {
                         
                         [self.listTableView setContentOffset:CGPointZero animated:NO];
                         if (self.listTableView.superview) [self.listTableView removeFromSuperview];
                         
                         _beDone = YES;
                         _isOpen = NO;
                         
                     }
     ];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        UILabel *contentLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 2, self.frame.size.width-10, self.frame.size.height-4)];
        contentLable.tag = 1000;
        contentLable.textColor = _textColor;
        contentLable.font = _font;
        [cell addSubview:contentLable];
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = kLineColor;
        lineView.frame = CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5);
        [cell addSubview:lineView];
    }
    UILabel *contentLabel = (UILabel *)[cell viewWithTag:1000];
    contentLabel.text = _listArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.contentLabel.text = [_listArray objectAtIndex:indexPath.row];
    [self close];
    if ([self.delegate respondsToSelector:@selector(downSelectedView:didSelectedAtIndex:)]) {
        [self.delegate downSelectedView:self didSelectedAtIndex:indexPath];
    }
}


#pragma mark - Public

- (void)setFont:(UIFont *)font
{
    _font = font;
    self.contentLabel.font = font;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.contentLabel.textColor = textColor;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    self.contentLabel.textAlignment = textAlignment;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    self.contentLabel.placeholder = placeholder;
}

- (void)setListArray:(NSArray *)listArray
{
    _listArray = listArray;
    
    [self.listTableView reloadData];
}

- (NSString *)text
{
    return self.contentLabel.text;
}

#pragma mark - getter

- (UITextField *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [UITextField new];
        _contentLabel.placeholder = @"点击进行选择";
        _contentLabel.enabled = NO;
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = _textColor;
        _contentLabel.font = _font;
        _contentLabel.textAlignment = _textAlignment;
    }
    return _contentLabel;
}

- (UIButton *)clickBtn
{
    if (!_clickBtn) {
        _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clickBtn.backgroundColor = [UIColor clearColor];
        _clickBtn.layer.borderColor = [UIColor redColor].CGColor;
        _clickBtn.layer.borderWidth = 0.5f;
        [_clickBtn addTarget:self action:@selector(clickBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickBtn;
}

- (UIImageView *)arrowImgView
{
    if (!_arrowImgView) {
        _arrowImgView = [UIImageView new];
        _arrowImgView.image = [UIImage imageNamed:@"arrow_up.png"];
        _arrowImgView.transform = CGAffineTransformRotate(self.arrowImgView.transform, angleValue(-180));
    }
    return _arrowImgView;
}

- (UIView *)arrowImgBgView
{
    if (!_arrowImgBgView) {
        _arrowImgBgView = [[UIView alloc] initWithFrame:CGRectZero];
        _arrowImgBgView.backgroundColor = [UIColor clearColor];
    }
    return _arrowImgBgView;
}

- (UITableView *)listTableView
{
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listTableView.layer.borderWidth = 0.5;
        _listTableView.layer.borderColor = kLineColor.CGColor;
        _listTableView.scrollsToTop = NO;
        _listTableView.bounces = NO;
        _listTableView.dataSource = self;
        _listTableView.delegate = self;
        _listTableView.separatorColor = kLineColor;
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _listTableView;
}

#pragma mark - Layout

- (void)updateConstraints
{
    //NSLog(@"updateConstraints");
    
    // 箭头
    self.arrowImgView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [NSLayoutConstraint constraintWithItem:self.arrowImgView
                                                                           attribute:NSLayoutAttributeCenterX
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.arrowImgBgView
                                                                           attribute:NSLayoutAttributeCenterX
                                                                          multiplier:1.0
                                                                            constant:0.0],
                                              [NSLayoutConstraint constraintWithItem:self.arrowImgView
                                                                           attribute:NSLayoutAttributeCenterY
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.arrowImgBgView
                                                                           attribute:NSLayoutAttributeCenterY
                                                                          multiplier:1.0
                                                                            constant:0.0]
                                              ]];
    
    self.arrowImgBgView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [NSLayoutConstraint constraintWithItem:self
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.arrowImgBgView
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1.0
                                                                            constant:0.0],
                                              [NSLayoutConstraint constraintWithItem:self
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.arrowImgBgView
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0
                                                                            constant:0.0],
                                              [NSLayoutConstraint constraintWithItem:self
                                                                           attribute:NSLayoutAttributeBottom
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.arrowImgBgView
                                                                           attribute:NSLayoutAttributeBottom
                                                                          multiplier:1.0
                                                                            constant:0.0],
                                              [NSLayoutConstraint constraintWithItem:self.arrowImgBgView
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1.0
                                                                            constant:30]
                                              ]];
    
    // 内容label
    self.contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [NSLayoutConstraint constraintWithItem:self.contentLabel
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1.0
                                                                            constant:5.0],
                                              [NSLayoutConstraint constraintWithItem:self.contentLabel
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0
                                                                            constant:0.0],
                                              [NSLayoutConstraint constraintWithItem:self.contentLabel
                                                                           attribute:NSLayoutAttributeBottom
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeBottom
                                                                          multiplier:1.0
                                                                            constant:0.0],
                                              [NSLayoutConstraint constraintWithItem:self.contentLabel
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.arrowImgBgView
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1.0
                                                                            constant:0.0]
                                              ]];
    
    self.clickBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [NSLayoutConstraint constraintWithItem:self.clickBtn
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1.0
                                                                            constant:0.0],
                                              [NSLayoutConstraint constraintWithItem:self.clickBtn
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0
                                                                            constant:0.0],
                                              [NSLayoutConstraint constraintWithItem:self.clickBtn
                                                                           attribute:NSLayoutAttributeBottom
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeBottom
                                                                          multiplier:1.0
                                                                            constant:0.0],
                                              [NSLayoutConstraint constraintWithItem:self.clickBtn
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1.0
                                                                            constant:0.0]
                                              ]];
    [super updateConstraints];
}

@end
