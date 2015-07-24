//
//  LogoCcView.m
//  iRemember
//
//  Created by Cc on 14/12/3.
//  Copyright (c) 2014年 CenterC. All rights reserved.
//

#import "LogoCcView.h"

@interface LogoCcView ()

@property (nonatomic,strong) NSTimer *mM_time;

@property (nonatomic,assign) NSInteger mM_stepNum;              //当前步数 从0开始，但是不包括0

@property (nonatomic,assign) NSInteger mM_allStepNum;           //总步数， 总数一半步数时 小c开始运动

@property (nonatomic,assign) NSTimeInterval mM_timeInterval;    //停顿时间

@property (nonatomic,assign) CGPoint mM_bigCenterC;             //大C 中心点

@property (nonatomic,assign) CGPoint mM_smallCenterC;           //小C 中心点

@property (nonatomic,assign) CGFloat mM_radiusC;                //大C 半径

@end

@implementation LogoCcView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.mM_allStepNum = 300;
        self.pLogoStyle = eLogoCcViewStyleDefault;
        self.mM_timeInterval = 0.005;
        self.mM_radiusC = 110;
        self.mM_bigCenterC = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0 );
        self.mM_smallCenterC = CGPointMake(self.mM_bigCenterC.x, self.mM_bigCenterC.y + (self.mM_radiusC / 2));
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"LogoCcView dealloc");
}

- (void)drawRect:(CGRect)rect {
//     Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    CGContextSetLineWidth(context, 12.0);
    [self drawBigCenterC:rect withCGContextRef:context withStepNum:self.mM_stepNum];
    [self drawSmallCenterC:rect withCGContextRef:context withStepNum:self.mM_stepNum];
}
- (void)drawBigCenterC:(CGRect)rect withCGContextRef:(CGContextRef)context withStepNum:(NSInteger)step
{
    switch (self.pLogoStyle)
    {
        case eLogoCcViewStyleDefault:
        {
            CGContextBeginPath(context);
            if (step > self.mM_allStepNum / 2) {
                
                step = self.mM_allStepNum / 2;
            }
            CGFloat s = step * (M_PI / self.mM_allStepNum) * 2;
            CGContextAddArc(context, self.mM_bigCenterC.x, self.mM_bigCenterC.y, self.mM_radiusC,  -M_PI / 2 , -M_PI / 2 - s, YES);
            CGContextStrokePath(context);
        }
            break;
        case eLogoCcViewStyleDouble:
        {
            if(step > 0) {
                
                CGContextBeginPath(context);
                CGFloat s = step * (M_PI / self.mM_allStepNum) ;
                CGContextAddArc(context, self.mM_bigCenterC.x, self.mM_bigCenterC.y, self.mM_radiusC,  -M_PI / 2 , -M_PI / 2 - s, YES);
                CGContextStrokePath(context);
            }
        }
            break;
    }
}
- (void)drawSmallCenterC:(CGRect)rect withCGContextRef:(CGContextRef)context withStepNum:(NSInteger)step
{
    switch (self.pLogoStyle)
    {
        case eLogoCcViewStyleDefault:
        {
            CGContextBeginPath(context);
            if (step > self.mM_allStepNum / 2) {
                
                CGFloat s = (step * (M_PI / self.mM_allStepNum) * 2) - M_PI ;
                s *= 2;
                if(step > self.mM_allStepNum / 4 * 3) {
                    
                    CGContextAddArc(context, self.mM_smallCenterC.x, self.mM_smallCenterC.y, self.mM_radiusC / 2, M_PI + M_PI / 2 - s , M_PI / 2 - s, YES);
                }
                else {
                    
                    CGContextAddArc(context, self.mM_smallCenterC.x, self.mM_smallCenterC.y, self.mM_radiusC / 2,  M_PI / 2 , M_PI / 2 - s, YES);
                }
            }
            CGContextStrokePath(context);
        }
            break;
        case eLogoCcViewStyleDouble:
        {
            if (step > 0) {
                
                CGContextBeginPath(context);
                {
                    CGFloat s = (step * (M_PI / self.mM_allStepNum)) - M_PI ;
                    s *= 2;
                    if(step > self.mM_allStepNum / 2) {
                        
                        CGContextAddArc(context, self.mM_smallCenterC.x, self.mM_smallCenterC.y, self.mM_radiusC / 2, M_PI + M_PI / 2 - s , M_PI / 2 - s, YES);
                    }
                    else {
                        
                        CGContextAddArc(context, self.mM_smallCenterC.x, self.mM_smallCenterC.y, self.mM_radiusC / 2,  M_PI / 2 , M_PI / 2 - s, YES);
                    }
                }
                CGContextStrokePath(context);
            }
        }
            break;
    }
}


#pragma mark - 私有
-(void)onTimer
{
    NSLog(@"onTimer");
    if(self.mM_stepNum == self.mM_allStepNum) {
        
        [self pStop];
    }
    else {
        
        self.mM_stepNum ++;
        [self setNeedsDisplay];
    }
}


#pragma mark - 公共
- (void)pStart
{
    self.mM_stepNum = 0;
    if(self.mM_time == nil) {
        
        self.mM_time = [NSTimer scheduledTimerWithTimeInterval:self.mM_timeInterval
                                                        target:self
                                                      selector:@selector(onTimer)
                                                      userInfo:nil
                                                       repeats:YES];
    }
    
    [self.pDelegate dgLogoCcView_onStart:self];
}

- (void)pStop
{
    if (self.mM_time) {
        
        [self.mM_time invalidate];
        self.mM_time = nil;
    }
    
    [self.pDelegate dgLogoCcView_onEnd:self];
}
@end
