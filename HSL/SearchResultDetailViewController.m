//
//  SearchResultDetailViewController.m
//  HSL
//
//  Created by DajieWang on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchResultDetailViewController.h"
#import "Routing.h"
#import "Leg.h"
#import "Loc.h"
#import "SearchResultDetailMapViewController.h"


@implementation SearchResultDetailViewController

@synthesize oneRouting;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.oneRouting.legs count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    Leg *oneLeg = [oneRouting.LegArray objectAtIndex:section];
    
    return [oneLeg.locArrayWithName count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width,self.tableView.sectionHeaderHeight)];
    
    Leg *oneLeg = [oneRouting.LegArray objectAtIndex:section];
    if ([oneLeg.locArrayWithName count] > 0) 
    {
        Loc *firstLoc = [oneLeg.locArrayWithName objectAtIndex:0];
        
        //first half of the Head view: depTime, depName, BusNo.
        //use locArray
        [viewHead addSubview:[self labelForOneLegOfRouting:[NSString stringWithFormat:@"%@      %@      %@",[Loc getTimeFromDepOrArrTime:firstLoc.depTime]==NULL?@"":[Loc getTimeFromDepOrArrTime:firstLoc.depTime], firstLoc.name==NULL?@"":firstLoc.name, [Leg getNofromCode:oneLeg.code]==NULL?@"":[Leg getNofromCode:oneLeg.code]]  withFrame:CGRectMake(0, 0, viewHead.frame.size.width, viewHead.frame.size.height*0.5) withFont:15]];
        
        //second half of the Head view: image for type
        [viewHead addSubview:[self imageForOneLegOfRouting:oneLeg.type withFrame:CGRectMake(0, viewHead.frame.size.height*0.5, 20,20 )]];
        NSLog(@"oneLeg.type:%@",oneLeg.type);
    }

   
    return viewHead;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DetailCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    Leg *oneLeg = [oneRouting.LegArray objectAtIndex:indexPath.section];
    
    if ([oneLeg.locArrayWithName count] > 0)
    {
        Loc *oneLoc = [oneLeg.locArrayWithName objectAtIndex:indexPath.row];
        
        [cell addSubview:[self labelForOneLegOfRouting:[NSString stringWithFormat:@"%@    %@(%@)",[Loc getTimeFromDepOrArrTime:oneLoc.arrTime]==NULL?@"":[Loc getTimeFromDepOrArrTime:oneLoc.arrTime], oneLoc.name==NULL?@"":oneLoc.name, oneLoc.shortCode==NULL?@"":oneLoc.shortCode]  withFrame:CGRectMake(self.tableView.frame.size.width*0.1, 0, self.tableView.frame.size.width, self.tableView.rowHeight*0.8) withFont:12 ]];
    }   
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
}

//functions
//
-(UILabel *)labelForOneLegOfRouting:(NSString *)legStr withFrame:(CGRect)frame withFont:(CGFloat)fontSize
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.text = legStr;
    [label setTextAlignment:UITextAlignmentLeft];
    
    return label;
}

-(UIImageView *)imageForOneLegOfRouting:(NSString *)type withFrame:(CGRect)frame
{
    UIImageView *image = [[UIImageView alloc] initWithFrame:frame];
    
    if ([type isEqualToString:@"walk"]) 
    {
        image.image = [UIImage imageNamed:@"walk.gif"];
    }
    else if ([type isEqualToString:@"1"] || [type isEqualToString:@"5"] || 
             [type isEqualToString:@"22"]|| [type isEqualToString:@"25"]) 
    {
        image.image = [UIImage imageNamed:@"bus.gif"];
    }
    else if ([type isEqualToString:@"2"])
    {
        image.image = [UIImage imageNamed:@"tram.gif"];
    }
    else if ([type isEqualToString:@"6"])
    {
        image.image = [UIImage imageNamed:@"metro.gif"];
    }
    else if ([type isEqualToString:@"12"])
    {
        image.image = [UIImage imageNamed:@"train.gif"];
    }
   
    return image;
}

//segue
//
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailToDetailMap"]) 
    {
        SearchResultDetailMapViewController *searchResultDetailMaplViewController = segue.destinationViewController;
        [searchResultDetailMaplViewController.searchResultLegsArray removeAllObjects];
        searchResultDetailMaplViewController.searchResultLegsArray = self.oneRouting.LegArray;
        
        NSLog(@"segue ID: %@, sender:%@, array length:%d",segue.identifier, sender,[searchResultDetailMaplViewController.searchResultLegsArray count]);
    }
    
}

@end
