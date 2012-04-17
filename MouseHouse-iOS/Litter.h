//
//  Litter.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Mouse;

@interface Litter : NSManagedObject

@property (nonatomic) NSTimeInterval bornOn;
@property (nonatomic) NSTimeInterval diedOn;
@property (nonatomic) NSTimeInterval weanedOn;
@property (nonatomic, retain) NSSet *parents;
@property (nonatomic, retain) NSSet *pups;
@end

@interface Litter (CoreDataGeneratedAccessors)

- (void)addParentsObject:(Mouse *)value;
- (void)removeParentsObject:(Mouse *)value;
- (void)addParents:(NSSet *)values;
- (void)removeParents:(NSSet *)values;

- (void)addPupsObject:(Mouse *)value;
- (void)removePupsObject:(Mouse *)value;
- (void)addPups:(NSSet *)values;
- (void)removePups:(NSSet *)values;

@end
