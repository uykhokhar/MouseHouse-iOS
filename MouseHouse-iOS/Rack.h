//
//  Rack.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Rack : NSManagedObject

@property (nonatomic) int16_t columns;
@property (nonatomic) NSTimeInterval createdOn;
@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSString * location;
@property (nonatomic) int16_t rows;

@end
