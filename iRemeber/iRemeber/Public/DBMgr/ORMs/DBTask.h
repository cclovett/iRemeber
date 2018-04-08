//
//  DBTask.h
//  iRemeber
//
//  Created by Cc on 2018/4/8.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBTask : NSObject

@property int db_uuid;// 自动uuid

@property(retain) NSDate *db_createTime;// 添加日期
@property(retain) NSDate *db_modifiedTime;// 修改日期

@end
