//
//  TopBarView.m
//  iRemeber
//
//  Created by Cc on 2018/4/8.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "TopBarView.h"
#import <CLOCommon/CLOCommonUI.h>

@interface TopBarView ()

@property (nonatomic, strong) UILabel *mTitle;

@end
@implementation TopBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = kCLOColor(50, 50, 50, 1);
    }
    return self;
}


- (void)fSetupTitle:(NSString *)strText
{
    CGFloat y = [CLOPositionHelper sGetStatusBarHeight];
    CGFloat height = self.bounds.size.height - y;
    self.mTitle.frame = CGRectMake(0, y, self.bounds.size.width, height);
    self.mTitle.text = strText;
}


- (UILabel *)mTitle
{
    if (!_mTitle) {
        
        UILabel *v = [[UILabel alloc] init];
        v.backgroundColor = [UIColor clearColor];
        v.textColor = kCLOColor(255, 255, 255, 1);
        v.textAlignment = NSTextAlignmentCenter;
        _mTitle = v;
        [self addSubview:v];
    }
    
    return _mTitle;
}

@end
