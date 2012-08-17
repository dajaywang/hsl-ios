//
//  Loc.h
//  HSL
//
//  Created by DajieWang on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Loc : NSObject

@property (strong) NSString *coords;
@property (strong) NSString *arrTime; //NSNumber
@property (strong) NSString *depTime; //NSNumber
@property (strong) NSString *name;
@property (strong) NSString *code;    //NSNumber
@property (strong) NSString *shortCode;
@property (strong) NSString *stopAddress;

+(Loc *)initWithAttributesDict:(NSDictionary *)attributesDict;

+(NSString *)getTimeFromDepOrArrTime:(NSString *)DepOrArrTime;

- (NSArray *)getXYarrayFromLoc;

@end
