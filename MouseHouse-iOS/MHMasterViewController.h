//
//  MHMasterViewController.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHDetailViewController;

@interface MHMasterViewController : UITableViewController

@property (strong, nonatomic) MHDetailViewController *detailViewController;

@end
