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
#import "Cage.h"


enum MHCageViewTags {
    MHInactiveCageLabelTag = 10
    };

@interface CageViewController ()

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

- (void)viewDidLoad
{
    assert(self.rack != nil);
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cage-background"]];
    _cage = [self.rack cageAtColumn:self.column row:self.row];
    if (!_cage) {
        [[self.view labelWithTag:MHInactiveCageLabelTag] setHidden:YES];
    } else {
        [[self.view labelWithTag:MHInactiveCageLabelTag] setHidden:NO];
    }
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
    UINavigationController *navController = (UINavigationController *)[segue destinationViewController] ;
    CageDetailsViewController *vc = [[navController viewControllers] objectAtIndex:0];
    NSManagedObjectContext *_editingContext = [[NSManagedObjectContext alloc] init];
    [_editingContext setPersistentStoreCoordinator:[self.rack.managedObjectContext persistentStoreCoordinator]];
        if (_cage) {
        vc.cage = (Cage *)[_editingContext objectWithID:[_cage objectID]];
    } else {
        Rack *rack = (Rack *)[_editingContext objectWithID:[_rack objectID]];
        Cage *cage = [NSEntityDescription insertNewObjectForEntityForName:@"Cage" inManagedObjectContext:_editingContext];
        [cage setValue:rack forKey:@"rack"];
        [cage setValue:_column forKey:@"column"];
        [cage setValue:_row forKey:@"row"];
        vc.cage = cage;
    }
}
@end