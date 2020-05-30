//
//  DRShouKuanChildVC.h
//  Shop
//
//  Created by BWJ on 2019/7/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SalesOrderModel;
NS_ASSUME_NONNULL_BEGIN

@interface DRShouKuanChildVC : STBaseViewController
@property(nonatomic,assign)NSInteger fatherStatus;
@property (strong , nonatomic)SalesOrderModel *saleModel;
@end

NS_ASSUME_NONNULL_END
