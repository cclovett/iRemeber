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

@interface TaskAddVC ()

@property (strong, nonatomic) TopBarView *mTopBarView;

@end

@implementation TaskAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self fLoadViews];
    
    [self fSetupTopBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    SDKErrorLog(@"didReceiveMemoryWarning");
}

- (void)fSetupTopBar
{
    @CLOWeakify(self)
    [self.mTopBarView fSetupBackButtonTitle:@"" withBlock:^(TopBarButton *btn) {
        @CLOStrongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
