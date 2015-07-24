//
//  CoreDataManager.m
//  iRemember
//
//  Created by Cc on 14/12/21.
//  Copyright (c) 2014年 CenterC. All rights reserved.
//

#import "CoreDataManager.h"
#import <iRememberCommon/iRememberCommon.h>

//#define k_pg_edit_sdk_api_core_data_manager_dbName @"pg_edit_sdk"

NSString * const mmDBName = @"iRemember";

@interface CoreDataManager ()

@property (nonatomic,strong) CCoreDataManager *mCoreDataManager;

@end

@implementation CoreDataManager

+ (instancetype)instance
{
    static CoreDataManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[CoreDataManager alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.mCoreDataManager = [[CCoreDataManager alloc] init];
        NSURL *baseUrl = [CPathHelper sGotDocumentDirectoryURL];
        NSURL *dbUrl = [[baseUrl URLByAppendingPathComponent:mmDBName] URLByAppendingPathExtension:@"DB"];
        [self.mCoreDataManager pSetupCoreDataDBUrl:dbUrl];
        NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:mmDBName withExtension:@"momd"];
        [self.mCoreDataManager pSetupCoreDataModelUrl:modelUrl];
    }
    return self;
}

- (CCoreDataManagedObjectContext *)pCreatePrivateQueueContext
{
    return [self.mCoreDataManager pCreatePrivateQueueContext];
}

- (BOOL)pSaveDisk
{
    return [self.mCoreDataManager pSaveDisk];
}

- (BOOL)pSaveDisk:(CCoreDataManagedObjectContext *)context
{
    return [self.mCoreDataManager pSaveDisk:context];
}
@end
