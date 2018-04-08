//
//  MainVC.h
//  iRemeber
//
//  Created by Cc on 2018/4/8.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabBarView, TopBarView;

@interface MainVC : UIViewController

@property (strong, nonatomic, readonly) TabBarView *mTabBarView;
@property (strong, nonatomic, readonly) TopBarView *mTopBarView;

@end
