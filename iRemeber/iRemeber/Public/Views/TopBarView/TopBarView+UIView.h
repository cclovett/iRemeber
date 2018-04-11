//
//  TopBarView+UIView.h
//  iRemeber
//
//  Created by TT on 2018/4/10.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "TopBarView.h"

@interface TopBarView (UIView)

@property (nonatomic, assign) eTopBarViewStyle mStyle;
@property (nonatomic, strong) UILabel *mTitle;
@property (nonatomic, strong) ButtonView *mBackButton;


- (void)fLoadViews;

@end
