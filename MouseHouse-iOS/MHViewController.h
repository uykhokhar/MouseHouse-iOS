//
//  MHViewController.h
//  MouseHouse
//
//  Created by Daniel Brajkovic on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHAuthenticationChallengeHandler.h"

@interface MHViewController : UIViewController <NSURLConnectionDataDelegate>

@property(strong, nonatomic)MHAuthenticationChallengeHandler *currentChallenge;
@property(strong, nonatomic)NSMutableData *receivedData;
@property(strong, nonatomic)NSString *resource;

- (void)refresh;

@end
