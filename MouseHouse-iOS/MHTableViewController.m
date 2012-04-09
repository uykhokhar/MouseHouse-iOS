//
//  MHTableViewController.m
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MHTableViewController.h"
#import "MHSignInViewController.h"

#define MHBaseURLString @"http://furious-frost-7266.herokuapp.com/"
//#define MHBaseURLString @"http://0.0.0.0:3000/"
#define MHAPIString @"api/v1/"


@interface MHTableViewController ()

@property NSURLAuthenticationChallenge *challenge;

@end

@implementation MHTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

@synthesize challenge = _challenge;
@synthesize currentChallenge = _currentChallenge;
@synthesize receivedData = _receivedData;
@synthesize resource = _resource;

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
- (void)refresh:(id)sender
{
    NSLog(@"Refreshing");
    assert(self.resource != nil);
    // Create the request.
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", MHBaseURLString, MHAPIString, self.resource]]];
    [theRequest setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [theRequest setTimeoutInterval:60.0];
    [theRequest setAllHTTPHeaderFields:[NSDictionary dictionaryWithObjectsAndKeys:@"taco", @"X-MouseHouse-API-Key", @"application/json", @"Accept", nil]];
    // create the connection with the request
    // and start loading the data
    NSURLConnection *theConnection= [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        _receivedData = [NSMutableData data];
    } else {
        // Inform the user that the connection failed.
    }
}

- (void)saveObject:(NSMutableDictionary *)unsavedObject
{
    assert(self.resource != nil);
    // Create the request.
    NSMutableDictionary *object = [NSMutableDictionary dictionaryWithDictionary:unsavedObject];
    NSString *objectID = [object objectForKey:@"_id"];
    
    NSString *urlString;
    NSString *httpMethod;
    if (objectID) {
        urlString = [NSString stringWithFormat:@"%@%@%@/%@", MHBaseURLString, MHAPIString, self.resource, objectID];
        httpMethod = @"PUT";
    } else {
        urlString = [NSString stringWithFormat:@"%@%@%@", MHBaseURLString, MHAPIString, self.resource];
        httpMethod = @"POST";
    }
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [theRequest setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [theRequest setTimeoutInterval:60.0];
    [theRequest setAllHTTPHeaderFields:[NSDictionary dictionaryWithObjectsAndKeys:@"taco", @"X-MouseHouse-API-Key", @"application/json", @"Accept", @"application/json", @"content-type", nil]];
    [theRequest setHTTPMethod:httpMethod];
    NSLog(@"Post params: %@", [object description]);
    NSError *error;
    NSData *body = [NSJSONSerialization dataWithJSONObject:object options:nil error:&error];
    
    [theRequest setHTTPBody:body];
    // create the connection with the request
    // and start loading the data
    NSURLConnection *theConnection= [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
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

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    // Configure the cell...
//    
//    return cell;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     */
//}

@end
