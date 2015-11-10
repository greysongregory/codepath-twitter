//
//  TwitterClient.h
//  twitter
//
//  Created by Greyson Gregory on 11/9/15.
//  Copyright © 2015 Grey. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openURL:(NSURL *)url;

- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;

- (void)tweetWithParams:(NSDictionary *)params completion:(void (^)(NSError *error))completion;

- (void)retweetWithParams:(NSDictionary *)params completion:(void (^)(NSError *error))completion;

- (void)favoriteWithParams:(NSDictionary *)params completion:(void (^)(NSError *error))completion;

@end
