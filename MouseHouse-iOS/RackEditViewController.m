//
//  MHRackDetailsViewController.m
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RackEditViewController.h"

@interface RackEditViewController ()


@property (strong, nonatomic) NSManagedObjectContext *editingContext;

@end

@implementation RackEditViewController
@synthesize rackLabelTextField = _rackLabelTextField;
@synthesize locationTextField = _locationTextField;
@synthesize columnsTextField = _columnsTextField;
@synthesize rowsTextField = _rowsTextField;
@synthesize rack = _rack;
@synthesize editingContext = _editingContext;

- (void)awakeFromNib
{
    [super awakeFromNib];
    id appDelegate = [[UIApplication sharedApplication] delegate];
    NSPersistentStoreCoordinator *coordinator = [appDelegate persistentStoreCoordinator];
    _editingContext = [[NSManagedObjectContext alloc] init];
    [_editingContext setPersistentStoreCoordinator:coordinator];
}

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
    [self setLocationTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!_rack) {
        NSEntityDescription *rackEntity = [NSEntityDescription entityForName:@"Rack" inManagedObjectContext:_editingContext];
        _rack = [[Rack alloc] initWithEntity:rackEntity insertIntoManagedObjectContext:_editingContext];
    }
    _rackLabelTextField.text = _rack.label;
    _locationTextField.text = _rack.location;
    _columnsTextField.text = [NSString stringWithFormat:@"%d", _rack.columns];
    _rowsTextField.text = [NSString stringWithFormat:@"%d", _rack.rows];
   [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)cancel:(id)sender 
{   
    self.rack = nil;
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)save:(id)sender 
{
    NSString *label = self.rackLabelTextField.text;
    NSString *columns = self.columnsTextField.text;
    NSString *rows = self.rowsTextField.text;
    if ([label isEqualToString:@""] || [columns isEqualToString:@""] || [rows isEqualToString:@""]) {
        UIAlertView *blankFields = [[UIAlertView alloc] initWithTitle:@"Blank Fields Not Allowed" 
                                                              message:@"All fields must be complete." 
                                                             delegate:nil 
                                                    cancelButtonTitle:@"Dismiss" 
                                                    otherButtonTitles:nil];
        [blankFields show];
        return;
    }
    if (!_rack)
        _rack = [NSMutableDictionary dictionary];
    [_rack setLabel:self.rackLabelTextField.text];
    [_rack setLocation:self.locationTextField.text];
    [_rack setColumns:[self.columnsTextField.text intValue]];
    [_rack setRows:[self.rowsTextField.text intValue]];
    [self.editingContext save:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setRack:(Rack *)rack
{
    if (rack) {
        _rack = (Rack *)[_editingContext objectWithID:[rack objectID]];
    } else {
        NSEntityDescription *rackEntity = [NSEntityDescription entityForName:@"Rack" inManagedObjectContext:_editingContext];
        _rack = [[Rack alloc] initWithEntity:rackEntity insertIntoManagedObjectContext:_editingContext];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableCharacterSet *cs = [NSMutableCharacterSet decimalDigitCharacterSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:[cs invertedSet]] componentsJoinedByString:@""];
    BOOL replacementAllowed = [string isEqualToString:filtered];
    return  replacementAllowed;
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

@end
