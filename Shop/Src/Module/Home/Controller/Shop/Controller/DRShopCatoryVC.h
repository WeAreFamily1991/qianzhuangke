//
//  DRShopCatoryVC.h
//  Shop
//
//  Created by rockding on 2020/3/18.
//  Copyright © 2020 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DRNullShopModel;
@interface DRShopCatoryVC : STBaseViewController
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary,*typeDic;
@property (strong,nonatomic)  NSString *classListStr,*czID,*queryTypeStr,*keyWordStr,*shopStr,*sellidStr,*searchTypeStr;
@property (strong,nonatomic)NSString *level1IdStr;
@property (strong,nonatomic)NSString *level2IdStr;
@property (strong,nonatomic)NSString *categoryIdStr;
@property (strong,nonatomic)DRNullShopModel *nullShopModel;
@property (nonatomic,strong)NSString  * isAirCloudYes;
@end

NS_ASSUME_NONNULL_END
