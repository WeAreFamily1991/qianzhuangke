//
//  AfterSellListModel.h
//  Shop
//
//  Created by BWJ on 2019/5/30.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoodsList;
NS_ASSUME_NONNULL_BEGIN

@interface AfterSellListModel : DRBaseModel
@property (nonatomic , copy) NSArray<GoodsList *>    * goodsList;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , copy) NSString              * payType;
@property (nonatomic , copy) NSString              * returnId;
@property (nonatomic , copy) NSString              * returnOrderNo;
@property (nonatomic , copy) NSString              * returnAmt;
@property (nonatomic , copy) NSString              * storeName;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , copy) NSString              * imgs;
@property (nonatomic , copy) NSString              * afterSaleStatus;
@property (nonatomic , copy) NSString              * orderReturnWay;
@property (nonatomic , copy) NSString              * orderNo;
@property (nonatomic , copy) NSString              * isHy;
@property (nonatomic , copy) NSString              * kfPhone;
@property (nonatomic , copy) NSString              * priceTypeName;
@property (nonatomic , copy) NSString              * compTypeName;
@property (nonatomic , copy) NSString              * buyerId;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * kpName;
@property (nonatomic , copy) NSString              * priceType;
@property (nonatomic , copy) NSString              * expressType;
@property (nonatomic , copy) NSString              * orderId;
@property (nonatomic , copy) NSString              * returnQty;
@end

NS_ASSUME_NONNULL_END
@interface GoodsList : DRBaseModel


@end
