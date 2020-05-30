//
//  DCRecommendItem.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RecommendList;
@class ItemList;
@class AdvList;
@interface DCRecommendItem : DRBaseModel
@property (nonatomic , copy) NSString              * sortID;
@property (nonatomic , copy) NSArray<RecommendList *>              * recommendList;
@property (nonatomic , copy) NSArray<ItemList *>              * itemList;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSArray<AdvList *>              * advList;
///** 图片URL */
//@property (nonatomic, copy ,readonly) NSString *image_url;
///** 商品标题 */
//@property (nonatomic, copy ,readonly) NSString *main_title;
///** 商品小标题 */
//@property (nonatomic, copy ,readonly) NSString *goods_title;
///** 商品价格 */
//@property (nonatomic, copy ,readonly) NSString *price;
///** 剩余 */
//@property (nonatomic, copy ,readonly) NSString *stock;
///** 属性 */
//@property (nonatomic, copy ,readonly) NSString *nature;
//
///* 头部轮播 */
//@property (copy , nonatomic , readonly)NSArray *images;
//
//@property (nonatomic , assign) NSInteger              sortId;
//@property (nonatomic , assign) NSInteger              isShow;
//@property (nonatomic , copy) NSString              * shopNewID;
//@property (nonatomic , copy) NSString              * recommend;
//@property (nonatomic , copy) NSString              * title;
//@property (nonatomic , copy) NSString              * qCondition;
//
//
//@property (nonatomic , assign) double              qtyPercent;
//@property (nonatomic , copy) NSString              * materialName;
//@property (nonatomic , copy) NSString              *bidprice;
//@property (nonatomic , assign) double              zfprice;
//@property (nonatomic , copy) NSString              * itemparamid;
//@property (nonatomic , copy) NSString              * sortID;
//@property (nonatomic , copy) NSString              * standardname;
//@property (nonatomic , copy) NSString              * basicUnitId;
//@property (nonatomic , copy) NSString              * itemcode;
//@property (nonatomic , copy) NSString              * complog;
//@property (nonatomic , assign) double              totalAmt;
//@property (nonatomic , copy) NSString              * lengthname;
//@property (nonatomic , copy) NSString              * bursttype;
//@property (nonatomic , copy) NSString              * createtime;
//@property (nonatomic , copy) NSString              * itemid;
//@property (nonatomic , copy) NSString              * toothdistanceid;
//@property (nonatomic , assign) NSInteger              islogistics;
//@property (nonatomic , copy) NSString              * diametername;
//@property (nonatomic , copy) NSString              * sellername;
//@property (nonatomic , copy) NSString              * levelId;
//@property (nonatomic , copy) NSString              * brandName;
//@property (nonatomic , copy) NSString              * basicUnitName;
//@property (nonatomic , copy) NSString              * bhtid;
//@property (nonatomic , assign) double              stprice;
//@property (nonatomic , copy) NSString              * updatename;
//@property (nonatomic , copy) NSString              * standardId;
//@property (nonatomic , copy) NSString              * levelName;
//@property (nonatomic , copy) NSString              * diameterid;
//@property (nonatomic , copy) NSString              * status;
//@property (nonatomic , copy) NSString              * areaname;
//@property (nonatomic , copy) NSString              * itemName;
//@property (nonatomic , copy) NSString              * ibssId;
//@property (nonatomic , copy) NSString              * toothdistancename;
//@property (nonatomic , copy) NSString              * surfaceId;
//@property (nonatomic , assign) NSInteger              iszf;
//@property (nonatomic , copy) NSString              * createname;
//@property (nonatomic , copy) NSString              * img;
//@property (nonatomic , copy) NSString              *userPrice;
//@property (nonatomic , copy) NSString              * spec;
//@property (nonatomic , copy) NSString              * lengthId;
//@property (nonatomic , copy) NSString              * sellerId;
//@property (nonatomic , copy) NSString              * sortnum;
//@property (nonatomic , copy) NSString              * updatetime;
//@property (nonatomic , copy) NSString              * surfaceName;
//@property (nonatomic , copy) NSString              * brandid;
//@property (nonatomic , copy) NSString              * materialId;
//@property (nonatomic , copy) NSString              * imgm;
//@property (nonatomic , copy) NSString              * areaid;
//@property (nonatomic , copy) NSString              *factoryArea;

@end

@interface ItemList :NSObject
@property (nonatomic , assign) double              totalAmt;
@property (nonatomic , copy) NSString              * item_id;
@property (nonatomic , copy) NSString              * levelId;
@property (nonatomic , copy) NSString              * materialId;
@property (nonatomic , copy) NSString              * itemId;
@property (nonatomic , assign) double              zfPrice;
@property (nonatomic , copy) NSString              * basicUnitId;
@property (nonatomic , copy) NSString              * imgM;
@property (nonatomic , copy) NSString              * itemParamId;
@property (nonatomic , copy) NSString              * lengthId;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * itemCode;
@property (nonatomic , copy) NSString              * surfaceId;
@property (nonatomic , assign) double              bidPrice;
@property (nonatomic , assign) double              userPrice;
@property (nonatomic , copy) NSString              * materialName;
@property (nonatomic , copy) NSString              * burstType;
@property (nonatomic , copy) NSString              * storeImg;
@property (nonatomic , copy) NSString              * standardName;
@property (nonatomic , copy) NSString              * lengthName;
@property (nonatomic , copy) NSString              * bhtName;
@property (nonatomic , copy) NSString              * brandId;
@property (nonatomic , copy) NSString              * brandName;
@property (nonatomic , copy) NSString              * standardId;
@property (nonatomic , copy) NSString              * basicUnitName;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * diameterId;
@property (nonatomic , copy) NSString              * surfaceName;
@property (nonatomic , copy) NSString              * spec;
@property (nonatomic , copy) NSString              * factoryArea;
@property (nonatomic , copy) NSString              * diameterName;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , copy) NSString              * bhtId;
@property (nonatomic , copy) NSString              * itemName;
@property (nonatomic , copy) NSString              * levelName;
@property (nonatomic , copy) NSString              * toothDistanceId;
@property (nonatomic , copy) NSString              * toothDistanceName;
@property (nonatomic , assign) double              qtyPercent;

@end
