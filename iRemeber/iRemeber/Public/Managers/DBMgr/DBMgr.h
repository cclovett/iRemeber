//
//  DBMgr.h
//  iRemeber
//
//  Created by Cc on 2018/4/8.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDBMgr [DBMgr sInstance]

@interface DBMgr : NSObject

+ (instancetype)sInstance;


@end
