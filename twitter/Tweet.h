//
//  Tweet.h
//  twitter
//
//  Created by Greyson Gregory on 11/9/15.
//  Copyright © 2015 Grey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *tweetID;

-(id) initWithDictionary:(NSDictionary *)dictionary;

+(NSArray *)tweetsWithArray: (NSArray*) array;

@end
