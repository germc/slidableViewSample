//
//  ViewController.m
//  slidableViewTest
//
//  Created by HouKang on 13/8/27.
//  Copyright (c) 2013年 arplanet. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "LeftViewController.h"
#import "RightViewController.h"
#import "MiddleViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    leftViewController = [[LeftViewController alloc]init];
    [self addChildViewController:leftViewController];
    [self willMoveToParentViewController:nil];
    //rightViewController = [[RightViewController alloc]initWithNibName:@"rightViewController" bundle:nil];
    rightViewController = [[RightViewController alloc]init];
    [self addChildViewController:rightViewController];
    
    //rightViewController.view.frame = CGRectMake(0.0, 0.0, 300.0, 568.0);
    [self.view addSubview:leftViewController.view];
    //leftViewController.view.frame = CGRectMake(20.0, 0.0, 300.0, 568.0);
    [self.view addSubview:rightViewController.view];
    
    middleViewController = [[MiddleViewController alloc]init];
    [self addChildViewController:middleViewController];
    [self.view addSubview:middleViewController.view];
    
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [middleViewController.view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [middleViewController.view removeObserver:self forKeyPath:@"frame"];
    [super viewWillDisappear:animated];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    NSLog(@"KVO is trigged");
    if([keyPath isEqual:@"frame"]){
        
        CGRect oldFrame = [[change objectForKey:@"old"]CGRectValue];
        CGRect newFrame = [[change objectForKey:@"new"]CGRectValue];
        
        float diff = newFrame.origin.x - oldFrame.origin.x;
        NSLog(@"diff:%f",diff);
        
        if (diff>0.0 && middleViewController.view.frame.origin.x>0.0) {
            //調整中間視窗左右移動時，背後視窗的順序
            [self.view bringSubviewToFront:rightViewController.view];
            [self.view bringSubviewToFront:middleViewController.view];
            //製造漸亮的效果
            float rightViewAlpha = 0.5+(middleViewController.view.frame.origin.x / 320.0);
            rightViewController.view.alpha = rightViewAlpha;
            leftViewController.view.alpha = 0.0;
        }else if(diff<=0.0 && middleViewController.view.frame.origin.x<0.0){
            [self.view bringSubviewToFront:leftViewController.view];
            [self.view bringSubviewToFront:middleViewController.view];
            float leftViewAlpha = 0.5+(-middleViewController.view.frame.origin.x / 320.0);
            leftViewController.view.alpha = leftViewAlpha;
            rightViewController.view.alpha = 0.0;
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    oldX = touchLocation.x;
    oldY = touchLocation.y;
    
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];

    
    //NSLog(@"%f",touchLocation.x);
    float diff = touchLocation.x - oldX;
    if (diff>0.0 && middleViewController.view.frame.origin.x>0.0) {
        [self.view bringSubviewToFront:rightViewController.view];
        [self.view bringSubviewToFront:middleViewController.view];
    }else if(diff<=0.0 && middleViewController.view.frame.origin.x<0.0){
        [self.view bringSubviewToFront:leftViewController.view];
        [self.view bringSubviewToFront:middleViewController.view];
    }
    
    oldX = touchLocation.x;
    oldY = touchLocation.y;
    

}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
}

@end
