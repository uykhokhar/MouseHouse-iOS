//
//  MHSignInViewController.h
//  MouseHouse
//
//  Created by Daniel Brajkovic on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHSignInViewController : UIViewController

@property(assign, nonatomic)id delegate;

- (IBAction)submitCredentialsAction:(id)sender;

@end


@protocol MHSignInViewController

- (void)authenticationViewController:(MHSignInViewController *)controller didEnterCredential:(NSURLCredential *)credential;

@end