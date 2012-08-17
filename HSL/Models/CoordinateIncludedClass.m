//
//  CoordinateIncludedClass.m
//  HSL
//
//  Created by DajieWang on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoordinateIncludedClass.h"

@implementation CoordinateIncludedClass

-(MKMapPoint)getCoordsFromNSString:(NSString *)coordsString
{
    NSArray *coordsArray = [coordsString componentsSeparatedByString:@","];
    return MKMapPointMake([[coordsArray objectAtIndex:0] doubleValue], [[coordsArray objectAtIndex:1] doubleValue]);
}

-(NSString *)getNSStringFromCoords:(MKMapPoint)coordsPoint
{
    NSString *coordsString1 = [NSString stringWithFormat:@"@f", coordsPoint.x]; 
    NSString *coordsString2 = [NSString stringWithFormat:@"@f", coordsPoint.y];
    return [NSString stringWithFormat:@"@s,@s", coordsString1, coordsString2];
}

@end
