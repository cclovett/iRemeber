//
//  DBTask+WCTTableCoding.h
//  iRemeber
//
//  Created by TT on 2018/4/19.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "DBTask.h"
#import <WCDB/WCDB.h>

@interface DBTask (WCTTableCoding)
<
    WCTTableCoding
>

WCDB_PROPERTY(mUUID)
WCDB_PROPERTY(mCreateTime)
WCDB_PROPERTY(mModifiedTime)

@end
