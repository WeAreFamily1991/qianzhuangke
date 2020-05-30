//
//  AfterSellInfoModel.h
//  Shop
//
//  Created by BWJ on 2019/5/30.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AfterSellList;
NS_ASSUME_NONNULL_BEGIN

@interface AfterSellInfoModel : DRBaseModel
//@property (nonatomic , copy) NSString              * receiveTime;
//@property (nonatomic , copy) NSString              * orderId;
//@property (nonatomic , copy) NSString              * auditRemark;
//@property (nonatomic , copy) NSString              * sellerName;
//@property (nonatomic , copy) NSString              * orderReturnWay;
//@property (nonatomic , copy) NSString              * receiveMobile;
//@property (nonatomic , copy) NSString              * expressRemark;
//@property (nonatomic , copy) NSString              * expressNo;
//@property (nonatomic , copy) NSString              * address;
//@property (nonatomic , copy) NSString              * expressTime;
//@property (nonatomic , copy) NSString              * orderAmt;
//@property (nonatomic , copy) NSString              * returnedAmt;
//@property (nonatomic , copy) NSString              * expressComp;
//@property (nonatomic , copy) NSString              * payType;
//@property (nonatomic , copy) NSString              * buyerId;
//@property (nonatomic , copy) NSString              * sellerId;
//@property (nonatomic , copy) NSString              * userReturnAmt;
//@property (nonatomic , copy) NSString              * vendorName;
//@property (nonatomic , copy) NSString              * storeName;
//@property (nonatomic , copy) NSString              * expressImg;
//@property (nonatomic , copy) NSString              * imgs;
//@property (nonatomic , copy) NSString              * receiverPhone;
//@property (nonatomic , copy) NSString              * returnId;
//@property (nonatomic , copy) NSArray<AfterSellList *>              * goodsList;
//@property (nonatomic , copy) NSString              * afterSaleStatus;
//@property (nonatomic , copy) NSString              * kfPhone;
//@property (nonatomic , copy) NSString              * returnAmt;
//@property (nonatomic , copy) NSString              * isHy;
//@property (nonatomic , copy) NSString              * priceType;
//@property (nonatomic , copy) NSString              * returnQty;
//@property (nonatomic , copy) NSString              * mobile;
//@property (nonatomic , copy) NSString              * userReturnQty;
//@property (nonatomic , copy) NSString              * orderNo;
//@property (nonatomic , copy) NSString              * createTime;
//@property (nonatomic , copy) NSString              * expressType;
//@property (nonatomic , copy) NSString              * returnOrderNo;
//@property (nonatomic , copy) NSString              * auditTime;
//@property (nonatomic , copy) NSString              * compTypeName;
//@property (nonatomic , copy) NSString              * priceTypeName;
//@property (nonatomic , copy) NSString              * reason;
//@property (nonatomic , copy) NSString              * kpName;
//@property (nonatomic , copy) NSString              * receiveAddress;
//@property (nonatomic , copy) NSString              * receiveName;
//@property (nonatomic , copy) NSString              * discount;
//@property (nonatomic , copy) NSString              * compType;
//@property (nonatomic , copy) NSString              * message;
//@property (nonatomic , copy) NSString              * areaid;

@property (nonatomic , copy) NSString              * orderId;
@property (nonatomic , copy) NSString              * auditRemark;
@property (nonatomic , assign) NSInteger              orderReturnWay;
@property (nonatomic , copy) NSString              * expressRemark;
@property (nonatomic , copy) NSString              * expressNo;
@property (nonatomic , copy) NSString              * expressTime;
@property (nonatomic , assign) NSInteger              goodsSize;
@property (nonatomic , copy) NSString              * expressComp;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * storeName;
@property (nonatomic , copy) NSString              * expressImg;
@property (nonatomic , copy) NSString              * imgs;
@property (nonatomic , copy) NSString              * returnAddress;
@property (nonatomic , copy) NSArray<AfterSellList *>              * goodsList;
@property (nonatomic , copy) NSString              * kfPhone;
@property (nonatomic , assign) NSInteger              returnAmt;
@property (nonatomic , copy) NSString              * fpParty;
@property (nonatomic , copy) NSString              * isHy;
@property (nonatomic , copy) NSString              * priceType;
@property (nonatomic , assign) NSInteger              returnQty;
@property (nonatomic , copy) NSString              * orderServiceType;
@property (nonatomic , assign) NSInteger              orderPayType;
@property (nonatomic , copy) NSString              * returnOrderId;
@property (nonatomic , assign) NSInteger              returnOrderStatus;
@property (nonatomic , assign) NSInteger              sellerPayWay;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * expressType;
@property (nonatomic , copy) NSString              * returnOrderNo;
@property (nonatomic , copy) NSString              * auditTime;
@property (nonatomic , copy) NSString              * returnPhone;
@property (nonatomic , copy) NSString              * kpName;
@property (nonatomic , copy) NSString              * reason;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , copy) NSString              * returnContacts;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , copy) NSString              * message;
@end

@interface AfterSellList :DRBaseModel
//@property (nonatomic , copy) NSString              * materialName;
//@property (nonatomic , copy) NSString              * imgUrlM;
//@property (nonatomic , copy) NSString              * unitConversion3;
//@property (nonatomic , copy) NSString              * remark;
//@property (nonatomic , copy) NSString              * standardname;
//@property (nonatomic , copy) NSString              * unitName4;
//@property (nonatomic , copy) NSString              * unitConversion5;
//@property (nonatomic , copy) NSString              * salePrice;
//@property (nonatomic , copy) NSString              * unit4;
//@property (nonatomic , copy) NSString              * toothFormName;
//@property (nonatomic , copy) NSString              * basicUnitId;
//@property (nonatomic , copy) NSString              * orderAmt;
//@property (nonatomic , copy) NSString              * unit2;
//@property (nonatomic , copy) NSString              * returnOrderDetailId;
//@property (nonatomic , copy) NSString              * comment;
//@property (nonatomic , copy) NSString              * unitName5;
//@property (nonatomic , copy) NSString              * userReturnAmt;
//@property (nonatomic , copy) NSString              * brandName;
//@property (nonatomic , copy) NSString              * qty;
//@property (nonatomic , copy) NSString              * unitName1;
//@property (nonatomic , copy) NSString              * returnId;
//@property (nonatomic , copy) NSString              * standardcode;
//@property (nonatomic , copy) NSString              * canReturnQty;
//@property (nonatomic , copy) NSString              * unitConversion2;
//@property (nonatomic , copy) NSString              * returnAmt;
//@property (nonatomic , copy) NSString              * levelName;
//@property (nonatomic , copy) NSString              * returnQty;
//@property (nonatomic , copy) NSString              * returnPrice;
//@property (nonatomic , copy) NSString              * unitConversion4;
//@property (nonatomic , copy) NSString              * orderQty;
//@property (nonatomic , copy) NSString              * unitName2;
//@property (nonatomic , copy) NSString              * userReturnQty;
//@property (nonatomic , copy) NSString              * unit5;
//@property (nonatomic , copy) NSString              * lengthName;
//@property (nonatomic , copy) NSString              * unit3;
//@property (nonatomic , copy) NSString              * basicUnitName;
//@property (nonatomic , copy) NSString              * unit1;
//@property (nonatomic , copy) NSString              * orderGoodId;
//@property (nonatomic , copy) NSString              * spec;
//@property (nonatomic , copy) NSString              * toothDistanceName;
//@property (nonatomic , copy) NSString              * diameterName;
//@property (nonatomic , copy) NSString              * surfaceName;
//@property (nonatomic , copy) NSString              * itemName;
//@property (nonatomic , copy) NSString              * imgUrl;
//@property (nonatomic , copy) NSString              * discount;
//@property (nonatomic , copy) NSString              * unitName3;
//@property (nonatomic , copy) NSString              * unitConversion1;
@property (nonatomic , copy) NSString              * imgUrlM;
@property (nonatomic , copy) NSString              * standardCode;
@property (nonatomic , assign) double              unitConversion3;
@property (nonatomic , copy) NSString              * unitName4;
@property (nonatomic , assign) double              unitConversion5;
@property (nonatomic , copy) NSString              * unit4;
@property (nonatomic , copy) NSString              * itemId;
@property (nonatomic , copy) NSString              * toothFormName;
@property (nonatomic , assign) NSInteger              returnedAmt;
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
@property (nonatomic , assign) NSInteger              returnPrice;
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
