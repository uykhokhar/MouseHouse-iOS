//
//  CageDetailsViewController.m
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CageDetailsViewController.h"
#import <CoreData/CoreData.h>
#import "Mouse.h"
#import "MouseEditViewController.h"

@interface CageDetailsViewController ()

@end

@implementation CageDetailsViewController

@synthesize cancelButton = _cancelButton;
@synthesize doneButton = _doneButton;
@synthesize cage = _cage;
@synthesize mice = _mice;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.sectionHeaderHeight = 44;
}

- (void)viewDidUnload
{
    [self setCancelButton:nil];
    [self setDoneButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   
    // Return the number of rows in the section.
    NSInteger numberOfRows;
    switch (section) {
        case 0:
            numberOfRows = 1;
            break;
        case 1:
            numberOfRows = 3;
            break;
        default:
            numberOfRows = [self.cage.mice count] > 0 ? [self.cage.mice count] : 1;
            break;
    }

    return numberOfRows;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 44)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, headerView.bounds.size.width -35, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0, 1);
    [headerView addSubview:label];
    UIButton *addMouseButton = nil;
    switch (section) {
        case 0:
            label.text = @"Cage Information";
            break;
        case 1:
            label.text = @"Notices";
            break;
        default:
            addMouseButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
            [addMouseButton addTarget:self action:@selector(addMouse:) forControlEvents:UIControlEventTouchUpInside];
            CGRect frame = addMouseButton.frame;
            frame.origin = CGPointMake(headerView.bounds.size.width - 36, 7);
            addMouseButton.frame = frame;
            [headerView addSubview:addMouseButton];
            label.text = @"Mice";
            break;
    }    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    switch (indexPath.section) {
        case 0:
            cellIdentifier = @"Cage number cell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            [[cell textFieldWithTag:MHCageNumberTextFieldTag] setText:_cage.cageNumber];
            break;
        case 1:
            cellIdentifier = @"Notice cell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Health Notice";
                    cell.textLabel.textColor = [UIColor redColor];
                    break;
                case 1:
                    cell.textLabel.text = @"Overcrowding";
                    cell.textLabel.textColor = [UIColor greenColor];
                    break;    
                default:
                    cell.textLabel.text = @"Breeding Cage";
                    cell.textLabel.textColor = [UIColor blueColor];
                    break;
            }
            break;
        default:
            if ([self.mice count] > 0) {
                Mouse *mouse = [self.mice objectAtIndex:indexPath.row];
                cellIdentifier = @"Mouse cell";
                cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                cell.textLabel.text = mouse.earTag;
                cell.detailTextLabel.text = @"Sequence";
            } else {
                cell.textLabel.text = @"No mice.";
                cell.detailTextLabel.text = @"Click add button to add mice to cage.";
            }
            break;
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

- (void)addMouse:(id)sender
{
    NSManagedObjectContext *moc = self.cage.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Mouse" inManagedObjectContext:moc];
    Mouse *newMouse = [[Mouse alloc] initWithEntity:entity insertIntoManagedObjectContext:moc];
    newMouse.earTag = @"1234";
    [self.cage addMiceObject:newMouse];
    _mice = [self.cage.mice allObjects];
    self.cage.cageNumber = [[self.view textFieldWithTag:MHCageNumberTextFieldTag] text];
    [self.tableView reloadData];
    [self performSegueWithIdentifier:@"Edit Mouse Segue" sender:[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[self.cage.mice count] - 1 inSection:2]]];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    Mouse *mouse = [_mice objectAtIndex:[self.tableView indexPathForCell:sender].row];
    MouseEditViewController *vc = segue.destinationViewController;
    vc.mouse = mouse;
}


- (void)setCage:(Cage *)cage
{
    _cage = cage;
    _mice = [_cage.mice allObjects];
    [self.tableView reloadData];
}

@end
