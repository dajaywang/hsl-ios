//
//  StopsInArea.h
//  HSL
//
//  Created by DajieWang on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoordinateIncludedClass.h"

@interface StopsInArea : CoordinateIncludedClass

@property (strong) NSNumber *code;
@property (strong) NSString *name;
@property (strong) NSString *city;
@property (strong) NSString *coords;
@property (strong) NSNumber *dist;
@property (strong) NSString *codeShort;
@property (strong) NSString *address;

+(StopsInArea *)initWithAttributesDict:(NSDictionary *)attributesDict;

- (NSString *)getStrFromStopsInArea;

@end
