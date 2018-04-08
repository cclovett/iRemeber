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

@interface MainVC ()

@property (strong, nonatomic) TabBarView *mTabBarView;
@property (strong, nonatomic) TopBarView *mTopBarView;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self fLoadViews];
    
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


@end
