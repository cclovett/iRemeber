//
//  CSettingViewController.m
//  iRemember
//
//  Created by Cc on 14-7-11.
//  Copyright (c) 2014年 CenterC. All rights reserved.
//

#import "CSettingViewController.h"
#import "CMUIGlobel.h"
#import "VRememberUpDownRefreshView.h"

@interface CSettingViewController () <VRememberUpDownRefreshViewDelegate>

@property (nonatomic,strong) UIScrollView *mV_scrollView;


@end

@implementation CSettingViewController


- (instancetype)initWithDelegate:(id<CSettingViewControllerDelegate>)delegate
{
    self = [super init];
    if (self) {
        
        self.pDelegate = delegate;
    }
    return self;
}

- (void)dealloc
{
    self.pDelegate = nil;
    self.mV_scrollView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initmV_scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - mV_scrollView
- (void)initmV_scrollView
{
    if (self.mV_scrollView == nil) {
        
        self.mV_scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.mV_scrollView.userInteractionEnabled = YES;
        self.mV_scrollView.scrollEnabled = YES;
        self.mV_scrollView.alwaysBounceVertical = YES;
        self.mV_scrollView.backgroundColor = gUI_setting_backgroundColor;
        [self.view addSubview:self.mV_scrollView];
        
        UIView *view = [[UIView alloc] initWithFrame:self.mV_scrollView.bounds];
        view.backgroundColor = gUI_setting_backgroundColor;
        [self.mV_scrollView addSubview:view];
        
        self.mV_upDownRefreshView = \
            [[VRememberUpDownRefreshView alloc] initWithDirection:eVRememberUpDownRefreshDirection_up
                                                     withDelegate:self];
        
        [self.mV_scrollView addSubview:self.mV_upDownRefreshView];
    }
}

- (void)dgVRememberUpDownRefreshView_refresh:(VRememberUpDownRefreshView *)refreshView
{
    [self.pDelegate dgVRememberUpDownRefreshView_refresh:refreshView];
}

@end
