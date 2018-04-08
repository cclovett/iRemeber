//
//  DBTask.m
//  iRemeber
//
//  Created by Cc on 2018/4/8.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "DBTask.h"
#import <WCDB/WCDB.h>

@interface DBTask ()

WCDB_PROPERTY(db_uuid)
WCDB_PROPERTY(db_createTime)
WCDB_PROPERTY(db_modifiedTime)

@end
@implementation DBTask

WCDB_IMPLEMENTATION(DBTask)

WCDB_SYNTHESIZE(DBTask, db_uuid)

WCDB_SYNTHESIZE(DBTask, db_createTime)
WCDB_SYNTHESIZE(DBTask, db_modifiedTime)

WCDB_PRIMARY(DBTask, db_uuid)

WCDB_INDEX(DBTask, "_index", db_createTime)

@end
