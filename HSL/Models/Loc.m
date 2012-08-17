//
//  Loc.m
//  HSL
//
//  Created by DajieWang on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Loc.h"

@implementation Loc

@synthesize coords;
@synthesize arrTime;
@synthesize depTime;
@synthesize name;
@synthesize code;
@synthesize shortCode;
@synthesize stopAddress;

+(Loc *)initWithAttributesDict:(NSDictionary *)attributesDict
{
    Loc *loc = [[Loc alloc] init];
    loc.coords = [attributesDict valueForKey:@"coords"];
    loc.arrTime = [attributesDict valueForKey:@"arrTime"];
    loc.depTime = [attributesDict valueForKey:@"depTime"];
    loc.name = [attributesDict valueForKey:@"name"];
    NSLog(@"name777 %@",loc.name);
    loc.code = [attributesDict valueForKey:@"code"];
    NSLog(@"code 777 %@",loc.code);
    loc.shortCode = [attributesDict valueForKey:@"shortCode"];
    loc.stopAddress = [attributesDict valueForKey:@"stopAddress"];
    
    return loc;
    
}

+(NSString *)getTimeFromDepOrArrTime:(NSString *)DepOrArrTime
{

    int timeStrLength = [DepOrArrTime length];
    return [NSString stringWithFormat:@"%@:%@",[DepOrArrTime substringWithRange:NSMakeRange(timeStrLength-4,2)],[DepOrArrTime substringWithRange:NSMakeRange(timeStrLength-2, 2)]];
}

- (NSArray *)getXYarrayFromLoc
{
    return [self.coords componentsSeparatedByString:@","];
}

@end
