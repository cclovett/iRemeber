//
//  MainVC.m
//  iRemeber
//
//  Created by Cc on 2018/4/8.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "MainVC.h"
#import <CLOCommon/CLOCommonCore.h>
#import "MainVC+UIView.h"
#import "TabBarEntity.h"
#import "TabBarView.h"
#import "TaskAddVC.h"

@interface MainVC ()

@property (strong, nonatomic) TabBarView *mTabBarView;
@property (strong, nonatomic) TopBarView *mTopBarView;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self fLoadViews];
    [self fSetupTabBarEntities];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    SDKErrorLog(@"didReceiveMemoryWarning");
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)fSetupTabBarEntities
{
    TabBarEntity *ety1 = [[TabBarEntity alloc] init];
    {
        TabBarEntity *ety = ety1;
        @CLOWeakify(self)
        ety.mBlock = ^(TabBarButton *btn) {
            @CLOStrongify(self)
            // 添加一个提醒
            TaskAddVC *vc = [[TaskAddVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        };
    }
    TabBarEntity *ety2 = [[TabBarEntity alloc] init];
    {
        TabBarEntity *ety = ety2;
        @CLOWeakify(self)
        ety.mBlock = ^(TabBarButton *btn) {
            @CLOStrongify(self)
            // 我
        };
    }
    [self.mTabBarView fSetupEntities:@[ety1, ety2]];
}

@end
