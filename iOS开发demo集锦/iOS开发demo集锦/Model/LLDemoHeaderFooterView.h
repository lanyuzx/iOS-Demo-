//
//  LLDemoHeaderFooterView.h
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/14.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLDemoModel;
@class LLDemoHeaderFooterView;
typedef void(^DemoHeaderFooterViewBlock)(LLDemoHeaderFooterView *);
@interface LLDemoHeaderFooterView : UITableViewHeaderFooterView
@property (nonatomic,strong)  LLDemoModel * model;
@property (nonatomic,copy)  DemoHeaderFooterViewBlock  block;
@end
