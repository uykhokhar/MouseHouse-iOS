//
//  Rack.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "_Rack.h"

@class Cage;

@interface Rack : _Rack

@property (nonatomic) int16_t columns;
@property (nonatomic) NSTimeInterval createdOn;
@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSString * location;
@property (nonatomic) int16_t rows;
@property (nonatomic, retain) NSSet *cages;
@end

@interface Rack (CoreDataGeneratedAccessors)

- (void)addCagesObject:(Cage *)value;
- (void)removeCagesObject:(Cage *)value;
- (void)addCages:(NSSet *)values;
- (void)removeCages:(NSSet *)values;

@end
