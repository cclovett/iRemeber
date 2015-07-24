//
//  BIZCoreDataManager.m
//  CCCoreDataDemo
//
//  Created by Cc on 14-5-8.
//  Copyright (c) 2014年 Cc. All rights reserved.
//

#import "CCoreDataManager.h"
#import "CCoreDataManagedObjectContext.h"

@interface CCoreDataManager ()

@property (nonatomic,strong) NSPersistentStoreCoordinator   *mPersistentStoreCoordinator;
@property (nonatomic,strong) NSManagedObjectModel           *mManagedObjectModel;
@property (nonatomic,strong) NSManagedObjectContext         *mDefaultPrivateQueueContext;

@property (nonatomic,strong) NSURL *mCoreDataDBUrl;
@property (nonatomic,strong) NSURL *mCoreDataModelUrl;

@end

@implementation CCoreDataManager

#pragma mark - 公开

- (CCoreDataManagedObjectContext *)pCreatePrivateQueueContext
{
    CCoreDataManagedObjectContext *context = [[CCoreDataManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = [self mDefaultPrivateQueueContext];
    return context;
}

- (BOOL)pSaveDisk:(CCoreDataManagedObjectContext *)context
{
    @synchronized (self){
        BOOL bRet = [context pSaveContext];
        if (bRet) {
            
            bRet = [self pSaveDisk];
        }
        return bRet;
    }
}

- (void)pSetupCoreDataDBUrl:(NSURL*)url
{
    self.mCoreDataDBUrl = url;
}

- (void)pSetupCoreDataModelUrl:(NSURL *)url
{
    self.mCoreDataModelUrl = url;
}

#pragma mark - 私

- (NSManagedObjectContext *)mDefaultPrivateQueueContext
{
    if (!_mDefaultPrivateQueueContext)
    {
        @synchronized(self)
        {
            if (!_mDefaultPrivateQueueContext)
            {
                _mDefaultPrivateQueueContext = \
                    [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
                _mDefaultPrivateQueueContext.persistentStoreCoordinator = self.mPersistentStoreCoordinator;
            }
        }
    }

    return _mDefaultPrivateQueueContext;
}

- (NSPersistentStoreCoordinator *)mPersistentStoreCoordinator
{
    if (!_mPersistentStoreCoordinator)
    {
        @synchronized(self)
        {
            if (!_mPersistentStoreCoordinator)
            {
                //重用DB
                NSURL *dbURL = self.mCoreDataDBUrl;
                if ([dbURL checkResourceIsReachableAndReturnError:nil] == NO)
                {
                    NSLog(@"Error: 第一次数据初始化");
                }
                
                _mPersistentStoreCoordinator
                        = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.mManagedObjectModel];
                NSError *error = nil;

                if (![_mPersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                configuration:nil
                                                                          URL:dbURL
                                                                      options:[self persistentStoreOptions]
                                                                        error:&error])
                {
                    NSLog(@"Error: adding persistent store. %@, %@", error, error.userInfo);
                    NSLog(@"Error: 数据库错误,请删掉App重装");
                    abort();
                }
            }
        }
    }

    return _mPersistentStoreCoordinator;
}

- (NSManagedObjectModel *)mManagedObjectModel
{
    if (!_mManagedObjectModel)
    {
        @synchronized(self)
        {
            if (!_mManagedObjectModel)
            {
                NSURL *modelURL = self.mCoreDataModelUrl;
                _mManagedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
            }
        }
    }

    return _mManagedObjectModel;
}

- (NSDictionary *)persistentStoreOptions
{
    return @{NSInferMappingModelAutomaticallyOption : @YES,
             NSMigratePersistentStoresAutomaticallyOption : @YES,
             NSSQLitePragmasOption : @{@"synchronous" : @"OFF"}};
}

- (BOOL)pSaveDisk
{
    NSManagedObjectContext *managedObjectContext = self.mDefaultPrivateQueueContext;
    if (managedObjectContext != nil)
    {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
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
                        NSLog(@"Error: Core Data Save Error\n\n \
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
                    NSLog(@"Error: Core Data Save Error\n\n \
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
                NSLog(@"Error: %@", [error localizedDescription]);
            }
            
            NSLog(@"Error: %@, %@", error, [error userInfo]);
            abort();
        }
        return YES;
    }
    return NO;
}


@end
