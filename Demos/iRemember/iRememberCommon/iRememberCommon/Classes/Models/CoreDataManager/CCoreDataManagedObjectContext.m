//
//  BIZCoreDataManagedObjectContext.m
//  CCCoreDataDemo
//
//  Created by Cc on 14-5-8.
//  Copyright (c) 2014年 Cc. All rights reserved.
//

#import "CCoreDataManagedObjectContext.h"
#import "NSManagedObject+CUnitils.h"

@implementation CCoreDataManagedObjectContext

#pragma mark - 公开

- (BOOL)pSaveContext
{
    if ([self hasChanges])
    {
        NSError *error = nil;
        if (![self save:&error])
        {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate.
            // You should not use this function in a shipping application,
            // although it may be useful during development.
            if ([[error domain] isEqualToString:@"NSCocoaErrorDomain"]) {
                // ...check whether there's an NSDetailedErrors array
                NSDictionary *userInfo = [error userInfo];
                if ([userInfo valueForKey:@"NSDetailedErrors"] != nil) {
                    // ...and loop through the array, if so.
                    NSArray *errors = [userInfo valueForKey:@"NSDetailedErrors"];
                    for (NSError *anError in errors) {
                        
                        NSDictionary *subUserInfo = [anError userInfo];
                        subUserInfo = [anError userInfo];
                        // Granted, this indents the NSValidation keys rather a lot
                        // ...but it's a small loss to keep the code more readable.
                        NSLog(@"Core Data Save Error\n\n \
                              NSValidationErrorKey\n%@\n\n \
                              NSValidationErrorPredicate\n%@\n\n \
                              NSValidationErrorObject\n%@\n\n \
                              NSLocalizedDescription\n%@",
                              [subUserInfo valueForKey:@"NSValidationErrorKey"],
                              [subUserInfo valueForKey:@"NSValidationErrorPredicate"],
                              [subUserInfo valueForKey:@"NSValidationErrorObject"],
                              [subUserInfo valueForKey:@"NSLocalizedDescription"]);
                    }
                }
                // If there was no NSDetailedErrors array, print values directly
                // from the top-level userInfo object. (Hint: all of these keys
                // will have null values when you've got multiple errors sitting
                // behind the NSDetailedErrors key.
                else {
                    NSLog(@"Core Data Save Error\n\n \
                          NSValidationErrorKey\n%@\n\n \
                          NSValidationErrorPredicate\n%@\n\n \
                          NSValidationErrorObject\n%@\n\n \
                          NSLocalizedDescription\n%@",
                          [userInfo valueForKey:@"NSValidationErrorKey"],
                          [userInfo valueForKey:@"NSValidationErrorPredicate"],
                          [userInfo valueForKey:@"NSValidationErrorObject"],
                          [userInfo valueForKey:@"NSLocalizedDescription"]);
                    
                }
            }
            // Handle mine--or 3rd party-generated--errors
            else {
                NSLog(@"Custom Error: %@", [error localizedDescription]);
            }
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            return NO;
        }
    }
    return YES;
}

- (NSManagedObject*)pGotManagedObjectByID:(NSManagedObjectID*)objID
{
    NSManagedObject *object = [self objectWithID:objID];
    return object;
}

- (NSArray *)pGotManagedObjectListByIDs:(NSArray *)objectIDs
{
    __block NSMutableArray *arrObjects = [[NSMutableArray alloc] initWithCapacity:objectIDs.count];
    __weak __typeof (&*self)weakSelf = self;
    [self performBlockAndWait:^{
        for (NSManagedObjectID *objectID in objectIDs)
        {
            NSManagedObject *object = [weakSelf objectWithID:objectID];
            if ([object isKindOfClass:[NSManagedObject class]])
            {
                [arrObjects addObject:object];
            }
        }
    }];

    if (arrObjects.count == 0) {
        arrObjects = nil;
    }
    return arrObjects;
}


- (NSManagedObject *)pSearchDataFirstByEntityName:(Class)anEntityClass
                                   withPredicates:(NSArray *)predicates
                              withSortDescriptors:(NSArray *)sortDescriptors
{
    //参数检查
    NSAssert(anEntityClass, @"必须有值");

//    //开始
//    NSFetchRequest *fetchRequest = [self fGetFetchRequestByClass:anEntityClass
//                                                 withPredicaties:predicates
//                                             withSortDescriptors:sortDescriptors];
//
//
//    if (fetchRequest)
//    {
//        [fetchRequest setFetchLimit:1];
//
//        NSArray *arr = [self fExecuteFetchRequest:fetchRequest];
//        if (arr.count > 0)
//        {
//            return arr[0];
//        }
//    }
//
//    return nil;
    
    NSArray *arr = [self pSearchDataArrayByEntityName:anEntityClass
                                       withPredicates:predicates
                                  withSortDescriptors:sortDescriptors];
    if (arr.count > 0) {
        return arr[0];
    }
    return nil;
}

- (NSArray *)pSearchDataArrayByEntityName:(Class)anEntityClass
                           withPredicates:(NSArray *)predicates
                      withSortDescriptors:(NSArray *)sortDescriptors
{
    //参数检查
    NSAssert(anEntityClass, @"必须有值");

    //开始
    NSFetchRequest *fetchRequest = [self fGetFetchRequestByClass:anEntityClass
                                                 withPredicaties:predicates
                                             withSortDescriptors:sortDescriptors];
    if (fetchRequest)
    {
        return [self fExecuteFetchRequest:fetchRequest];
    }

    return nil;
}


- (NSFetchedResultsController *)pGotFetchControllerByEntityName:(Class)anEntityClass
                                                 withPredicates:(NSArray *)predicates
                                            withSortDescriptors:(NSArray *)sortDescriptors
                                         withSectionNameKeyPath:(NSString *)aSectionKeyPath
{
    //参数检查
    NSAssert(anEntityClass && (sortDescriptors.count > 0) && (aSectionKeyPath.length > 0), @"必须有值");

    //开始
    NSFetchRequest *fetchRequest = [self fGetFetchRequestByClass:anEntityClass
                                                 withPredicaties:predicates
                                             withSortDescriptors:sortDescriptors];
    if (fetchRequest)
    {
        NSFetchedResultsController *aFetchedResultsController = \
            [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                managedObjectContext:self
                                                  sectionNameKeyPath:aSectionKeyPath
                                                           cacheName:nil];
        NSError *anError = nil;
        if (![aFetchedResultsController performFetch:&anError])
        {
            NSLog(@"Unresolved error %@, %@", anError, [anError userInfo]);
        }
        else
        {
            return aFetchedResultsController;
        }
    }

    return nil;
}


#pragma mark - 私

/**
 *  NSFetchRequest
 */
- (NSFetchRequest *)fGetFetchRequestByClass:(Class)anEntityClass
                            withPredicaties:(NSArray *)aPredicates
                        withSortDescriptors:(NSArray *)aSortDescriptors
{
    NSFetchRequest *fetchRequest = nil;

    if ([anEntityClass isSubclassOfClass:[NSManagedObject class]])
    {
        NSEntityDescription *entityDescription = \
                            [NSEntityDescription entityForName:[anEntityClass c_gotManagedObjectName]
                                        inManagedObjectContext:self];
        if (entityDescription)
        {
            fetchRequest = [[NSFetchRequest alloc] init];

            [fetchRequest setEntity:entityDescription];

            if (aPredicates && aPredicates.count > 0)
            {
                NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:aPredicates];
                [fetchRequest setPredicate:predicate];
            }

            if (aSortDescriptors && aSortDescriptors.count > 0)
            {
                [fetchRequest setSortDescriptors:aSortDescriptors];
            }

            fetchRequest.fetchBatchSize = 20;
        }
    }

    return fetchRequest;
}

- (NSArray *)fExecuteFetchRequest:(NSFetchRequest *)fetchRequest
{
    NSAssert(fetchRequest,@"要有值");

    NSArray *result = nil;
    if (fetchRequest)
    {
        NSError *anError = nil;
        result = [self executeFetchRequest:fetchRequest error:&anError];
        if (anError)
        {
            NSLog(@"%@", anError);
        }
    }

    return result;
}


@end
