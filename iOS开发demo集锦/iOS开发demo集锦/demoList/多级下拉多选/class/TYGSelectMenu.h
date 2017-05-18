//
//  TYGSelectMenu.h
//  TYGSelectMenu
//
//  Created by tanyugang on 15/7/6.
//  Copyright (c) 2015年 tanyugang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYGSelectMenuEntity.h"

@interface TYGSelectMenu : UIView<UITableViewDataSource,UITableViewDelegate>{
    void(^selectedMenu)(NSMutableArray *selectedMenuArray);
}

@property (nonatomic,assign) NSInteger id;
@property (nonatomic,strong) NSMutableArray *menuArray;//目录树
@property (nonatomic,strong) NSMutableArray *selectedMneuArray;//选中的目录

@property (nonatomic,strong) UIFont *titleFont;//标题字体（默认：系统默认字体）
@property (nonatomic,assign) NSTextAlignment textAlignment;//标题对齐方式（默认：系统默认）
@property (nonatomic,assign) CGFloat maxHeight;//最大高度（不得超过边界）
@property (nonatomic,assign) CGFloat maxWidth;//最大宽度（不得超过边界）

/**
 *  添加目录
 *  @param childMenu  添加的目录
 *  @param parentMenu 父级目录，当父级目录为nil时，为一级目录
 */
- (void)addChildSelectMenu:(TYGSelectMenuEntity *)childMenu forParent:(TYGSelectMenuEntity *)parentMenu;

/**
 *  删除目录
 *  @param menu 要删除的目录，如果还有子目录，子目录也会一并删除
 */
- (void)removeMenu:(TYGSelectMenuEntity *)menu;

/**
 *  显示
 *  @param view 要显示的视图（如：一个按钮）
 */
- (void)showFromView:(UIView *)view;

/**
 *  隐藏
 */
- (void)disMiss;

/**
 *  选中目录事件
 *  @param selectedMenu 选中的目录
 */
- (void)selectAtMenu:(void(^)(NSMutableArray *selectedMenuArray))selectedMenu;

@end
