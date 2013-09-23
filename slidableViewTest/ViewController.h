//
//  ViewController.h
//  slidableViewTest
//
//  Created by HouKang on 13/8/27.
//  Copyright (c) 2013年 arplanet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    UIViewController* leftViewController;
    UIViewController* rightViewController;
    UIViewController* middleViewController;
    float oldX, oldY;
    BOOL isRunning;
    float currentTimes;
}

@end
