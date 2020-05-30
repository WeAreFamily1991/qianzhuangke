//
//  DRPinPaiDetailVC.h
//  Shop
//
//  Created by BWJ on 2019/4/26.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CRDetailModel;
@interface DRPinPaiDetailVC : STBaseViewController
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,retain)CRDetailModel *detailModel;
@end

NS_ASSUME_NONNULL_END
