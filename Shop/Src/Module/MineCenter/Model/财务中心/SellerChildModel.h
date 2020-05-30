//
//  SellerChildModel.h
//  Shop
//
//  Created by BWJ on 2019/7/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SelleModel;
@interface SellerChildModel : DRBaseModel
@property (nonatomic , assign) double              totalAmt;
@property (nonatomic , assign) NSInteger              onlineAmt;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , assign) NSInteger              payAmt;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , assign) NSInteger              lineExpressPrice;
@property (nonatomic , assign) NSInteger              lineAmt;
@property (nonatomic , copy) NSArray<SelleModel *>              * list;
@property (nonatomic , assign) NSInteger              lineReturnAmt;
@property (nonatomic , assign) NSInteger              onlineExpressPrice;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , assign) NSInteger              onlineReturnAmt;

@end

@interface SelleModel :DRBaseModel
@property (nonatomic , assign) NSInteger              totalAmt;
@property (nonatomic , assign) NSInteger              realAmt;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , assign) NSInteger              orderExpressPrice;
@property (nonatomic , assign) NSInteger              inAccountTime;
@property (nonatomic , copy) NSString              * payType;
@property (nonatomic , copy) NSString              * dzId;
@property (nonatomic , copy) NSString              * priod;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , copy) NSString              * list_id;
@property (nonatomic , assign) double              qty;
@property (nonatomic , copy) NSString              * orderNo;
@property (nonatomic , assign) NSInteger              transferFee;
@property (nonatomic , assign) NSInteger              addTime;
@property (nonatomic , copy) NSString              * dzNo;
@property (nonatomic , assign) double              orderAmt;
@property (nonatomic , assign) NSInteger              orderCompleteTime;
@property (nonatomic , assign) NSInteger              orderDate;
@property (nonatomic , copy) NSString              * billType;
@property (nonatomic , copy) NSString              * orderId;


@end
