//
//  FromToAddressViewController.m
//  HSL
//
//  Created by DajieWang on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FromToAddressViewController.h"
#import "Geocoding.h"
#import "StopsInArea.h"

@interface FromToAddressViewController ()

@end

@implementation FromToAddressViewController

@synthesize fromToAddressArray;
@synthesize currentLocation;
@synthesize isFromNearby;
@synthesize fromToAddressDelegate;
@synthesize fromToMap;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//in Modal
//ViewDidLoad is called before SearchViewController's prepareSegue()
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareViewController
{
    NSLog(@"fromToAddressView Controller:%f,%f", self.currentLocation.latitude, self.currentLocation.longitude);
    
    MKCoordinateRegion coordinateRegion = MKCoordinateRegionMakeWithDistance(self.currentLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    NSLog(@"fromToAddressView, MKCoordinateRegion,center:%f,%f", coordinateRegion.center.latitude,coordinateRegion.center.longitude);
    NSLog(@"fromToAddressView, MKCoordinateRegion,span:%f,%f", coordinateRegion.span.latitudeDelta,coordinateRegion.span.longitudeDelta);
    MKCoordinateRegion adjustedRegion = [self.fromToMap regionThatFits:coordinateRegion];
    [self.fromToMap setRegion:adjustedRegion animated:YES];
}

//
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fromToAddressArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //NSLog(@"before return cell1:%@", cell);
    // Configure the cell...
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //NSLog(@"before return cell2:%@", cell);
    
    if (self.isFromNearby == YES) {
        StopsInArea *stopInArea = [[StopsInArea alloc] init];
        stopInArea = [self.fromToAddressArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [stopInArea getStrFromStopsInArea];
    }
    else {
        Geocoding *geocodingTemp = [[Geocoding alloc] init];
        geocodingTemp = [self.fromToAddressArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [geocodingTemp getStrFromGeocoding];
        
        NSLog(@"cell");
    }
    
    return cell;
}

//
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    //MUST excute the dismiss first, then delegate, or there will be focus problem of TextField will
    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"FromToAddressView dismiss");
    [self.fromToAddressDelegate fromToAddItemChanged:indexPath.row];
    [self.fromToAddressArray removeAllObjects];
    NSLog(@"FromToAddressDelegate delegate invoked");
}

@end
