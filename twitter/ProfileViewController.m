//
//  ProfileViewController.m
//  twitter
//
//  Created by Greyson Gregory on 11/16/15.
//  Copyright © 2015 Grey. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"


@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *tweetsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileFollowingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileFollowersCountLabel;

@property (strong, nonatomic) User *currentUser;
@end

@implementation ProfileViewController
- (id)init
{
    return [self initWithUser:[User currentUser]];
}

-(id) initWithUser:(User*)user {
    self = [super init];
    if (self) {
        self.currentUser = user;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //User *currentUser = [User currentUser];
    [self.backgroundImageView setImageWithURL:[NSURL URLWithString:self.currentUser.profileBackgroundImangeUrl]];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.currentUser.profileImageUrl]];
    self.profileNameLabel.text = self.currentUser.name;
    self.tweetsCountLabel.text = self.currentUser.tweetCount;
    self.profileFollowingCountLabel.text = self.currentUser.followingCount;
    self.profileFollowersCountLabel.text = self.currentUser.followersCount;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(didCancel)];

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

@end
