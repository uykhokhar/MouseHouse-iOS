//
//  Mouse.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cage, Litter;

@interface Mouse : NSManagedObject

@property (nonatomic) NSTimeInterval bornOn;
@property (nonatomic) NSTimeInterval diedOn;
@property (nonatomic, retain) NSString * earTag;
@property (nonatomic, retain) NSString * genomeType;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * strain;
@property (nonatomic, retain) Cage *cage;
@property (nonatomic, retain) NSManagedObject *healthCards;
@property (nonatomic, retain) Litter *litter;
@property (nonatomic, retain) NSSet *litters;
@end

@interface Mouse (CoreDataGeneratedAccessors)

- (void)addLittersObject:(Litter *)value;
- (void)removeLittersObject:(Litter *)value;
- (void)addLitters:(NSSet *)values;
- (void)removeLitters:(NSSet *)values;

@end
