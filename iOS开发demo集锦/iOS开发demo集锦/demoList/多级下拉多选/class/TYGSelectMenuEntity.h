//
//  TYGSelectMenuEntity.h
//  TYGSelectMenu
//
//  Created by tanyugang on 15/7/6.
//  Copyright (c) 2015年 tanyugang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYGSelectMenuEntity : UIView

@property (nonatomic,assign) NSInteger id;//ID
@property (nonatomic,strong) NSString *title;//标题
@property (nonatomic,strong) TYGSelectMenuEntity *parentMenu;
@property (nonatomic,strong) NSMutableArray *childMenuArray;//子级目录
@property (nonatomic,readwrite) id obj;

@property (nonatomic,assign) NSInteger level;//所处的级别,自动生成

@end
