//
//  TopBarView+UIView.m
//  iRemeber
//
//  Created by TT on 2018/4/10.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "TopBarView+UIView.h"
#import "Global.h"
#import "ButtonView.h"

@implementation TopBarView (UIView)

@dynamic mTitle;
@dynamic mStyle;
@dynamic mBackButton;

- (void)fLoadViews
{
    {
        // mTitle
        UILabel *v = [[UILabel alloc] init];
        v.backgroundColor = [UIColor clearColor];
        switch (self.mStyle) {
            case eTopBarViewStyle_LightContent:
                v.textColor = kLightContentTitleColor;
                break;
                
            default:
                v.textColor = kDarkContentTitleColor;
                break;
        }
        
        v.textAlignment = NSTextAlignmentCenter;
        v.hidden = YES;// 先隐藏
        [self addSubview:v];
        
        self.mTitle = v;
    }
    {
        //mBackButton
        ButtonView *v = [[ButtonView alloc] initWithFrame:CGRectZero];
        v.hidden = YES;// 先隐藏
        [self addSubview:v];
        
        self.mBackButton = v;
    }
}

@end
