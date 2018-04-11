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
#import "ButtonView.h"

@implementation TaskAddVC (UIView)

@dynamic mTopBarView;
@dynamic mAddButton;


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
        [v fSetupTitle:NSLocalizedString(@"TaskAddPageTitle", @"添加任务页标题")];
    }
    {
        // mAddButton
        NSInteger height = 50;
        NSInteger y = self.view.bounds.size.height - height - [CLOPositionHelper sGetiPhoneXBottomHeight];
        NSInteger x = 10;
        ButtonView *btn = [[ButtonView alloc] initWithFrame:CGRectMake(x, y, self.view.bounds.size.width - 2 * x, height)];
        [self.view addSubview:btn];
        self.mAddButton = btn;
        btn.layer.cornerRadius = 8;
        btn.backgroundColor = [UIColor grayColor];
    }
}

@end
