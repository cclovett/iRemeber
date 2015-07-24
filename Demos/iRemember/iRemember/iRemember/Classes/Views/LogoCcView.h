//
//  LogoCcView.h
//  iRemember
//
//  Created by Cc on 14/12/3.
//  Copyright (c) 2014年 CenterC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LogoCcView;

typedef NS_ENUM(NSUInteger, eLogoCcViewStyle) {
    
    eLogoCcViewStyleDefault,
    eLogoCcViewStyleDouble,
};

@protocol LogoCcViewDelegate <NSObject>

- (void)dgLogoCcView_onStart:(LogoCcView*)view;
- (void)dgLogoCcView_onEnd:(LogoCcView*)view;

@end

@interface LogoCcView : UIView

@property (nonatomic,weak) id<LogoCcViewDelegate> pDelegate;

@property (nonatomic,assign) eLogoCcViewStyle pLogoStyle;

- (void)pStart;

- (void)pStop;

@end
