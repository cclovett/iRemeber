//
//  DBBase.h
//  iRemeber
//
//  Created by TT on 2018/4/19.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCTDatabase;

@interface DBBase : NSObject

+ (NSString *)sClassName;

+ (void)sCreateTable:(WCTDatabase *)database;
+ (void)sDropTable:(WCTDatabase *)database;

@end
