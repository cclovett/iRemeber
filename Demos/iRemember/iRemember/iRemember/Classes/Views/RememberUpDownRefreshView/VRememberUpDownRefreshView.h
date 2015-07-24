//
//  VRememberUpDownRefreshView.h
//  iRemember
//
//  Created by Cc on 14-7-5.
//  Copyright (c) 2014年 CenterC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VRememberUpDownRefreshView;

typedef NS_ENUM(NSUInteger, eVRememberUpDownRefreshDirection) {
    eVRememberUpDownRefreshDirection_up = 1,
    eVRememberUpDownRefreshDirection_down,
};

@protocol VRememberUpDownRefreshViewDelegate <NSObject>

- (void)dgVRememberUpDownRefreshView_refresh:(VRememberUpDownRefreshView*)refreshView;

@end

@interface VRememberUpDownRefreshView : UIView

@property (nonatomic,weak) id<VRememberUpDownRefreshViewDelegate> pDelegate;

@property (nonatomic,assign) eVRememberUpDownRefreshDirection pEDirection;
//是否可以触发
@property (nonatomic,assign,readonly) BOOL pIsAction;

- (id)initWithDirection:(eVRememberUpDownRefreshDirection)direction
           withDelegate:(id<VRememberUpDownRefreshViewDelegate>)delegate;

@end
