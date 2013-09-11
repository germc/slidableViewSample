//
//  SlidableView.h
//  slidableViewTest
//
//  Created by HouKang on 13/9/5.
//  Copyright (c) 2013年 arplanet. All rights reserved.
//

#import <Foundation/Foundation.h>

//不同狀態
//typedef是把型別名稱取別名
typedef enum HHSlidaleViewModes{
    slideToRight = 0,
    slideToLeft,
    slideToCenter
} hhSlidableViewMode;


@interface SlidableView : NSObject{
    
    hhSlidableViewMode _currentMode;
    UIPanGestureRecognizer *_panGestureRecognizer;
    CGPoint originalOrigin;
    CGPoint currentOrigin;
    CGPoint lastOrigin;
    CGPoint lastTranslation;
    BOOL isAnimationRunning;
}

@property (retain,nonatomic) UIView* view;

-(id) initWithView:(UIView*)targetView;
- (void) rightButtonTapped;
- (void) leftButtonTapped;
@end
