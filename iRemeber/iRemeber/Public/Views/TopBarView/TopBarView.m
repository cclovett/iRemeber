//
//  TopBarView.m
//  iRemeber
//
//  Created by Cc on 2018/4/8.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "TopBarView.h"
#import "Global.h"
#import "TopBarView+UIView.h"

@interface TopBarView ()

@property (nonatomic, assign) eTopBarViewStyle mStyle;
@property (nonatomic, strong) UILabel *mTitle;
@property (nonatomic, strong) ButtonView *mBackButton;

@end
@implementation TopBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame withStyle:eTopBarViewStyle_Default];
}


- (instancetype)initWithFrame:(CGRect)frame withStyle:(eTopBarViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _mStyle = style;
        switch (self.mStyle) {
            case eTopBarViewStyle_LightContent:
                self.backgroundColor = kLightContentBackgroundColor;
                break;
                
            default:
                self.backgroundColor = kDarkContentBackgroundColor;
                break;
        }
        
        [self fLoadViews];
    }
    return self;
}


- (void)fSetupTitle:(NSString *)strText
{
    if (strText.length > 0) {
    
        self.mTitle.hidden = NO;
        CGFloat y = [CLOPositionHelper sGetStatusBarHeight];
        CGFloat height = self.bounds.size.height - y;
        self.mTitle.frame = CGRectMake(0, y, self.bounds.size.width, height);
        self.mTitle.text = strText;
    }
    else {
        
        self.mTitle.hidden = YES;
    }
}


- (void)fSetupBackButtonTitle:(NSString *)strText withBlock:(bButtonViewBlock_TouchUpInside)block
{
    if (block) {
        
        self.mBackButton.hidden = NO;
        CGFloat y = [CLOPositionHelper sGetStatusBarHeight];
        CGFloat height = self.bounds.size.height - y;
        CGFloat width = 50;//TODO: 通过文字判断
        self.mBackButton.frame = CGRectMake(5, y, width, height);
        self.mBackButton.mBlock_TouchUpInside = block;
    }
    else {
        
        self.mBackButton.mBlock_TouchUpInside = nil;
        self.mBackButton.hidden = YES;
    }
}
@end
