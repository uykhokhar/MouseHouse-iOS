//
//  MHDetailViewController.m
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MHCagesViewController.h"
#import "MHCageView.h"

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
    if (_rack != rack || [_rack valueForKey:@"columns"] != [rack valueForKey:@"columns"] || [_rack valueForKey:@"rows"] != [rack valueForKey:@"rows"]) {
        _rack = rack;
        
        // Update the view.
        [self configureView];

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
        [_cagesScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
        NSInteger cols, rows;
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
                UIView *cardView = [[UIView alloc] initWithFrame:CGRectMake(cols*254, rows*125, 254, 125)];
                cardView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cage-background"]];
                
                [_cagesScrollView addSubview:cardView];
                NSLog(@"card: %@ \n", [cardView description]);
            }
        }
        float width = cols * 254;
        float height = rows * 125;
        [_rackColumnHeaderScrollView setContentSize:CGSizeMake(width, _rackColumnHeaderScrollView.frame.size.height)];
        [_rackRowHeaderScrollView setContentSize:CGSizeMake(_rackRowHeaderScrollView.frame.size.width, height)];
        [_cagesScrollView setContentSize:CGSizeMake(_rackColumnHeaderScrollView.contentSize.width, _rackRowHeaderScrollView.contentSize.height)];
        
        NSLog(@"Col: %f, Row: %f, main: %f", _rackColumnHeaderScrollView.contentSize.height, _rackRowHeaderScrollView.contentSize.height, _cagesScrollView.contentSize.height);

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
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
