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
        NSLog(@">>>>>>>price is changed");
        NSLog(@"old price is %@",[change objectForKey:@"old"]);
        NSLog(@"new price is %@",[change objectForKey:@"new"]);
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

-(void) initializeTimer{
    //設定Timer觸發的頻率，每秒30次
    float theInterval = 1.0/3.0;
    currentTimes = 0.0;
    //正式啟用Timer，selector是設定Timer觸發時所要呼叫的函式
    //theTimer是NSTimer型態的指標，用來存放當前的計時器狀態
    theTimer = [NSTimer scheduledTimerWithTimeInterval:theInterval
                                                target:self
                                              selector:@selector(countTotalFrames)
                                              userInfo:nil
                                               repeats:YES];
}
-(void)countTotalFrames{
    frame.origin.x = [self positionBySHMWithTimes:currentTimes withSeconds:20.0];
    middleViewController.view.frame = frame;
    currentTimes = currentTimes + 1.0;
}
-(float)positionBySHMWithTimes:(float)times withSeconds:(float)seconds{
    if (times<=30.0*seconds) {
        return cosf(M_PI/seconds)*seconds;
    }
    return 0.0;
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
    
//    [middleViewController touchesMoved:touches withEvent:event];
//
//    frame = middleViewController.view.frame;
//    if (frame.origin.x + touchLocation.x - oldX>=-frame.size.width+30.0 && frame.origin.x + touchLocation.x - oldX <= frame.size.width-30.0) {
//        frame.origin.x = frame.origin.x + touchLocation.x - oldX;
//    }
//    //frame.origin.y =  rightViewController.view.frame.origin.y + touchLocation.y - oldY;
//    middleViewController.view.frame = frame;
//    NSLog(@"%f",frame.origin.x);
    oldX = touchLocation.x;
    oldY = touchLocation.y;
    

}
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//
//    CGFloat duration = 0.3f;
//    CGFloat delay = 0.0f;
//    if (middleViewController.view.center.x > middleViewController.view.frame.size.width) {
//        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
//            middleViewController.view.frame = CGRectMake(300.0, 0.0, 320.0, 460.0);
//        } completion:^(BOOL finished) {
//            
//        }];
//    }else if(middleViewController.view.center.x > 0.0){
//        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
//            middleViewController.view.frame = CGRectMake(0.0, 0.0, 320.0, 460.0);
//        } completion:^(BOOL finished) {
//            
//        }];
//    }else if(middleViewController.view.center.x < 0.0){
//        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
//            middleViewController.view.frame = CGRectMake(-300.0, 0.0, 320.0, 460.0);
//        } completion:^(BOOL finished) {
//            
//        }];
//    }
//}

@end
