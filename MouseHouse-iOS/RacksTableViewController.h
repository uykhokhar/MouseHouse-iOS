//
//  MHMasterViewController.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHTableViewController.h"

@class RackViewController;

@interface RacksTableViewController : UITableViewController  <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) RackViewController *rackViewController;
@property (strong, nonatomic) NSMutableArray *racks;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end
