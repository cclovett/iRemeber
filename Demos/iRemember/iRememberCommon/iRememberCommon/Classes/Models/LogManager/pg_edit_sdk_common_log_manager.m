//
//  pg_edit_sdk_common_Log_manager.m
//  pg_edit_sdk_common
//
//  Created by Cc on 15/3/12.
//  Copyright (c) 2015年 PinguoSDK. All rights reserved.
//

#import "pg_edit_sdk_common_log_manager.h"
#import "pg_edit_sdk_common_alert_view.h"

@implementation pg_edit_sdk_common_log_manager

+ (void)sSDKssLog:(NSString*)desc file:(NSString *)fileName lineNumber:(NSInteger)line selector:(SEL)selector
{
    fprintf(stderr, "------- <%s : %d> %s \n"
            ,[[fileName lastPathComponent] UTF8String]
            ,(int)line
            ,[NSStringFromSelector(selector) UTF8String]);
    
    NSLog(@"%@",desc);
    fprintf(stderr, "-------\n");
}
+ (void)sSDKsLog:(nonnull NSString *)format, ...
{
#if kSDKLog == 1
#warning [日志] 开启 kSDKLog

    va_list argList;
    va_start(argList, format);
    NSString *desc = [[NSString alloc] initWithFormat:format arguments:argList];
    va_end(argList);
//    [self sSDKssLog:desc];
    NSLog(@"%@",desc);
    
#else
    
    #warning [日志] 关闭 kSDKLog
    
#endif
    
    
}

+ (void)sSDKErrorsLog:(nonnull SEL)selector
               object:(nullable id)object
                 file:(nonnull NSString *)fileName
           lineNumber:(NSInteger)line
           withFormat:(nonnull NSString *)format, ...
{
#if kSDKErrorLog == 1
#warning [日志] 开启 kSDKErrorLog
    
    va_list argList;
    va_start(argList, format);
    NSString *desc = [[NSString alloc] initWithFormat:format arguments:argList];
    va_end(argList);
    
    desc = [NSString stringWithFormat:@" < Error > : %@", desc];
    
    [self sSDKssLog:desc file:fileName lineNumber:line selector:selector];

#else
    
    #warning [日志] 关闭 kSDKErrorLog
    
#endif
}

+ (void)sSDKAssertionsLog:(BOOL)condition
      withFailureInMethod:(nonnull SEL)selector
                   object:(nullable id)object
                     file:(nonnull NSString *)fileName
               lineNumber:(NSInteger)line
               withFormat:(nonnull NSString *)format, ...
{
#if kSDKAssertionLog == 1
#warning [日志] 开启 kSDKAssertionLog
    
    if (!(condition)) {
        
        va_list argList;
        va_start(argList, format);
        NSString *desc = [[NSString alloc] initWithFormat:format arguments:argList];
        va_end(argList);
        
        desc = [NSString stringWithFormat:@" < Assertion > : %@", desc];
        
        [self sSDKssLog:desc file:fileName lineNumber:line selector:selector];
        
        
    #if kSDKAssertEnable == 1
#warning [断言] 直接断言 kSDKAssertionLog
        
        [[NSAssertionHandler currentHandler] handleFailureInMethod:selector
                                                            object:object
                                                              file:fileName
                                                        lineNumber:line
                                                       description:desc,nil];
        
    #else
#warning [断言] 异步断言 kSDKAssertionLog
        
        NSString *alertMsg = [NSString stringWithFormat: @"<%@ %@ %@>, %@"
                              ,fileName
                              ,@(line)
                              ,NSStringFromSelector(selector)
                              ,desc];
        
        if ([UIAlertController class]) {
            
            UIAlertController *alertController = \
                [UIAlertController alertControllerWithTitle:@"!!断言崩溃!!, 请QA截图反馈, 点击[取消]将退出"
                                                    message:alertMsg
                                             preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction *action)
            {
                [[NSAssertionHandler currentHandler] handleFailureInMethod:selector
                                                                    object:object
                                                                      file:fileName
                                                                lineNumber:line
                                                               description:desc,nil];
            }];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"继续"
                                                               style:UIAlertActionStyleDestructive
                                                             handler:nil];
            
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController
                                                                                         animated:YES
                                                                                       completion:nil];
        }
        else {
            
            pg_edit_sdk_common_alert_view *alert = \
                [[pg_edit_sdk_common_alert_view alloc] initWithTitle:@"!断言崩溃!, 请QA截图反馈, 点击[取消]将退出"
                                                             message:alertMsg
                                                   cancelButtonTitle:@"取消"
                                                   otherButtonTitles:@"继续"
                                                         clickButton:^(UIAlertView *alertView, NSInteger index)
            {
                if (index == 0) {
                    
                    [[NSAssertionHandler currentHandler] handleFailureInMethod:selector
                                                                        object:object
                                                                          file:fileName
                                                                    lineNumber:line
                                                                   description:desc,nil];
                }
                else {
                    
                    // 不管他
                }
                
            }];
            
            [alert show];
        }
    #endif
    }
#else
    #warning [日志] 关闭 kSDKAssertionLog
#endif
}

@end
