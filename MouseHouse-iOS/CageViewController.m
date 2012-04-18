//
//  CageViewController.m
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CageViewController.h"
#import "CageDetailsViewController.h"
#import "Rack.h"
#import "Rack+Extensions.h"
#import "Cage.h"


@interface CageViewController ()
{
    UIPopoverController *cageDetailsPopover;
    CageDetailsViewController *detailsViewController;
}

@end

@implementation CageViewController

@synthesize column = _column;
@synthesize row = _row;
@synthesize rack = _rack;
@synthesize cage = _cage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)configureCageView
{
    _cage = [self.rack cageAtColumn:self.column row:self.row];
    
    if (!_cage) {
        [[self.view labelWithTag:MHInactiveCageLabelTag] setHidden:NO];
    } else {
        [[self.view labelWithTag:MHInactiveCageLabelTag] setHidden:YES];
        [[self.view labelWithTag:MHCageNumberLabelTag] setText:_cage.cageNumber];
        [[self.view labelWithTag:MHNumberOfMiceLabelTag] setText:[NSString stringWithFormat:@"%d", [_cage.mice count]]];
    }
}

- (void)viewDidLoad
{
    assert(self.rack != nil);
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cage-background"]];
    [self configureCageView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *navController = (UINavigationController *)[segue destinationViewController];
    cageDetailsPopover = [(UIStoryboardPopoverSegue *)segue popoverController];
    cageDetailsPopover.delegate = self;
    
    detailsViewController = [[navController viewControllers] objectAtIndex:0];
    detailsViewController.doneButton.target = self;
    detailsViewController.doneButton.action = @selector(save:);
    
    detailsViewController = [[navController viewControllers] objectAtIndex:0];
    detailsViewController.cancelButton.target = self;
    detailsViewController.cancelButton.action = @selector(cancel:);
    NSManagedObjectContext *moc = self.rack.managedObjectContext;
        if (_cage) {
        detailsViewController.cage = (Cage *)[moc objectWithID:[_cage objectID]];
    } else {
        Cage *cage = [NSEntityDescription insertNewObjectForEntityForName:@"Cage" inManagedObjectContext:moc];
        [cage setValue:self.rack forKey:@"rack"];
        [cage setValue:_column forKey:@"column"];
        [cage setValue:_row forKey:@"row"];
        detailsViewController.cage = cage;
    }
    
}

- (IBAction)save:(id)sender
{
    detailsViewController.cage.cageNumber = [[detailsViewController.view textFieldWithTag:MHCageNumberTextFieldTag] text];
    NSError *error = nil;
    [_rack addCagesObject:detailsViewController.cage];
    [[_rack managedObjectContext] save:&error];
    [self configureCageView];
    [cageDetailsPopover dismissPopoverAnimated:YES];
}

-(IBAction)cancel:(id)sender
{
    [[_cage managedObjectContext] rollback];
    [cageDetailsPopover dismissPopoverAnimated:YES];
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [self cancel:nil];
}

@end