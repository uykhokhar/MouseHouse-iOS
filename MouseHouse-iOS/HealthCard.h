//
//  HealthCard.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Mouse;

@interface HealthCard : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic) NSTimeInterval createdOn;
@property (nonatomic, retain) Mouse *mouse;

@end
