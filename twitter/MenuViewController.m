//
//  MenuViewController.m
//  twitter
//
//  Created by Greyson Gregory on 11/16/15.
//  Copyright © 2015 Grey. All rights reserved.
//

#import "MenuViewController.h"
#import "HamburgerViewController.h"
#import "TweetsViewController.h"
#import "ProfileViewController.h"
#import "MentionsViewController.h"


@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIViewController *homeTimelineNavigationController;

@property (strong, nonatomic) UIViewController *profileNavigationController;

@property (strong, nonatomic) UIViewController *mentionsNavigationController;


@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.homeTimelineNavigationController = [[TweetsViewController alloc] init];

    //replace below with newly constructed view controllers:
    self.profileNavigationController = [[ProfileViewController alloc] init];
    
    self.mentionsNavigationController = [[MentionsViewController alloc] init];
    
    self.viewControllers = [[NSArray alloc] initWithObjects:self.profileNavigationController, self.homeTimelineNavigationController, self.mentionsNavigationController, nil];
    
    self.hamburgerViewController.contentViewController = self.homeTimelineNavigationController;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuCell" bundle:nil] forCellReuseIdentifier:@"MenuCell"];

    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewControllers.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    
    NSArray *titles = [[NSArray alloc] initWithObjects:@"Profile", @"Timeline", @"Mentions", nil];
    cell.textLabel.text = titles[indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.hamburgerViewController.contentViewController = self.viewControllers[indexPath.row];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
