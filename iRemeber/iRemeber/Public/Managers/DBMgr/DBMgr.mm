//
//  DBMgr.m
//  iRemeber
//
//  Created by Cc on 2018/4/8.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "DBMgr.h"
#import <WCDB/WCDB.h>
#import <CLOCommon/CLOCommonCore.h>
#import "DBTask+WCTTableCoding.h"

@interface DBMgr ()

@property (nonatomic,strong) WCTDatabase *mDatabase;

@end
@implementation DBMgr

+ (instancetype)sInstance
{
    static id _instace;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instace = [[self.class alloc] init];
    });
    
    return _instace;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *loc = [CLOPathHelper sGetLibraryDirectoryPath];
#ifdef DEBUG
        loc = [CLOPathHelper sGetDocumentDirectoryPath];
#endif
        NSString *filePath = [loc stringByAppendingPathComponent:@"db.sqlite"];
        SDKLog(@"[DBMgr] 创建数据库=> %@", filePath);
        _mDatabase = [[WCTDatabase alloc] initWithPath:filePath];
        
        if ([_mDatabase canOpen]) {
            // WCDB大量使用延迟初始化（Lazy initialization）的方式管理对象，因此SQLite连接会在第一次被访问时被打开。开发者不需要手动打开数据库。
            // 先判断表是不是已经存在
            if ([_mDatabase isOpened]) {
                
#ifdef DEBUG
                [DBTask sDropTable:_mDatabase];
#endif
                [DBTask sCreateTable:_mDatabase];
            }
        }
    }
    
    return self;
}

- (void)fAddTask:(NSString *)uuid
{
    DBTask *task = [[DBTask alloc] init];
    task.mUUID = uuid;
    [self.mDatabase insertObject:task into:[DBTask sClassName]];
}
@end
