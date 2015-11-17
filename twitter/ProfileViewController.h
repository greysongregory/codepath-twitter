//
//  ProfileViewController.h
//  twitter
//
//  Created by Greyson Gregory on 11/16/15.
//  Copyright © 2015 Grey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileViewController : UIViewController
-(id) initWithUser:(User*)user;
@end
