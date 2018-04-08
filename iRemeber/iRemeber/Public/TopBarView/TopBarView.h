//
//  TopBarView.h
//  iRemeber
//
//  Created by Cc on 2018/4/8.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopBarView : UIView

@property (nonatomic, strong, readonly) UILabel *mTitle;

- (void)fSetupTitle:(NSString *)strText;

@end
