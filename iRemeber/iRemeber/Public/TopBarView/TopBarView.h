//
//  TopBarView.h
//  iRemeber
//
//  Created by Cc on 2018/4/8.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBarButton.h"

typedef NS_ENUM(NSUInteger, eTopBarViewStyle) {
    
    eTopBarViewStyle_Default = 0,// 亮背景
    eTopBarViewStyle_LightContent = 1,// 暗背景
};

@interface TopBarView : UIView

@property (nonatomic, assign, readonly) eTopBarViewStyle mStyle;
@property (nonatomic, strong, readonly) UILabel *mTitle;
@property (nonatomic, strong, readonly) TopBarButton *mBackButton;


- (instancetype)initWithFrame:(CGRect)frame withStyle:(eTopBarViewStyle)style;


/**
 设置中间抬头显示

 @param strText 字符串
 */
- (void)fSetupTitle:(NSString *)strText;


/**
 设置返回按钮

 @param strText 返回显示字符串
 @param block 点击后block回调
 */
- (void)fSetupBackButtonTitle:(NSString *)strText withBlock:(TopBarButtonClickBlock)block;

@end
