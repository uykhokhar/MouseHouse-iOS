//
//  MHMasterViewController.m
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MHRacksViewController.h"
#import "MHRackDetailsViewController.h"
#import "MHCagesViewController.h"

#define MHBaseResource  @"mouse_racks"

@interface MHRacksViewController ()

- (NSMutableDictionary *)rackWithId:(NSString *)idString;

@end

@implementation MHRacksViewController

@synthesize cagesViewController = _cagesViewController;
@synthesize tableView = _tableView;
@synthesize refreshButton = _refreshButton;
@synthesize racks = _racks;
@synthesize selectedRackId = _selectedRackId;

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    self.resource = MHBaseResource;
    [super awakeFromNib];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Segue: %@", [segue identifier]);
    if ([[segue identifier] isEqualToString:@"Edit Segue"]) {
        MHRackDetailsViewController *vc = [segue destinationViewController];
        vc.rack = [self rackWithId:[self selectedRackId]];
    }
}


- (NSMutableDictionary *)rackWithId:(NSString *)idString
{
    NSMutableDictionary *selectedRack = nil;
    NSPredicate *selectionPredicate = [NSPredicate predicateWithFormat:@"_id == %@", _selectedRackId];
    NSArray *filteredArray = [_racks filteredArrayUsingPredicate:selectionPredicate];
    NSLog(@"Selected Rack %d", [filteredArray count]);
    if ([filteredArray count] > 0) {
         selectedRack = [filteredArray objectAtIndex:0];
    }
    return selectedRack;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.refreshButton.target = self;
    self.refreshButton.action = @selector(refresh:);
    [self refresh:nil];
    self.cagesViewController = (MHCagesViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewDidUnload
{
    [self setRefreshButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)insertNewObject:(id)sender
{
    if (!_racks) {
        _racks = [[NSMutableArray alloc] init];
    }
    [_racks insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _racks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    NSDictionary *rack = [_racks objectAtIndex:indexPath.row];
    cell.textLabel.text = [rack objectForKey:@"label"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self destroyObject:[_racks objectAtIndex:indexPath.row]];
        [_racks removeObjectAtIndex:indexPath.row];
        self.selectedRackId = nil;
        self.cagesViewController.rack = nil;
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [_racks count]) { 
        NSMutableDictionary *selectedRack = [_racks objectAtIndex:indexPath.row];
        self.cagesViewController.rack = selectedRack;
        self.selectedRackId = [selectedRack objectForKey:@"_id"];
        NSLog(@"Selected Rack %@", _selectedRackId.description);
    }
}

#pragma mark - NSURLConnection override

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received %d bytes of data",[self.receivedData length]);
    
    NSError *error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:self.receivedData options:NSJSONReadingMutableContainers | NSJSONReadingAllowFragments error:&error];
    TFLog(@"JSON Object: %@", [jsonObject description]);
    _racks = jsonObject;
    NSLog(@"Racks count: %d", [_racks count]);
    self.receivedData = nil;
    [self.tableView reloadData];
    [self viewDidAppear:YES];
    NSLog(@"Selected Rack %@", _selectedRackId.description);
    if ((!_selectedRackId || [_selectedRackId isEqualToString:@""])  && [_racks count] > 0) {
        NSLog(@"INITIAL ID: %@", [[_racks objectAtIndex:0] description]);
        _selectedRackId = [[_racks objectAtIndex:0] valueForKey:@"_id"];
    }
    NSInteger row = [_racks indexOfObject:[self rackWithId:_selectedRackId]];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    self.cagesViewController.rack = [self rackWithId:_selectedRackId];

}

@end
