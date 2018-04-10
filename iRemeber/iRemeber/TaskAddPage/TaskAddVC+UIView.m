//
//  TaskAddVC+UIView.m
//  iRemeber
//
//  Created by TT on 2018/4/10.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "TaskAddVC+UIView.h"
#import <CLOCommon/CLOCommonUI.h>
#import "Global.h"
#import "TopBarView.h"

@implementation TaskAddVC (UIView)

@dynamic mTopBarView;

- (void)fLoadViews
{
    {
        // mTopBarView
        NSInteger height = [CLOPositionHelper sGetStatusBarHeight] + kTopBarView_height;
        TopBarView *v = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0,
                                                                     self.view.bounds.size.width,
                                                                     height)
                                                withStyle:eTopBarViewStyle_Default];
        [self.view addSubview:v];
        self.mTopBarView = v;
        [v fSetupTitle:@"iRemember"];
    }
}

@end
