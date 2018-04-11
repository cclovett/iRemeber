//
//  ButtonView.h
//  iRemeber
//
//  Created by TT on 2018/4/11.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ButtonView;

typedef void (^bButtonViewBlock_TouchUpInside)(id sender);

@interface ButtonView : UIButton

@property (nonatomic, copy) bButtonViewBlock_TouchUpInside mBlock_TouchUpInside;


- (instancetype)initWithFrame:(CGRect)frame;

@end
