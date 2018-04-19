//
//  TaskAddVC.h
//  iRemeber
//
//  Created by TT on 2018/4/10.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopBarView, ButtonView;
@class JVFloatLabeledTextField, JVFloatLabeledTextView;

@interface TaskAddVC : UIViewController

@property (strong, nonatomic, readonly) TopBarView *mTopBarView;
@property (strong, nonatomic, readonly) ButtonView *mAddButton;
@property (strong, nonatomic, readonly) JVFloatLabeledTextField *mTitleTextField;
@property (strong, nonatomic, readonly) JVFloatLabeledTextView *mDescription;

@end
