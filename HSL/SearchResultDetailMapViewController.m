//
//  SearchResultDetailMapViewController.m
//  HSL
//
//  Created by DajieWang on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchResultDetailMapViewController.h"
#import "Routing.h"
#import "Leg.h"
#import "Loc.h"

@interface SearchResultDetailMapViewController ()

@end

@implementation SearchResultDetailMapViewController

@synthesize searchResultLegsArray;
@synthesize oneRoutingMapView;
@synthesize polyLine;
@synthesize routeRect;
@synthesize polyLineView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    MKMapPoint northEastPoint;
    MKMapPoint southWestPoint;
    
    MKMapPoint * pointArr = malloc(sizeof(CLLocationCoordinate2D)*[self.searchResultLegsArray count]);
    NSLog(@"%d",[self.searchResultLegsArray count]);
    
    for (int i; i < [self.searchResultLegsArray count]; i++) 
    {
        Leg *oneLeg = [self.searchResultLegsArray objectAtIndex:i]; 
        for (int j=0; j< [oneLeg.locArray count]; j++) {
            Loc *oneLoc =[oneLeg.locArray objectAtIndex:j];
            NSLog(@"loc:%@",oneLoc.coords);
            
            NSArray *latLonArray = [oneLoc.coords componentsSeparatedByString:@","];
            
            CLLocationDegrees latitude = [[latLonArray objectAtIndex:0] doubleValue];
            CLLocationDegrees longitude = [[latLonArray objectAtIndex:1] doubleValue];
            
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
            
            MKMapPoint point = MKMapPointForCoordinate(coordinate);
            
            if (i == 0) {
                northEastPoint = point;
                southWestPoint = point;
            }
            else {
                if (point.x > northEastPoint.x) {
                    northEastPoint.x = point.x;
                }
                
                if (point.y > northEastPoint.y) {
                    northEastPoint.y = point.y;
                }
                
                if (point.x < southWestPoint.x) {
                    southWestPoint.x = point.x;
                }
                
                if (point.y < southWestPoint.y) {
                    southWestPoint.y = point.y;
                }  
            }
            
            pointArr[i] = point;
        }
        
    }
    
    self.polyLine= [MKPolyline polylineWithPoints:pointArr count:[self.searchResultLegsArray count]];
    self.routeRect = MKMapRectMake(southWestPoint.x, southWestPoint.y, northEastPoint.x-southWestPoint.x, northEastPoint.y-southWestPoint.y);
    
    [self.oneRoutingMapView addOverlay:polyLine];
    
    free(pointArr);
    
 
}

- (void)viewDidUnload
{
    [self setOneRoutingMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//Function
//
- (IBAction)closeMapDetail:(id)sender 
{
    [self dismissModalViewControllerAnimated:YES];
}

//Map delegate
//
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    MKOverlayView *overlayView = nil;
    
    if (overlay == self.polyLine) 
    {
        if (nil == self.polyLineView) 
        {
            self.polyLineView = [[MKPolylineView alloc] initWithPolyline:self.polyLine];
            self.polyLineView.fillColor = [UIColor redColor];
            self.polyLineView.strokeColor = [UIColor redColor];
            self.polyLineView.lineWidth =3;
        }
        
        overlayView = self.polyLineView;
    }
    
    return overlayView;
    
}

@end
