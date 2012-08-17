//
//  FromToAddTableViewController.h
//  HSL
//
//  Created by DajieWang on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@protocol FromToAddressDelegate <NSObject>

- (void) fromToAddItemChanged:(NSInteger)index;

@end

@interface FromToAddTableViewController : UIViewController

@property (strong) NSMutableArray *fromToAddressArray;
@property (strong) id <FromToAddressDelegate> fromToaddressDelegate;

@property BOOL isFromNearby;
@property (strong, nonatomic) IBOutlet MKMapView *fromToMap;


@end
