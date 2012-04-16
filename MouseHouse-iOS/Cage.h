//
//  Cage.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Rack;

@interface Cage : NSManagedObject

@property (nonatomic, retain) NSDate * activatedOn;
@property (nonatomic, retain) NSString * cageNumber;
@property (nonatomic, retain) NSDate * deactivatedOn;
@property (nonatomic, retain) NSDate * floodedOn;
@property (nonatomic, retain) NSNumber * maxCapacity;
@property (nonatomic, retain) NSString * column;
@property (nonatomic, retain) NSString * row;
@property (nonatomic, retain) Rack *rack;

@end
