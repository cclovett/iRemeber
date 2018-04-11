//
//  TaskAddVC.h
//  iRemeber
//
//  Created by TT on 2018/4/10.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopBarView, ButtonView;

@interface TaskAddVC : UIViewController

@property (strong, nonatomic, readonly) TopBarView *mTopBarView;
@property (strong, nonatomic, readonly) ButtonView *mAddButton;

@end
