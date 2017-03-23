//
//  GFCalendarMonth.h
//
//  Created by Mercy on 2016/11/9.
//  Copyright © 2016年 Mercy. All rights reserved.
//
//  月份模型类
//

#import <Foundation/Foundation.h>

@interface GFCalendarMonth : NSObject

@property (nonatomic, strong) NSDate *monthDate; //!< 传入的 NSDate 对象，该 NSDate 对象代表当前月的某一日，根据它来获得其他数据
@property (nonatomic, assign) NSInteger totalDays; //!< 当前月的天数
@property (nonatomic, assign) NSInteger firstWeekday; //!< 标示第一天是星期几（0代表周日，1代表周一，以此类推）
@property (nonatomic, assign) NSInteger year; //!< 所属年份
@property (nonatomic, assign) NSInteger month; //!< 当前月份
@property (nonatomic, assign) NSInteger day; //!< 当前月的日
- (instancetype)initWithDate:(NSDate *)date;

@end
