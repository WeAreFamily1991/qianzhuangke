//
//  DRSellAfterModel.h
//  Shop
//
//  Created by BWJ on 2019/5/30.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoodsList;
NS_ASSUME_NONNULL_BEGIN
@interface DRSellAfterModel : DRBaseModel
//@property (nonatomic , copy) NSArray<GoodsList *>    * goodsList;
//@property (nonatomic , copy) NSString              * compType;
//@property (nonatomic , copy) NSString              * payType;
//@property (nonatomic , copy) NSString              * returnId;
//@property (nonatomic , copy) NSString              * returnOrderNo;
//@property (nonatomic , copy) NSString              * returnAmt;
//@property (nonatomic , copy) NSString              * storeName;
//@property (nonatomic , copy) NSString              * sellerId;
//@property (nonatomic , copy) NSString              * sellerName;
//@property (nonatomic , copy) NSString              * imgs;
//@property (nonatomic , copy) NSString              * afterSaleStatus;
//@property (nonatomic , copy) NSString              * orderReturnWay;
//@property (nonatomic , copy) NSString              * orderNo;
//@property (nonatomic , copy) NSString              * isHy;
//@property (nonatomic , copy) NSString              * kfPhone;
@property (nonatomic , copy) NSString              * priceTypeName;
//@property (nonatomic , copy) NSString              * compTypeName;
//@property (nonatomic , copy) NSString              * buyerId;
//@property (nonatomic , copy) NSString              * createTime;
//@property (nonatomic , copy) NSString              * kpName;
//@property (nonatomic , copy) NSString              * priceType;
//@property (nonatomic , copy) NSString              * expressType;
//@property (nonatomic , copy) NSString              * orderId;
//@property (nonatomic , copy) NSString              * returnQty;
@property (nonatomic , copy) NSArray<GoodsList *>              * goodsList;
@property (nonatomic , assign) double              returnQty;
@property (nonatomic , copy) NSString              * fpParty;
@property (nonatomic , assign) NSInteger              sellerPayWay;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , copy) NSString              * storeName;
@property (nonatomic , copy) NSString              * returnOrderNo;
@property (nonatomic , assign) double              returnAmt;
@property (nonatomic , copy) NSString              * orderServiceType;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , assign) NSInteger              returnOrderStatus;
@property (nonatomic , assign) NSInteger              orderPayType;
@property (nonatomic , copy) NSString              * returnOrderId;
@property (nonatomic , copy) NSString              * kfPhone;
@property (nonatomic , copy) NSString              * isHy;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * expressType;
@property (nonatomic , assign) NSInteger              goodsSize;
@property (nonatomic , copy) NSString              * kpName;
@property (nonatomic , copy) NSString              * orderId;
@property (nonatomic , copy) NSString              * priceType;

@end

@interface GoodsList : DRBaseModel

@property (nonatomic , copy) NSString              * imgUrlM;
@property (nonatomic , copy) NSString              * standardCode;
@property (nonatomic , assign) double              unitConversion3;
@property (nonatomic , copy) NSString              * unitName4;
@property (nonatomic , assign) double              unitConversion5;
@property (nonatomic , copy) NSString              * unit4;
@property (nonatomic , copy) NSString              * itemId;
@property (nonatomic , copy) NSString              * toothFormName;
@property (nonatomic , assign) double              returnedAmt;
@property (nonatomic , copy) NSString              * returnOrderDetailId;
@property (nonatomic , copy) NSString              * unit2;
@property (nonatomic , copy) NSString              * itemParamId;
@property (nonatomic , copy) NSString              * saleUnitName;
@property (nonatomic , copy) NSString              * unitName5;
@property (nonatomic , assign) NSInteger              returnedQty;
@property (nonatomic , assign) NSInteger              userReturnAmt;
@property (nonatomic , assign) NSInteger              qty;
@property (nonatomic , copy) NSString              * unitName1;
@property (nonatomic , assign) NSInteger              canReturnQty;
@property (nonatomic , assign) double              unitConversion2;
@property (nonatomic , copy) NSString              * materialName;
@property (nonatomic , assign) double              returnPrice;
@property (nonatomic , assign) double              unitConversion4;
@property (nonatomic , copy) NSString              * unitName2;
@property (nonatomic , copy) NSString              * standardName;
@property (nonatomic , copy) NSString              * unit5;
@property (nonatomic , assign) NSInteger              userReturnQty;
@property (nonatomic , copy) NSString              * returnOrderId;
@property (nonatomic , copy) NSString              * lengthName;
@property (nonatomic , copy) NSString              * brandName;
@property (nonatomic , copy) NSString              * unit3;
@property (nonatomic , copy) NSString              * surfaceName;
@property (nonatomic , copy) NSString              * basicUnitName;
@property (nonatomic , copy) NSString              * unit1;
@property (nonatomic , copy) NSString              * spec;
@property (nonatomic , copy) NSString              * toothDistanceName;
@property (nonatomic , copy) NSString              * diameterName;
@property (nonatomic , copy) NSString              * imgUrl;
@property (nonatomic , copy) NSString              * itemName;
@property (nonatomic , copy) NSString              * unitName3;
@property (nonatomic , copy) NSString              * levelName;
@property (nonatomic , copy) NSString              * orderGoodsId;
@property (nonatomic , assign) double              unitConversion1;
@end
NS_ASSUME_NONNULL_END
