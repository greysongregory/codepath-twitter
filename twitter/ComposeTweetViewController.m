//
//  ComposeTweetViewController.m
//  twitter
//
//  Created by Greyson Gregory on 11/9/15.
//  Copyright © 2015 Grey. All rights reserved.
//

#import "ComposeTweetViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "Tweet.h"

@interface ComposeTweetViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UITextView *tweetText;

@end

@implementation ComposeTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    User *currentUser = [User currentUser];
    [self.profileImage setImageWithURL:[NSURL URLWithString:currentUser.profileImageUrl]];
    self.username.text = currentUser.name;
    
    if (self.tweet != nil ) {
        self.tweetText.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    }
    self.tweetText.delegate = self;
    [self.tweetText becomeFirstResponder];

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(didCancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(didTweet)];
    
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
- (void)didCancel {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didTweet {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:self.tweetText.text forKey:@"status"];
    
    if (self.tweet != nil) {
        [params setObject:self.tweet.tweetID forKey:@"in_reply_to_status_id"];
    }
    
    [[TwitterClient sharedInstance] tweetWithParams:params completion:^(NSError *error) {
        if (error != nil) {
            NSLog(@"error posting tweet %@", error);
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self.tweetText becomeFirstResponder];
}

@end
