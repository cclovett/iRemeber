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
    @weakify(self)
    TabBarEntity *ety1 = [[TabBarEntity alloc] init];
    {
        TabBarEntity *ety = ety1;
        ety.mBlock = ^(TabBarButton *btn) {
            @strongify(self)
            // 添加一个提醒
        };
    }
    TabBarEntity *ety2 = [[TabBarEntity alloc] init];
    {
        TabBarEntity *ety = ety2;
        ety.mBlock = ^(TabBarButton *btn) {
            @strongify(self)
            // 我
        };
    }
    [self.mTabBarView fSetupEntities:@[ety1, ety2]];
}

@end
