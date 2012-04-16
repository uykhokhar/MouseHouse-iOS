//
//  _Rack.m
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "_Rack.h"

@implementation _Rack

- (Cage *)cageAtColumn:(NSString *)column row:(NSString *)row
{
    assert(column != nil);
    assert(row != nil);
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cage" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(column like %@) and (row like %@)", column, row];
    [fetchRequest setPredicate:predicate];

    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
       //
    }
    if ([fetchedObjects count] > 0)
        return [fetchedObjects objectAtIndex:0];
    else
        return nil;
}

@end
