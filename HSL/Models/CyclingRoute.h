//
//  CyclingRoute.h
//  HSL
//
//  Created by DajieWang on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoordinateIncludedClass.h"

@interface CyclingRoute : CoordinateIncludedClass

@property (strong) NSNumber *length;
@property (strong) NSArray *path;
@property (strong) NSNumber *length2;
@property (strong) NSString *name;
@property (strong) NSString *type;
@property (strong) NSArray *points;
@property (strong) NSString *passtype;

+(CyclingRoute *)initWithAttributesDict:(NSDictionary *)attributesDict;

@end
