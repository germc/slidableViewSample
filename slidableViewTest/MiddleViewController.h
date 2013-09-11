//
//  MiddleViewController.h
//  slidableViewTest
//
//  Created by HouKang on 13/8/28.
//  Copyright (c) 2013年 arplanet. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SlidableView;
@interface MiddleViewController : UIViewController{
    SlidableView* sliableViewPlugIn;
}
- (IBAction)rightButtonTapped:(id)sender;

- (IBAction)leftButtonTapped:(id)sender;
@end
