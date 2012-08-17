//
//  Leg.h
//  HSL
//
//  Created by DajieWang on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Leg : NSObject

@property (strong) NSString *length;
@property (strong) NSString *duration;
@property (strong) NSString *type; //String or Number
@property (strong) NSString *code;
@property (strong) NSArray *locs;
@property (strong) NSArray *shape;

@property (strong) NSMutableArray *locArray;
@property (strong) NSMutableArray *locArrayWithName;

+(Leg *)initWithAttributesDict:(NSDictionary *)attributesDict;

+(NSString *)getNofromCode:(NSString *)code;


@end
