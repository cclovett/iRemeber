//
//  VRememberUpDownRefreshView.m
//  iRemember
//
//  Created by Cc on 14-7-5.
//  Copyright (c) 2014年 CenterC. All rights reserved.
//

#import "VRememberUpDownRefreshView.h"
#import "CMGlobel.h"

#define kRadius 17.5

const CGFloat view_Height = 50;

const CGFloat const_activeHeight = 110;

static inline CGFloat lerp(CGFloat a, CGFloat b, CGFloat p)
{
    return a + (b - a) * p;
}

@interface VRememberUpDownRefreshView ()

@property (nonatomic,weak) UIScrollView *mV_superView;

@property (nonatomic,strong) UIView *mV_displayView;
@property (nonatomic,strong) UILabel *mV_textLabel;

@property (nonatomic,assign) CGFloat offsetY;


@property (nonatomic,assign) BOOL mIsAction_copy;
@end

@implementation VRememberUpDownRefreshView

- (instancetype)initWithDirection:(eVRememberUpDownRefreshDirection)direction withDelegate:(id<VRememberUpDownRefreshViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        
        self.pDelegate = delegate;
        self.pEDirection = direction;
        
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 旧的父控件
    [self removeObserverForSuperView];
    
    if ([newSuperview isKindOfClass:[UIScrollView class]]) {
        
        self.mV_superView = (UIScrollView *)newSuperview;
        
        [self addObserverForSuperView];
        
        if ([self isDirectionDown]) {
            
            CGRect mFrame = CGRectMake(self.mV_superView.bounds.origin.x,
                                       -view_Height,
                                       self.mV_superView.bounds.size.width,
                                       view_Height);
            [self setFrame:mFrame];
        }
        if ([self isDirectionUp]) {
            CGRect mFrame = CGRectMake(self.mV_superView.bounds.origin.x,
                                       self.mV_superView.bounds.size.height,
                                       self.mV_superView.bounds.size.width,
                                       view_Height);
            [self setFrame:mFrame];
        }
        
        [self initViews];
    }
}

- (void)dealloc
{
    [self addObserverForSuperView];
    
    self.pDelegate = nil;
    self.mV_superView = nil;
    self.mV_textLabel = nil;
    self.mV_displayView = nil;
}

- (void)initViews
{
    if ([self isDirectionDown]) {
        if (self.mV_displayView == nil) {
            self.mV_displayView = [[UIView alloc] initWithFrame:self.bounds];
            self.mV_displayView.backgroundColor = gUI_setting_backgroundColor;
            [self addSubview:self.mV_displayView];
        }
        
        if (self.mV_textLabel == nil) {
            self.mV_textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                          0,
                                                                          self.frame.size.width,
                                                                          self.frame.size.height)];
            
            self.mV_textLabel.text = @"Setting";
            self.mV_textLabel.textAlignment = NSTextAlignmentCenter;
            self.mV_textLabel.font = [UIFont systemFontOfSize:21];
            self.mV_textLabel.adjustsFontSizeToFitWidth = YES;
            
            [self.mV_textLabel setHighlightedTextColor:gUI_main_backgroundColor];
            [self.mV_textLabel setTextColor:[UIColor blackColor]];
            
            [self.mV_displayView addSubview:self.mV_textLabel];
        }
    }
    if ([self isDirectionUp]) {
        if (self.mV_displayView == nil) {
            self.mV_displayView = [[UIView alloc] initWithFrame:self.bounds];
            self.mV_displayView.backgroundColor = gUI_main_backgroundColor;
            [self addSubview:self.mV_displayView];
        }
        
        if (self.mV_textLabel == nil) {
            self.mV_textLabel = [[UILabel alloc] initWithFrame:self.mV_displayView.bounds];
            
            self.mV_textLabel.text = @"TableView";
            self.mV_textLabel.textAlignment = NSTextAlignmentCenter;
            self.mV_textLabel.font = [UIFont systemFontOfSize:21];
            self.mV_textLabel.adjustsFontSizeToFitWidth = YES;
            
            [self.mV_textLabel setHighlightedTextColor:gUI_setting_backgroundColor];
            [self.mV_textLabel setTextColor:[UIColor blackColor]];
            
            [self.mV_displayView addSubview:self.mV_textLabel];
        }
    }
}

- (BOOL)isDirectionDown
{
    return self.pEDirection == eVRememberUpDownRefreshDirection_down;
}
- (BOOL)isDirectionUp
{
    return self.pEDirection == eVRememberUpDownRefreshDirection_up;
}
#pragma mark - Label
- (void)refreshLabel
{
    [self.mV_textLabel setHighlighted:self.pIsAction];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isEqual:self.mV_superView]) {
        if ([keyPath isEqualToString:@"contentOffset"]) {
            
            if ([self isDirectionUp]) {
                
                self.offsetY = self.mV_superView.contentOffset.y;
                
                SDKLog(@"Up %f",self.offsetY);

                if (self.offsetY > view_Height) {
                    self.frame = CGRectMake(self.frame.origin.x,
                                            self.mV_superView.bounds.size.height,
                                            self.frame.size.width,
                                            self.offsetY);
                    
                    self.mV_displayView.frame = CGRectMake(self.mV_displayView.frame.origin.x,
                                                           self.bounds.size.height - self.mV_displayView.frame.size.height,
                                                           self.mV_displayView.frame.size.width,
                                                           self.mV_displayView.frame.size.height);
                    
                    self.mV_textLabel.alpha = 1;
                    [self setNeedsDisplay];
                    [self.mV_displayView setHidden:NO];
                }
                else {
                    self.frame = CGRectMake(self.frame.origin.x,
                                            self.mV_superView.bounds.size.height,
                                            self.frame.size.width,
                                            view_Height);
                    [self.mV_displayView setFrame:self.bounds];
                }
                
                if (self.mV_superView.isDragging) {
                    
                    if (self.offsetY > const_activeHeight) {
                        
                        _pIsAction = self.mIsAction_copy = YES;
                    }
                    else {
                        
                        _pIsAction = self.mIsAction_copy = NO;
                    }
                }
                else {
                    if (self.mIsAction_copy) {
                        self.mIsAction_copy = NO;
                        [self.pDelegate dgVRememberUpDownRefreshView_refresh:self];
                    }
                }
                
                [self refreshLabel];
            }
            
            if ([self isDirectionDown]) {
                CGFloat barHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
                CGFloat y = self.mV_superView.frame.origin.y - self.mV_superView.contentInset.top;
                
                self.offsetY = self.mV_superView.contentOffset.y;
                
                CGFloat diff = y - self.offsetY + barHeight;
                SDKLog(@"Down %f",diff);
                
                if (view_Height < diff) {
                    self.frame = CGRectMake(self.frame.origin.x, -diff, self.frame.size.width, diff);

                    self.mV_textLabel.alpha = 1;
                    [self setNeedsDisplay];
                }
                else {
                    self.frame = CGRectMake(self.frame.origin.x, -view_Height, self.frame.size.width, view_Height);
                    
                    /**
                     *  设置透明度
                     */
                    {
                        CGFloat alphaStart = self.mV_superView.contentInset.top + 10;
                        CGFloat alphaEnd = view_Height;
                        CGFloat alphaPer = 1.0 / (alphaEnd - alphaStart);
                        CGFloat alphaValue = alphaPer * (diff - alphaStart);
                        
                        self.mV_textLabel.alpha = alphaValue;
                    }
                }
                
                if (self.mV_superView.isDragging) {
                
                    if (diff > const_activeHeight) {
                        
                        _pIsAction = self.mIsAction_copy = YES;
                    }
                    else {
                        
                        _pIsAction = self.mIsAction_copy = NO;
                    }
                }
                else {
                    if (self.mIsAction_copy) {
                        self.mIsAction_copy = NO;
                        [self.pDelegate dgVRememberUpDownRefreshView_refresh:self];
                    }
                }
                [self refreshLabel];
            }
        }
    }
}
- (void)addObserverForSuperView
{
    if (self.mV_superView) {
        [self.mV_superView addObserver:self
                            forKeyPath:@"contentOffset"
                               options:NSKeyValueObservingOptionNew
                               context:nil];
    }
}
- (void)removeObserverForSuperView
{
    if (self.mV_superView) {
        [self.mV_superView removeObserver:self forKeyPath:@"contentOffset" context:nil];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // Drawing code
    
    CGFloat allWidth = rect.size.width;
    CGFloat halfWidth = allWidth / 2.0;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    if ([self isDirectionDown]) {
        
        [gUI_main_backgroundColor setFill];
        CGFloat circleY = rect.size.height+self.offsetY+kRadius+view_Height;
        [path moveToPoint:CGPointMake(0, rect.size.height)];
        CGPoint leftCp1 = CGPointMake(lerp(0, halfWidth-kRadius, 0.4), lerp(circleY, circleY-self.offsetY-view_Height, 0.6));
        CGPoint leftCp2 = CGPointMake(lerp(0, halfWidth-kRadius, 1), lerp(circleY, circleY-self.offsetY-view_Height, 0.6));
        [path addCurveToPoint:CGPointMake(halfWidth-kRadius, circleY) controlPoint1:leftCp1 controlPoint2:leftCp2];
        [path addArcWithCenter:CGPointMake(CGRectGetMidX(rect), circleY) radius:kRadius startAngle:-M_PI endAngle:0 clockwise:YES];
        CGPoint rightCp1 = CGPointMake(lerp(allWidth, halfWidth+kRadius, 0.4), lerp(circleY, circleY-self.offsetY-view_Height, 0.6));
        CGPoint rightCp2 = CGPointMake(lerp(allWidth, halfWidth+kRadius, 1), lerp(circleY, circleY-self.offsetY-view_Height, 0.6));
        [path addCurveToPoint:CGPointMake(allWidth, rect.size.height) controlPoint1:rightCp2 controlPoint2:rightCp1];
        [path addLineToPoint:CGPointMake(0, rect.size.height)];
        [path closePath];
        [path fill];
    }
    if ([self isDirectionUp]) {
        
        
        [gUI_setting_backgroundColor setFill];
        CGFloat circleY = self.offsetY - kRadius - view_Height;;
        [path moveToPoint:CGPointMake(0, 0)];
        CGPoint leftCp1 = CGPointMake(lerp(0, halfWidth-kRadius, 0.4), lerp(0, circleY, 0.1));
        CGPoint leftCp2 = CGPointMake(lerp(0, halfWidth-kRadius, 1), lerp(0, circleY, 0.0));
        [path addCurveToPoint:CGPointMake(halfWidth-kRadius, circleY) controlPoint1:leftCp1 controlPoint2:leftCp2];
        [path addArcWithCenter:CGPointMake(CGRectGetMidX(rect), circleY) radius:kRadius startAngle:M_PI endAngle:0 clockwise:NO];
        CGPoint rightCp1 = CGPointMake(lerp(allWidth, halfWidth+kRadius, 1), lerp(0, circleY, 0.0));
        CGPoint rightCp2 = CGPointMake(lerp(allWidth, halfWidth+kRadius, 0.4), lerp(0, circleY, 0.1));
        [path addCurveToPoint:CGPointMake(allWidth, 0) controlPoint1:rightCp1 controlPoint2:rightCp2];
        [path addLineToPoint:CGPointMake(0, 0)];
        [path closePath];
        [path fill];
    }
}

@end
