//
//  pg_edit_sdk_common_alert_view.m
//  pg_edit_sdk_ui_c360
//
//  Created by Cc on 15/5/28.
//  Copyright (c) 2015年 PinguoSDK. All rights reserved.
//

#import "pg_edit_sdk_common_alert_view.h"

@implementation pg_edit_sdk_common_alert_view

- (instancetype)initWithTitle:(nonnull NSString *)title
                      message:(nonnull NSString *)message
            cancelButtonTitle:(nonnull NSString *)cancelButtonTitle
            otherButtonTitles:(nullable NSString *)otherButtonTitles
                  clickButton:(nullable AlertBlock)block
{
    self = [super initWithTitle:title
                        message:message
                       delegate:self
              cancelButtonTitle:cancelButtonTitle
              otherButtonTitles:otherButtonTitles,
            nil];
    
    if (self) {
        
        self.pBlock = block;
    }
    return self;
}


- (void)dealloc
{
    self.pBlock = nil;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.pBlock) {
        
        self.pBlock(alertView, buttonIndex);
    }
}

@end
