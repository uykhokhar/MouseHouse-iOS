//
//  _Rack.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Cage;

@interface _Rack : NSManagedObject

- (Cage *)cageAtColumn:(NSString *)column row:(NSString *)row;

@end
