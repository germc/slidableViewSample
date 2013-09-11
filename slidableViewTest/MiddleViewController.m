//
//  MiddleViewController.m
//  slidableViewTest
//
//  Created by HouKang on 13/8/28.
//  Copyright (c) 2013年 arplanet. All rights reserved.
//

#import "MiddleViewController.h"
#import "SlidableView.h"
@interface MiddleViewController ()

@end

@implementation MiddleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    sliableViewPlugIn = [[SlidableView alloc]initWithView:self.view];
    self.view = sliableViewPlugIn.view;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rightButtonTapped:(id)sender {
    [sliableViewPlugIn rightButtonTapped];
}

- (IBAction)leftButtonTapped:(id)sender {
    [sliableViewPlugIn leftButtonTapped];
}
@end
