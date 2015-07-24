//
//  CoreDataManager.h
//  iRemember
//
//  Created by Cc on 14/12/21.
//  Copyright (c) 2014年 CenterC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCoreDataManagedObjectContext;

@interface CoreDataManager : NSObject

+ (instancetype)instance;

- (CCoreDataManagedObjectContext *)pCreatePrivateQueueContext;

- (BOOL)pSaveDisk;

- (BOOL)pSaveDisk:(CCoreDataManagedObjectContext*)context;

@end
