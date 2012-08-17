//
//  Routing.m
//  HSL
//
//  Created by DajieWang on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Routing.h"
#import "Leg.h"

@implementation Routing

@synthesize length;
@synthesize duration;
@synthesize legs;

@synthesize  LegArray;

+(Routing *)initWithAttributesDict:(NSDictionary *)attributesDict
{
    Routing *routing = [[Routing alloc] init];
    routing.length = [attributesDict objectForKey:@"length"];
    routing.duration = [attributesDict objectForKey:@"duration"];
    routing.legs = [attributesDict objectForKey:@"legs"];
    
    routing.LegArray = [NSMutableArray array];
    
    for (int i = 0; i < [routing.legs count]; i++) 
    {
        Leg *oneLeg = [Leg initWithAttributesDict:[routing.legs objectAtIndex:i]];
        NSLog(@"legs:%@,%@,%@,%@", oneLeg.length,oneLeg.duration,oneLeg.type,oneLeg.code);
        [routing.LegArray addObject:oneLeg]; 
    }

    
    return routing;
}


@end
