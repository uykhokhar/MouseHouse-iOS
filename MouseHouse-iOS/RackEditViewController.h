//
//  MHRackDetailsViewController.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rack.h"

@interface RackEditViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *rackLabelTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *columnsTextField;
@property (weak, nonatomic) IBOutlet UITextField *rowsTextField;
@property (strong, nonatomic) Rack *rack;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end