//
//  User.h
//  twitter
//
//  Created by Greyson Gregory on 11/9/15.
//  Copyright © 2015 Grey. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDidLoginNotification;
extern NSString * const UserDidLogoutNotification;

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *tagline;
@property (nonatomic, strong) NSString *profileBackgroundImangeUrl;
@property (nonatomic, strong) NSString *tweetCount;
@property (nonatomic, strong) NSString *followingCount;
@property (nonatomic, strong) NSString *followersCount;
@property (nonatomic, strong) NSString *userId;

-(id) initWithDictionary:(NSDictionary *)dictionary;

+ (User *)currentUser;
+ (void)setCurrentUser:(User *)currentUser;

+(void)logout;
@end
