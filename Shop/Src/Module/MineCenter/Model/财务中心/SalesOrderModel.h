//
//  SalesOrderModel.h
//  Shop
//
//  Created by BWJ on 2019/3/26.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ListModel;
NS_ASSUME_NONNULL_BEGIN
@interface SalesOrderModel : DRBaseModel

@property (nonatomic,retain)NSString                *sale_id;
@property (nonatomic , copy) NSString              * buyerId;
@property (nonatomic , copy) NSString              * dzPeriod;
@property (nonatomic , copy) NSString              * dzNo;
@property (nonatomic , copy) NSString              * totalOrderAmt;
@property (nonatomic , copy) NSString              * dzEdd;
@property (nonatomic , copy) NSString              * qualityFeeRatio;
@property (nonatomic , copy) NSString              * qty;
@property (nonatomic , copy) NSString              * qualityFee;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * duringreconciliationId;
@property (nonatomic , copy) NSString              * dzSdd;
@property (nonatomic , copy) NSString              * qualityFeeOrderAmt;
@property (nonatomic , copy) NSString              *returnOrderAmt;
@property (nonatomic , copy) NSString              *expressFeeTotal;
@property (nonatomic , copy) NSString              *wsOrderAmt;
@property (nonatomic , copy) NSString              *payStatus;
@property (nonatomic , copy) NSString              *payType;
@property (nonatomic , copy) NSString              *wsExpressPriceAmt;
@property (nonatomic , copy) NSString              *transferFeeTotal;
@property (nonatomic , copy) NSString              *payTypeName;
@property (nonatomic , copy) NSString              *feeAmt;

@end

@interface ChargeOrderModel : DRBaseModel
@property (nonatomic,retain)NSString *charge_id;
@end

@interface detailSalesOrderModel : DRBaseModel
@property (nonatomic,retain)NSString *detail_id;
@property (nonatomic , assign) double              payAmt;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , copy) NSMutableArray<ListModel *>   * list;
@property (nonatomic , assign) double              onlineReturnAmt;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , assign) double              lineReturnAmt;
@property (nonatomic , assign) double              onlineAmt;
@property (nonatomic , assign) double              totalAmt;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , assign) double              lineAmt;
@property (nonatomic , assign) double totalOrderAmt;
@property (nonatomic , assign) double totalExpressAmt;
@end
NS_ASSUME_NONNULL_END

@interface ListModel :DRBaseModel
@property (nonatomic , copy) NSString              * list_id;
@property (nonatomic , assign) NSInteger             orderDate;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * dzNo;
@property (nonatomic , copy) NSString              * dzId;
@property (nonatomic , copy) NSString              * billType;
@property (nonatomic , copy) NSString              * orderNo;
@property (nonatomic ,assign)CGFloat                orderAmt;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , copy) NSString              * orderId;
@property (nonatomic ,assign)NSInteger             addTime;
@property (nonatomic ,assign)CGFloat                qty;
@property (nonatomic , copy) NSString              * payType;
@property (nonatomic ,assign)NSInteger              orderCompleteTime;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , copy) NSString              * returnOrderNo;
@property (nonatomic , copy) NSString              * feeAmt;
@property (nonatomic , copy) NSString              *feeRatio;
@property (nonatomic , copy) NSString              *returnOrderId;
@property (nonatomic , copy) NSString              *orderExpressPrice;
@property (nonatomic , copy) NSString              *transferFeeTotal;
@property (nonatomic , copy) NSString              *totalOrderAmt;
@property (nonatomic , copy) NSString              *transferFee;
@property (nonatomic , copy) NSString              *realAmt;
@end

