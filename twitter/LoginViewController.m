//
//  LoginViewController.m
//  twitter
//
//  Created by Greyson Gregory on 11/9/15.
//  Copyright © 2015 Grey. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetsViewController.h"
#import "HamburgerViewController.h"
#import "MenuViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            // modally present tweets view
            NSLog(@"Welcome to %@", user.name);
            HamburgerViewController *hamburgerViewController = [HamburgerViewController new];
            // may neec for handling changes to view controller events:
            //[HamburgerViewController addObserver:self forKeyPath:@"menuViewController" options:NSKeyValueObservingOptionNew context:nil];
            
            MenuViewController *menuViewController = [[MenuViewController alloc] init];
            
            menuViewController.hamburgerViewController = hamburgerViewController;
            
            hamburgerViewController.menuViewController = menuViewController;
            
            [menuViewController.tableView reloadData];
            
           // self.window.rootViewController = hamburgerViewController;

            [self presentViewController:hamburgerViewController animated:YES completion:nil];
            
            [User currentUser];
        } else {
            // present error view
        }
    }];
    
}

@end
