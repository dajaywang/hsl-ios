//
//  FromToAddressViewController.h
//  HSL
//
//  Created by DajieWang on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define METERS_PER_MILE 1609.344

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol FromToAddressDelegate <NSObject>

- (void) fromToAddItemChanged:(NSInteger)index;

@end

@interface FromToAddressViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong) NSMutableArray *fromToAddressArray;
@property BOOL isFromNearby;
@property CLLocationCoordinate2D currentLocation;

@property (strong) id <FromToAddressDelegate> fromToAddressDelegate;

@property (strong, nonatomic) IBOutlet MKMapView *fromToMap;

- (void)prepareViewController;
@end
