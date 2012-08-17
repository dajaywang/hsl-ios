//
//  SearchRequest.m
//  HSL
//
//  Created by DajieWang on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchRequest.h"
#import "Geocoding.h"
#import "Stop.h"
#import "StopsInArea.h"
#import "LineInfo.h"
#import "Routing.h"
#import "Leg.h"
#import "Loc.h"
#import "CyclingRoute.h"



#define BASE_URL @"http://api.reittiopas.fi/hsl/prod/?user=dajie&pass=482826"
#define GEOCODING_URL [[NSString alloc] initWithFormat:@"%@&request=geocode",BASE_URL]
#define RESERSE_GEOCODING_URL [[NSString alloc] initWithFormat:@"%@&request=reverse_geocode",BASE_URL]
#define ROUTING_URL [[NSString alloc] initWithFormat:@"%@&request=route",BASE_URL]
#define STOP_IN_AREA_URL [[NSString alloc] initWithFormat:@"%@&request=stops_area&epsg_in=wgs84", BASE_URL] //coordinate system:WGS84


@interface SearchRequest()
{

}

@end

@implementation SearchRequest


@synthesize fromCoord;
@synthesize toCoord;
@synthesize dateStr;
@synthesize timeStr;
@synthesize timeTypeStr;


@synthesize fromToAddressRequestResult;
@synthesize routingRequestResult;

-(id)init
{
    self.fromToAddressRequestResult = [[NSMutableArray alloc] init];
    self.routingRequestResult = [[NSMutableArray alloc] init];
    
    return self;
}

-(void)geocodingRequest:(NSString *)key
{
    NSURL *url = [NSURL URLWithString:[GEOCODING_URL stringByAppendingFormat:@"&key=%@", key]];
    NSLog(@"geocoding URL:%@", url);
    
    NSMutableURLRequest *geocodingURLRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    //[geocodingURLRequest setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse *geocodingURLResponse;
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:geocodingURLRequest 
                                          returningResponse:&geocodingURLResponse 
                                                      error:&error];
    if (error == nil) {
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data 
                                                        options:NSJSONReadingAllowFragments 
                                                          error:&error];
        
        if (jsonObject != nil && error == nil) 
        {
            NSLog(@"gecoding json is going to deserialize...");
            
            if ([jsonObject isKindOfClass:[NSArray class]]) 
            {
                NSArray *deserializedArray = (NSArray *)jsonObject;
                
                for (int i=0; i < [deserializedArray count]; i++) 
                {
                    Geocoding *oneGeocoding = [Geocoding initWithAttributesDict:[deserializedArray objectAtIndex:i]];
                    
                    [self.fromToAddressRequestResult addObject:oneGeocoding];
                }
                
            }
        }
    }
}

-(void)routingRequest:(NSString *)from withTo:(NSString *)to withDate:(NSString *)date withTime:(NSString *)time withTimeType:(NSString *)timeType
{
    NSURL *url = [NSURL URLWithString:[ROUTING_URL stringByAppendingFormat:@"&from=%@&to=%@&date=%@&time=%@&timetype=%@",from,to,date,time,timeType]];
    NSLog(@"routingRequest URL:%@", url);
    
    NSMutableURLRequest *routingURLRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSHTTPURLResponse *routingURLResponse;
    NSError *error;
    
    NSData *data =[NSURLConnection sendSynchronousRequest:routingURLRequest 
                                        returningResponse:&routingURLResponse 
                                                    error:&error];
    
    error =nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data 
                                                    options:NSJSONReadingAllowFragments 
                                                      error:&error];
    
    if (jsonObject != nil && error == nil) {
        NSLog(@"routingRequest json is going to deserialize");
        
        if ([jsonObject isKindOfClass:[NSArray class]]) 
        {
            NSLog(@"jsonObject is NSArray");
            NSArray *deserializedArray = (NSArray *)jsonObject;
            
            for (int i=0; i< [deserializedArray count]; i++) 
            {
                NSArray *deserializedArray2 = [[NSArray alloc] initWithArray:[deserializedArray objectAtIndex:i]];
                Routing *oneRouting = [Routing initWithAttributesDict:[deserializedArray2 objectAtIndex:0]];
                
                NSLog(@"oneRouting = %@", oneRouting);
                
                [self.routingRequestResult addObject:oneRouting];
            }
                 

        }
    }
    
}

-(void)stopInAreaRequest:(NSString *)coord
{
    NSURL *url = [NSURL URLWithString:[STOP_IN_AREA_URL stringByAppendingFormat:@"&center_coordinate=%@",coord]];
    NSLog(@"stop in area URL:%@", url);
    
    NSMutableURLRequest *stopInAreaURLRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSHTTPURLResponse *stopInAreaURLResponse;
    NSError *error;
    
    NSData *data =[NSURLConnection sendSynchronousRequest:stopInAreaURLRequest 
                                        returningResponse:&stopInAreaURLResponse 
                                                    error:&error];
    
    error =nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data 
                                                    options:NSJSONReadingAllowFragments 
                                                      error:&error];
    
    if (jsonObject != nil && error == nil) {
        NSLog(@"stop in area json is going to deserialize");
        
        if ([jsonObject isKindOfClass:[NSArray class]]) 
        {
            NSLog(@"jsonObject is NSArray");
            NSArray *deserializedArray = (NSArray *)jsonObject;
            
            for (int i=0; i< [deserializedArray count]; i++) 
            {
                StopsInArea *oneStopInArea = [StopsInArea initWithAttributesDict:[deserializedArray objectAtIndex:i]];
                
                NSLog(@"oneStopInArea = %@", oneStopInArea);
                
                [self.fromToAddressRequestResult addObject:oneStopInArea];
            }
            
            
        }
    }
    
}

@end
