//
//  DRPinpaiVC.h
//  Shop
//
//  Created by BWJ on 2019/4/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CRDetailModel;
@interface DRPinpaiVC : STBaseViewController
@property(nonatomic,assign)NSInteger num;
@property(nonatomic,retain)CRDetailModel *detailModel;
@end

NS_ASSUME_NONNULL_END
