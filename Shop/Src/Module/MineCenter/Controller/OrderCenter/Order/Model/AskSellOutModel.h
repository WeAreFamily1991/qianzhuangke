//
//  AskSellOutModel.h
//  Shop
//
//  Created by BWJ on 2019/4/16.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoodModel;
NS_ASSUME_NONNULL_BEGIN

@interface AskSellOutModel : DRBaseModel
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * storeTitle;
@property (nonatomic , copy) NSString              * payMethod;
@property (nonatomic , copy) NSString              * priceType;
@property (nonatomic , copy) NSString              * statusName;
@property (nonatomic , copy) NSString              * priceTypeName;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , copy) NSString              * orderNo;
@property (nonatomic , assign) NSInteger              createTime;
@property (nonatomic , copy) NSString              * orderId;
@property (nonatomic , copy) NSString              * expressType;
@property (nonatomic , copy) NSString              * isHy;
@property (nonatomic , copy) NSString              * storeName;
@property (nonatomic , copy) NSArray<GoodModel *>              * goodsList;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , assign) NSInteger              status;
@end

@interface GoodModel : DRBaseModel
@property (nonatomic , copy) NSString              * unitConversion3;
@property (nonatomic , copy) NSString              * standardname;
@property (nonatomic , copy) NSString              * unitName4;
@property (nonatomic , assign) double              realAmt;
@property (nonatomic , copy) NSString              * unitConversion5;
@property (nonatomic , assign) double              amt;
@property (nonatomic , copy) NSString              * unit4;
@property (nonatomic , copy) NSString              * toothFormName;
@property (nonatomic , copy) NSString              * basicUnitId;
@property (nonatomic , copy) NSString              * unit2;
@property (nonatomic , copy) NSString              * unitName5;
@property (nonatomic , copy) NSString              * saleUnitName;
@property (nonatomic , assign) double              qty;
@property (nonatomic , copy) NSString              * unitName1;
@property (nonatomic , copy) NSString              * standardcode;
@property (nonatomic , assign) double              canReturnQty;
@property (nonatomic , copy) NSString              *unitConversion2;
@property (nonatomic , copy) NSString              * priceSource;
@property (nonatomic , copy) NSString              * materialName;
@property (nonatomic , copy) NSString              * unitConversion4;
@property (nonatomic , assign) double              returnQty;
@property (nonatomic , assign) double              price;
@property (nonatomic , copy) NSString              * unitName2;
@property (nonatomic , assign) double              realPrice;
@property (nonatomic , copy) NSString              * unit5;
@property (nonatomic , copy) NSString              * lengthName;
@property (nonatomic , copy) NSString              * brandName;
@property (nonatomic , assign) double              basePrice;
@property (nonatomic , copy) NSString              * surfaceName;
@property (nonatomic , copy) NSString              * unit3;
@property (nonatomic , copy) NSString              * basicUnitName;
@property (nonatomic , copy) NSString              * unit1;
@property (nonatomic , copy) NSString              * spec;
@property (nonatomic , copy) NSString              * toothDistanceName;
@property (nonatomic , copy) NSString              * diameterName;
@property (nonatomic , copy) NSString              * imgUrl;
@property (nonatomic , copy) NSString              * itemName;
@property (nonatomic , copy) NSString              * unitName3;
@property (nonatomic , copy) NSString              * levelName;
@property (nonatomic , copy) NSString              * saleUnitId;
@property (nonatomic , assign) double              saleUnitConversion;
@property (nonatomic , copy) NSString              * orderGoodsId;
@property (nonatomic , copy) NSString              * unitConversion1;
@property (nonatomic , copy) NSString              * modelCount;
@property (nonatomic , copy) NSString              * numModelStr;
@end
NS_ASSUME_NONNULL_END
