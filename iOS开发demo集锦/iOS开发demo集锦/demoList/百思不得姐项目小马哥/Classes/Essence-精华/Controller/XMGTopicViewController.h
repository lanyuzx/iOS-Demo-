//
//  XMGTopicViewController.h
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/27.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//  最基本的帖子控制器

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
@interface XMGTopicViewController : UITableViewController
/** 帖子类型(交给子类去实现) */
@property (nonatomic, assign) XMGTopicType type;
@end
