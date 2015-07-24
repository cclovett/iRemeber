//
//  NSManagedObject+PGUnitils.h
//  Camera360
//
//  Created by Cc on 14-5-13.
//  Copyright (c) 2014年 Pinguo. All rights reserved.
//

#import <CoreData/CoreData.h>

@class CCoreDataManagedObjectContext;

/**
 *  Unitils
 */
@interface NSManagedObject (CUnitils)

/**
 *  在context当中创建一个新的 NSManagedObject
 *
 *  @param context BIZCoreDataManagedObjectContext
 *
 *  @return NSManagedObject / nil
 */
+ (instancetype)c_createManagedObjectInContext:(CCoreDataManagedObjectContext *)context;

/**
 *  去除了 “DL” 的 string 如 "DLImage" －> "Image"
 *
 *  @return NSString
 */
+ (NSString *)c_gotManagedObjectName;

/**
 *  获取第一个满足条件的 NSManagedObject 对象
 *
 *  @param context         BIZCoreDataManagedObjectContext
 *  @param predicates      NSPredicate
 *  @param sortDescriptors NSSortDescriptor
 *
 *  @return NSManagedObject / nil
 */
+ (instancetype)c_searchFirstDataInContext:(CCoreDataManagedObjectContext *)context
                              ByPredicates:(NSArray *)predicates
                       withSortDescriptors:(NSArray *)sortDescriptors;

/**
 *  获取所有满足条件的 NSManagedObject 对象
 *
 *  @param context         BIZCoreDataManagedObjectContext
 *  @param predicates      条件
 *  @param sortDescriptors 排序
 *
 *  @return @[NSManagedObject,NSManagedObject...] / nil
 */
+ (NSArray*)c_searchAllDataInContext:(CCoreDataManagedObjectContext*)context
                        ByPredicates:(NSArray *)predicates
                 withSortDescriptors:(NSArray *)sortDescriptors;


/**
 *  通过objectID 获取 object
 */
+ (instancetype)c_gotManagedObjectWithID:(NSManagedObjectID*)objectID
                               InContext:(CCoreDataManagedObjectContext *)context;

/**
 *  通过自身object 获取异步线程的 object
 */
- (instancetype)c_gotManagedObjectInContext:(CCoreDataManagedObjectContext*)context;




@end
