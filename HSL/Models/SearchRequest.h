//
//  SearchRequest.h
//  HSL
//
//  Created by DajieWang on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class Geocoding;

#import <Foundation/Foundation.h>

@interface SearchRequest : NSObject


@property (strong) NSString *fromCoord;
@property (strong) NSString *toCoord;
@property (strong) NSString *dateStr;
@property (strong) NSString *timeStr;
@property (strong) NSString *timeTypeStr;


@property (strong) NSMutableArray *fromToAddressRequestResult;
@property (strong) NSMutableArray *routingRequestResult;

-(void)geocodingRequest:(NSString *)key;
-(void)routingRequest:(NSString *)from withTo:(NSString *)to withDate:(NSString *)date withTime:(NSString *)time withTimeType:(NSString *)timetype;
-(void)stopInAreaRequest:(NSString *)coord;

@end
