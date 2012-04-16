//
//  MHDetailViewController.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHCageDetailsViewController.h"
#import "Rack.h"

@interface RackViewController : UIViewController <UISplitViewControllerDelegate, UIScrollViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) Rack *rack;
@property (strong, nonatomic) NSMutableArray *cageViewControllers;

@property (weak, nonatomic) IBOutlet UIScrollView *rackColumnHeaderScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *rackRowHeaderScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *cagesScrollView;

@end
