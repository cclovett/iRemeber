//
//  pg_edit_sdk_common_alert_view.h
//  pg_edit_sdk_ui_c360
//
//  Created by Cc on 15/5/28.
//  Copyright (c) 2015年 PinguoSDK. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  点击button后，返回得回调函数
 *
 *  @param alertView
 *  @param index
 *
 *  @return
 */
typedef void (^AlertBlock)(UIAlertView * __nonnull alertView, NSInteger index);

@interface pg_edit_sdk_common_alert_view : UIAlertView
<
    UIAlertViewDelegate
>


- (nonnull instancetype)initWithTitle:(nonnull NSString  * )title
                              message:(nonnull NSString *)message
                    cancelButtonTitle:(nonnull NSString *)cancelButtonTitle
                    otherButtonTitles:(nullable NSString *)otherButtonTitles
                          clickButton:(nullable AlertBlock)block NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy, nullable) AlertBlock pBlock;

@end
