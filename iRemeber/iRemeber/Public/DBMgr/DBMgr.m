//
//  DBMgr.m
//  iRemeber
//
//  Created by Cc on 2018/4/8.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "DBMgr.h"

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
        
        
    }
    return self;
}
@end
