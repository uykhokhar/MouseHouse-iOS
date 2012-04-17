//
//  CageViewController.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Rack;
@class Cage;

@interface CageViewController : UIViewController  <UIPopoverControllerDelegate>

@property (strong, nonatomic) NSString *column;
@property (strong, nonatomic) NSString *row;
@property (strong, nonatomic) Rack *rack;
@property (strong, nonatomic) Cage *cage;


@end
