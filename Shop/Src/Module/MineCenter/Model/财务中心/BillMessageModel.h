//
//  BillMessageModel.h
//  Shop
//
//  Created by BWJ on 2019/3/27.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BillMessageModel : NSObject
@property (nonatomic , copy) NSString              * checkUserId;
@property (nonatomic , copy) NSString              * invoiceType;
@property (nonatomic , copy) NSString              * fpParty;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , copy) NSString              * checkTime;
@property (nonatomic , copy) NSString              * checkUser;
@property (nonatomic , copy) NSString              * applyTime;
@property (nonatomic , copy) NSString              * compId;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , copy) NSString              * invoiceAddress;
@property (nonatomic , copy) NSString              * receiverAddress;
@property (nonatomic , copy) NSString              * invoiceNo;
@property (nonatomic , copy) NSString              * message_id;
@property (nonatomic , copy) NSString              * applyNo;
@property (nonatomic , assign) double              invoiceAmt;
@property (nonatomic , copy) NSString              * invoiceTel;
@property (nonatomic , copy) NSString              * receiverPhone;
@property (nonatomic , copy) NSString              * receiverName;
@property (nonatomic , copy) NSString              * expressNo;
@property (nonatomic , copy) NSString              * rejectReason;
@property (nonatomic , copy) NSString              * taxNo;
@property (nonatomic , copy) NSString              * buyerId;
@property (nonatomic , copy) NSString              * fpsellerId;
@property (nonatomic , copy) NSString              * bankName;
@property (nonatomic , copy) NSString              * bankAccount;
@property (nonatomic , copy) NSString              * expressComp;
@property (nonatomic , copy) NSString              * kpName;
@end

NS_ASSUME_NONNULL_END
