//
//  GoodsModel.h
//  Shop
//
//  Created by BWJ on 2019/4/2.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FavoriteModel;
NS_ASSUME_NONNULL_BEGIN

@interface GoodsModel : DRBaseModel
//@property (nonatomic , copy) NSString              * spec;
//@property (nonatomic , copy) NSString              * lengthname;
//@property (nonatomic , copy) NSString              * kpName;
//@property (nonatomic , copy) NSString              * unitConversion2;
//@property (nonatomic , copy) NSString              * unitName5;
//@property (nonatomic , copy) NSString              * payMothed;
//@property (nonatomic , copy) NSString              * goods_id;
//@property (nonatomic , copy) NSString              * surfaceName;
//@property (nonatomic , copy) NSString              * unitConversion4;
//@property (nonatomic , copy) NSString              * materialcode;
//@property (nonatomic , copy) NSString              * itemUnitConversion;
//@property (nonatomic , copy) NSString              * saleUnitConversion;
//@property (nonatomic , copy) NSString              * lengthcode;
//@property (nonatomic , copy) NSString              * sellerPayMethod;
//@property (nonatomic , copy) NSString              * bid;
//@property (nonatomic , copy) NSString              * condition3;
//@property (nonatomic , copy) NSString              * toothdistancecode;
@property (nonatomic , copy) NSString              * isHy;
//@property (nonatomic , copy) NSString              * toothformname;
//@property (nonatomic , copy) NSString              * qty;
//@property (nonatomic , copy) NSString              * lengthId;
//@property (nonatomic , copy) NSString              * allSaleCount;
//@property (nonatomic , copy) NSString              * discount2;
//@property (nonatomic , copy) NSString              * diametername;
@property (nonatomic , copy) NSString              * serviceType;
//@property (nonatomic , copy) NSString              * unitName1;
//@property (nonatomic , copy) NSString              * isstock;
//@property (nonatomic , copy) NSString              * isZf;
//@property (nonatomic , copy) NSString              * unit1;
//@property (nonatomic , copy) NSString              * zfMoq;
//@property (nonatomic , copy) NSString              * unitName4;
//@property (nonatomic , copy) NSString              * storeCode;
//@property (nonatomic , copy) NSString              * areaId;
//@property (nonatomic , copy) NSString              * storeName;
@property (nonatomic , copy) NSString              * priceType;
//@property (nonatomic , copy) NSString              * buyNum;
//@property (nonatomic , copy) NSString              * countPiece;
//@property (nonatomic , copy) NSString              * brandcode;
//@property (nonatomic , copy) NSString              * brandName;
//@property (nonatomic , copy) NSString              * storeId;
//@property (nonatomic , copy) NSString              * unitConversion1;
//@property (nonatomic , copy) NSString              * buyerId;
//@property (nonatomic , copy) NSString              * saledCount;
//@property (nonatomic , copy) NSString              * levelId;
//@property (nonatomic , copy) NSString              * discountId;
//@property (nonatomic , copy) NSString              * erpcode;
//@property (nonatomic , copy) NSString              * itemUnit;
//@property (nonatomic , copy) NSString              * unit2;
//@property (nonatomic , copy) NSString              * surfaceId;
//@property (nonatomic , copy) NSString              * condition1;
//@property (nonatomic , copy) NSString              * authstatus;
//@property (nonatomic , copy) NSString              * toothformid;
//@property (nonatomic , copy) NSString              * imgUrl;
//@property (nonatomic , copy) NSString              * imgUrlM;
//@property (nonatomic , copy) NSString              * diametercode;
//@property (nonatomic , copy) NSString              * toothdistanceid;
//@property (nonatomic , copy) NSString              * pmid;
//@property (nonatomic , copy) NSString              * isLogistics;
//@property (nonatomic , copy) NSString              * stock;
//@property (nonatomic , copy) NSString              * sellerTypeCode;
//@property (nonatomic , copy) NSString              * unitConversion3;
//@property (nonatomic , copy) NSString              * discount1;
@property (nonatomic , copy) NSString              * sellerName;
//@property (nonatomic , copy) NSString              * branchId;
//@property (nonatomic , copy) NSString              * materialId;
//@property (nonatomic , copy) NSString              * ptypeid;
//@property (nonatomic , copy) NSString              * userPrice;
//@property (nonatomic , copy) NSString              * standardname;
//@property (nonatomic , copy) NSString              * unitName3;
//@property (nonatomic , copy) NSString              * unit3;
//@property (nonatomic , copy) NSString              * surfacecode;
//@property (nonatomic , copy) NSString              * favouriteId;
//@property (nonatomic , copy) NSString              * standardId;
//@property (nonatomic , copy) NSString              * unitConversion5;
//@property (nonatomic , copy) NSString              * weight1000;
//@property (nonatomic , copy) NSString              * allowbuycount;
//@property (nonatomic , copy) NSString              * saleUnitName;
//@property (nonatomic , copy) NSString              * level2_price;
//@property (nonatomic , copy) NSString              * basicUnitId;
//@property (nonatomic , copy) NSString              * discountvalue;
//@property (nonatomic , copy) NSString              * limitType;
//@property (nonatomic , copy) NSString              * bidPrice;
//@property (nonatomic , copy) NSString              * sellerId;
//@property (nonatomic , copy) NSString              * stMoq;
//@property (nonatomic , copy) NSString              * title;
//@property (nonatomic , copy) NSString              * pid;
@property (nonatomic , copy) NSString              * drawing;
//@property (nonatomic , copy) NSString              * itemcode;
//@property (nonatomic , copy) NSString              * unit4;
//@property (nonatomic , copy) NSString              * status;
//@property (nonatomic , copy) NSString              * basicUnitName;
//@property (nonatomic , copy) NSString              * toothdistancename;
//@property (nonatomic , copy) NSString              * standardcode;
//@property (nonatomic , copy) NSString              * sellerTypeKeyCode;
@property (nonatomic , copy) NSString              * deliveryDay;
//@property (nonatomic , copy) NSString              * condition2;
//@property (nonatomic , copy) NSString              * saleUnitId;
//@property (nonatomic , copy) NSString              * diameterid;
//@property (nonatomic , copy) NSString              * userPrice_o;
//@property (nonatomic , copy) NSString              * materialName;
//@property (nonatomic , copy) NSString              * btypeid;
//@property (nonatomic , copy) NSString              * itemName;
//@property (nonatomic , copy) NSString              * toothformcode;
//@property (nonatomic , copy) NSString              * ktypeid;
//@property (nonatomic , copy) NSString              * levelcode;
//@property (nonatomic , copy) NSString              * levelName;
//@property (nonatomic , copy) NSString              * kfPhone;
//@property (nonatomic , copy) NSString              * discount3;
//@property (nonatomic , copy) NSString              * unitPiece;
//@property (nonatomic , copy) NSString              * brandid;
//@property (nonatomic , copy) NSString              * unitName2;
//@property (nonatomic , copy) NSString              * discounttype;
//@property (nonatomic , copy) NSString              * sellerType;
//@property (nonatomic , copy) NSString              * level_price;
//@property (nonatomic , copy) NSString              * unit5;
//@property (nonatomic , copy) NSString              * minQuantity;
//@property (nonatomic , copy) NSString              * leftCount;
@property (nonatomic , copy) NSString              * payType;
//@property (nonatomic , copy) NSString              * recordid;
//@property (nonatomic , copy) NSString              * baseName;
//@property (nonatomic , copy) NSString               *hopeDay;
//@property (nonatomic , copy) NSString               *sellerClass;
//@property (nonatomic , copy) NSString               *noticeqty;
////@property (nonatomic , copy) NSString               *storeName;

@property (nonatomic , copy) NSString              * branchId;
@property (nonatomic , copy) NSString              * storeId;
@property (nonatomic , copy) NSString              * goods_id;
@property (nonatomic , assign) double              qty;
@property (nonatomic , copy) NSString              * toothFormName;
@property (nonatomic , copy) NSString              * saleUnitName;
@property (nonatomic , copy) NSString              * unit4;
@property (nonatomic , copy) NSString              * basicUnitId;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * storeName;
@property (nonatomic , copy) NSString              * unitName1;
@property (nonatomic , assign) NSInteger              leftCount;
@property (nonatomic , copy) NSString              * spec;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , copy) NSString              * unitName2;
@property (nonatomic , copy) NSString              * areaId;
@property (nonatomic , copy) NSString              * discountId;
@property (nonatomic , copy) NSString              * standardName;
@property (nonatomic , copy) NSString              * unitName3;
@property (nonatomic , copy) NSString              * unitName4;
@property (nonatomic , copy) NSString              * imgUrl;
@property (nonatomic , copy) NSString              * unitName5;
@property (nonatomic , copy) NSString              * unit1;
@property (nonatomic , copy) NSString              * unit5;
@property (nonatomic , copy) NSString              * levelName;
@property (nonatomic , copy) NSString              * itemName;
@property (nonatomic , assign) double              saleUnitConversion;
@property (nonatomic , assign) double              unitConversion1;
@property (nonatomic , assign) double              minQuantity;
@property (nonatomic , assign) double              unitConversion2;
@property (nonatomic , assign) double              allowBuyCount;
@property (nonatomic , assign) double              unitConversion3;
@property (nonatomic , copy) NSString              * lengthName;
@property (nonatomic , assign) double              userPriceOld;
@property (nonatomic , assign) double              unitConversion4;
@property (nonatomic , copy) NSString              * toothDistanceName;
@property (nonatomic , assign) double              unitConversion5;
@property (nonatomic , copy) NSString              * unit2;
@property (nonatomic , copy) NSString              * arrivalNoticeId;
@property (nonatomic , copy) NSString              * pmId;
@property (nonatomic , copy) NSString              * favouriteId;
@property (nonatomic , copy) NSString              * basicUnitName;
@property (nonatomic , copy) NSString              * sellerTypeCode;
@property (nonatomic , copy) NSString              * diameterName;
@property (nonatomic , copy) NSString              * saleUnitId;
@property (nonatomic , assign) NSInteger              sellerClass;
@property (nonatomic , copy) NSString              * unit3;
@property (nonatomic , assign) NSInteger              limitType;
@property (nonatomic , copy) NSString              * kpName;
@property (nonatomic , copy) NSString              * brandName;
@property (nonatomic , copy) NSString              * materialName;
@property (nonatomic , copy) NSString              * surfaceName;
@property (nonatomic , assign) double              userPrice;
@end

NS_ASSUME_NONNULL_END
@interface FavoriteModel : DRBaseModel
@property (nonatomic , copy) NSString              * favorite_id;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * kfPhone;
@property (nonatomic , copy) NSString              * compLog;
@property (nonatomic , copy) NSString              * storePrdt;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , copy) NSString              * storeTitle;
@property (nonatomic , copy) NSString              * compAddr;
@property (nonatomic , copy) NSString              * isSendVoucher;

@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , assign)NSInteger             sellerClass;


@end
