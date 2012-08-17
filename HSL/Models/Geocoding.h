//
//  Geocoding.h
//  HSL
//
//  Created by DajieWang on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoordinateIncludedClass.h"

@interface Geocoding : CoordinateIncludedClass

@property (strong) NSString *locType;
@property (strong) NSNumber *locTypeId;
@property (strong) NSString *name;
@property (strong) NSString *matchedName;
@property (strong) NSString *lang;
@property (strong) NSString *city;
@property (strong) NSString *coords;
@property (strong) NSArray *details;

+ (Geocoding *)initWithAttributesDict:(NSDictionary *)attributesDict;

- (NSString *)getStrFromGeocoding;
- (NSArray *)getXYarrayFromCoords;

@end 
