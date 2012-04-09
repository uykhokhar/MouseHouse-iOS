//
//  MHTableViewController.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHAuthenticationChallengeHandler.h"

@interface MHTableViewController : UITableViewController <NSURLConnectionDataDelegate>

@property(strong, nonatomic)MHAuthenticationChallengeHandler *currentChallenge;
@property(strong, nonatomic)NSMutableData *receivedData;
@property(strong, nonatomic)NSString *resource;

- (IBAction)refresh:(id)sender;
- (void)saveObject:(NSMutableDictionary *)object;
- (void)destroyObject:(NSMutableDictionary *)object;

@end
