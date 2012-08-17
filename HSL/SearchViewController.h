//
//  SearchViewController.h
//  HSL
//
//  Created by DajieWang on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define METERS_PER_MILE 1609.344

@class SearchRequest;

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "DatePickerViewController.h"
#import "FromToAddressViewController.h"


@interface SearchViewController : UIViewController <UITextFieldDelegate, FromToAddressDelegate, DatePickerDelegate, MKMapViewDelegate, CLLocationManagerDelegate>  

@property (strong) SearchRequest *searchRequest;
@property CLLocationCoordinate2D currentLocation;
@property (strong) CLLocationManager *locationManager;

@property (strong, nonatomic) IBOutlet UITextField *fromTextField;
@property (strong, nonatomic) IBOutlet UITextField *toTextField;
@property (strong, nonatomic) IBOutlet UITextField *timeTextField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *timeSegment;

- (IBAction)fromOrToChanged:(id)sender;


- (IBAction)findNearbyAddress:(id)sender;
- (IBAction)searchRequest:(id)sender;


@end
