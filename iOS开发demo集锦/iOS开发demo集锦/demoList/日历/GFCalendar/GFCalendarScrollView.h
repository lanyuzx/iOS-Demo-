//
//  GFCalendarScrollView.h
//
//  Created by Mercy on 2016/11/9.
//  Copyright © 2016年 Mercy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFCalendarMonth.h"
typedef void (^DidSelectDayHandler)(NSInteger, NSInteger, NSInteger);

@interface GFCalendarScrollView : UIScrollView


@property (nonatomic, strong) DidSelectDayHandler didSelectDayHandler; // 日期点击回调

- (void)refreshToCurrentMonth; // 刷新 calendar 回到当前日期月份
- (instancetype)initWithFrame:(CGRect)frame maxH:(CGFloat)maxH mixH:(CGFloat)minH midH:(CGFloat)midH parentH:(CGFloat) parentH StartDate:(NSDate *)StartDate EndDate:(NSDate *)EndDate;
@property (nonatomic, strong) GFCalendarMonth *StartDate_GFCalendarMonth;
@property (nonatomic, strong) GFCalendarMonth *EndDate_GFCalendarMonth;
@end
