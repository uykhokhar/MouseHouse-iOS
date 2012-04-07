//
//  MHViewController.m
//  MouseHouse
//
//  Created by Daniel Brajkovic on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MHViewController.h"
#import "MHSignInViewController.h"

#define MHBaseURLString @"http://0.0.0.0:3000/"
#define MHAPIString @"api/v1/"

@interface MHViewController ()

@property NSURLAuthenticationChallenge *challenge;
@property (retain, nonatomic) NSURLConnection *refreshConnection;
@property (retain, nonatomic) NSURLConnection *createConnection;
@property (retain, nonatomic) NSURLConnection *updateConnection;
@property (retain, nonatomic) NSURLConnection *destroyConnection;
@property (retain, nonatomic) NSURLConnection *showConnection;

@end

@implementation MHViewController

@synthesize challenge = _challenge;
@synthesize currentChallenge = _currentChallenge;
@synthesize receivedData = _receivedData;
@synthesize resource = _resource;
@synthesize refreshConnection = _refreshConnection;
@synthesize createConnection = _createConnection;
@synthesize updateConnection = _updateConnection;
@synthesize destroyConnection = _destroyConnection;
@synthesize showConnection = _showConnection;

- (void)authenticationViewController:(MHSignInViewController *)controller didEnterCredential:(NSURLCredential *)credential
{
    NSLog(@"Did recieve credentials");
     [[self.challenge sender] useCredential:credential forAuthenticationChallenge:self.challenge];
}

#pragma mark NSURLConnectionDelegate implementation
- (void)connection:(NSURLConnection *)conn didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
#pragma unused(conn)
    //assert(conn == self.connection);
    //assert(challenge != nil);
    self.challenge = challenge;
    NSLog(@"didReceiveAuthenticationChallenge %@ %zd", [[challenge protectionSpace] authenticationMethod], (ssize_t) [challenge previousFailureCount]);
    
    self.currentChallenge = nil;
    //if ([challenge previousFailureCount] < 5) {
        self.currentChallenge = [[MHAuthenticationChallengeHandler alloc] initWithChallenge:challenge parentViewController:self];
        //if (self.currentChallenge == nil) {
        //    [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
        //} else {
            //self.currentChallenge.delegate = self;
            [self.currentChallenge start];
        //}
//    } else {
//        [[challenge sender] cancelAuthenticationChallenge:challenge];
//    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    NSLog(@"%@\nStatus:%d", [(NSHTTPURLResponse *)response allHeaderFields], [(NSHTTPURLResponse *)response statusCode]);
    if (self.currentChallenge) {
        [self.currentChallenge stop];
        self.currentChallenge = nil;
    }
    // receivedData is an instance variable declared elsewhere.
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

- (void)createWithParameters:(NSDictionary *)parameters
{
    
}

// Refresh data
- (void)refresh
{
    assert(self.resource != nil);
    // Create the request.
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", MHBaseURLString, MHAPIString, self.resource]]];
    [theRequest setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [theRequest setTimeoutInterval:60.0];
    [theRequest setAllHTTPHeaderFields:[NSDictionary dictionaryWithObjectsAndKeys:@"taco", @"X-MouseHouse-API-Key", @"application/json", @"Accept", nil]];
    // create the connection with the request
    // and start loading the data
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        _receivedData = [NSMutableData data];
    } else {
        // Inform the user that the connection failed.
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
