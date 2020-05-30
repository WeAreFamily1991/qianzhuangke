//
//  HomeBannerModel.h
//  Shop
//
//  Created by rockding on 2020/3/16.
//  Copyright © 2020 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Params;
@class ParamsArray;

@interface HomeBannerModel : DRBaseModel
@property (nonatomic , strong) Params              * params;
@property (nonatomic , copy) NSString              * bannerImgTitle;
@property (nonatomic , copy) NSString              * bannerImgLink;
@property (nonatomic , copy) NSString              * banner_id;
@property (nonatomic , copy) NSString              * msgDetailsParmas;
@property (nonatomic , copy) NSString              * bannerImgUrl;
@property (nonatomic , copy) NSArray<ParamsArray *>              * paramsArray;
@property (nonatomic , copy) NSString              * msgDetailsName;
@property (nonatomic , copy) NSString              * bannerImgType;
@property (nonatomic , copy) NSString              * msgDetailsType;
@end
@class Product;
NS_ASSUME_NONNULL_END
@interface Params :NSObject
@property (nonatomic , copy) NSString              * keyword;
@property (nonatomic , strong) Product              * product;
@property (nonatomic , copy) NSString              * store;

@end

@interface Product :NSObject
@property (nonatomic , copy) NSString              * materialid;
@property (nonatomic , copy) NSString              * standardid;
@property (nonatomic , copy) NSString              * lengthid;
@property (nonatomic , copy) NSString              * diameterid;
@property (nonatomic , copy) NSString              * surfaceid;
@property (nonatomic , copy) NSString              * brandid;
@property (nonatomic , copy) NSString              * levelid;
@property (nonatomic , copy) NSString              * toothdistanceid;
@property (nonatomic , copy) NSString              * toothformid;

@end
