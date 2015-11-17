//
//  MenuViewController.h
//  twitter
//
//  Created by Greyson Gregory on 11/16/15.
//  Copyright © 2015 Grey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HamburgerViewController.h"

@interface MenuViewController : UIViewController
@property (strong,nonatomic) NSArray *viewControllers;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) HamburgerViewController *hamburgerViewController;

@end
