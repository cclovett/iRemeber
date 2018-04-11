//
//  TaskAddVC.m
//  iRemeber
//
//  Created by TT on 2018/4/10.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "TaskAddVC.h"
#import "Global.h"
#import "TopBarView.h"
#import "TaskAddVC+UIView.h"
#import "ButtonView.h"

@interface TaskAddVC ()

@property (strong, nonatomic) TopBarView *mTopBarView;
@property (strong, nonatomic) ButtonView *mAddButton;

@end

@implementation TaskAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self fLoadViews];
    
    [self fSetupTopBar];
    [self fSetupAddButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    SDKErrorLog(@"didReceiveMemoryWarning");
}

- (void)fSetupTopBar
{
    @CLOWeakify(self)
    [self.mTopBarView fSetupBackButtonTitle:NSLocalizedString(@"MainPageTitle", @"主页标题") withBlock:^(id btn) {
        @CLOStrongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (void)fSetupAddButton
{
    @CLOWeakify(self)
    self.mAddButton.mBlock_TouchUpInside = ^(id sender) {
        @CLOStrongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    };
}

@end
