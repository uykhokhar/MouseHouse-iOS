//
//  MHCageDetailsViewController.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHCageDetailsViewController : UITableViewController

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *cageNumber;
@property (strong, nonatomic) NSMutableDictionary *cage;
@property (weak, nonatomic) id delegate;

@end

@protocol MHCageDetailsDelegate <NSObject>

- (void)cageDetailsSaveButtonClickedForCage:(NSMutableDictionary *)cage;
- (void)cageDetailsCancelButtonClickedForCage:(NSMutableDictionary *)cage;

@end