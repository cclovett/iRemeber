//
//  TaskAddVC+UIView.m
//  iRemeber
//
//  Created by TT on 2018/4/10.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "TaskAddVC+UIView.h"
#import <CLOCommon/CLOCommonUI.h>
#import "Global.h"
#import "TopBarView.h"
#import "ButtonView.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextView.h>
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>

@implementation TaskAddVC (UIView)

@dynamic mTopBarView;
@dynamic mAddButton;
@dynamic mTitleTextField;
@dynamic mDescription;

- (void)fLoadViews
{
    {
        // mTopBarView
        NSInteger height = [CLOPositionHelper sGetStatusBarHeight] + kTopBarView_height;
        TopBarView *v = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0,
                                                                     self.view.bounds.size.width,
                                                                     height)
                                                withStyle:eTopBarViewStyle_Default];
        [self.view addSubview:v];
        self.mTopBarView = v;
        [v fSetupTitle:NSLocalizedString(@"TaskAddPageTitle", @"添加任务页标题")];
    }
    {
        // mAddButton
        NSInteger height = 50;
        NSInteger y = self.view.bounds.size.height - height - [CLOPositionHelper sGetiPhoneXBottomHeight];
        NSInteger x = 10;
        ButtonView *btn = [[ButtonView alloc] initWithFrame:CGRectMake(x, y, self.view.bounds.size.width - 2 * x, height)];
        [self.view addSubview:btn];
        self.mAddButton = btn;
        btn.layer.cornerRadius = 8;
        btn.backgroundColor = [UIColor grayColor];
    }
    {
        // mTitleTextField
        JVFloatLabeledTextField *v = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(20, 100, 375 - 40, 44)];
        v.font = [UIFont systemFontOfSize:16.0f];
        v.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Title", @"")
                                                                              attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
        v.floatingLabelFont = [UIFont boldSystemFontOfSize:11.0f];
        v.floatingLabelTextColor = [UIColor brownColor];
        [self.view addSubview:v];
        self.mTitleTextField = v;
        [v becomeFirstResponder];
        v.keepBaseline = YES;
    }
    {
        JVFloatLabeledTextView *descriptionField = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(20, 200, 375 - 40, 88)];
        descriptionField.font = [UIFont systemFontOfSize:16.0f];
        descriptionField.placeholder = NSLocalizedString(@"Description", @"");
        descriptionField.placeholderTextColor = [UIColor darkGrayColor];
        descriptionField.floatingLabelFont = [UIFont boldSystemFontOfSize:11.0f];
        descriptionField.floatingLabelTextColor = [UIColor brownColor];
        [self.view addSubview:descriptionField];
        self.mDescription = descriptionField;
    }
}

@end
