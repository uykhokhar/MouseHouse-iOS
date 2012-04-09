//
//  MHCageView.m
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MHCageView.h"
#import <QuartzCore/CALayer.h>

@interface MHCageView () {
    
    UILabel *inactiveLabel;
}

@end

@implementation MHCageView

@synthesize cage = _cage;
@synthesize delegate = _delegate;
@synthesize column = _column;
@synthesize row = _row;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cage-background"]];
        
        //  The Inactive Label
        inactiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 20)];
        inactiveLabel.backgroundColor = [UIColor clearColor];
        inactiveLabel.font = [UIFont boldSystemFontOfSize:17.0];
        inactiveLabel.textAlignment = UITextAlignmentCenter;
        float color = 133/255;
        inactiveLabel.textColor = [UIColor colorWithRed:color green:color blue:color alpha:0.5];
        inactiveLabel.shadowColor = [UIColor whiteColor];
        inactiveLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        inactiveLabel.text = @"Tap to Activate";
        CGRect tvFrame = inactiveLabel.frame;
        tvFrame.origin.y = 56.0;
        tvFrame.origin.x = frame.size.width / 2 - tvFrame.size.width / 2;
        inactiveLabel.frame = tvFrame;
        [self addSubview:inactiveLabel];
        
        // Recognize taps
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tapRecognizer];
    }
    return self;
}

- (void)setCage:(NSMutableDictionary *)cage
{
    if (_cage != cage) {
        _cage = cage;
    }
    [self setNeedsLayout];
}

- (void)setNeedsLayout
{
    [super setNeedsLayout];
    if (!_cage) {
        inactiveLabel.hidden = NO;
    } else {
        inactiveLabel.hidden = YES;
    }
}

- (void)tap:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(cageViewTapped:)]) {
        [_delegate cageViewTapped:self];
    }
}

@end
