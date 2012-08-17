//
//  SearchResultDetailMapViewController.h
//  HSL
//
//  Created by DajieWang on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SearchResultDetailMapViewController : UIViewController <MKMapViewDelegate>

- (IBAction)closeMapDetail:(id)sender;

@property (strong) NSMutableArray *searchResultLegsArray;

@property (strong) MKPolyline *polyLine;
@property (strong) MKPolylineView *polyLineView;
@property  MKMapRect routeRect;
@property (strong, nonatomic) IBOutlet MKMapView *oneRoutingMapView;

@end
