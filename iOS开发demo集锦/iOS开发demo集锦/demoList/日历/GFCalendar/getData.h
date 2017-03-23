//
//  getData.h
//  Kline
//
//  Created by zhaomingxi on 14-2-10.
//  Copyright (c) 2014年 zhaomingxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface getData : NSObject
@property (nonatomic,retain) NSMutableArray *data;
@property (nonatomic,retain) NSMutableArray *titledata;
@property (nonatomic,retain) NSMutableArray *original_data;
@property (nonatomic,retain) NSMutableArray *category;
@property (nonatomic,retain) UILabel *status;
@property (nonatomic,assign) BOOL isFinish;
@property (nonatomic,assign) CGFloat maxValue;
@property (nonatomic,assign) CGFloat minValue;
@property (nonatomic,assign) NSInteger kCount;
@property (nonatomic,strong) NSDate *startdate;
@property (nonatomic,strong) NSDate *enddate;
@property (nonatomic,strong) NSString *Ids;
@property (nonatomic,strong) NSString *categoryid;
@property (nonatomic,assign) NSInteger linescount;

-(id)initWithUrl:(NSString*)ids _startdatev:(NSDate *)_startdatev _enddatev:(NSDate *)_enddatev _categoryidv:(NSString *)_categoryidv;
+(NSString *) converStringFormDate:(NSDate *)date;
+(NSString *) converStringFormDate8:(NSDate *)date;
+(NSDate*) convertDateFromString:(NSString*)uiDate;
+ (NSDate *)dateFromString:(NSString *)dateString;
+(NSDate *)getenddate:(NSDate *)today;
+(NSDate *)getyesterday:(NSDate *)today;
+(NSDate *)gettomorrow:(NSDate *)today;
+(NSInteger) calcDaysFromBegin:(NSDate *)inBegin end:(NSDate *)inEnd;
@end
