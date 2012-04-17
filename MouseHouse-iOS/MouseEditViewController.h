//
//  MouseEditViewController.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mouse.h"
@interface MouseEditViewController : UITableViewController

@property (strong, nonatomic) Mouse *mouse;
@property (weak, nonatomic) IBOutlet UITextField *earTagTextField;

@end
