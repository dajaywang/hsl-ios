//
//  Leg.m
//  HSL
//
//  Created by DajieWang on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Leg.h"
#import "Loc.h"

@implementation Leg

@synthesize length;
@synthesize duration;
@synthesize type;
@synthesize code;
@synthesize locs;
@synthesize shape;

@synthesize locArray;
@synthesize locArrayWithName;

+(Leg *)initWithAttributesDict:(NSDictionary *)attributesDict
{
    Leg *leg = [[Leg alloc] init];
    leg.length = [attributesDict valueForKey:@"length"];
    leg.duration = [attributesDict valueForKey:@"duration"];
    leg.type = [attributesDict valueForKey:@"type"];
    leg.code = [attributesDict valueForKey:@"code"];
    leg.locs = [attributesDict valueForKey:@"locs"];
    leg.shape = [attributesDict valueForKey:@"shape"];
    
    leg.locArray = [NSMutableArray array];
    leg.locArrayWithName = [NSMutableArray array];
    
    for (int i = 0; i < [leg.locs count]; i++) 
    {
        Loc *oneLoc = [Loc initWithAttributesDict:[leg.locs objectAtIndex:i]];
        
        [leg.locArray addObject:oneLoc];        
        
        if (oneLoc.code != NULL) {
            [leg.locArrayWithName addObject:oneLoc];
        }
    }
    
    return leg;
}

+(NSString *)getNofromCode:(NSString *)code
{
    return [[code substringWithRange:NSMakeRange(1, 3)] intValue] < 100 ? [code substringWithRange:NSMakeRange(2, 3)]:[code substringWithRange:NSMakeRange(1, 4)];
}


@end
