//
//  DRAddShopModel.h
//  Shop
//
//  Created by BWJ on 2019/4/11.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ItemsModel;
NS_ASSUME_NONNULL_BEGIN

@interface DRAddShopModel : DRBaseModel
@property (nonatomic , copy) NSString              * storeid;
@property (nonatomic , copy) NSString              * areaId;
@property (nonatomic , copy) NSString              * addshop_id;
@property (nonatomic , assign)CGFloat              zfMoq;
@property (nonatomic , assign)CGFloat              stMoq;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * kfPhone;
@property (nonatomic , copy) NSString              * branchId;
@property (nonatomic , copy) NSArray<ItemsModel *>           * items;
@end
@interface ItemsModel :NSObject
@property (nonatomic , copy) NSString              * payType;
@property (nonatomic , copy) NSString              * serviceType;
@property (nonatomic , assign) double              price;
@end

NS_ASSUME_NONNULL_END
