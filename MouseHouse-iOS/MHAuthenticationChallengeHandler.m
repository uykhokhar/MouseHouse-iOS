//
//  MHAuthenticationChallengeHandler.m
//  MouseHouse
//
//  Created by Daniel Brajkovic on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MHAuthenticationChallengeHandler.h"
#import "MHSignInViewController.h"

@interface MHAuthenticationChallengeHandler ()

@property(strong, nonatomic)MHSignInViewController *signInController;

@end

@implementation MHAuthenticationChallengeHandler

@synthesize challenge = _challenge;
@synthesize credential = _credential;
@synthesize parentViewController = _parentViewController;
@synthesize signInController = _signInController;

- (id)initWithChallenge:(NSURLAuthenticationChallenge *)challenge parentViewController:(UIViewController *)parentViewController
{
    assert([NSThread isMainThread]);
    
    assert(challenge != nil);
    assert(parentViewController != nil);
    self = [super init];
    if (self != nil) {
        self->_challenge            = challenge;
        self->_parentViewController = parentViewController;
    }
    return self;
}

- (void)start
{
    assert(self.parentViewController != nil);
    _signInController =(MHSignInViewController *)[self.parentViewController.storyboard instantiateViewControllerWithIdentifier:@"Sign In View Controller"];
    [_signInController setDelegate:self.parentViewController];
    [_signInController setModalPresentationStyle:UIModalPresentationFormSheet];
    [_signInController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self.parentViewController presentViewController:_signInController animated:NO completion:nil];
}

- (void)stop
{
    [_signInController dismissViewControllerAnimated:YES completion:nil];
    self.signInController = nil;
}

@end
