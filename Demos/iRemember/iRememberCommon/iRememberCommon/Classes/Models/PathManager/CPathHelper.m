//
//  CPathHelper.m
//  iRememberCommon
//
//  Created by Cc on 14/12/21.
//  Copyright (c) 2014年 CenterC. All rights reserved.
//

#import "CPathHelper.h"

@implementation CPathHelper

+ (NSString *)sGotDocumentDirectoryPath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return path;
}

+ (NSURL*)sGotDocumentDirectoryURL
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

+ (NSURL*)sGotLibraryDirectoryURL
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

@end
