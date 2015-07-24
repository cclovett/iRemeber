//
//  BIZCoreDataManagedObjectContext.h
//  CCCoreDataDemo
//
//  Created by Cc on 14-5-8.
//  Copyright (c) 2014年 Cc. All rights reserved.
//

#import <CoreData/CoreData.h>

/**
 *  Context
 */
@interface CCoreDataManagedObjectContext : NSManagedObjectContext

/**
 *  保存到主线
 *
 *  @return YES＝成功
 */
- (BOOL)pSaveContext;

/**
 *  通过ID 获取 object
 *
 *  @param objectIDs
 *
 *  @return NSManagedObject Array
 */
- (NSArray *)pGotManagedObjectListByIDs:(NSArray *)objectIDs;
/**
 *  通过 ID 获取 object
 */
- (NSManagedObject *)pGotManagedObjectByID:(NSManagedObjectID *)objID;
/**
 *  查询
 *
 *  @param anEntityClass   必选   NSManagedObject class
 *  @param predicates      可选   条件
 *  @param sortDescriptors 可选   排序
 *
 *  @return NSManagedObject / nil
 */
- (NSManagedObject *)pSearchDataFirstByEntityName:(Class)anEntityClass
                                   withPredicates:(NSArray *)predicates
                              withSortDescriptors:(NSArray *)sortDescriptors;

/**
 *  查询
 *
 *  @param anEntityClass   必选   NSManagedObject class
 *  @param predicates      可选   条件
 *  @param sortDescriptors 可选   排序
 *
 *  @return NSManagedObject Array
 */
- (NSArray *)pSearchDataArrayByEntityName:(Class)anEntityClass
                           withPredicates:(NSArray *)predicates
                      withSortDescriptors:(NSArray *)sortDescriptors;

/**
 *  分组
 *
 *  @param anEntityClass   必选   NSManagedObject class
 *  @param predicates      可选   条件
         NSPredicate *condition1 = [NSPredicate predicateWithFormat:@"K1 > %@", v1];
         NSPredicate *condition2 = [NSPredicate predicateWithFormat:@"K2 = %@", v2];
         predicates ＝ @[condition1, condition2];
 *  @param sortDescriptors 必选   排序
 *  @param aSectionKeyPath 必选   分组
 *
 *  @return NSFetchedResultsController
 */
- (NSFetchedResultsController *)pGotFetchControllerByEntityName:(Class)anEntityClass
                                                 withPredicates:(NSArray *)predicates
                                            withSortDescriptors:(NSArray *)sortDescriptors
                                         withSectionNameKeyPath:(NSString *)aSectionKeyPath;


@end
