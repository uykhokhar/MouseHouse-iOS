//
//  MHSignUpViewController.m
//  MouseHouse
//
//  Created by Daniel Brajkovic on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MHSignUpViewController.h"

#define MHSignupURLString @"http://0.0.0.0:3000/users.json"
#define EmailTextFieldTag       10
#define PasswordTextFieldTag    11
#define NameTextFieldTag        12

@interface MHSignUpViewController ()

@property(strong, nonatomic) NSURLConnection *connection;
@property(strong, nonatomic) NSMutableData *receivedData;
@property BOOL signInSuccessful;

@end

@implementation MHSignUpViewController

@synthesize connection = _connection;
@synthesize receivedData = _receivedData;
@synthesize signInSuccessful = _signInSuccessful;

- (IBAction)dismissAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signUpAction:(id)sender
{
    if (self.connection) {
        [self.connection cancel];
        self.connection = nil;
    }
    NSString *name = [(UITextField *)[self.view viewWithTag:NameTextFieldTag] text];
    NSString *email = [(UITextField *)[self.view viewWithTag:EmailTextFieldTag] text];
    NSString *password = [(UITextField *)[self.view viewWithTag:PasswordTextFieldTag] text];
    if ([email isEqualToString:@""] || [name isEqualToString:@""] || [password isEqualToString:@""]) {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"All fields must be completed" message:@"Please provide your name, valid email address, and a strong password." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [errorAlert show];
        return;
    }
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    BOOL emailMatchesRegEx = [regExPredicate evaluateWithObject:email];
    
    if (!emailMatchesRegEx) {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Invalid email format" message:@"Please a valid email address." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [errorAlert show];
        return;
    }
    
    NSURL *url = [NSURL URLWithString:MHSignupURLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    
    NSDictionary *formFields = [NSDictionary dictionaryWithObjectsAndKeys:name, @"user[name]", email, @"user[email]", password, @"user[password]", nil];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField: @"Accept"];
    
    NSMutableData	*postBody = [NSMutableData data];
    NSData			*amp = nil;
    
    for (NSString *key in [formFields allKeys])
    {
        if (amp != nil)
            [postBody appendData:amp];
        
        id value = [formFields objectForKey:key];
        //NSLog(@"KEY: %@  Value: %@ \n", key, value);
        NSString *encodedValue = [[value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        [postBody appendData:[[NSString stringWithFormat:@"%@=", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[encodedValue dataUsingEncoding:NSUTF8StringEncoding]];
        
        if (amp == nil)
            amp = [@"&" dataUsingEncoding:NSUTF8StringEncoding];
    }
    //add the body to the post
    [request setHTTPBody:postBody];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Dismiss"] || [buttonTitle isEqualToString:@"Sign in"]) {
        [(UITextField *)[self.view viewWithTag:NameTextFieldTag] setText:@""];
        [(UITextField *)[self.view viewWithTag:EmailTextFieldTag] setText:@""];
        [(UITextField *)[self.view viewWithTag:PasswordTextFieldTag] setText:@""];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    NSUInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
    
    switch (statusCode) {
        case 200:
        case 201: {
            _signInSuccessful = YES;
            UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"Thank you for signing up!" message:@"A message with a confirmation link has been sent to your email address. Please open the link to activate your account." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [successAlert show];
            break;
        }
        default: {
            _signInSuccessful = NO;
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error signing up!" message:@"The email address you provided is already associated with an account. Would you like to return to the sign in form or enter a different email address" delegate:self cancelButtonTitle:@"Sign in" otherButtonTitles:@"Change email", nil];
            [errorAlert show];
            break;
        }
    }
    // receivedData is an instance variable declared elsewhere.
    NSString *jsonString = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"JSON Response:\n%@", jsonString);
    [self.receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection  didFailWithError:(NSError *)error
{
    // receivedData is declared as a method instance elsewhere
    self.receivedData = nil;
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received %d bytes of data",[self.receivedData length]);
    
    self.receivedData = nil;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
