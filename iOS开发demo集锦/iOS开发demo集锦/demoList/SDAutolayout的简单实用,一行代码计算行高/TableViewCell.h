//
//  TableViewCell.h
//  仿微信cell小弹框
//
//  Created by JYD on 2017/2/4.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLModel;
@interface TableViewCell : UITableViewCell
@property (nonatomic,strong)  UILabel * txtLable;

@property (nonatomic,strong)  LLModel * model;
@end
