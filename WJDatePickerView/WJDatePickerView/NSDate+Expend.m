//
//  NSDate+Expend.m
//  BodyScaleBLE
//
//  Created by Jason on 13-1-30.
//  Copyright (c) 2013年 Jason. All rights reserved.
//

#import "NSDate+Expend.h"

@implementation NSDate (Expend)

+(int)getDaysFrom1970:(NSString*)dateString
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1=[dateFormatter dateFromString:@"1970-1-1"];
    NSDate *date2=[dateFormatter dateFromString:dateString];
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    int days=((int)time)/(3600*24);
    return days;
}

+(NSDate *)getDateByDayPassedFrom1970:(int)passDays
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1=[dateFormatter dateFromString:@"1970-1-1"];
    NSDate *date2=[date1 dateByAddingTimeInterval:passDays*3600*24];
    return date2;
}

+(NSDate *)getDateByTimePassedFrom1970:(long long)passTime
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1=[dateFormatter dateFromString:@"1970-1-1"];
    NSDate *date2=[date1 dateByAddingTimeInterval:passTime];
    return date2;
}

+(int)getCurrentYear
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int year = (int)[dateComponent year];
    return year;
}

+(int)getCurrentMonth
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int month = (int)[dateComponent month];
    return month;
}

+(int)getCurrentDay
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int day = (int)[dateComponent day];
    return day;
}

+(int)getCurrentHour
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int hour = (int)[dateComponent hour];
    return hour;

}

+(int)getCurrentMin
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int min = (int)[dateComponent minute];
    return min;

}

+(int)getCurrentSecond
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int second = (int)[dateComponent second];
    return second;
}


+(NSDate*) convertDateFromString:(NSString*)uiDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];

    NSDate *date=[formatter dateFromString:uiDate];
    return date;
}

+(NSDate*)preDay:(NSDate*)nowDate Days:(int)dayLength
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString * reportDate = [format stringFromDate:nowDate];
    NSDate *date = [format dateFromString:reportDate];
    NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date timeIntervalSinceReferenceDate] - 24*3600*dayLength)];
//    reportDate = [format stringFromDate:newDate];
    return newDate;
}

+(NSDate*)nextDay:(NSDate*)nowDate Days:(int)dayLength
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString * reportDate = [format stringFromDate:nowDate];
    NSDate *date = [format dateFromString:reportDate];
    NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date timeIntervalSinceReferenceDate] + 24*3600*dayLength)];
//    reportDate = [format stringFromDate:newDate];
    return newDate;
}

+ (NSString *)getMonthAppointDayWith:(NSString *)dateStr andDays:(int)dayLength{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    
    if (OK) {
//        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    } else {
        return @"";
    }
    
    NSDate *appointDate = [NSDate nextDay:firstDate Days:dayLength-1];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *appointStr = [fmt stringFromDate:appointDate];
    
    return appointStr;
}

+(NSUInteger)getWeekdayFromDate:(NSDate*)date
{
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger unitFlags = NSCalendarUnitYear |
    
    NSCalendarUnitMonth |
    
    NSCalendarUnitDay |
    
    NSCalendarUnitWeekday |
    
    NSCalendarUnitHour |
    
    NSCalendarUnitMinute |
    
    NSCalendarUnitSecond;
    
    
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    
    NSUInteger weekday = [components weekday];
    
    return weekday;
    
}

-(int)getYear
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    return (int)[components year];
}

-(int)getMon
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    return (int)[components month];
}

-(int)getDay
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    return (int)[components day];
}

-(int)getGeoYear
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    return (int)[components year];
}

-(int)getGeoMon
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    return (int)[components month];
}

-(int)getGeoDay
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    return (int)[components day];
}

-(int)getHour
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear|NSCalendarUnitHour fromDate:self];
    return (int)[components hour];
}

-(int)getMin
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear|NSCalendarUnitMinute fromDate:self];
    return (int)[components minute];
}

-(int)getSecond
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear |NSCalendarUnitSecond fromDate:self];
    return (int)[components second];
}

+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month

{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setYear:0];
    
    [comps setMonth:month];
    
    [comps setDay:0];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    return mDate;
    
}

- (NSDateComponents *)componentsOfDay
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
}

- (NSUInteger)year
{
    return [self componentsOfDay].year;
}
- (NSUInteger)month
{
    return [self componentsOfDay].month;
}
- (NSUInteger)day162
{
    return [self componentsOfDay].day;
}
- (NSUInteger)weekday
{
    return [self componentsOfDay].weekday;
}
- (NSUInteger)weekOfDayInYear
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitYear forDate:self];
}


- (BOOL)sameWeekWithDate:(NSDate *)otherDate
{
    if (self.year == otherDate.year  && self.month == otherDate.month && self.weekOfDayInYear == otherDate.weekOfDayInYear) {
        return YES;
    } else {
        return NO;
    }
}

+(NSString*)getEngMon:(int)monNum
{
    switch (monNum) {
        case 1:
            return @"Jan";
            break;
        case 2:
            return @"Feb";
            break;
        case 3:
            return @"Mar";
            break;
        case 4:
            return @"Apr";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"Jun";
            break;
        case 7:
            return @"Jul";
            break;
        case 8:
            return @"Aug";
            break;
        case 9:
            return @"Sep";
            break;
        case 10:
            return @"Oct";
            break;
        case 11:
            return @"Nov";
            break;
        case 12:
            return @"Dec";
            break;
        default:
            break;
    }
    return @"";
}

//获取当地时间
+ (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
+ (NSString*)getCurrentTimeWithDateFormat:(NSString*)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
+(NSInteger )getDayWithYear:(NSNumber *)year month:(NSNumber *)month
{
    NSInteger day=0;
    switch ([month intValue]) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            day=31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            day=30;
            break;
        default:
            
        {
            if([self isLeapYear:year])
            {
                day=29;
            }else
            {
                day=28;
            }
        }
            break;
    }
    return day;
}

+(BOOL)isLeapYear:(NSNumber *)year
{
    NSInteger yr=[year intValue];
    if ((yr % 4  == 0 && yr % 100 != 0) || yr % 400 == 0)
        return YES;
    else
        return NO;
}

+(int)getDaysBeforeNowWithTime:(NSString *)time
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
    int x = [confromTimesp timeIntervalSinceNow];
    int day = -x /86400 + 1;
    return day;
}


//比较两个日期的大小
+ (NSInteger)compareDate:(NSString *)aDate bDate:(NSString *)bDate
{
    NSInteger c_result = 0;

    //
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *a_date = [formatter dateFromString:aDate];
    
    
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    NSDate *b_date = [dateformater dateFromString:bDate];
    
    NSComparisonResult result = [a_date compare:b_date];
    if (result==NSOrderedSame)
    {
        //        相等
        c_result=0;
    }else if (result==NSOrderedAscending)
    {
        //aDate比date小
        c_result=1;
    }else if (result==NSOrderedDescending)
    {
        //aDate比date大
        c_result=-1;
        
    }
    
    return c_result;
}
+ (NSString*)getEarlierDateByCompareDate:(NSString *)aDate bDate:(NSString *)bDate
{
    NSString* resultDate = @"";
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *a_date = [formatter dateFromString:aDate];
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    NSDate *b_date = [dateformater dateFromString:bDate];
    
    NSComparisonResult result = [a_date compare:b_date];
    if (result==NSOrderedSame)
    {
        //        相等
        resultDate = aDate;
    }else if (result==NSOrderedAscending)
    {
        //aDate比b_date早
        resultDate = aDate;
    }else if (result==NSOrderedDescending)
    {
        //aDate比b_date晚
        resultDate = bDate;
    }
    
    return resultDate;
}
@end
