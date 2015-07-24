//
//  NSManagedObject+PGUnitils.m
//  Camera360
//
//  Created by Cc on 14-5-13.
//  Copyright (c) 2014年 Pinguo. All rights reserved.
//

#import "NSManagedObject+CUnitils.h"
#import "CCoreDataManagedObjectContext.h"

@implementation NSManagedObject (CUnitils)

+ (instancetype)c_createManagedObjectInContext:(CCoreDataManagedObjectContext *)context
{
    NSString *strClassName = [self c_gotManagedObjectName];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:strClassName
                                                         inManagedObjectContext:context];
    
    return [[self alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
}

+ (NSString*)c_gotManagedObjectName
{
    NSString *strClassName = NSStringFromClass([self class]);
    return strClassName;
}

+ (instancetype)c_searchFirstDataInContext:(CCoreDataManagedObjectContext *)context
                              ByPredicates:(NSArray *)predicates
                       withSortDescriptors:(NSArray *)sortDescriptors
{
    return [context pSearchDataFirstByEntityName:[self class]
                                  withPredicates:predicates
                             withSortDescriptors:sortDescriptors];
}

+ (NSArray *)c_searchAllDataInContext:(CCoreDataManagedObjectContext *)context
                         ByPredicates:(NSArray *)predicates
                  withSortDescriptors:(NSArray *)sortDescriptors
{
    return [context pSearchDataArrayByEntityName:[self class]
                                  withPredicates:predicates
                             withSortDescriptors:sortDescriptors];
}

+ (instancetype)c_gotManagedObjectWithID:(NSManagedObjectID *)objectID
                               InContext:(CCoreDataManagedObjectContext *)context
{
    return [context pGotManagedObjectByID:objectID];
}

- (instancetype)c_gotManagedObjectInContext:(CCoreDataManagedObjectContext *)context
{
    return [NSManagedObject c_gotManagedObjectWithID:self.objectID InContext:context];
}


@end
