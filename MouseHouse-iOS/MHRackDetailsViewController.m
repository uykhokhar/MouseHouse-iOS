//
//  MHRackDetailsViewController.m
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MHRackDetailsViewController.h"
#import "MHRacksViewController.h"

#define MHResource    @"mouse_racks"
#define MHIDKey             @"_id"
#define MHLabelKey          @"label"
#define MHColumnsKey        @"columns"
#define MHRowsKey           @"rows"

@interface MHRackDetailsViewController ()

@end

@implementation MHRackDetailsViewController
@synthesize rackLabelTextField = _rackLabelTextField;
@synthesize columnsTextField = _columnsTextField;
@synthesize rowsTextField = _rowsTextField;
@synthesize rack = _rack;
- (IBAction)cancel:(id)sender 
{   
    self.rack = nil;
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_rack) {
        _rackLabelTextField.text = [_rack objectForKey:MHLabelKey];
        _columnsTextField.text = [[_rack objectForKey:MHColumnsKey] description];
        _rowsTextField.text = [[_rack objectForKey:MHRowsKey] description];
    }
}

- (IBAction)save:(id)sender 
{
    if (!_rack)
        _rack = [NSMutableDictionary dictionary];
    [_rack setObject:self.rackLabelTextField.text forKey:MHLabelKey];
    [_rack setObject:self.columnsTextField.text forKey:MHColumnsKey];
    [_rack setObject:self.rowsTextField.text forKey:MHRowsKey];
    [self saveObject:_rack];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.resource = MHResource;
}

- (void)viewDidUnload
{
    [self setRackLabelTextField:nil];
    [self setColumnsTextField:nil];
    [self setRowsTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    // Configure the cell...
//    
//    return cell;
//}

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

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     */
//}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received %d bytes of data",[self.receivedData length]);
    
    NSError *error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:self.receivedData options:NSJSONReadingMutableContainers | NSJSONReadingAllowFragments error:&error];
    NSLog(@"JSON Object: %@", [jsonObject description]);
    if (![_rack objectForKey:MHIDKey]) {
        [(MHRacksViewController *)[self.navigationController.viewControllers objectAtIndex:0] setSelectedRackId:[jsonObject objectForKey:MHIDKey]];
    }
    [(MHRacksViewController *)[self.navigationController.viewControllers objectAtIndex:0] refresh:nil];
    [self.navigationController popViewControllerAnimated:YES];
    _rack = nil;
    self.receivedData = nil;
}

@end
