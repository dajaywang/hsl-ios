//
//  Utilities.m
//  HSL
//
//  Created by DajieWang on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+(NSString *)getDateTimeStrFromNSDate:(NSDate *)date
{
    NSDateFormatter *dateTimeFormatter = [[NSDateFormatter alloc] init];
    [dateTimeFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateTimeFormatter setTimeStyle:NSDateFormatterShortStyle];
    return [[NSString alloc] initWithFormat:@"%@", [dateTimeFormatter stringFromDate:date]];
}

+(NSString *)getDateStrFromNSDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    return [[NSString alloc] initWithFormat:@"%@", [dateFormatter stringFromDate:date]];
}

+(NSString *)getTimeStrFromNSDate:(NSDate *)date
{
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HHmm"];
    return [[NSString alloc] initWithFormat:@"%@", [timeFormatter stringFromDate:date]];
}

+(void)nslogCurrentTime:(NSString *)idStr
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterLongStyle];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    NSLog(@"%@, current time:%@",idStr, currentTime);
}

@end
