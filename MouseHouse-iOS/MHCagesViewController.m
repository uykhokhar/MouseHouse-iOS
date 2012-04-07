//
//  MHDetailViewController.m
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MHCagesViewController.h"

@interface MHCagesViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation MHCagesViewController

@synthesize rack = _rack;
@synthesize rackColumnHeaderScrollView = _rackColumnHeaderScrollView;
@synthesize rackRowHeaderScrollView = _rackRowHeaderScrollView;
@synthesize cagesScrollView = _cagesScrollView;
@synthesize masterPopoverController = _masterPopoverController;

#pragma mark - Managing the detail item

- (void)setRack:(id)rack
{
    if (_rack != rack) {
        _rack = rack;
        
        // Update the view.
        [self configureView];
    }

//    if (self.masterPopoverController != nil) {
//        [self.masterPopoverController dismissPopoverAnimated:YES];
//    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    //if (self.rack) {
        NSArray *columnHeaders = [@"A B C D E F G H I J K L M N O P" componentsSeparatedByString:@" "];
        [_cagesScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
        int cols, rows;
        for (cols = 0; cols < 7; cols++) {
            UILabel *columnHeader = [[UILabel alloc] initWithFrame:CGRectMake(cols*236, 0, 236, _rackColumnHeaderScrollView.bounds.size.height)];
            [columnHeader setTextAlignment:UITextAlignmentCenter];
            [columnHeader setText:[columnHeaders objectAtIndex:cols]];
            [_rackColumnHeaderScrollView addSubview:columnHeader];
            for (rows = 0; rows < 10; rows++) {
                if (cols == 0) {
                    UILabel *rowHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, rows*107, _rackRowHeaderScrollView.bounds.size.width, 107)];
                    [rowHeader setTextAlignment:UITextAlignmentCenter];
                    [rowHeader setText:[NSString stringWithFormat:@"%d", rows +1]];
                    [_rackRowHeaderScrollView addSubview:rowHeader];
                }
                UIView *cardView = [[UIView alloc] initWithFrame:CGRectMake(cols*236, rows*107, 236, 107)];
                UIImageView *cardImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mockup_cage_card"]];
                [cardImage setContentMode:UIViewContentModeScaleAspectFit];
                cardImage.frame = CGRectMake(2, 2, 232, 103);
                [cardView addSubview:cardImage];
                [_cagesScrollView addSubview:cardView];
            }
        }
        [_cagesScrollView setContentSize:CGSizeMake(cols*236, rows*107)];
        [_rackColumnHeaderScrollView setContentSize:CGSizeMake(cols*236, rows*107)];
    //}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [self setCagesScrollView:nil];
    [self setRackColumnHeaderScrollView:nil];
    [self setRackRowHeaderScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    _rackColumnHeaderScrollView.contentOffset = CGPointMake([object contentOffset].x, 0);
    _rackRowHeaderScrollView.contentOffset = CGPointMake(0, [object contentOffset].y);
}

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return YES;
}

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Racks", @"Racks");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
