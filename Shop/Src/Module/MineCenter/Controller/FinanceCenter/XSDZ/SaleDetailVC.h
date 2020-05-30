//
//  SaleDetailVC.h
//  Shop
//
//  Created by BWJ on 2019/3/1.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalesOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SaleDetailVC : STBaseViewController
@property(nonatomic,assign)NSInteger num;
@property(nonatomic,assign)NSInteger fatherStatus;
@property (strong , nonatomic)SalesOrderModel *saleModel;
@end

NS_ASSUME_NONNULL_END
