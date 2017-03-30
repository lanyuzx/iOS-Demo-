//
//  LLMainTableViewCell.h
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/30.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLDemoModel;
@interface LLMainTableViewCell : UITableViewCell

@property (nonatomic,assign)  NSIndexPath * indexPath;
@property (nonatomic,strong)  LLDemoModel * model;
@end
