//
//  SlidableView.m
//  slidableViewTest
//
//  Created by HouKang on 13/9/5.
//  Copyright (c) 2013年 arplanet. All rights reserved.
//

#import "SlidableView.h"

@implementation SlidableView
-(id) initWithView:(UIView*)targetView{
    self = [super init];
    if (self) {
        self.view = targetView;
        [self _setAugments];
        [self _addPanGesture];
    }
    return self;
}

-(void)_setAugments{
    originalOrigin = self.view.frame.origin;
    currentOrigin = self.view.frame.origin;
    lastOrigin = self.view.frame.origin;
    isAnimationRunning = NO;
}

-(void)_addPanGesture{
    //手勢中的initWithTarget代表你的action放置的位置
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(_actWithPanGesture:)];
    [self.view addGestureRecognizer:_panGestureRecognizer];
}

-(void)_actWithPanGesture:(UIPanGestureRecognizer*)panGesture{
    
    currentOrigin = self.view.frame.origin;
    CGPoint translation = [panGesture translationInView:panGesture.view];
    //The velocity of the pan gesture, which is expressed in points per second. The velocity is broken into horizontal and vertical components.
    CGPoint velocity = [panGesture velocityInView:panGesture.view];
    NSLog(@"translationX%f",translation.x);
    NSLog(@"currentOrigin.X%f",currentOrigin.x);
    NSLog(@"velocity.X%f",velocity.x);

    if (!isAnimationRunning) {
        
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            
            if (velocity.x<900.0&&velocity.x>-900.0) {
                self.view.frame = CGRectMake(currentOrigin.x+translation.x-lastTranslation.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
            }else{
                
                if (translation.x > lastTranslation.x) {
                    if (self.view.frame.origin.x<0.0) {
                        [self _moveViewByMode:slideToCenter withDuration:0.3];
                    }else{
                        [self _moveViewByMode:slideToRight withDuration:0.3];
                    }
                }else{
                    if (self.view.frame.origin.x>0.0) {
                        [self _moveViewByMode:slideToCenter withDuration:0.3];
                    }else{
                        [self _moveViewByMode:slideToLeft withDuration:0.3];
                    }

                }
    
            }
            
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            
            if (self.view.frame.origin.x>self.view.frame.size.width/2.0) {
                [self _moveViewByMode:slideToRight withDuration:0.5];
            }else if(self.view.frame.origin.x<-self.view.frame.size.width/2.0) {
                [self _moveViewByMode:slideToLeft withDuration:0.5];
            }else{
                [self _moveViewByMode:slideToCenter withDuration:0.5];
            }
            //替換lastPoint
            lastOrigin = self.view.frame.origin;
            break;
        default:
            break;
    }
    }
    lastTranslation = translation;
}

- (void)_moveViewByMode:(hhSlidableViewMode)mode withDuration:(float)duration {
    isAnimationRunning = YES;
    switch (mode) {
        case slideToRight:
            
            [UIView animateWithDuration:duration animations:^{
                self.view.frame = CGRectMake(270.0, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
            } completion:^(BOOL finished) {
                isAnimationRunning = NO;
            }];
            break;
        case slideToCenter:
            [UIView animateWithDuration:duration animations:^{
                self.view.frame = CGRectMake(0.0, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
            } completion:^(BOOL finished) {
                isAnimationRunning = NO;
            }];
            break;
        case slideToLeft:
            [UIView animateWithDuration:duration animations:^{
                self.view.frame = CGRectMake(-270.0, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
            } completion:^(BOOL finished) {
                isAnimationRunning = NO;
            }];
            break;
        default:
            isAnimationRunning = NO;
            break;
    }
}

-(void)rightButtonTapped{
    if (!isAnimationRunning) {
        if (!self.view.frame.origin.x == 0.0) {
            [self _moveViewByMode:slideToCenter withDuration:0.3];
        }else{
            isAnimationRunning = YES;
            [UIView animateWithDuration:0.3 animations:^{
                self.view.frame = CGRectMake(-280.0, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.view.frame = CGRectMake(-270.0, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                } completion:^(BOOL finished) {
                }];
                isAnimationRunning = NO;
            }];
        }
    }
}
-(void)leftButtonTapped{
    if (!isAnimationRunning) {
        if (!self.view.frame.origin.x == 0.0) {
            [self _moveViewByMode:slideToCenter withDuration:0.3];
        }else{
            isAnimationRunning = YES;
            [UIView animateWithDuration:0.3 animations:^{
                self.view.frame = CGRectMake(280.0, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.view.frame = CGRectMake(270.0, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                } completion:^(BOOL finished) {
                }];
                isAnimationRunning = NO;
            }];
        }
    }
    
}

@end
