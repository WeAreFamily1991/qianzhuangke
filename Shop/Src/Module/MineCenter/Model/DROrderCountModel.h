//
//  DROrderCountModel.h
//  Shop
//
//  Created by rockding on 2019/12/4.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DROrderCountModel : DRBaseModel
@property (nonatomic , assign) NSInteger              arrivalNotice;
@property (nonatomic , assign) NSInteger              seller;
@property (nonatomic , assign) NSInteger              waitDeliver;
@property (nonatomic , assign) NSInteger              waitingReceived;
@property (nonatomic , assign) NSInteger              waitPayment;
@property (nonatomic , assign) NSInteger              voucherCount;
@property (nonatomic , assign) NSInteger              complete;
@property (nonatomic , assign) NSInteger              waitConfirm;
@property (nonatomic , assign) NSInteger              afterSaleCount;
@property (nonatomic , assign) NSInteger              item;
@end

NS_ASSUME_NONNULL_END
