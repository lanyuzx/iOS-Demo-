//
//  SMKDropSelectMenu.h
//  test
//
//  Created by Mac on 17/4/5.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMKDropSelectMenu : UIView

/**
 *  标题数组
 */
@property (nonatomic, strong) NSArray *titleArray;
/**
 *  是否显示第一个标题按钮的指示图片
 */
@property (nonatomic, assign) BOOL  isShowFirstButtonImage;
/**
 *  标题按钮正常状态的颜色
 */
@property (nonatomic, strong) UIColor *titleButtonNormalColor;
/**
 *  标题按钮选中状态的颜色
 */
@property (nonatomic, strong) UIColor *titleButtonSelectedColor;
/**
 *  最大高度
 */
@property (nonatomic, assign) CGFloat  dropMenuMaxHeight;
/**
 * 存放每个标题按钮对应下的数据
 */
@property (nonatomic) NSMutableArray *menuDataArray;
/**
 *  第一个按钮是否是重置功能按钮
 */
@property (nonatomic, assign) BOOL  isFirstResetButton;
/**
 *  选中内容回调block
 */
@property (nonatomic) void (^handleSelectDataBlock) (NSString *selectTitle, NSUInteger selectIndex ,NSUInteger selectButtonTag);
/**
 *  选中标题回调block
 */
@property (nonatomic) void (^handleSelectButtonBlock) (NSUInteger selectIndex);


/**
 *  实例化
 */
+ (instancetype)dropSelectMenu;

/**
 *  重置
 */
- (void)resetAction;

@end


@interface SMKDropSelectMenuCell : UICollectionViewCell

@property (nonatomic) BOOL  isSelected;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UILabel *menuTextLabel;

@property (nonatomic, strong) UIImageView *menuImageView;


@end
