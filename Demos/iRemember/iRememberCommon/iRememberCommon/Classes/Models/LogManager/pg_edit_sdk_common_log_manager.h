//
//  pg_edit_sdk_common_Log_manager.h
//  pg_edit_sdk_common
//
//  Created by Cc on 15/3/12.
//  Copyright (c) 2015年 PinguoSDK. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSDKLog 1
#define kSDKErrorLog 1
#define kSDKAssertionLog 1
//1  直接断言，  0 断言提示
#define kSDKAssertEnable 0

//输出日志
#if kSDKLog == 1
    #define SDKLog(fmt, ...) [pg_edit_sdk_common_log_manager sSDKsLog:(fmt), ##__VA_ARGS__]
#else
    #define SDKLog(fmt, ...)
#endif

//错误时断言，并输出日志
#if kSDKErrorLog == 1
    #define SDKErrorLog(fmt, ...) \
        [pg_edit_sdk_common_log_manager sSDKErrorsLog:_cmd \
                                               object:self \
                                                 file:[NSString stringWithUTF8String:__FILE__] \
                                           lineNumber:__LINE__ \
                                           withFormat:(fmt), ##__VA_ARGS__]
#else
    #define SDKErrorLog(fmt, ...)
#endif

//错误时断言，并输出日志
#if kSDKAssertionLog == 1
    #define SDKAssertionLog(condition, fmt, ...) \
        [pg_edit_sdk_common_log_manager sSDKAssertionsLog:(condition) \
                                      withFailureInMethod:_cmd \
                                                   object:self \
                                                     file:[NSString stringWithUTF8String:__FILE__] \
                                               lineNumber:__LINE__ \
                                               withFormat:(fmt), ##__VA_ARGS__]
#else
    #define SDKAssertionLog(condition, fmt, ...)
#endif

#define SDKAssert SDKAssertionLog(NO, @"")

@interface pg_edit_sdk_common_log_manager : NSObject

+ (void)sSDKsLog:(nonnull NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

+ (void)sSDKErrorsLog:(nonnull SEL)selector
               object:(nullable id)object
                 file:(nonnull NSString *)fileName
           lineNumber:(NSInteger)line
           withFormat:(nonnull NSString *)format, ... NS_FORMAT_FUNCTION(5,6);

+ (void)sSDKAssertionsLog:(BOOL)condition
      withFailureInMethod:(nonnull SEL)selector
                   object:(nullable id)object
                     file:(nonnull NSString *)fileName
               lineNumber:(NSInteger)line
               withFormat:(nonnull NSString *)format, ... NS_FORMAT_FUNCTION(6,7);

@end
