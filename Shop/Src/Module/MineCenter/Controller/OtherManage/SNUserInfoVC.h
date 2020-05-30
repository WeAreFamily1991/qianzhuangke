//
//  SNUserInfoVC.h
//  FaceCook
//
//  Created by Murphy on 15/10/30.
//  Copyright (c) 2015年 scinan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNUser;

@interface SNUserInfoVC : UITableViewController

@property (nonatomic, strong) SNUser *user;

@property (nonatomic, copy) void (^changeInfo)();

@end
