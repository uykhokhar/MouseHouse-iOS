//
//  MHAuthenticationChallengeHandler.h
//  MouseHouse
//
//  Created by Daniel Brajkovic on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHAuthenticationChallengeHandler : NSObject

@property(strong, nonatomic) NSURLAuthenticationChallenge *challenge;
@property(strong, nonatomic) UIViewController *parentViewController;
@property(strong, nonatomic) NSURLCredential *credential;

// Returns a challenge handler that's prepared to handle the specified challenge 
// (and that presents any modal view controllers on top of parentViewController). 
// Alternatively, returns nil if no one is prepared to handle this challenge.
- (id)initWithChallenge:(NSURLAuthenticationChallenge *)challenge parentViewController:(UIViewController *)parentViewController;
- (void)start;
- (void)stop;


@end
