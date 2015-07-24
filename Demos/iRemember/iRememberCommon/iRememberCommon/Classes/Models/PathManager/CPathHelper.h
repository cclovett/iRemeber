//
//  CPathHelper.h
//  iRememberCommon
//
//  Created by Cc on 14/12/21.
//  Copyright (c) 2014年 CenterC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPathHelper : NSObject

/**
 *  获取 Document Directory Path
 */
+ (NSString *)sGotDocumentDirectoryPath;
/**
 *  获取 Document Directory URL
 */
+ (NSURL*)sGotDocumentDirectoryURL;

/**
 *  获取 Library Directory URL
 */
+ (NSURL*)sGotLibraryDirectoryURL;

@end
