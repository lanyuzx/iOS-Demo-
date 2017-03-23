//
//  getData.m
//  Kline
//
//  Created by zhaomingxi on 14-2-10.
//  Copyright (c) 2014年 zhaomingxi. All rights reserved.
//

#import "getData.h"



@implementation getData

-(id)init{
    self = [super init];
    if (self){
        self.isFinish = NO;
        self.maxValue = 0;
        self.minValue = CGFLOAT_MAX;
        self.titledata=[NSMutableArray array];
        self.original_data=[NSMutableArray array];
    }
    return  self;
}




+(NSString *) converStringFormDate8:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT+8"];
    [dateFormatter setTimeZone:timeZone];
    NSString *strDate = [dateFormatter stringFromDate:date];
    dateFormatter=nil;
    return strDate;
    
}

+(NSString *) converStringFormDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    NSString *strDate = [dateFormatter stringFromDate:date];
    dateFormatter=nil;
    return strDate;
    
}
+(NSDate*) convertDateFromString:(NSString*)uiDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [formatter setTimeZone:timeZone];
    NSDate *date=[formatter dateFromString:uiDate];
    formatter=nil;
    return date;
}

+ (NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *   dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    dateFormatter=nil;
    return destDate;
    
}
+(NSDate *)getenddate:(NSDate *)today
{
    
    //NSDate *today = [getData convertDateFromString:@"2015-10-16"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:-6];
    NSDate *enddate = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];
    gregorian=nil;
    return enddate;
}

+(NSDate *)getyesterday:(NSDate *)today
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:-1];
    NSDate *enddate = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];
    gregorian=nil;
    return enddate;
}
+(NSInteger) calcDaysFromBegin:(NSDate *)inBegin end:(NSDate *)inEnd
{
   
    NSTimeInterval interval = [inEnd timeIntervalSinceDate:inBegin];
    NSInteger beginDays=((NSInteger)interval)/(3600*24);
    
    
    return beginDays;
}
+(NSDate *)gettomorrow:(NSDate *)today
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:1];
    NSDate *enddate = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];
    gregorian=nil;
    return enddate;
}


-(CGFloat)sumArrayWithData:(NSArray*)data andRange:(NSRange)range{
    CGFloat value = 0;
    if (data.count - range.location>range.length) {
        NSArray *newArray = [data objectsAtIndexes:[[NSIndexSet alloc] initWithIndexesInRange:range]];
        for (NSString *item in newArray) {
            NSArray *arr = [item componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
            value += [[arr objectAtIndex:4] floatValue];
        }
        if (value>0) {
            value = value / newArray.count;
        }
    }
    return value;
}
/*
- (void)Failed:(ASIHTTPRequest *)request{
	self.status.text = @"Error!";
    request = nil;
    self.isFinish = YES;
}
*/
-(void)dealloc{

}
@end
