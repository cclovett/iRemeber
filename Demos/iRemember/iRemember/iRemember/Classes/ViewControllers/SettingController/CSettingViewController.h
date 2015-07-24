//
//  CSettingViewController.h
//  iRemember
//
//  Created by Cc on 14-7-11.
//  Copyright (c) 2014年 CenterC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRememberUpDownRefreshView.h"

@protocol CSettingViewControllerDelegate <VRememberUpDownRefreshViewDelegate>

@end

@interface CSettingViewController : UIViewController

@property (nonatomic,strong) VRememberUpDownRefreshView *mV_upDownRefreshView;

@property (nonatomic,weak) id<CSettingViewControllerDelegate> pDelegate;

- (instancetype)initWithDelegate:(id<CSettingViewControllerDelegate>)delegate;

@end
