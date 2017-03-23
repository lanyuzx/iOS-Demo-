//
//  GFCalendarView.h
//
//  Created by Mercy on 2016/11/9.
//  Copyright © 2016年 Mercy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectDayHandler)(NSInteger, NSInteger, NSInteger);

@interface GFCalendarView : UIView


/**
 *  构造方法
 *
 *  @param origin calendar 的位置
 *  @param width  calendar 的宽度（高度会根据给定的宽度自动计算）
 *
 *  @return bannerView对象
 */
- (instancetype)initWithFrameOrigin:(CGPoint)origin width:(CGFloat)width;
- (instancetype)initWithFrameOrigin:(CGPoint)origin width:(CGFloat)width startdate:(NSDate *)startdate enddate:(NSDate *)enddate;

/**
 *  calendar 的高度（只读属性）
 */
@property (nonatomic, assign, readonly) CGFloat calendarHeight;


/**
 *  日期点击回调
 *  block 的参数表示当前日期的 NSDate 对象
 */
@property (nonatomic, strong) DidSelectDayHandler didSelectDayHandler;

@property (nonatomic, strong) NSDate *StartDate;
@property (nonatomic, strong) NSDate *EndDate;

@end
