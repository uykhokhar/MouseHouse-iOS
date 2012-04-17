//
//  Cage.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Mouse, Rack;

@interface Cage : NSManagedObject

@property (nonatomic) NSTimeInterval activatedOn;
@property (nonatomic, retain) NSString * cageNumber;
@property (nonatomic, retain) NSString * column;
@property (nonatomic) NSTimeInterval deactivatedOn;
@property (nonatomic) NSTimeInterval floodedOn;
@property (nonatomic) int16_t maxCapacity;
@property (nonatomic, retain) NSString * row;
@property (nonatomic, retain) NSSet *mice;
@property (nonatomic, retain) Rack *rack;
@end

@interface Cage (CoreDataGeneratedAccessors)

- (void)addMiceObject:(Mouse *)value;
- (void)removeMiceObject:(Mouse *)value;
- (void)addMice:(NSSet *)values;
- (void)removeMice:(NSSet *)values;

@end
