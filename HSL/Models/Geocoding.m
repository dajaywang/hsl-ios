//
//  Geocoding.m
//  HSL
//
//  Created by DajieWang on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Geocoding.h"

@implementation Geocoding

@synthesize locType;
@synthesize locTypeId;
@synthesize name;
@synthesize matchedName;
@synthesize lang;
@synthesize city;
@synthesize coords;
@synthesize details;

+ (Geocoding *)initWithAttributesDict:(NSDictionary *)attributesDict
{
    Geocoding *geocoding = [[Geocoding alloc] init];
    geocoding.locType = [attributesDict objectForKey:@"locType"];
    geocoding.locTypeId = [attributesDict objectForKey:@"locTypeId"];
    geocoding.name = [attributesDict objectForKey:@"name"];
    geocoding.matchedName = [attributesDict objectForKey:@"matchedName"];
    geocoding.lang = [attributesDict objectForKey:@"lang"];
    geocoding.city = [attributesDict objectForKey:@"city"];
    geocoding.coords = [attributesDict objectForKey:@"coords"];
    geocoding.details =[attributesDict objectForKey:@"details"];
    
    return geocoding;
}

- (NSString *)getStrFromGeocoding
{
    //NSLog(@"called in Geocoding");
    return [self.name stringByAppendingFormat:@",%@", self.city];
}

- (NSArray *)getXYarrayFromCoords
{
    return [self.coords componentsSeparatedByString:@","];
}

@end
