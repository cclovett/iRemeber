//
//  CMainViewController.h
//  iRemember
//
//  Created by Cc on 15/6/22.
//  Copyright (c) 2015年 CenterC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRememberUpDownRefreshView.h"

@protocol CMainViewControllerDelegate <VRememberUpDownRefreshViewDelegate>

@end

@interface CMainViewController : UIViewController

@property (nonatomic,strong) VRememberUpDownRefreshView *mV_upDownRefreshView;

@property (nonatomic,weak) id<CMainViewControllerDelegate> pDelegate;

- (instancetype)initWithDelegate:(id<CMainViewControllerDelegate>)delegate;


- (void)reflashIB_tableViewDataSource;

@end
