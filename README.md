slidableViewTest
=======================
project: slidableViewTest<br/>
Author: Harvey Hu<br/>
URL: https://github.com/HarveyHu/slidableViewTest<br/>
License: the MIT license.<br/>

###About slidableViewTest
You can make a slidableView like FaceBook by this sample.<br/><br/>

You should import SlidableView.h & SlidableView.m to your project.<br/>
To make your view as SlidableView in your app by following code:<br/>
```Objective-C
.h file
#import <UIKit/UIKit.h>
@class SlidableView;
@interface MiddleViewController : UIViewController{
    SlidableView* sliableViewPlugIn;
}
- (IBAction)rightButtonTapped:(id)sender;

- (IBAction)leftButtonTapped:(id)sender;


.m file
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
```
###Info
