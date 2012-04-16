//
//  MHDetailViewController.m
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RackViewController.h"
#import "CageViewController.h"

@interface RackViewController () 
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) UIPopoverController *activateCagePopover;

- (void)configureView;
@end

@implementation RackViewController

@synthesize rack = _rack;
@synthesize rackColumnHeaderScrollView = _rackColumnHeaderScrollView;
@synthesize rackRowHeaderScrollView = _rackRowHeaderScrollView;
@synthesize cagesScrollView = _cagesScrollView;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize activateCagePopover = _activateCagePopover;
@synthesize cageViewControllers = _cageViewControllers;

- (void)cageViewTapped:(id)sender
{
//    UIView *cageView = sender;
//    if (!cageView.cage) {
//        MHCageDetailsViewController *cageDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Activate Cage Popover"];
//        cageDetailsVC.delegate = self;
//        cageDetailsVC.cage = [NSMutableDictionary dictionaryWithObjectsAndKeys:cageView.column, @"column", cageView.row, @"row", nil];
//        _activateCagePopover = [[UIPopoverController alloc] initWithContentViewController:cageDetailsVC];
//        
//        _activateCagePopover.popoverContentSize = CGSizeMake(320.0, 200.0);
//        CGRect frame = cageView.frame;
//        frame.origin.x += 40 - _cagesScrollView.contentOffset.x;
//        frame.origin.y += 40 - _cagesScrollView.contentOffset.y;
//        [_activateCagePopover presentPopoverFromRect:frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight animated:YES];
//    }
}

#pragma mark - Managing the detail item

- (void)setRack:(Rack *)rack
{
    assert(rack != nil);
    _rack = rack;
    [self configureView];
}

- (void)configureView
{

    // Update the user interface for the detail item.
    if ([[_cagesScrollView subviews] count] > 0) {
        for (UIView *subview in [_cagesScrollView subviews]) {
            [subview removeFromSuperview];
        }
        for (UIView *subview in [_rackColumnHeaderScrollView subviews]) {
            [subview removeFromSuperview];
        }
        for (UIView *subview in [_rackRowHeaderScrollView subviews]) {
            [subview removeFromSuperview];
        }
    }
    
    if (self.rack) {
        self.cageViewControllers = [NSMutableArray array];
        CageViewController *cageViewController;
        NSArray *columnHeaders = [@"A B C D E F G H I J K L M N O P" componentsSeparatedByString:@" "];
        NSInteger column = 0;
        NSInteger row = 0;
        for (column = 0; column < self.rack.columns; column++) {
            UILabel *columnHeader = [[UILabel alloc] initWithFrame:CGRectMake(column*254, 0, 254, _rackColumnHeaderScrollView.bounds.size.height)];
            [columnHeader setBackgroundColor:[UIColor whiteColor]];
            [columnHeader setTextAlignment:UITextAlignmentCenter];
            [columnHeader setTextColor:[UIColor blackColor]];
            [columnHeader setText:[columnHeaders objectAtIndex:column]];
            [_rackColumnHeaderScrollView addSubview:columnHeader];
            for (row = 0; row < self.rack.rows; row++) {
                if (column == 0) {
                    UILabel *rowHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, row*125, _rackRowHeaderScrollView.bounds.size.width, 125)];
                    [rowHeader setBackgroundColor:[UIColor whiteColor]];
                    [rowHeader setTextAlignment:UITextAlignmentCenter];
                    [rowHeader setTextColor:[UIColor blackColor]];
                    [rowHeader setText:[NSString stringWithFormat:@"%d", row +1]];
                    [_rackRowHeaderScrollView addSubview:rowHeader];
                }
                cageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Cage View Controller"];
                [cageViewController setColumn:columnHeader.text];
                [cageViewController setRow:[NSString stringWithFormat:@"%d", row +1]];
                [cageViewController setRack:self.rack];
                
                UIView *cageView = cageViewController.view;
                [cageView  setFrame:CGRectMake(column*254, row*125, 254, 125)];
                [_cagesScrollView addSubview:cageView];
                
                [self.cageViewControllers addObject:cageViewController];
                cageViewController = nil;
            }
        }
        float width = column * 254;
        float height = row * 125;
        [_rackColumnHeaderScrollView setContentSize:CGSizeMake(width, _rackColumnHeaderScrollView.frame.size.height)];
        [_rackRowHeaderScrollView setContentSize:CGSizeMake(_rackRowHeaderScrollView.frame.size.width, height)];
        [_cagesScrollView setContentSize:CGSizeMake(_rackColumnHeaderScrollView.contentSize.width, _rackRowHeaderScrollView.contentSize.height)];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"black-Linen"]]];
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

#pragma mark - Cage Details Delegate

- (void)cageDetailsSaveButtonClickedForCage:(NSMutableDictionary *)cage
{
    [_activateCagePopover dismissPopoverAnimated:YES];
}

- (void)cageDetailsCancelButtonClickedForCage:(NSMutableDictionary *)cage
{
    [_activateCagePopover dismissPopoverAnimated:YES];
}

#pragma mark - Scroll Views

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == _cagesScrollView) {
        _rackColumnHeaderScrollView.delegate = nil;
        _rackRowHeaderScrollView.delegate = nil;
    } else if (scrollView == _rackColumnHeaderScrollView) {
        _cagesScrollView.delegate = nil;
        _rackRowHeaderScrollView.delegate = nil;
    } else if (scrollView == _rackRowHeaderScrollView) {
        _cagesScrollView.delegate = nil;
        _rackColumnHeaderScrollView.delegate = nil;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _cagesScrollView) {
        _rackColumnHeaderScrollView.contentOffset = CGPointMake([scrollView contentOffset].x, 0);
        _rackRowHeaderScrollView.contentOffset = CGPointMake(0, [scrollView contentOffset].y);
    } else if (scrollView == _rackColumnHeaderScrollView) {
        _cagesScrollView.contentOffset = CGPointMake([scrollView contentOffset].x, 0);
    } else if (scrollView == _rackRowHeaderScrollView) {
        _cagesScrollView.contentOffset = CGPointMake(0, [scrollView contentOffset].y);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _cagesScrollView.delegate = self;
    _rackColumnHeaderScrollView.delegate = self;
    _rackRowHeaderScrollView.delegate = self;
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
