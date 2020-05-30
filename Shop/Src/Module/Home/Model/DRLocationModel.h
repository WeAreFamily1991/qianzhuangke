//
//  DRLocationModel.h
//  Shop
//
//  Created by BWJ on 2019/5/14.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRLocationModel : DRBaseModel
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * storeTitle;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , copy) NSString              * favoriteId;
@property (nonatomic , copy) NSString              * compLog;
@property (nonatomic , assign) NSInteger               isSendVoucher;
@property (nonatomic , copy) NSString              * storeImg;
@property (nonatomic , copy) NSString              * regArea;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , copy) NSString              * storePrdt;
@property (nonatomic , assign)NSInteger             sellerClass;

@end

NS_ASSUME_NONNULL_END
