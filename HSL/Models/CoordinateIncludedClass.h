//
//  CoordinateIncludedClass.h
//  HSL
//
//  Created by DajieWang on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CoordinateIncludedClass : NSObject

-(MKMapPoint)getCoordsFromNSString:(NSString *)coordsString;
-(NSString *)getNSStringFromCoords:(MKMapPoint)coords;

@end
