//
//  Stop.m
//  HSL
//
//  Created by DajieWang on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Stop.h"

@implementation Stop

@synthesize code;
@synthesize code_short;
@synthesize name_fi;
@synthesize name_sv;
@synthesize city_fi;
@synthesize city_sv;
@synthesize lines;
@synthesize coords;
@synthesize wgs_coords;
@synthesize accessibility;
@synthesize departurs;
@synthesize timetable_link;
@synthesize omatlahdot_link;
@synthesize address_fi;
@synthesize address_sv;

+(Stop *)initWithAttributesDict:(NSDictionary *)attributesDict
{
    Stop *stop = [[Stop alloc] init];
    stop.code = [attributesDict objectForKey:@"code"];
    stop.code_short = [attributesDict objectForKey:@"code_short"];
    stop.name_fi = [attributesDict objectForKey:@"name_fi"];
    stop.name_sv = [attributesDict objectForKey:@"name_sv"];
    stop.city_fi = [attributesDict objectForKey:@"city_fi"];
    stop.city_sv = [attributesDict objectForKey:@"city_sv"];
    stop.lines = [attributesDict objectForKey:@"lines"];
    stop.coords = [attributesDict objectForKey:@"coords"];
    stop.wgs_coords = [attributesDict objectForKey:@"wgs_coords"];
    stop.accessibility = [attributesDict objectForKey:@"accessibility"];
    stop.departurs = [attributesDict objectForKey:@"departures"];
    stop.timetable_link = [attributesDict objectForKey:@"timetable_link"];
    stop.omatlahdot_link = [attributesDict objectForKey:@"omatlahdot_link"];
    stop.address_fi = [attributesDict objectForKey:@"address_fi"];
    stop.address_sv = [attributesDict objectForKey:@"address_sv"];
    
    return stop;
}

@end
