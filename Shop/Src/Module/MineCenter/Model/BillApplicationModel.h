//
//  ShoppingModel.h
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShoppingModel;
@interface BillApplicationModel :DRBaseModel
@property (nonatomic , copy) NSString              * compId;
@property (nonatomic , copy) NSString              * fpParty;
@property (nonatomic , copy) NSString              * kpName;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , copy) NSString              * priceType;
@property (nonatomic , copy) NSArray<ShoppingModel *>   * orderList;
@property (nonatomic , copy) NSString              * compType;
@property(assign,nonatomic) BOOL isSelected;//是否选中状态

@end

@interface ShoppingModel : DRBaseModel

@property (nonatomic,strong) ShoppingModel *shoppingModel;

@property (nonatomic,strong) NSString *order;//单据编码

@property (nonatomic,strong) NSString *time;//单据时间

@property (nonatomic,strong) NSString *orderPrice;//单据金额

@property (nonatomic,strong) NSString *backPrice;//退货金额

@property (nonatomic,strong) NSString *number;//可开票金额


@property (nonatomic,strong) NSString *typeRight;//可开票

@property(assign,nonatomic) BOOL isSelected;//是否选中状态

@property (nonatomic , copy) NSString              * fpTaxno;
@property (nonatomic , copy) NSString              * saId;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , copy) NSString              * buyerName;
@property (nonatomic , assign) double              totalqty;
@property (nonatomic , copy) NSString              * areaid;
@property (nonatomic , assign) NSInteger              expressTime;
@property (nonatomic , copy) NSString              * fpRegTel;
@property (nonatomic , copy) NSString              * estTime;
@property (nonatomic , copy) NSString              * payRemark;
@property (nonatomic , copy) NSString              *realAmt;
@property (nonatomic , copy) NSString              * application_id;
@property (nonatomic , copy) NSString              * payTime;
@property (nonatomic , copy) NSString              * expressStation;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , assign) NSInteger              overcoststatus;
@property (nonatomic , copy) NSString              * voucheroff;
@property (nonatomic , copy) NSString              * pickPrintTime;
@property (nonatomic , copy) NSString              * fpRegAddress;
@property (nonatomic , copy) NSString              * tradorid;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , assign) double              canReturnAmt;
@property (nonatomic , copy) NSString              * fpType;
@property (nonatomic , copy) NSString              * erpOid;
@property (nonatomic , copy) NSString              * moneyoff;
@property (nonatomic , copy) NSString              * sellerExpressType;
@property (nonatomic , copy) NSString              * sellerEstDd;
@property (nonatomic , copy) NSString              * sycnfailedreason;
@property (nonatomic , copy) NSString              * totalDiscountPiece;
@property (nonatomic , copy) NSString              * evaluateType;
@property (nonatomic , assign) NSInteger              payStatus;
@property (nonatomic , assign) double              orderAmt;
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , copy) NSString              * expressImg;
@property (nonatomic , copy) NSString              * expressType;
@property (nonatomic , copy) NSString              * expressPrice;
@property (nonatomic , copy) NSString              * fpBank;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , copy) NSString              * isCostomPaytype;
@property (nonatomic , copy) NSString              * stockPrintTime;
@property (nonatomic , copy) NSString              * totalDiscountId;
@property (nonatomic , assign) NSInteger              estDd;
@property (nonatomic , copy) NSString              * payFriendname;
@property (nonatomic , copy) NSString              * sycnerpstatus;
@property (nonatomic , copy) NSString              * ip;
@property (nonatomic , copy) NSString              * buyerId;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , assign) NSInteger              completeTime;
@property (nonatomic , copy) NSString            *returnedAmt;
@property (nonatomic , copy) NSString              * sourcetype;
@property (nonatomic , copy) NSString              * expressStationId;
@property (nonatomic , copy) NSString              * paySn;
@property (nonatomic , copy) NSString              * returnedQty;
@property (nonatomic , assign) NSInteger              delaypaystatus;
@property (nonatomic , copy) NSString              * fpBankAccount;
@property (nonatomic , copy) NSString              * orderservicetype;
@property (nonatomic , copy) NSString              * ztAddress;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , copy) NSString              * kpName;
@property (nonatomic , copy) NSString              * fpTitle;
@property (nonatomic , copy) NSString              * stypeid;
@property (nonatomic , copy) NSString              * batchNo;
@property (nonatomic , copy) NSString              * payFee;
@property (nonatomic , copy) NSString              * buyerComfirmStatus;
@property (nonatomic , copy) NSString              * orderId;
@property (nonatomic , assign) NSInteger              orderComplateTime;
@property (nonatomic , assign) NSInteger              isReturn;
@property (nonatomic , copy) NSString              * fpParty;
@property (nonatomic , copy) NSString              * moneyoffTopic;
@property (nonatomic , assign) NSInteger              sellerPayWay;
@property (nonatomic , copy) NSString              * stockPrintNum;
@property (nonatomic , assign) double              goodAmt;
@property (nonatomic , copy) NSString              * expressNo;
@property (nonatomic , copy) NSString              * consignee;
@property (nonatomic , copy) NSString              * userPayType;
@property (nonatomic , copy) NSString              * paySystem;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              createTime;
@property (nonatomic , copy) NSString              * userPayDay;
@property (nonatomic , assign) NSInteger              orderpaytype;
@property (nonatomic , copy) NSString              * totalDiscountPrice;
@property (nonatomic , copy) NSString              * voucherTopic;
@property (nonatomic , copy) NSString              * storeid;
@property (nonatomic , assign) NSInteger              isProxyFee;
@property (nonatomic , copy) NSString              * pickPrintNum;
@property (nonatomic , copy) NSString              * regionId;
@property (nonatomic , copy) NSString              * payTypeName;
@property (nonatomic , copy) NSString              * eTypeName;
@property (nonatomic , copy) NSString              * compId;
@property (nonatomic , copy) NSString              * isOpenFp;
@property (nonatomic , copy) NSString              * orderNo;
@property (nonatomic , copy) NSString              * zyStatus;
@property (nonatomic , copy) NSString              * tradeNo;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , assign) NSInteger              confirmTime;
@property (nonatomic , copy) NSString              * expressCompany;
@property (nonatomic , copy) NSString              * payType;

@end
