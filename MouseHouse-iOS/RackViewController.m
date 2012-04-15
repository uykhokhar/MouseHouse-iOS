//
//  MHDetailViewController.m
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RackViewController.h"
#import "MHCageView.h"

#define MHBaseResource  @"cages"

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


- (void)cageViewTapped:(id)sender
{
    MHCageView *cageView = sender;
    if (!cageView.cage) {
        MHCageDetailsViewController *cageDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Activate Cage Popover"];
        cageDetailsVC.delegate = self;
        cageDetailsVC.cage = [NSMutableDictionary dictionaryWithObjectsAndKeys:cageView.column, @"column", cageView.row, @"row", nil];
        _activateCagePopover = [[UIPopoverController alloc] initWithContentViewController:cageDetailsVC];
        
        _activateCagePopover.popoverContentSize = CGSizeMake(320.0, 200.0);
        CGRect frame = cageView.frame;
        frame.origin.x += 40 - _cagesScrollView.contentOffset.x;
        frame.origin.y += 40 - _cagesScrollView.contentOffset.y;
        [_activateCagePopover presentPopoverFromRect:frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight animated:YES];
    }
}

#pragma mark - Managing the detail item

- (void)setRack:(id)rack
{
    if (_rack != rack || [_rack valueForKey:@"columns"] != [rack valueForKey:@"columns"] || [_rack valueForKey:@"rows"] != [rack valueForKey:@"rows"]) {
        _rack = rack;
        
        // Update the view.

//    if (self.masterPopoverController != nil) {
//        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
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
        NSArray *columnHeaders = [@"A B C D E F G H I J K L M N O P" componentsSeparatedByString:@" "];
        NSInteger cols = 0;
        NSInteger rows = 0;
        for (cols = 0; cols < [[self.rack valueForKey:@"columns"] integerValue]; cols++) {
            UILabel *columnHeader = [[UILabel alloc] initWithFrame:CGRectMake(cols*254, 0, 254, _rackColumnHeaderScrollView.bounds.size.height)];
            [columnHeader setBackgroundColor:[UIColor whiteColor]];
            [columnHeader setTextAlignment:UITextAlignmentCenter];
            [columnHeader setTextColor:[UIColor blackColor]];
            [columnHeader setText:[columnHeaders objectAtIndex:cols]];
            [_rackColumnHeaderScrollView addSubview:columnHeader];
            for (rows = 0; rows < [[self.rack valueForKey:@"rows"] integerValue]; rows++) {
                if (cols == 0) {
                    UILabel *rowHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, rows*125, _rackRowHeaderScrollView.bounds.size.width, 125)];
                    [rowHeader setBackgroundColor:[UIColor whiteColor]];
                    [rowHeader setTextAlignment:UITextAlignmentCenter];
                    [rowHeader setTextColor:[UIColor blackColor]];
                    [rowHeader setText:[NSString stringWithFormat:@"%d", rows +1]];
                    [_rackRowHeaderScrollView addSubview:rowHeader];
                }
                MHCageView *cageView = [[MHCageView alloc] initWithFrame:CGRectMake(cols*254, rows*125, 254, 125)];
                [cageView setDelegate:self];
                [_cagesScrollView addSubview:cageView];
                [cageView setColumn:[columnHeaders objectAtIndex:cols]];
                [cageView setRow:[NSString stringWithFormat:@"%d", rows +1]];
                [cageView setCage:nil];
            }
        }
        float width = cols * 254;
        float height = rows * 125;
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
    [cage setObject:[_rack objectForKey:@"_id"] forKey:@"mouse_rack_id"];
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
