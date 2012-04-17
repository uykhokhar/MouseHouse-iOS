//
//  CageDetailsViewController.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Cage.h"

enum MHCageDetailsTags {
    MHCageNumberTextFieldTag = 10
}; 

@interface CageDetailsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (strong, nonatomic) Cage *cage;

@end
