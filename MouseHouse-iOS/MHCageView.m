//
//  MHCageView.m
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MHCageView.h"
#import <QuartzCore/CALayer.h>

@implementation MHCageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"paper"]]];
        CALayer *layer = self.layer;
        layer.shadowOffset = CGSizeMake(1, 1);
        layer.shadowRadius = 3.0;
        layer.shadowColor = [UIColor blackColor].CGColor;
        layer.shadowOpacity = 0.6;
        CGRect frame = self.frame;
        frame.origin.x += 8;
        frame.origin.y += 8;
        frame.size.width -= 16;
        frame.size.height -= 16;
        layer.frame = frame;
        layer.borderColor = [UIColor blackColor].CGColor;
        layer.borderWidth = 00;
        layer.cornerRadius = 5.0;
        //[self.layer addSublayer:sublayer];
        
        CALayer *imageLayer = [CALayer layer];
        imageLayer.frame = layer.bounds;
        imageLayer.cornerRadius = 5.0;
        //imageLayer.contents = (id) [UIImage imageNamed:@"paper"].CGImage;
        imageLayer.masksToBounds = YES;
        [layer addSublayer:imageLayer];

    }
    return self;
}

//- (void)drawRect:(CGRect)rect
//{
//   }


@end
