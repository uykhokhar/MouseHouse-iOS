//
//  CageViewController.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rack.h"
#import "Cage.h"

@interface CageViewController : UIViewController

@property (strong, nonatomic) NSString *column;
@property (strong, nonatomic) NSString *row;
@property (strong, nonatomic) Rack *rack;
@property (strong, nonatomic) Cage *cage;


@end
