//
//  DRCollectionModel.h
//  Shop
//
//  Created by BWJ on 2019/5/10.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRCollectionModel : DRBaseModel
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * advList;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * collection_id;
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , copy) NSString              * colorValue;
@property (nonatomic , copy) NSString              * queryCondition;
@property (nonatomic , copy) NSString              * bigCategoryName;
@property (nonatomic , copy) NSString              * bigCategoryId;
@property (nonatomic , copy) NSString              * imgM;
@property (nonatomic , copy) NSString              * itemList;
@end

NS_ASSUME_NONNULL_END
