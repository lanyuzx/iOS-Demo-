//
//  SMKDropSelectMenu.m
//  test
//
//  Created by Mac on 17/4/5.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "SMKDropSelectMenu.h"
#import <objc/runtime.h>

#define SMKCOLOR(r, g, b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0]
#define KMaskBackGroundViewColor  [UIColor colorWithRed:40/255 green:40/255 blue:40/255 alpha:0.1]
#define Kscreen_width  [UIScreen mainScreen].bounds.size.width
#define Kscreen_height [UIScreen mainScreen].bounds.size.height
#define KTitleButtonHeight 42
#define KCellHeight 42
#define KTitleButtonTag 1000

#define SMKOBJCSetObject(object,value)  objc_setAssociatedObject(object,@"title" , value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)

#define SMKOBJCGetObject(object) objc_getAssociatedObject(object, @"title")

@interface SMKDropSelectMenu ()<UICollectionViewDelegate,UICollectionViewDataSource>
/**
 *  标题按钮数组
 */
@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, strong) UIView *bottomBarView;

@property (nonatomic) UIButton  *tempButton;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic) UIView  *maskBackGroundView;

@property (nonatomic) CGFloat selfOriginalHeight ;

@property (nonatomic)NSMutableArray *collectionDataArray;

@property (nonatomic, strong) UIButton *resetButton;

@property (nonatomic, strong) NSArray *tempTitleArray;

@end

@implementation SMKDropSelectMenu

+ (instancetype)dropSelectMenu {
    return [[SMKDropSelectMenu alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.isShowFirstButtonImage = YES;
        self.selfOriginalHeight = (frame.size.height <= 0 ? 40 : self.selfOriginalHeight);
        self.dropMenuMaxHeight = KCellHeight * 4.5 + 20;
        [self addSubview:self.maskBackGroundView];
        [self setupUI];

    }
    return self;
}

- (void)setupUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 2 - 8, 42);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, Kscreen_width, 0) collectionViewLayout:layout];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.scrollsToTop = NO;
    [self.collectionView registerClass:[SMKDropSelectMenuCell class] forCellWithReuseIdentifier:@"SMKDropSelectMenuCell"];
    [self addSubview:self.collectionView];
}

-  (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    self.tempTitleArray = titleArray;
    
    NSInteger count = titleArray.count;
    [self.topBarView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.buttonArray removeAllObjects];
    
    for (NSInteger index = 0; index < count; index++) {
        
        UIButton *titleButton=[UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.backgroundColor = [UIColor whiteColor];
        [titleButton setTitle:self.titleArray[index] forState:UIControlStateNormal];
        [titleButton setTitleColor:(self.titleButtonNormalColor == nil ? SMKCOLOR(0, 0, 0) : self.titleButtonSelectedColor) forState:UIControlStateNormal];
        [titleButton setTitleColor:(self.titleButtonSelectedColor == nil ? SMKCOLOR(250, 66, 76) : self.titleButtonSelectedColor) forState:UIControlStateSelected];
        titleButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        titleButton.tag = KTitleButtonTag + index ;
        [titleButton addTarget:self action:@selector(titleButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (!self.isShowFirstButtonImage && index == 0) {
            
        } else {
            [titleButton setImage:[UIImage imageNamed:@"daosanjiao"] forState:UIControlStateNormal];
            titleButton.imageEdgeInsets = UIEdgeInsetsMake(0,titleButton.titleLabel.intrinsicContentSize.width+3.5, 0, -titleButton.titleLabel.intrinsicContentSize.width-3.5);
            titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, -titleButton.imageView.bounds.size.width-3.5, 0, titleButton.imageView.bounds.size.width+3.5);
        }
        
        [self.topBarView addSubview:titleButton];
        [self.buttonArray addObject:titleButton];
        
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.maskBackGroundView.frame = CGRectMake(0,0,self.frame.size.width, Kscreen_height - self.frame.origin.y);
    self.topBarView.frame = CGRectMake(0, 0, self.frame.size.width, KTitleButtonHeight);
    self.bottomBarView.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), self.frame.size.width, 44);
    self.resetButton.frame = self.bottomBarView.bounds;
    
    CGFloat width = self.frame.size.width / self.buttonArray.count;
    for (UIButton *button in self.buttonArray) {
        NSInteger index = [self.buttonArray indexOfObject:button];
        button.frame= CGRectMake(width * index, 0, width, KTitleButtonHeight);
    }
    
}

#pragma mark --------------------  collectionView 数据源  --------------------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger index = 0;
    if (self.tempButton != nil) {
        index =  self.tempButton.tag - KTitleButtonTag;
    }
    NSInteger count = [self.menuDataArray[index] count];
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellD = @"SMKDropSelectMenuCell";
    SMKDropSelectMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellD forIndexPath:indexPath];
    
    NSUInteger index =  self.tempButton.tag - KTitleButtonTag;
    cell.title = [self.menuDataArray[index] objectAtIndex:indexPath.item];
    
    if ([cell.menuTextLabel.text isEqualToString:SMKOBJCGetObject(self.tempButton)]) {
        cell.isSelected = YES;
        cell.menuTextLabel.textColor = [UIColor colorWithRed:250/255.0 green:66/255.0 blue:76/255.0 alpha:1.0];
    } else {
        cell.isSelected=NO;
        cell.menuTextLabel.textColor = SMKCOLOR(0, 0, 0);
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    SMKDropSelectMenuCell *cell = (SMKDropSelectMenuCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.isSelected = YES;
    
    [self.tempButton setTitle:cell.menuTextLabel.text forState:UIControlStateNormal];
    
    self.tempButton.imageEdgeInsets = UIEdgeInsetsMake(0,self.tempButton.titleLabel.intrinsicContentSize.width+3.5, 0, -self.tempButton.titleLabel.intrinsicContentSize.width-3.5);
    self.tempButton.titleEdgeInsets = UIEdgeInsetsMake(0, -self.tempButton.imageView.bounds.size.width-3.5, 0, self.tempButton.imageView.bounds.size.width+3.5);
    
    SMKOBJCSetObject(self.tempButton, cell.menuTextLabel.text);
    
    if (self.handleSelectDataBlock) {
        self.handleSelectDataBlock(cell.menuTextLabel.text, indexPath.row,self.tempButton.tag - KTitleButtonTag);
    }
    
    [self dismiss];
    
}

#pragma mark --------------------  事件  --------------------

- (void)resetAction {
    
    [self dismiss];
    self.titleArray = self.tempTitleArray;
}

- (void)titleButtonClickAction:(UIButton *)titleButton {
    
    NSUInteger index =  titleButton.tag - KTitleButtonTag;
    
    if (self.handleSelectButtonBlock) {
        self.handleSelectButtonBlock(index);
    }
    
    if (self.isFirstResetButton &&  index == 0) {
        return;
    }
    
    for (UIButton *button in self.buttonArray) {
        if (button == titleButton) {
            button.selected=!button.selected;
            self.tempButton =button;
            [self changeButtonObject:button TransformAngle:M_PI];
        }else
        {
            button.selected=NO;
            [self changeButtonObject:button TransformAngle:0];
        }
    }
    
    if (titleButton.selected) {
        
        [self changeButtonObject:titleButton TransformAngle:M_PI];
        self.collectionDataArray = self.menuDataArray[index];
        //设置默认选中第一项。
        if ([SMKOBJCGetObject(self.tempButton) length]<1) {
            
            NSString *title = self.collectionDataArray.firstObject;
            SMKOBJCSetObject(self.tempButton, title);
            [self.collectionView reloadData];
        }

        if (self.collectionDataArray.count > 0) {
            [self.collectionView reloadData];
            
            CGFloat tableViewHeight =  self.collectionDataArray.count / 2 * KCellHeight + 20> self.dropMenuMaxHeight ? self.dropMenuMaxHeight : self.collectionDataArray.count / 2 * KCellHeight;
            
            [self expandWithViewHeight:tableViewHeight];
            self.bottomBarView.hidden = NO;
        } else {
            [self dismiss];
        }
        
    } else {
        [self dismiss];
    }
}

#pragma mark - 展开菜单
-(void)expandWithViewHeight:(CGFloat )height {
    

    CGRect rect = self.frame;
    rect.size.height = Kscreen_height - self.frame.origin.y;
    self.frame= rect;
    
    [self showSpringAnimationWithDuration:0.3 animations:^{
        
        self.collectionView.frame = CGRectMake(0, self.selfOriginalHeight, self.frame.size.width, height);
        
    } completion:^{
        self.maskBackGroundView.hidden=NO;
    }];
}

#pragma mark - 收起菜单
-(void)dismiss {
    for (UIButton *button in self.buttonArray) {
        button.selected=NO;
        [self changeButtonObject:button TransformAngle:0];
    }
    self.bottomBarView.hidden = YES;
    CGRect rect = self.frame;
    rect.size.height = self.selfOriginalHeight;
    self.frame = rect;
    
    [self showSpringAnimationWithDuration:.3 animations:^{
        
        self.collectionView.frame = CGRectMake(0, self.selfOriginalHeight, Kscreen_width,0);
        
    } completion:^{
        self.maskBackGroundView.hidden=YES;
    }];
    
}

#pragma mark --------------------  动画  --------------------

-(void)changeButtonObject:(UIButton *)button TransformAngle:(CGFloat)angle {
    [UIView animateWithDuration:0.5 animations:^{
        button.imageView.transform =CGAffineTransformMakeRotation(angle);
    } completion:^(BOOL finished) {
    }];
    
}

-(void)showSpringAnimationWithDuration:(CGFloat)duration
                            animations:(void (^)())animations
                            completion:(void (^)())completion {
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        if (animations) {
            animations();
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}



#pragma mark --------------------  懒加载  --------------------

- (NSArray *)tempTitleArray {
    if (!_tempTitleArray) {
        _tempTitleArray = [NSArray array];
    }
    return _tempTitleArray;
}

- (NSMutableArray *)menuDataArray {
    if (!_menuDataArray) {
        _menuDataArray = [NSMutableArray array];
    }
    return _menuDataArray;
}
- (UIView *)topBarView {
    if (!_topBarView) {
        _topBarView = [[UIView alloc]init];
        _topBarView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_topBarView];
    }
    return _topBarView;
}
- (UIView *)bottomBarView {
    if (!_bottomBarView) {
        _bottomBarView = [[UIView alloc]init];
        _bottomBarView.backgroundColor = [UIColor whiteColor];
        _bottomBarView.hidden = YES;
        [self addSubview:_bottomBarView];
    }
    return _bottomBarView;
}

- (UIButton *)resetButton {
    if (!_resetButton) {
        _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetButton setTitle:@"恢复默认" forState:UIControlStateNormal];
        _resetButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        [_resetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_resetButton addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomBarView addSubview:_resetButton];
    }
    return _resetButton;
}
- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
-(UIView *)maskBackGroundView {
    if (!_maskBackGroundView) {
        _maskBackGroundView=[[UIView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width, Kscreen_height - self.frame.origin.y)];
        _maskBackGroundView.backgroundColor = KMaskBackGroundViewColor;
        _maskBackGroundView.hidden = YES;
        _maskBackGroundView.userInteractionEnabled=YES;
        _maskBackGroundView.alpha = 0.6;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [_maskBackGroundView addGestureRecognizer:tap];
    }
    return _maskBackGroundView;
}


@end


@implementation SMKDropSelectMenuCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.menuTextLabel = [[UILabel alloc]init];
    self.menuTextLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self.contentView addSubview:self.menuTextLabel];
    
    self.menuImageView = [[UIImageView alloc]init];
    self.menuImageView.image = [UIImage imageNamed:@"menu_choose_"];
    [self.contentView addSubview:self.menuImageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.menuImageView.frame = CGRectMake(self.contentView.frame.size.width - 15 - 13, 27, 13, 10);
    self.menuTextLabel.frame = CGRectMake(15, 25, self.contentView.frame.size.width - 15 - 13, 14);
    self.menuTextLabel.backgroundColor = [UIColor whiteColor];
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.menuTextLabel.text = title;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        self.menuTextLabel.textColor = [UIColor colorWithRed:250/255.0 green:66/255.0 blue:76/255.0 alpha:1.0];
        self.backgroundColor = [UIColor whiteColor];
        self.menuImageView.hidden = NO;
    }else
    {
        self.menuTextLabel.textColor = [UIColor blackColor];
        self.menuImageView.hidden = YES;
        self.backgroundColor=[UIColor whiteColor];
    }
}

@end

