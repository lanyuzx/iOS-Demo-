//
//  XMGTagTextField.h
//  01-百思不得姐
//
//  Created by xiaomage on 15/8/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGTagTextField : UITextField
/** 按了删除键后的回调 */
@property (nonatomic, copy) void (^deleteBlock)();
@end
