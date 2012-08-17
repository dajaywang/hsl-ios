//
//  SearchViewController.m
//  HSL
//
//  Created by DajieWang on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"

#import "Utilities.h"
#import "SearchRequest.h"

#import "Geocoding.h"
#import "Routing.h"
#import "StopsInArea.h"
#import "SearchResultViewController.h"
#import "SearchResultMapViewController.h"


@interface SearchViewController()
{
    @public
    BOOL isFromTextField;
    BOOL isFromNearby;
}

@end

@implementation SearchViewController

@synthesize searchRequest;
@synthesize  currentLocation;
@synthesize locationManager;

@synthesize fromTextField;
@synthesize toTextField;
@synthesize timeTextField;
@synthesize timeSegment;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewWillAppear:(BOOL)animated
{ 
    /*
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 60.170097;
    zoomLocation.longitude= 24.939551;

    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.8*METERS_PER_MILE, 0.8*METERS_PER_MILE); // 3
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
    [mapView setRegion:adjustedRegion animated:YES];
    */
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.searchRequest = [[SearchRequest alloc] init];
    
    //set timeTextField
    NSDate *now = [[NSDate alloc] init];
    self.timeTextField.text = [Utilities getDateTimeStrFromNSDate:now];
    self.searchRequest.dateStr = [Utilities getDateStrFromNSDate:now];
    self.searchRequest.timeStr = [Utilities getTimeStrFromNSDate:now];
    
    //get timeSegement
    self.searchRequest.timeTypeStr = [self.timeSegment selectedSegmentIndex]?@"arrival":@"departure";
                                   
    self.fromTextField.delegate = self;
    self.toTextField.delegate =self;
    self.timeTextField.delegate = self;
    
    [self performSelectorOnMainThread:@selector(locateMap) withObject:nil waitUntilDone:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setFromTextField:nil];
    [self setToTextField:nil];
    [self setTimeTextField:nil];
    [self setTimeSegment:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//
//Functions

-(void)locateMap
{
    //self.mapView = [[MKMapView alloc] init];
    
    if (nil == locationManager) {
        locationManager = [[CLLocationManager alloc] init];
    }
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.distanceFilter = 500;
    [locationManager startUpdatingLocation];
}

//
//Actions

//segment
- (IBAction)fromOrToChanged:(id)sender 
{
    self.searchRequest.timeTypeStr = [self.timeSegment selectedSegmentIndex]?@"arrival":@"departure";
    NSLog(@"the direction is:%@", self.searchRequest.timeTypeStr);
}


//nearby button
- (IBAction)findNearbyAddress:(id)sender 
{   
    self->isFromNearby = TRUE;
    
    [searchRequest stopInAreaRequest:[[NSString alloc] initWithFormat:@"%f,%f", self.currentLocation.longitude, self.currentLocation.latitude]];
    
    if ([self.searchRequest.fromToAddressRequestResult count] > 0) 
    {
        [self performSegueWithIdentifier:@"FromToSegue" sender:self];
    }
    else 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Check Address" message:@"Address not found or timeout" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }

}

//search button
- (IBAction)searchRequest:(id)sender {
    [self.searchRequest.routingRequestResult removeAllObjects];
    [searchRequest routingRequest:self.searchRequest.fromCoord 
                           withTo:self.searchRequest.toCoord 
                         withDate:self.searchRequest.dateStr 
                         withTime:self.searchRequest.timeStr 
                     withTimeType:self.searchRequest.timeTypeStr];
    
    if ([self.searchRequest.routingRequestResult count] > 0) 
    {
        [self performSegueWithIdentifier:@"SearchSegue" sender:self];
    }
    else 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Search Result" message:@"search timeout" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }

}

//
#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    NSLog(@"didBeginEditing, textField tag:%@",textField);
    
    if (textField.tag == 103) 
    {
        [textField resignFirstResponder];
    }
    
    if (textField.tag == 101) 
    {
        self->isFromTextField = YES;
    }
    else if (textField.tag == 102)
    {
        self->isFromTextField = NO;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    self->isFromNearby = FALSE;
    
    NSString *textFieldstr = [[NSString alloc] init];
    if (self->isFromTextField) {
        textFieldstr = [self.fromTextField.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    }
    else {
        textFieldstr = [self.toTextField.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    }
    NSLog(@"textField String:%@", textFieldstr), 
    
    [self.searchRequest.fromToAddressRequestResult removeAllObjects];
    [searchRequest geocodingRequest:textFieldstr];
    
    if ([self.searchRequest.fromToAddressRequestResult count] > 0) 
    {
        [self performSegueWithIdentifier:@"FromToSegue" sender:self];
    }
    else 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Check Address" message:@"Address not found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }

    return YES;
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];

    NSLog(@"Did end editing");
}


//
#pragma mark - FromToAddressDelegate

- (void) fromToAddItemChanged:(NSInteger)index
{
    NSString *strTemp = [[NSString alloc] init];
    NSString *coords = [[NSString alloc] init];
    
    if (self->isFromNearby) {
        StopsInArea *stopInArea = [self.searchRequest.fromToAddressRequestResult objectAtIndex:index];
        strTemp = [stopInArea getStrFromStopsInArea];
        coords = stopInArea.coords;
    }
    else {
        Geocoding *geocodingTemp = [self.searchRequest.fromToAddressRequestResult objectAtIndex:index];
        strTemp = [geocodingTemp getStrFromGeocoding];
        coords = geocodingTemp.coords;
    }

        
    
    if (self->isFromTextField == YES) {
        NSLog(@"set date for fromTextField");
        
        self.fromTextField.text = strTemp;
        [self.fromTextField resignFirstResponder];
        
        self.searchRequest.fromCoord = coords;
        [self.searchRequest.fromToAddressRequestResult removeAllObjects];
    }
    else if (self->isFromTextField == NO)
    {
        NSLog(@"set date for toTextField");
        
        self.toTextField.text = strTemp;
        [self.toTextField resignFirstResponder];
        
        self.searchRequest.toCoord = coords;
        [self.searchRequest.fromToAddressRequestResult removeAllObjects];
    }
    NSLog(@"FromToAddressDelegate excuted, fromCoord:%@,toCoord:%@",self.searchRequest.fromCoord,self.searchRequest.toCoord);
}

//
#pragma mark - DatePickerDelegate

-(void)dateChanged:(NSDate *)newDate
{
    self.timeTextField.text = [Utilities getDateTimeStrFromNSDate:newDate];
    
    self.searchRequest.dateStr = [Utilities getDateStrFromNSDate:newDate];
    self.searchRequest.timeStr = [Utilities getTimeStrFromNSDate:newDate];
    
    NSLog(@"------datePickerDelegate excuted, searchRequest.date:%@,.time:%@,type:%@", self.searchRequest.dateStr, self.searchRequest.timeStr,self.searchRequest.timeTypeStr);
}

//
#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    self.currentLocation = userLocation.coordinate;
    
    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          userLocation.coordinate.latitude,
          userLocation.coordinate.longitude);
    
    //MKCoordinateRegion coordinateRegion = MKCoordinateRegionMakeWithDistance(self.currentLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    //MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:coordinateRegion];
    //[self.mapView setRegion:adjustedRegion animated:YES];
    
}

//
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    self.currentLocation = newLocation.coordinate;
    
    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          newLocation.coordinate.latitude,
          newLocation.coordinate.longitude);
    
    //MKCoordinateRegion coordinateRegion = MKCoordinateRegionMakeWithDistance(self.currentLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    //MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:coordinateRegion];
    //[self.mapView setRegion:adjustedRegion animated:YES];
}


//
//Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"segue ID: %@",segue.identifier);
    if ([segue.identifier isEqualToString:@"FromToSegue"]) 
    {
        FromToAddressViewController *fromToAddViewController = segue.destinationViewController;
        fromToAddViewController.fromToAddressDelegate = self;
        
        if ([self.searchRequest.fromToAddressRequestResult count] > 0) 
        {
            [fromToAddViewController.fromToAddressArray removeAllObjects];
            fromToAddViewController.fromToAddressArray = self.searchRequest.fromToAddressRequestResult;
            fromToAddViewController.currentLocation = self.currentLocation;
            
            NSLog(@"fromToAddressArray & currentLocation transferred");
            
            if (self->isFromNearby) 
            {
                fromToAddViewController.isFromNearby = TRUE;
            }
            
            [fromToAddViewController prepareViewController];
        }
        else 
        {
            
        }
    
    }
    else if ([segue.identifier isEqualToString:@"timeFieldSegue"]) 
    {
        DatePickerViewController *datePickerViewController = segue.destinationViewController;
        datePickerViewController.datePickerDelegate = self;
    }
    else if ([segue.identifier isEqualToString:@"SearchSegue"])
    {        
        NSLog(@"%@",segue.destinationViewController);
        
        UITabBarController *searchResultTabBarController = segue.destinationViewController;
        
        //search result table view
        SearchResultViewController *searchResultViewController = (SearchResultViewController *)[searchResultTabBarController.viewControllers objectAtIndex:0];
                
        //search result map view
        SearchResultMapViewController *searchResultMapViewController = (SearchResultMapViewController *)[searchResultTabBarController.viewControllers objectAtIndex:1];
        
        if ([self.searchRequest.routingRequestResult count] > 0) {
            [searchResultViewController.searchResultArray removeAllObjects];
            searchResultViewController.searchResultArray = self.searchRequest.routingRequestResult;
            
            [searchResultMapViewController.searchResultArray removeAllObjects];
            searchResultMapViewController.searchResultArray = self.searchRequest.routingRequestResult;
        }
        else {
            
        }
        
        NSLog(@"-----xxxx------");
    }
}


@end
