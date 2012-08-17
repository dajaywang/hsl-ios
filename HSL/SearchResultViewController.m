//
//  SearchResultViewController.m
//  HSL
//
//  Created by DajieWang on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchResultCell.h"
#import "Routing.h"
#import "Leg.h"
#import "Loc.h"
#import "SearchResultDetailViewController.h"


@implementation SearchResultViewController

@synthesize searchResultArray;

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
    
    [self.tableView reloadData];

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.searchResultArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    */
    // Configure the cell...
    
    SearchResultCell *cell = (SearchResultCell *)[tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
    
    Routing *oneRouting = [self.searchResultArray objectAtIndex:indexPath.row];
    int legsLength = [oneRouting.LegArray count];

    NSLog(@"Enter Routing:%d, it has %d legs",indexPath.row, legsLength);
    
    cell.totalDistance100.text = [NSString stringWithFormat:@"%.2fKM", [oneRouting.length doubleValue]/1000];
    cell.totalTime101.text = [NSString stringWithFormat:@"%.2fMin",[oneRouting.duration doubleValue]/60];
    
    for (int i=0; i<legsLength; i++) 
    {
        Leg *oneLeg = [oneRouting.LegArray objectAtIndex:i];
        NSLog(@"Enter in leg:%d",i);
        
        NSString *type = [oneLeg valueForKey:@"type"];
        NSLog(@"type got: %@", type);
        
        UILabel *labelTime = (UILabel *)[cell viewWithTag:102+i];
        UILabel *labelTime2;
        UILabel *labelName = (UILabel *)[cell viewWithTag:110+i];
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:120+i];
        
        NSString *depTime;
        NSString *arrTime;
        
        int locsLength = [oneLeg.locArray count];
        Loc *firstLoc = [oneLeg.locArray objectAtIndex:0];
        Loc *lastLoc = [oneLeg.locArray  objectAtIndex:locsLength-1];
        
        //start time for 1st loc
        if (i == 0) 
        {
            NSString *depTimeStr = [NSString stringWithFormat:@"%qi", [[firstLoc valueForKey:@"depTime"] longLongValue]];
            int depTimeStrLength = [depTimeStr length];
            depTime = [NSString stringWithFormat:@"%@:%@",[depTimeStr substringWithRange:NSMakeRange(depTimeStrLength-4,2)],[depTimeStr substringWithRange:NSMakeRange(depTimeStrLength-2, 2)]];
            
            NSLog(@"it is the 1st leg, depTime:%@",depTimeStr);
        }
        //end time for last loc
        else if (i == legsLength - 1) 
        {
            //use depTime, predent to be depTime to excude labelTime.text = [[NSString alloc] initWithString:depTime]; 
            NSString *arrTimeStr = [NSString stringWithFormat:@"%qi", [[lastLoc  valueForKey:@"depTime"] longLongValue]];
            int arrTimeStrLength = [arrTimeStr length];
            depTime = [NSString stringWithFormat:@"%@:%@",[arrTimeStr substringWithRange:NSMakeRange(arrTimeStrLength-4,2)],[arrTimeStr substringWithRange:NSMakeRange(arrTimeStrLength-2, 2)]];
            
            NSLog(@"it is the last leg, arrTime is:%@", arrTimeStr);
        }
        //start and end time for others
        else {
            
            NSString *depTimeStr = [NSString stringWithFormat:@"%qi", [[firstLoc valueForKey:@"depTime"] longLongValue]];
            int depTimeStrLength = [depTimeStr length];
            depTime = [NSString stringWithFormat:@"%@:%@",[depTimeStr substringWithRange:NSMakeRange(depTimeStrLength-4,2)],[depTimeStr substringWithRange:NSMakeRange(depTimeStrLength-2, 2)]];
            
            NSString *arrTimeStr = [NSString stringWithFormat:@"%qi", [[lastLoc valueForKey:@"depTime"] longLongValue]];
            int arrTimeStrLength = [arrTimeStr length];
            arrTime = [NSString stringWithFormat:@"%@:%@",[arrTimeStr substringWithRange:NSMakeRange(arrTimeStrLength-4,2)],[arrTimeStr substringWithRange:NSMakeRange(arrTimeStrLength-2, 2)]];
            
            //show end time
            labelTime2 = (UILabel *)[cell viewWithTag:103+i];
            labelTime2.text = arrTime;
            
            NSLog(@"it is the leg between first and last one, depTime:%@,arrTime:%@", depTimeStr, arrTimeStr);
        }
        
        //show start time
        labelTime.text = depTime;
        
        //show name and image according to type
        //walk
        if ([type isEqualToString:@"walk"]) 
        {
            NSNumber *length = [oneLeg valueForKey:@"length"];
            labelName.text = [NSString stringWithFormat:@"%.2fKM", [length doubleValue]/1000];
            [imageView setImage:[UIImage imageNamed:@"walk.gif"]];
            
            NSLog(@"enter type: %@,%.2f", type, [length doubleValue]);
        }
        //1 bus, 5 regional bus, 22 helsinki night bus, 25 regional night buses
        else if ([type isEqualToString:@"1"] || [type isEqualToString:@"5"] || [type isEqualToString:@"22"] || [type isEqualToString:@"25"]) 
        {
            NSLog(@"enter type: %@", type);
            
            NSString *codeStr = [NSString stringWithFormat:@"%@",[oneLeg valueForKey:@"code"]];
            NSString *codeStr2 = [[codeStr substringWithRange:NSMakeRange(1, 3)] intValue] < 100 ? [codeStr substringWithRange:NSMakeRange(2, 3)]:[codeStr substringWithRange:NSMakeRange(1, 4)];
            NSString *name = [firstLoc valueForKey:@"name"];
            labelName.text = [NSString stringWithFormat:@"%@,%@",codeStr2,name];
            
            [imageView setImage:[UIImage imageNamed:@"bus.gif"]];
        }
        //trams
        else if ([type isEqualToString:@"2"]) 
        {
            NSLog(@"enter type: %@", type);
            
            NSString *codeStr = [NSString stringWithFormat:@"%@",[oneLeg valueForKey:@"code"]];
            NSString *codeStr2 = [[codeStr substringWithRange:NSMakeRange(1, 3)] intValue] < 100 ? [codeStr substringWithRange:NSMakeRange(2, 3)]:[codeStr substringWithRange:NSMakeRange(1, 4)];
            NSString *name = [firstLoc valueForKey:@"name"];
            labelName.text = [NSString stringWithFormat:@"%@,%@",codeStr2,name];
            [imageView setImage:[UIImage imageNamed:@"tram.gif"]];
        }
        //metro
        else if ([type isEqualToString:@"6"]) {
            NSLog(@"enter type: %@", type);
            NSString *name = [firstLoc valueForKey:@"name"];
            labelName.text = [NSString stringWithFormat:@"%@,%@",[[oneLeg valueForKey:@"code"] substringWithRange:NSMakeRange(1, 4)],name];
            [imageView setImage:[UIImage imageNamed:@"metro.gif"]];
        }
        //train
        else if ([type isEqualToString:@"12"]) {
            NSLog(@"enter type: %@", type);
            NSString *name = [firstLoc valueForKey:@"name"];
            labelName.text = [NSString  stringWithFormat:@"%@,%@",[[oneLeg valueForKey:@"code"] substringWithRange:NSMakeRange(1, 4)],name];
            [imageView setImage:[UIImage imageNamed:@"train.gif"]];
        }

         
    }
    
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
                      
//
//


//segue
//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"segue ID: %@, %@",segue.identifier, sender);
    if ([segue.identifier isEqualToString:@"ResultToDetail"]) 
    {
        SearchResultDetailViewController *searchResultDetailViewController = segue.destinationViewController;
        
        searchResultDetailViewController.oneRouting = [self.searchResultArray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        NSLog(@"table view cell %d is selected",[[self.tableView indexPathForSelectedRow] row]);
    }
}
                      
@end
