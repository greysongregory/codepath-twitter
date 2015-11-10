//
//  TweetDetailsViewController.h
//  twitter
//
//  Created by Greyson Gregory on 11/9/15.
//  Copyright © 2015 Grey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
@class TweetDetailsViewController;

@protocol TweetDetailsDelegate <NSObject>
- (void)retweet:(Tweet *) tweet;
- (void)reply:(Tweet*) tweet withReplyText:(NSString *)text;
- (void)favorite:(Tweet *) tweet;

- (void)tweetDetailsViewController:(TweetDetailsViewController *) tweetDetailsViewController withTweet:(Tweet*)tweet;
@end

@interface TweetDetailsViewController : UIViewController
@property (strong, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *timestamp;


@property (nonatomic, weak) id<TweetDetailsDelegate> delegate;
@end
