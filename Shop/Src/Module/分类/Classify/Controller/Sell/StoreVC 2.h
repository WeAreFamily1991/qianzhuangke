//
//  StoreVC.h
//  Shop
//
//  Created by BWJ on 2019/3/9.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreVC : STBaseViewController
@property(nonatomic,assign)NSInteger num;
//店铺id
@property (nonatomic , copy) NSString *GroupID;
@end

NS_ASSUME_NONNULL_END
