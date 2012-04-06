//
//  MHRackDetailsViewController.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHRackDetailsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *rackIdentificationTextField;
@property (weak, nonatomic) IBOutlet UITextField *columnsTextField;
@property (weak, nonatomic) IBOutlet UITextField *rowsTextField;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
