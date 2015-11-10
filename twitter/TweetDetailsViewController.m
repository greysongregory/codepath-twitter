//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Greyson Gregory on 11/9/15.
//  Copyright © 2015 Grey. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "ComposeTweetViewController.h"


@interface TweetDetailsViewController ()

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.image setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    self.username.text = self.tweet.user.name;
    self.tweetText.text = self.tweet.text;
    

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];

    self.timestamp.text = [formatter stringFromDate:self.tweet.createdAt];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(didCancel)];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didRetweet:(id)sender {
    NSDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:self.tweet.tweetID forKey:@"id"];
    [[TwitterClient sharedInstance] retweetWithParams:dictionary completion:^(NSError *error) {
        if (error != nil ) {
            NSLog(@"error retweeting %@", error);
        } else {
            NSLog(@"success retweeting");
        }
    }];
}

- (IBAction)didReply:(id)sender {
    ComposeTweetViewController *vc = [[ComposeTweetViewController alloc] init];
    vc.tweet = self.tweet;
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nvc animated:YES completion:nil];
}

- (IBAction)didFavorite:(id)sender {
    NSDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:self.tweet.tweetID forKey:@"id"];
    [[TwitterClient sharedInstance] favoriteWithParams:dictionary completion:^(NSError *error) {
        if (error != nil ) {
            NSLog(@"error favoriting %@", error);
        } else {
            NSLog(@"success favoriting");
        }
    }];
}

@end
