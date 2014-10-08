//
//  SCHCricleViewCell.m
//  SCHCricleView
//
//  Created by 魏巍 on 12-11-10.
//  Copyright (c) 2012年 sch. All rights reserved.
//

#import "SCHCircleViewCell.h"

@interface SCHCircleViewCell(private)


@end

@implementation SCHCircleViewCell
@synthesize delete_button            = _delete_button;

@synthesize view_rect                = _view_rect;
@synthesize scale                    = _scale;
@synthesize view_point               = _view_point;
@synthesize radian                   = _radian;
@synthesize animation_radian         = _animation_radian;

@synthesize current_radian           = _current_radian;
@synthesize current_animation_radian = _current_animation_radian;
@synthesize current_scale            = _current_scale;

@synthesize delegate                 = _delegates;
#pragma mark -
#pragma mark - 初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    if(nil !=  _delete_button)
    {
        
    }
    
    /*增加长点击事件*/
    UILongPressGestureRecognizer *long_press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressedLong:)];
    [self addGestureRecognizer:long_press];
    
    /*增加单击事件*/
    UITapGestureRecognizer *single_tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleSingleTap:)] ;
    single_tap.numberOfTapsRequired    = 1;
    single_tap.cancelsTouchesInView    = NO;
    single_tap.numberOfTouchesRequired = 1;
    single_tap.delegate                = self;
    [self addGestureRecognizer: single_tap];
    
    /*增加拖动事件*/
    UIPanGestureRecognizer *single_pan = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(handleSinglePan:)] ;
    single_pan.cancelsTouchesInView    = NO;
    single_pan.delegate                = self;
    [self addGestureRecognizer: single_pan];
}


#pragma mark -
#pragma mark - 长按
- (void) pressedLong:(UILongPressGestureRecognizer *) gestureRecognizer
{
    
    CGPoint point;
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            point = [gestureRecognizer locationInView:self];
            // [_delegate gridDidEnterMoveMode:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            //放大这个item
            break;
        case UIGestureRecognizerStateEnded:
            point = [gestureRecognizer locationInView:self];
            // [_delegate gridDidEndMoved:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            //变回原来大小
            
            break;
        case UIGestureRecognizerStateFailed:
            
            break;
        case UIGestureRecognizerStateCancelled:
            
            point = [gestureRecognizer locationInView:self];
            // [_delegate gridDidEndMoved:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            break;
            
        case UIGestureRecognizerStateChanged:
            //移动
            point = [gestureRecognizer locationInView:self];
            //   [_delegate gridDidMoved:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            break;
            
        default:

            break;
    }
    //CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
}

#pragma mark -
#pragma mark - 单击
- (void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            
            [_delegates cellTouchBegin:self];
            break;
        case UIGestureRecognizerStateEnded:
            [_delegates cellTouchEnd:self];
            break;
        case UIGestureRecognizerStateFailed:
            [_delegates cellTouchFailed:self];
            break;
        case UIGestureRecognizerStateCancelled:
            [_delegates cellTouchCancelled:self];
            break;
        case UIGestureRecognizerStateChanged:

            break;
        default:

            break;
    }
    
}

#pragma mark - 拖动
- (void)handleSinglePan:(UIPanGestureRecognizer *)gestureRecognizer
{
    
    CGPoint point;
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            point = [gestureRecognizer locationInView:self];
            [_delegates cellDidEnterMoveMode:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            
            break;
        case UIGestureRecognizerStateEnded:
            point = [gestureRecognizer locationInView:self];
            [_delegates cellDidEndMoved:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            
            break;
        case UIGestureRecognizerStateFailed:

            point = [gestureRecognizer locationInView:self];
            [_delegates cellDidFailMoved:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            break;
        case UIGestureRecognizerStateCancelled:
            point = [gestureRecognizer locationInView:self];
            [_delegates cellDidCancelMoved:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            break;
        case UIGestureRecognizerStateChanged:
            //移动
            point = [gestureRecognizer locationInView:self];
            [_delegates cellDidMoved:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            break;
        default:
            
            break;
    }
}

#pragma mark -
#pragma mark - dealloc 
- (void)dealloc
{
    
}

#pragma mark -
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 过滤掉UIButton，也可以是其他类型
    if ( [touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    
    return YES;
}

@end
