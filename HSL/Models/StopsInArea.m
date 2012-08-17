//
//  StopsInArea.m
//  HSL
//
//  Created by DajieWang on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StopsInArea.h"

@implementation StopsInArea

@synthesize code;
@synthesize name;
@synthesize city;
@synthesize coords;
@synthesize dist;
@synthesize codeShort;
@synthesize address;

+(StopsInArea *)initWithAttributesDict:(NSDictionary *)attributesDict
{
    StopsInArea *stopsInArea = [[StopsInArea alloc] init];
    stopsInArea.code = [attributesDict objectForKey:@"code"];
    stopsInArea.name = [attributesDict objectForKey:@"name"];
    stopsInArea.city = [attributesDict objectForKey:@"city"];
    stopsInArea.coords = [attributesDict objectForKey:@"coords"];
    stopsInArea.dist = [attributesDict objectForKey:@"dist"];
    stopsInArea.codeShort = [attributesDict objectForKey:@"codeShort"];
    stopsInArea.address = [attributesDict objectForKey:@"address"];
    
    return stopsInArea;
}

- (NSString *)getStrFromStopsInArea
{
    return [self.name stringByAppendingFormat:@",%@",self.city];
}

@end
