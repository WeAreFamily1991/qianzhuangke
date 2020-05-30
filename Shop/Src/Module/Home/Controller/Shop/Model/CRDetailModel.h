//
//  CRShopDetailModel.h
//  CRShopDetailDemo
//
//  Created by roger wu on 18/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HonorImgs;
@class AboutImgs;
@interface CRDetailModel : DRBaseModel

@property (nonatomic, weak) UIViewController *currentController; // 当前ViewController

@property (copy, nonatomic) NSString *background; // 店铺背景图
@property (copy, nonatomic) NSString *portrait; // 头像
@property (copy, nonatomic) NSString *name; // 店铺名
@property (copy, nonatomic) NSString *fansCount; // 粉丝数


@property (nonatomic , assign) BOOL              zyStore;
@property (nonatomic , copy) NSString              * regArea;
@property (nonatomic , assign) NSInteger              compType;
@property (nonatomic , copy) NSString              * contactName;
@property (nonatomic , copy) NSString              * compUrl;
@property (nonatomic , copy) NSString              * contactPhone;
@property (nonatomic , assign) NSInteger              payType;
@property (nonatomic , copy) NSString              * wxShareDesc;
@property (nonatomic , copy) NSString              * compAbout;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , assign) NSInteger              isSendVoucher;
@property (nonatomic , assign) BOOL              proxyRun;
@property (nonatomic , copy) NSString              * closeTime;
@property (nonatomic , copy) NSString              * wxShareTitle;
@property (nonatomic , copy) NSString              * contactTel;
@property (nonatomic , copy) NSString              * email;
@property (nonatomic , copy) NSString              * favoriteId;
@property (nonatomic , assign) NSInteger              isHy;
@property (nonatomic , assign) NSInteger              isOpen;
@property (nonatomic , copy) NSString              * openTime;
@property (nonatomic , assign) NSInteger              sellerClass;
@property (nonatomic , copy) NSArray<HonorImgs *>              * honorImgs;
@property (nonatomic , copy) NSString              * busScope;
@property (nonatomic , copy) NSString              * compAddrInfo;
@property (nonatomic , copy) NSString              * kpName;
@property (nonatomic , assign) NSInteger              priceType;
@property (nonatomic , copy) NSString              * storeImg;
@property (nonatomic , copy) NSArray<AboutImgs *>              * aboutImgs;
@property (nonatomic , copy) NSString              * busLic;


@property (nonatomic , copy) NSString              * storeImgM;
@property (nonatomic , copy) NSString              * compLog;
@property (nonatomic , copy) NSString              * isProxyRun;
@property (nonatomic , copy) NSString              * sellerType;
@property (nonatomic , copy) NSString              * head_id;
@property (nonatomic , assign) NSInteger              evaluateCount;
@property (nonatomic , assign) double              evaluateScore;
@property (nonatomic , assign) NSInteger              isFavorite;
@property (nonatomic , copy) NSString              *compId;


// 请求连接
@property (copy, nonatomic) NSString *home;
@property (copy, nonatomic) NSString *allProduct;
@property (copy, nonatomic) NSString *moments;

- (NSURL *)backgroundURL;
- (NSURL *)portraitURL;


@end
@interface HonorImgs : DRBaseModel
@property (nonatomic , copy) NSString *flag;
@property (nonatomic , copy) NSString *HonorImgs_id;
@property (nonatomic , copy) NSString *imgUrl;
@property (nonatomic , copy) NSString *sellerId;

@end

@interface AboutImgs : DRBaseModel
@property (nonatomic , copy) NSString *flag;
@property (nonatomic , copy) NSString *AboutImgs_id;
@property (nonatomic , copy) NSString *imgUrl;
@property (nonatomic , copy) NSString *sellerId;
@end
