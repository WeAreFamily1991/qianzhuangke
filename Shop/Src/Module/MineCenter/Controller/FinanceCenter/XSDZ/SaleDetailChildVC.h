//
//  SaleDetailChildVC.h
//  Shop
//
//  Created by BWJ on 2019/3/1.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SalesOrderModel;
NS_ASSUME_NONNULL_BEGIN

@interface SaleDetailChildVC : STBaseViewController
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,assign)NSInteger fatherStatus;
@property (strong , nonatomic)SalesOrderModel *saleModel;
@end

NS_ASSUME_NONNULL_END
