//
//  MHMasterViewController.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHViewController.h"

@class MHCagesViewController;

@interface MHRacksViewController : MHViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) MHCagesViewController *cagesViewController;
@property (assign, nonatomic) IBOutlet UITableView *tableView;

@end
