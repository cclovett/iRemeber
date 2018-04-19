//
//  DBTask.m
//  iRemeber
//
//  Created by Cc on 2018/4/8.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "DBTask.h"
#import <WCDB/WCDB.h>

@implementation DBTask

WCDB_IMPLEMENTATION(DBTask)

WCDB_SYNTHESIZE(DBTask, mUUID)

WCDB_SYNTHESIZE(DBTask, mCreateTime)
WCDB_SYNTHESIZE(DBTask, mModifiedTime)

WCDB_PRIMARY(DBTask, mUUID)

WCDB_INDEX(DBTask, "_index", mCreateTime)

@end
