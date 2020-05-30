//
//  DRShopListVC.h
//  Shop
//
//  Created by BWJ on 2019/5/5.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DRNullGoodModel;
@interface DRShopListVC : STBaseViewController
@property (nonatomic,strong)DRNullGoodModel *nullGoodModel;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary,*typeDic;
@property (strong,nonatomic)  NSString *classListStr,*czID,*queryTypeStr,*keyWordStr,*shopStr,*sellerIdStr;
@property (strong,nonatomic)NSString *level1IdStr;
@property (strong,nonatomic)NSString *level2IdStr;
@property (strong,nonatomic)NSString *categoryIdStr;
@end

NS_ASSUME_NONNULL_END
