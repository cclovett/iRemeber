//
//  TaskAddVC+UIView.h
//  iRemeber
//
//  Created by TT on 2018/4/10.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "TaskAddVC.h"

@interface TaskAddVC (UIView)

@property (strong, nonatomic) TopBarView *mTopBarView;
@property (strong, nonatomic) ButtonView *mAddButton;
@property (strong, nonatomic) JVFloatLabeledTextField *mTitleTextField;
@property (strong, nonatomic) JVFloatLabeledTextView *mDescription;

- (void)fLoadViews;

@end
