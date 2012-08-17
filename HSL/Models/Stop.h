//
//  Stop.h
//  HSL
//
//  Created by DajieWang on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoordinateIncludedClass.h"

@interface Stop : CoordinateIncludedClass

@property (strong) NSNumber *code;
@property (strong) NSString *code_short;
@property (strong) NSString *name_fi;
@property (strong) NSString *name_sv;
@property (strong) NSString *city_fi;
@property (strong) NSString *city_sv;
@property (strong) NSArray *lines;
@property (strong) NSString *coords;
@property (strong) NSString *wgs_coords;
@property (strong) NSArray *accessibility;
@property (strong) NSArray *departurs;
@property (strong) NSString *timetable_link;
@property (strong) NSString *omatlahdot_link;
@property (strong) NSString *address_fi;
@property (strong) NSString *address_sv;

+(Stop *)initWithAttributesDict:(NSDictionary *)attributesDict;

@end
