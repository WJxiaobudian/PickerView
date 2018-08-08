//
//  NSDate+Expend.h
//  BodyScaleBLE
//
//  Created by Jason on 13-1-30.
//  Copyright (c) 2013年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Expend)

+(int)getDaysFrom1970:(NSString*)dateString;
+(NSDate *)getDateByDayPassedFrom1970:(int)passDays;
+(NSDate *)getDateByTimePassedFrom1970:(long long)passTime;
+(int)getCurrentYear;
+(int)getCurrentMonth;
+(int)getCurrentDay;
+(int)getCurrentHour;
+(int)getCurrentMin;
+(int)getCurrentSecond;
+(NSDate*)convertDateFromString:(NSString*)uiDate;
+(NSDate*)preDay:(NSDate*)nowDate Days:(int)dayLength;
+(NSDate*)nextDay:(NSDate*)nowDate Days:(int)dayLength;
+(NSString*)getMonthAppointDayWith:(NSString *)dateStr andDays:(int)dayLength;//获取当月指定日期
+(NSUInteger)getWeekdayFromDate:(NSDate*)date;
-(int)getYear;
-(int)getMon;
-(int)getDay;
-(int)getHour;
-(int)getMin;
-(int)getSecond;

-(int)getGeoYear;
-(int)getGeoMon;
-(int)getGeoDay;
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;
- (BOOL)sameWeekWithDate:(NSDate *)otherDate;
+(NSString*)getEngMon:(int)monNum;

+ (NSString *)getCurrentTime;
// 获取当前指定格式显示的时间
+ (NSString*)getCurrentTimeWithDateFormat:(NSString*)dateFormat;
//获取每月的天数
+(NSInteger )getDayWithYear:(NSNumber *)year month:(NSNumber *)month;
//判断是否闰年
+(BOOL)isLeapYear:(NSNumber *)year;
//比较两个日期的大小
+ (NSInteger)compareDate:(NSString *)aDate bDate:(NSString *)bDate;
// 取两个时间最小值
+ (NSString*)getEarlierDateByCompareDate:(NSString *)aDate bDate:(NSString *)bDate;
@end
