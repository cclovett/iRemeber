//
//  TopBarButton.h
//  iRemeber
//
//  Created by TT on 2018/4/10.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopBarButton;

typedef void (^TopBarButtonClickBlock)(TopBarButton *btn);

@interface TopBarButton : UIButton

@property (nonatomic, copy) TopBarButtonClickBlock mBlock;

@end
