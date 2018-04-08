//
//  MainVC+UIView.m
//  iRemeber
//
//  Created by Cc on 2018/4/8.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "MainVC+UIView.h"
#import <CLOCommon/CLOCommonUI.h>
#import "Global.h"

@implementation MainVC (UIView)

@dynamic mTabBarView;
@dynamic mTopBarView;

- (void)fLoadViews
{
    {
        // mTopBarView
        NSInteger height = [CLOPositionHelper sGetStatusBarHeight] + kTopBarView_height;
        TopBarView *v = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, height)];
        [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        v.backgroundColor = kCLOColor(50, 50, 50, 1);
        [self.view addSubview:v];
        self.mTopBarView = v;
        [v fSetupTitle:@"iRemember"];
    }
    {
        // mTabBarView
        NSInteger height = [CLOPositionHelper sGetiPhoneXBottomHeight] + kTabBarView_height;
        NSInteger y = self.view.bounds.size.height - height;
        TabBarView *v = [[TabBarView alloc] initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, height)];
        v.backgroundColor = [UIColor redColor];
        [self.view addSubview:v];
        self.mTabBarView = v;
    }
    
}


@end
