//
//  DRUserInfoVC.h
//  Shop
//
//  Created by BWJ on 2019/3/4.
//  Copyright © 2019 SanTie. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "DRUserInfoModel.h"

@interface DRUserInfoVC : STBaseViewController

//@property (nonatomic, strong) DRUserInfoModel *userModel;

@property (nonatomic, copy) void (^changeInfo)();
@end
