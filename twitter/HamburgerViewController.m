    //
//  HamburgerViewController.m
//  twitter
//
//  Created by Greyson Gregory on 11/16/15.
//  Copyright © 2015 Grey. All rights reserved.
//

#import "HamburgerViewController.h"

@interface HamburgerViewController ()
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;

@property (nonatomic) CGFloat originalLeftMargin;

@end

@implementation HamburgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view autoresizesSubviews];
    [self.contentView autoresizesSubviews];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPanGesture:(UIPanGestureRecognizer*)sender {
    //these need to use self.contentView ?
    CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.originalLeftMargin = self.leftMarginConstraint.constant;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        self.leftMarginConstraint.constant = self.originalLeftMargin + translation.x;
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:.3 animations:^{
            if (velocity.x > 0) {
                self.leftMarginConstraint.constant = self.view.frame.size.width - 50;
            } else {
                self.leftMarginConstraint.constant = 0;
            }
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)setMenuViewController:(UIViewController *)menuViewController {
    [self willChangeValueForKey:@"menuViewController"];
    _menuViewController = menuViewController;
    [self.view layoutIfNeeded];
    
    if(_menuViewController != nil) {
        
    }
    
    [self.menuView addSubview:menuViewController.view];
    [self didChangeValueForKey:@"menuViewController"];
}

- (void)setContentViewController:(UIViewController *)contentViewController {
    [self.view layoutIfNeeded];

    if (_contentViewController != nil) {
        [_contentViewController willMoveToParentViewController:nil];
        [_contentViewController.view removeFromSuperview];
        [_contentViewController didMoveToParentViewController:nil];
    }
    
    _contentViewController = contentViewController;

    [self.contentViewController willMoveToParentViewController:self];
    [self.contentView addSubview:contentViewController.view];
    [self.contentViewController didMoveToParentViewController:self];
    //[self.contentViewController ];
    
    [self.contentViewController viewDidLayoutSubviews];
    [self viewDidLayoutSubviews];
    [self.contentViewController.view layoutIfNeeded];

    
    [UIView animateWithDuration:.3 animations:^{
        self.leftMarginConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    if ([[change objectForKey:NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
//        return;
//    } else {
//        //read the change dictionary, and have fun :)
//    }
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
