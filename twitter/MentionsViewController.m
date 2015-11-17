//
//  MentionsViewController.m
//  twitter
//
//  Created by Greyson Gregory on 11/16/15.
//  Copyright © 2015 Grey. All rights reserved.
//

#import "MentionsViewController.h"
#import "User.h"
#import "Tweet.h"
#import "TwitterClient.h"
#import "TweetTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "TweetDetailsViewController.h"

@interface MentionsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *tweetsArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MentionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (self) {
        [[TwitterClient sharedInstance] mentionsTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
            for (Tweet *tweet in tweets) {
                NSLog(@"text: %@", tweet.text);
            }
            self.tweetsArray = [[NSMutableArray alloc] initWithArray:tweets];
            [self.tableView reloadData];
        }];
    }

    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    navBar.translucent = NO;
    navBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    navBar.backgroundColor = [UIColor blueColor];

    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    navItem.title = @"Mentions";
    
    navBar.items = @[ navItem ];

    [self.view addSubview:navBar];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"MentionsCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200.0;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MentionsCell"];
    Tweet *tweet = self.tweetsArray[indexPath.row];
    [cell.profileImage setImageWithURL:[NSURL URLWithString: tweet.user.profileImageUrl]];
    //    cell.profileImage = [NSURL URLWithString: ((Tweet*)self.tweetsArray[indexPath.row]).user.profileImageUrl] ;
    cell.tweetText.text = tweet.text;
    cell.username.text = tweet.user.name;
    long secondsSinceTweet = [tweet.createdAt timeIntervalSinceNow];
    cell.timestamp.text = [[NSString alloc] initWithFormat:@"%1.2f h", -secondsSinceTweet/60.0/60.0];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [[TwitterClient sharedInstance] mentionsTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        for (Tweet *tweet in tweets) {
            NSLog(@"text: %@", tweet.text);
        }
        self.tweetsArray = [[NSMutableArray alloc] initWithArray:tweets];
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *tweet = self.tweetsArray[indexPath.row];
    [self tweetDetailsViewController:nil withTweet:tweet];
}

- (void)tweetDetailsViewController:(TweetDetailsViewController *) tweetDetailsViewController withTweet:(Tweet*)tweet {
    TweetDetailsViewController *vc = [[TweetDetailsViewController alloc] init];
    vc.tweet = tweet;
    //    [vc.image setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    //    vc.username.text = tweet.user.name;
    //    vc.tweetText.text = tweet.text;
    //
    //    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"EEE, MMM/d/yyy HH:mm:ss"];
    //    vc.timestamp.text = [tweet.createdAt descriptionWithLocale:locale];
    
    vc.delegate = self;
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nvc animated:YES completion:nil];
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

@end
