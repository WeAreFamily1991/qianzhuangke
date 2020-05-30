//
//  DetailOrdervc.h
//  Shop
//
//  Created by BWJ on 2019/3/19.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailOrdervc : STBaseViewController
@property (nonatomic,retain)OrderModel *orderModel;
@property (nonatomic,retain)NSString *orderID;
@property (strong ,nonatomic)dispatch_block_t detailSourceBlock;
@end

NS_ASSUME_NONNULL_END
