//
//  Routing.h
//  HSL
//
//  Created by DajieWang on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoordinateIncludedClass.h"

@interface Routing : CoordinateIncludedClass

@property (strong) NSNumber *length;
@property (strong) NSNumber *duration;
@property (strong) NSArray *legs;

@property (strong) NSMutableArray *LegArray;

+(Routing *)initWithAttributesDict:(NSDictionary *)attributesDict;


@end
