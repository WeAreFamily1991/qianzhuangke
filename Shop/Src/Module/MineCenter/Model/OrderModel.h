//
//  OrderModel.h
//  Shop
//
//  Created by BWJ on 2019/4/12.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoodsListModel;
NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : DRBaseModel

@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , copy) NSString              * order_id;
@property (nonatomic , copy) NSString              * sellerExpressType;
@property (nonatomic , assign) double              realAmt;
@property (nonatomic , assign) double              totalqty;
@property (nonatomic , assign) double              totalAmt;
@property (nonatomic , assign) BOOL              check;
@property (nonatomic , assign) NSInteger              buyerConfirmStatus;
@property (nonatomic , assign) double              orderAmt;
@property (nonatomic , assign) double              returnedAmt;
@property (nonatomic , assign) NSInteger              goodsSize;
@property (nonatomic , copy) NSString              * buyerId;
@property (nonatomic , copy) NSString              * payType;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * storeName;
@property (nonatomic , copy) NSString              * returnId;
@property (nonatomic , copy) NSArray<GoodsListModel *>    * goodsList;
@property (nonatomic , copy) NSString              * kfPhone;
@property (nonatomic , assign) double              goodAmt;
@property (nonatomic , copy) NSString              * isHy;
@property (nonatomic , copy) NSString              * priceType;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              confirmTime;
@property (nonatomic , assign) NSInteger              sellerPayWay;
@property (nonatomic , copy) NSString              * expressPrice;
@property (nonatomic , copy) NSString              * sellerEstDd;
@property (nonatomic , copy) NSString              * orderNo;
@property (nonatomic , copy) NSString              * evaluateType;
@property (nonatomic , assign) NSInteger              createTime;
@property (nonatomic , copy) NSString              * expressType;
@property (nonatomic , copy) NSString              * kpName;
@property (nonatomic , copy) NSString              * ztAddress;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , copy) NSString              * tradeNo;
@property (nonatomic , assign) NSInteger              isReturn;
@property (nonatomic , copy) NSString              * fpTaxno;
@property (nonatomic , copy) NSString              * saId;
//@property (nonatomic , assign) BOOL              check;
@property (nonatomic , copy) NSString              * orderExpressPrice;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , copy) NSString              * buyerName;
//@property (nonatomic , assign) double              totalqty;
@property (nonatomic , copy) NSString              * areaid;
@property (nonatomic , assign) NSInteger              expressTime;
@property (nonatomic , copy) NSString              * fpRegTel;
@property (nonatomic , copy) NSString              * estTime;
@property (nonatomic , copy) NSString              * payRemark;
//@property (nonatomic , assign) double              realAmt;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * payTime;
@property (nonatomic , copy) NSString              * expressStation;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , assign) NSInteger              overcoststatus;
@property (nonatomic , assign) double              voucheroff;
@property (nonatomic , copy) NSString              * pickPrintTime;
@property (nonatomic , copy) NSString              * fpRegAddress;
@property (nonatomic , copy) NSString              * tradorid;

@property (nonatomic , copy) NSString              * isDf;
@property (nonatomic , copy) NSString              * returnExpressComp;
@property (nonatomic , copy) NSString              * fpType;
@property (nonatomic , copy) NSString              * erpOid;
@property (nonatomic , assign) double              moneyoff;
//@property (nonatomic , copy) NSString              * sellerExpressType;
//@property (nonatomic , copy) NSString              * sellerEstDd;
@property (nonatomic , copy) NSString              * sycnfailedreason;
@property (nonatomic , copy) NSString              * totalDiscountPiece;
//@property (nonatomic , copy) NSString              * isHy;
//@property (nonatomic , copy) NSString              * evaluateType;
@property (nonatomic , assign) NSInteger              payStatus;
//@property (nonatomic , assign) double              orderAmt;
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , copy) NSString              * returnExpressImg;
@property (nonatomic , copy) NSString              * expressImg;
//@property (nonatomic , copy) NSString              * expressType;
//@property (nonatomic , copy) NSString              * expressPrice;
@property (nonatomic , assign) NSInteger              afterSaleStatus;
@property (nonatomic , copy) NSString              * fpBank;
@property (nonatomic , copy) NSString              * phone;
//@property (nonatomic , copy) NSString              * storeName;
@property (nonatomic , copy) NSString              * isCostomPaytype;
@property (nonatomic , copy) NSString              * stockPrintTime;
@property (nonatomic , copy) NSString              * totalDiscountId;
@property (nonatomic , assign) NSInteger              estDd;
@property (nonatomic , copy) NSString              * payFriendname;
@property (nonatomic , copy) NSString              * sycnerpstatus;
@property (nonatomic , copy) NSString              * ip;
//@property (nonatomic , copy) NSString              * buyerId;
@property (nonatomic , copy) NSString              * mobile;
//@property (nonatomic , copy) NSArray<GoodsList *>              * goodsList;
@property (nonatomic , assign) NSInteger              completeTime;
//@property (nonatomic , assign) double              afterSaleStatus;
@property (nonatomic , copy) NSString              * sourcetype;
@property (nonatomic , copy) NSString              * expressStationId;
@property (nonatomic , copy) NSString              * paySn;
@property (nonatomic , copy) NSString              * returnExpressNo;
@property (nonatomic , copy) NSString              * returnedQty;
@property (nonatomic , assign) NSInteger              delaypaystatus;
@property (nonatomic , copy) NSString              * fpBankAccount;
@property (nonatomic , copy) NSString              * returnExpressTime;
@property (nonatomic , copy) NSString              * orderservicetype;
//@property (nonatomic , copy) NSString              * ztAddress;
//@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , copy) NSString              * fpTitle;
@property (nonatomic , copy) NSString              * stypeid;
@property (nonatomic , copy) NSString              * batchNo;
@property (nonatomic , copy) NSString              * returnExpressRemark;
@property (nonatomic , copy) NSString              * payFee;
@property (nonatomic , assign) NSInteger              buyerComfirmStatus;
@property (nonatomic , assign) NSInteger              orderComplateTime;
//@property (nonatomic , assign) NSInteger              isReturn;
@property (nonatomic , copy) NSString              * logphone;
@property (nonatomic , copy) NSString              * fpParty;
@property (nonatomic , copy) NSString              * moneyoffTopic;
//@property (nonatomic , assign) NSInteger              sellerPayWay;
@property (nonatomic , copy) NSString              * stockPrintNum;
//@property (nonatomic , assign) double              goodAmt;
@property (nonatomic , copy) NSString              * expressNo;
@property (nonatomic , copy) NSString              * consignee;
@property (nonatomic , copy) NSString              * userPayType;
@property (nonatomic , copy) NSString              * paySystem;
//@property (nonatomic , assign) NSInteger              status;
//@property (nonatomic , assign) NSInteger              createTime;
@property (nonatomic , copy) NSString              * userPayDay;
@property (nonatomic , assign) NSInteger              orderPayType;
@property (nonatomic , copy) NSString              * totalDiscountPrice;
@property (nonatomic , copy) NSString              * voucherTopic;
@property (nonatomic , copy) NSString              * storeid;
@property (nonatomic , copy) NSString              * isProxyFee;
@property (nonatomic , copy) NSString              * pickPrintNum;
@property (nonatomic , copy) NSString              * regionId;
@property (nonatomic , copy) NSString              * payTypeName;
@property (nonatomic , copy) NSString              * eTypeName;
@property (nonatomic , copy) NSString              * isOpenFp;

@property (nonatomic , copy) NSString              * zyStatus;

@property (nonatomic , copy) NSString              * expressCompany;
@property (nonatomic , copy) NSString              *severType;
@end


@interface GoodsListModel : DRBaseModel

//@property (nonatomic , assign) NSInteger              sortId;
//@property (nonatomic , assign) double              baseprice;
//@property (nonatomic , copy) NSString              * orderId;
//@property (nonatomic , copy) NSString              * materialName;
//@property (nonatomic , copy) NSString              * good_id;
//@property (nonatomic , copy) NSString              * remark;
//@property (nonatomic , copy) NSString              * standardname;
//@property (nonatomic , assign) double              realAmt;
//@property (nonatomic , copy) NSString              * pmid;
//@property (nonatomic , copy) NSString              * lengthname;
//@property (nonatomic , assign) double              amt;
//@property (nonatomic , copy) NSString              * itemId;
//@property (nonatomic , assign) BOOL              isreview;
//@property (nonatomic , assign) double              returnedAmt;
//@property (nonatomic , copy) NSString              * storeid;
//@property (nonatomic , copy) NSString              * itemParamId;
//@property (nonatomic , copy) NSString              * diametername;
//@property (nonatomic , copy) NSString              * brandName;
//@property (nonatomic , assign) double              returnedQty;
//@property (nonatomic , copy) NSString              * moneyoff;
//@property (nonatomic , assign) double              qty;
//@property (nonatomic , copy) NSString              * pmqty;
//@property (nonatomic , copy) NSString              * discountPiece;
//@property (nonatomic , copy) NSString              * stypeid;
//@property (nonatomic , copy) NSString              * standardcode;
//@property (nonatomic , copy) NSString              * erpOrderid;
//@property (nonatomic , copy) NSString              * erpOid;
//@property (nonatomic , copy) NSString              * levelName;
//@property (nonatomic , copy) NSString              * orderservicetype;
//@property (nonatomic , copy) NSString              * erpId;
//@property (nonatomic , copy) NSString              * discountPrice;
@property (nonatomic , assign) double              price;
//@property (nonatomic , copy) NSString              * toothdistancename;
//@property (nonatomic , assign) double              realPrice;
//@property (nonatomic , copy) NSString              * orderpaytype;
//@property (nonatomic , copy) NSString              * pricesource;
//@property (nonatomic , copy) NSString              * orderNo;
//@property (nonatomic , copy) NSString              * basicUnitName;
//@property (nonatomic , copy) NSString              * toothformname;
//@property (nonatomic , copy) NSString              * discountId;
//@property (nonatomic , copy) NSString              * voucheroff;
//@property (nonatomic , copy) NSString              * spec;
//@property (nonatomic , copy) NSString              * surfaceName;
//@property (nonatomic , copy) NSString              * imgUrl;
//@property (nonatomic , copy) NSString              * itemName;
//@property (nonatomic , copy) NSString              * discount;
//@property (nonatomic , copy) NSString              * pack;
//@property (nonatomic , copy) NSString              * areaid;
//
//@property (nonatomic , copy) NSString              * unitPiece;
//@property (nonatomic , copy) NSString              * unit4;
//@property (nonatomic , copy) NSString              * saleUnitName;
//@property (nonatomic , copy) NSString              * basicUnitId;
//@property (nonatomic , copy) NSString              * unitName1;
//@property (nonatomic , copy) NSString              * countPiece;
//@property (nonatomic , copy) NSString              * unitName2;
//@property (nonatomic , assign) double              returnPrice;
////@property (nonatomic , copy) NSString              * discountId;
//@property (nonatomic , copy) NSString              * unitName3;
//
//@property (nonatomic , copy) NSString              * unitName4;
////@property (nonatomic , assign) BOOL              isreview;
////@property (nonatomic , copy) NSString              * standardcode;
//@property (nonatomic , copy) NSString              * condition1;
////@property (nonatomic , copy) NSString              * imgUrl;
////@property (nonatomic , copy) NSString              * toothdistancename;
//@property (nonatomic , copy) NSString              * unitName5;
////@property (nonatomic , copy) NSString              * diametername;
////@property (nonatomic , copy) NSString              * toothformname;
//@property (nonatomic , copy) NSString              * unit1;
////@property (nonatomic , copy) NSString              * areaid;
//@property (nonatomic , copy) NSString              * condition2;
////@property (nonatomic , copy) NSString              * itemId;
////@property (nonatomic , assign) double              voucheroff;
//@property (nonatomic , copy) NSString              * unit5;
//@property (nonatomic , assign) BOOL              inApply;
////@property (nonatomic , copy) NSString              * levelName;
//@property (nonatomic , copy) NSString              * condition3;
////@property (nonatomic , assign) double              price;
////@property (nonatomic , copy) NSString              * itemName;
////@property (nonatomic , copy) NSString              * stypeid;
//@property (nonatomic , copy) NSString              * unitConversion1;
////@property (nonatomic , assign) double              returnedAmt;
//@property (nonatomic , copy) NSString              * saleUnitConversion;
////@property (nonatomic , copy) NSString              * pmid;
//@property (nonatomic , copy) NSString              *unitConversion2;
//@property (nonatomic , copy) NSString              * discount1;
////@property (nonatomic , copy) NSString              * materialName;
////@property (nonatomic , copy) NSString              * pmqty;
//@property (nonatomic , copy) NSString              *unitConversion3;
//@property (nonatomic , copy) NSString              * unitConversion4;
//@property (nonatomic , copy) NSString              * discount2;
////@property (nonatomic , copy) NSString              * storeid;
////@property (nonatomic , copy) NSString              * pack;
//@property (nonatomic , copy) NSString              * unitConversion5;
//@property (nonatomic , copy) NSString              * discount3;
////@property (nonatomic , assign) double              realAmt;
//@property (nonatomic , copy) NSString              * unit2;
////@property (nonatomic , copy) NSString              * surfaceName;
////@property (nonatomic , copy) NSString              * remark;
////@property (nonatomic , assign) NSInteger              sortId;
////@property (nonatomic , copy) NSString              * orderId;
////@property (nonatomic , copy) NSString              * erpId;
////@property (nonatomic , copy) NSString              * standardname;
////@property (nonatomic , copy) NSString              * lengthname;
////@property (nonatomic , copy) NSString              * basicUnitName;
//@property (nonatomic , copy) NSString              * returnId;
//@property (nonatomic , copy) NSString              * saleUnitId;
////@property (nonatomic , copy) NSString              * itemParamId;
////@property (nonatomic , copy) NSString              * orderpaytype;
//@property (nonatomic , copy) NSString              * unit3;
//@property (nonatomic , copy) NSString              * discountTitle;
//@property (nonatomic , copy) NSString              * pricesource;
//@property (nonatomic , copy) NSString              * erpOid;
//@property (nonatomic , copy) NSString              * discountPrice;
//@property (nonatomic , copy) NSString              * orderservicetype;
//@property (nonatomic , copy) NSString              * brandName;
//@property (nonatomic , copy) NSString              * discount;

@property (nonatomic , copy) NSString              * imgUrlM;
@property (nonatomic , copy) NSString              * orderId;
@property (nonatomic , copy) NSString              * standardCode;
@property (nonatomic , copy) NSString              * good_id;
@property (nonatomic , assign) double              unitConversion3;
@property (nonatomic , copy) NSString              * unitName4;
@property (nonatomic , assign) double              realAmt;
@property (nonatomic , assign) double              unitConversion5;
@property (nonatomic , assign) double              amt;
@property (nonatomic , copy) NSString              * unit4;
@property (nonatomic , copy) NSString              * itemId;
@property (nonatomic , copy) NSString              * toothFormName;
@property (nonatomic , copy) NSString              * basicUnitId;
@property (nonatomic , assign) NSInteger              returnedAmt;
@property (nonatomic , copy) NSString              * returnOrderDetailId;
@property (nonatomic , copy) NSString              * unit2;
@property (nonatomic , copy) NSString              * itemParamId;
@property (nonatomic , copy) NSString              * saleUnitName;
@property (nonatomic , copy) NSString              * unitName5;
@property (nonatomic , assign) NSInteger              returnedQty;
@property (nonatomic , assign) double              qty;
@property (nonatomic , copy) NSString              * unitName1;
@property (nonatomic , assign) BOOL              inApply;
@property (nonatomic , assign) NSInteger              canReturnQty;
@property (nonatomic , assign) double              unitConversion2;
@property (nonatomic , copy) NSString              * materialName;
@property (nonatomic , assign) double              unitConversion4;
@property (nonatomic , copy) NSString              * unitName2;
@property (nonatomic , assign) double              realPrice;
@property (nonatomic , copy) NSString              * standardName;
@property (nonatomic , copy) NSString              * unit5;
@property (nonatomic , copy) NSString              * lengthName;
@property (nonatomic , copy) NSString              * brandName;
@property (nonatomic , assign) BOOL              review;
@property (nonatomic , copy) NSString              * surfaceName;
@property (nonatomic , copy) NSString              * unit3;
@property (nonatomic , copy) NSString              * basicUnitName;
@property (nonatomic , copy) NSString              * unit1;
@property (nonatomic , copy) NSString              * spec;
@property (nonatomic , copy) NSString              * toothDistanceName;
@property (nonatomic , copy) NSString              * diameterName;
@property (nonatomic , copy) NSString              * imgUrl;
@property (nonatomic , copy) NSString              * itemName;
@property (nonatomic , copy) NSString              * saleUnitId;
@property (nonatomic , copy) NSString              * levelName;
@property (nonatomic , copy) NSString              * unitName3;
@property (nonatomic , assign) NSInteger              saleUnitConversion;
@property (nonatomic , assign) double              unitConversion1;

@end
NS_ASSUME_NONNULL_END
