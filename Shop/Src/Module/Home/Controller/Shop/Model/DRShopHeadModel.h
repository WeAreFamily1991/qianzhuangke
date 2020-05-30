//
//  DRShopHeadModel.h
//  Shop
//
//  Created by BWJ on 2019/5/9.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRShopHeadModel : DRBaseModel
@property (nonatomic, weak) UIViewController *currentController; // 当前ViewController
@property (nonatomic , copy) NSString              * regArea;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , copy) NSString              * contactName;
@property (nonatomic , copy) NSString              * storeImgM;
@property (nonatomic , copy) NSString              * compUrl;
@property (nonatomic , assign) NSInteger              payType;
@property (nonatomic , copy) NSString              * contactPhone;
@property (nonatomic , copy) NSString              * compLog;
@property (nonatomic , copy) NSString              * wxShareDesc;
@property (nonatomic , copy) NSString              * isProxyRun;
@property (nonatomic , copy) NSString              * compAbout;
@property (nonatomic , copy) NSString              * sellerType;
@property (nonatomic , copy) NSString              * wxShareTitle;
@property (nonatomic , copy) NSString              * head_id;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , assign) NSInteger              evaluateCount;
@property (nonatomic , copy) NSString              * favoriteId;
@property (nonatomic , assign) double              evaluateScore;
@property (nonatomic , copy) NSString              * closeTime;
@property (nonatomic , assign) NSInteger              isOpen;
@property (nonatomic , copy) NSString              * contactTel;
@property (nonatomic , assign) NSInteger              isFavorite;
@property (nonatomic , copy) NSString              * openTime;
//@property (nonatomic , copy) NSArray<HonorImgs *>              * honorImgs;
@property (nonatomic , copy) NSString              * busScope;
@property (nonatomic , copy) NSString              * sellerClass;
@property (nonatomic , copy) NSString              * kpName;
@property (nonatomic , copy) NSString              * compAddrInfo;
@property (nonatomic , copy) NSString              * email;
//@property (nonatomic , copy) NSArray<AboutImgs *>              * aboutImgs;
@property (nonatomic , copy) NSString              * busLic;
@end

NS_ASSUME_NONNULL_END
