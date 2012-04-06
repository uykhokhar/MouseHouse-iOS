//
//  MHDetailViewController.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHCagesViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id rack;

@property (weak, nonatomic) IBOutlet UIScrollView *rackColumnHeaderScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *rackRowHeaderScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *cagesScrollView;

@end
