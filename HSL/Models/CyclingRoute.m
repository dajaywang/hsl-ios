//
//  CyclingRoute.m
//  HSL
//
//  Created by DajieWang on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CyclingRoute.h"

@implementation CyclingRoute

@synthesize length;
@synthesize path;
@synthesize length2;
@synthesize name;
@synthesize type;
@synthesize points;
@synthesize passtype;

+(CyclingRoute *)initWithAttributesDict:(NSDictionary *)attributesDict
{
    CyclingRoute *cyclingRoute = [[CyclingRoute alloc] init];
    cyclingRoute.length = [attributesDict objectForKey:@"length"];
    cyclingRoute.path = [attributesDict objectForKey:@"path"];
    cyclingRoute.length2 = [attributesDict objectForKey:@"length2"];
    cyclingRoute.name = [attributesDict objectForKey:@"name"];
    cyclingRoute.type = [attributesDict objectForKey:@"type"];
    cyclingRoute.points = [attributesDict objectForKey:@"points"];
    cyclingRoute.passtype = [attributesDict objectForKey:@"passtype"];
    
    return cyclingRoute;
}

@end
