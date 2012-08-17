//
//  LineInfo.m
//  HSL
//
//  Created by DajieWang on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LineInfo.h"

@implementation LineInfo

@synthesize code;
@synthesize code_short;
@synthesize transport_type_id;
@synthesize line_start;
@synthesize line_end;
@synthesize name;
@synthesize timetable_url;
@synthesize line_shape;
@synthesize line_stops;
@synthesize code2;
@synthesize codeShort;
@synthesize time;
@synthesize address;
@synthesize name2;
@synthesize coords;
@synthesize city_name;


+(LineInfo *)initWithAttributesDict:(NSDictionary *)attributesDict
{
    LineInfo * lineInfo = [[LineInfo alloc] init];
    lineInfo.code = [attributesDict objectForKey:@"code"];
    lineInfo.code_short = [attributesDict objectForKey:@"code_short"];
    lineInfo.transport_type_id = [attributesDict objectForKey:@"transport_type_id"];
    lineInfo.line_start = [attributesDict objectForKey:@"line_start"];
    lineInfo.line_end = [attributesDict objectForKey:@"line_end"];
    lineInfo.name = [attributesDict objectForKey:@"name"];
    lineInfo.timetable_url = [attributesDict objectForKey:@"timetable_url"];
    lineInfo.line_shape = [attributesDict objectForKey:@"line_shape"];
    lineInfo.line_stops = [attributesDict objectForKey:@"line_stops"];
    lineInfo.code2 = [attributesDict objectForKey:@"code2"];
    lineInfo.codeShort = [attributesDict objectForKey:@"codeShort"];
    lineInfo.time = [attributesDict objectForKey:@"time"];
    lineInfo.address = [attributesDict objectForKey:@"address"];
    lineInfo.name2 = [attributesDict objectForKey:@"name2"];
    lineInfo.coords = [attributesDict objectForKey:@"coords"];
    lineInfo.city_name = [attributesDict objectForKey:@"city_name"];
    
    return lineInfo;    
}

@end
