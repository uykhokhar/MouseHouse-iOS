//
//  MHSignInViewController.m
//  MouseHouse
//
//  Created by Daniel Brajkovic on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MHSignInViewController.h"

#define EmailTextFieldTag       10
#define PasswordTextFieldTag    11

@interface MHSignInViewController ()

@property(strong, nonatomic)NSMutableData *receivedData;

@end

@implementation MHSignInViewController

@synthesize receivedData = _receivedData;
@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)submitCredentialsAction:(id)sender
{
    NSString *email     = [(UITextField *)[self.view viewWithTag:EmailTextFieldTag] text];
    NSString *password  = [(UITextField *)[self.view viewWithTag:PasswordTextFieldTag] text];
    if ([email isEqualToString:@""]) {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Email address not entered" message:@"Please provide a valid email address" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [errorAlert show];
    } else if ([password isEqualToString:@""]) {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Password not entered" message:@"Please provide the password associated with your account" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [errorAlert show];
    }
    else {
        NSLog(@"Email: %@\nPassword: %@", email, password);
        NSURLCredential *credential = [NSURLCredential credentialWithUser:email password:password persistence:NSURLCredentialPersistencePermanent];
        if ([_delegate respondsToSelector:@selector(authenticationViewController:didEnterCredential:)]) {
            [_delegate authenticationViewController:self didEnterCredential:credential];
        }
    }
}
@end
