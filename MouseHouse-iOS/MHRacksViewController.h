//
//  MHMasterViewController.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHTableViewController.h"

@class MHCagesViewController;

@interface MHRacksViewController : MHTableViewController

@property (strong, nonatomic) MHCagesViewController *cagesViewController;
@property (strong, nonatomic) NSMutableArray *racks;
@property (strong, nonatomic) NSString *selectedRackId;
@property (assign, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;


@end
