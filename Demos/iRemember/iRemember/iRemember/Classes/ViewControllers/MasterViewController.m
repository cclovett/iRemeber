//
//  MasterViewController.m
//  iRemember
//
//  Created by Cc on 14/11/22.
//  Copyright (c) 2014年 CenterC. All rights reserved.
//

#import "MasterViewController.h"
#import <iAd/iAd.h>
#import "CMGlobel.h"
#import "LogoCcView.h"
#import "CSettingViewController.h"
#import "CMainViewController.h"

@interface MasterViewController ()
<
    LogoCcViewDelegate
    ,ADBannerViewDelegate
    ,CSettingViewControllerDelegate
    ,CMainViewControllerDelegate
>

    @property (nonatomic,strong) UIView *mV_View;
    @property (nonatomic,assign) CGRect origTableViewFrame;

    @property (nonatomic,strong) LogoCcView *mM_logoCcView;

    @property (nonatomic,strong) ADBannerView *mV_ADBView;

    @property (nonatomic,strong) CSettingViewController *mC_settingViewController;

    @property (nonatomic,strong) CMainViewController *mC_mainViewController;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //启动动画 只播一次
//    [self startLaunchAnimation];
    
    self.origTableViewFrame = self.view.bounds;
    {
        self.mV_View = [[UIView alloc] initWithFrame:CGRectMake(self.origTableViewFrame.origin.x
                                                                 ,- self.origTableViewFrame.size.height
                                                                 , self.origTableViewFrame.size.width
                                                                 , self.origTableViewFrame.size.height * 2)];
        [self.view addSubview:self.mV_View];
        [self.mV_View setUserInteractionEnabled:YES];
    }
    
    [self initmC_settingViewController];
    [self initmC_mainViewController];
    [self initmV_ADBView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 启动动画 只播一次
- (void)startLaunchAnimation
{
    [self closeLaunchAnimationView];
    if (self.mM_logoCcView == nil) {
        
        self.mM_logoCcView = [[LogoCcView alloc] initWithFrame:self.view.bounds];
        self.mM_logoCcView.pDelegate = self;
        self.mM_logoCcView.pLogoStyle = eLogoCcViewStyleDouble;
        [self.view addSubview:self.mM_logoCcView];
    }
    [self.mM_logoCcView pStart];
}
- (void)closeLaunchAnimationView
{
    if (self.mM_logoCcView) {
        
        self.mM_logoCcView.pDelegate = nil;
        [self.mM_logoCcView removeFromSuperview];
        self.mM_logoCcView = nil;
    }
}
- (void)dgLogoCcView_onEnd:(LogoCcView *)view
{
    [UIView animateWithDuration:1 animations:^{
       
        [self.mM_logoCcView setAlpha:0];
    } completion:^(BOOL finished) {
        
        [self closeLaunchAnimationView];
    }];
}
- (void)dgLogoCcView_onStart:(LogoCcView *)view
{}


#pragma mark - iAd
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    CGFloat h = 50;
    [self.mV_ADBView setFrame:CGRectMake(self.origTableViewFrame.origin.x, self.origTableViewFrame.size.height * 2, self.origTableViewFrame.size.width, h)];
    [UIView animateWithDuration:0.5 animations:
     ^{
         {
             CGFloat y = self.mV_View.frame.size.height - h;
             CGRect pFrame = CGRectMake(self.origTableViewFrame.origin.x
                                        , y
                                        , self.origTableViewFrame.size.width
                                        , h);
             
             [self.mV_ADBView setFrame:pFrame];
         }
         {
             CGRect pFrame = CGRectMake(self.origTableViewFrame.origin.x, self.origTableViewFrame.size.height, self.origTableViewFrame.size.width, self.origTableViewFrame.size.height - h);
             [self.mC_mainViewController.view setFrame:pFrame];
         }
     }];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    SDKErrorLog(@"%@",error);
}

- (void)dgVRememberUpDownRefreshView_refresh:(VRememberUpDownRefreshView *)refreshView
{
    switch (refreshView.pEDirection) {
        case eVRememberUpDownRefreshDirection_down:
        {
            [self.view bringSubviewToFront:self.mC_mainViewController.view];
            [UIView animateWithDuration:1 animations:
             ^{
                 
                 [self.mV_View setFrame:CGRectMake(self.origTableViewFrame.origin.x
                                                    , self.origTableViewFrame.origin.y
                                                    , self.origTableViewFrame.size.width
                                                    , self.origTableViewFrame.size.height * 2)];
             } completion:nil];
        } break;
            
        case eVRememberUpDownRefreshDirection_up:
        {
            [self.view bringSubviewToFront:self.mC_settingViewController.view];
            [self.mC_mainViewController reflashIB_tableViewDataSource];
            [UIView animateWithDuration:1 animations:
             ^{
                 [self.mV_View setFrame:CGRectMake(self.origTableViewFrame.origin.x
                                                    ,- self.origTableViewFrame.size.height
                                                    , self.origTableViewFrame.size.width
                                                    , self.origTableViewFrame.size.height * 2)];
            } completion:nil];
        } break;
            
        default:
            break;
    }
}

#pragma mark - mC_settingViewController
- (void)initmC_settingViewController
{
    if (self.mC_settingViewController == nil) {
        
        self.mC_settingViewController = [[CSettingViewController alloc] initWithDelegate:self];
        
        [self addChildViewController:self.mC_settingViewController];
        [self.mV_View addSubview:self.mC_settingViewController.view];
        
        [self.mC_settingViewController.view setFrame:self.origTableViewFrame];
    }
}


#pragma mark - mC_mainViewController
- (void)initmC_mainViewController
{
    if (self.mC_mainViewController == nil) {
        
        self.mC_mainViewController = [[CMainViewController alloc] initWithDelegate:self];
        
        [self addChildViewController:self.mC_mainViewController];
        [self.mV_View addSubview:self.mC_mainViewController.view];
        
        [self.mC_mainViewController.view setFrame:CGRectMake(self.origTableViewFrame.origin.x, self.origTableViewFrame.size.height, self.origTableViewFrame.size.width, self.origTableViewFrame.size.height)];
    }
}

#pragma mark - mV_ADBView
- (void)initmV_ADBView
{
    if (self.mV_ADBView == nil) {
        
        self.mV_ADBView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
        [self.mV_ADBView setFrame:CGRectZero];
        self.mV_ADBView.delegate = self;
        [self.mV_View addSubview:self.mV_ADBView];
    }
}

@end
