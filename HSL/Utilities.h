//
//  Utilities.h
//  HSL
//
//  Created by DajieWang on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+(NSString *)getDateTimeStrFromNSDate:(NSDate *)date;
+(NSString *)getDateStrFromNSDate:(NSDate *)date;
+(NSString *)getTimeStrFromNSDate:(NSDate *)date;

+(void)nslogCurrentTime:(NSString *)idStr;

@end
