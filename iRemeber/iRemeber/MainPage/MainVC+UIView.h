//
//  MainVC+UIView.h
//  iRemeber
//
//  Created by Cc on 2018/4/8.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "MainVC.h"
#import "TabBarView.h"
#import "TopBarView.h"

@interface MainVC (UIView)

@property (strong, nonatomic) TabBarView *mTabBarView;
@property (strong, nonatomic) TopBarView *mTopBarView;

- (void)fLoadViews;

@end
