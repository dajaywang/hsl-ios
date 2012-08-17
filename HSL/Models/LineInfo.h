//
//  LineInfo.h
//  HSL
//
//  Created by DajieWang on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoordinateIncludedClass.h"

@interface LineInfo : CoordinateIncludedClass

@property (strong) NSString *code;
@property (strong) NSString *code_short;
@property (strong) NSNumber *transport_type_id;
@property (strong) NSString *line_start;
@property (strong) NSString *line_end;
@property (strong) NSString *name;
@property (strong) NSString *timetable_url;
@property (strong) NSArray *line_shape; //list of coordinates
@property (strong) NSArray *line_stops;
@property (strong) NSNumber *code2;
@property (strong) NSString *codeShort;
@property (strong) NSNumber *time;
@property (strong) NSString *address;
@property (strong) NSString *name2;
@property (strong) NSString *coords;
@property (strong) NSString *city_name;

+(LineInfo *)initWithAttributesDict:(NSDictionary *)attributesDict;


@end
