//
//  DBBase.m
//  iRemeber
//
//  Created by TT on 2018/4/19.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "DBBase.h"
#import <WCDB/WCDB.h>
#import <CLOCommon/CLOCommonCore.h>

@implementation DBBase

+ (NSString *)sClassName
{
    return NSStringFromClass(self.class);
}

+ (void)sCreateTable:(WCTDatabase *)database
{
    NSString *tableName = [self.class sClassName];
    if ([database isTableExists:tableName]) {
        
        SDKLog(@"[%@]表已经存在!", tableName);
    }
    else {
        
        SDKLog(@"创建[%@]表!", tableName);
        [database createTableAndIndexesOfName:tableName withClass:self.class];
    }
}
+ (void)sDropTable:(WCTDatabase *)database
{
    NSString *tableName = [self.class sClassName];
    if ([database isTableExists:tableName]) {
        
        SDKLog(@"[%@]表删除!", tableName);
        [database deleteAllObjectsFromTable:tableName];
        [database dropTableOfName:tableName];
    }
    else {
        
        SDKLog(@"没有找到[%@]表!", tableName);
    }
}
@end
