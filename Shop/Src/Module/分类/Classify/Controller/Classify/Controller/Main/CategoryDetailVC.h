//
//  CategoryDetailVC.h
//  Shop
//
//  Created by BWJ on 2019/3/7.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DRNullShopModel;
@interface CategoryDetailVC : STBaseViewController
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary,*typeDic;

@property (strong,nonatomic)  NSString *classListStr,*czID,*queryTypeStr,*keyWordStr,*shopStr,*sellidStr;
@property (strong,nonatomic)NSString *level1IdStr;
@property (strong,nonatomic)NSString *level2IdStr;
@property (strong,nonatomic)NSString *categoryIdStr;
@property (strong,nonatomic)DRNullShopModel *nullShopModel;

@end

NS_ASSUME_NONNULL_END
