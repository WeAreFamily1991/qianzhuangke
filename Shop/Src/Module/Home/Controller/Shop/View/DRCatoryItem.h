//
//  DRCatoryItem.h
//  Shop
//
//  Created by BWJ on 2019/6/17.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class List;
@class SmallList;
@interface DRCatoryItem : DRBaseModel
@property (nonatomic , copy) NSString              * item_id;
@property (nonatomic , assign) BOOL              isShow;
@property (nonatomic , copy) NSString              * parentId;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * classList;
@property (nonatomic , assign) BOOL              hasBurst;
@property (nonatomic , assign) NSInteger              subType;
@property (nonatomic , copy) NSString              * pyIndex;
@property (nonatomic , copy) NSString              * itemCategorys;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , assign) NSInteger              sortId;
@property (nonatomic , copy) NSString              * cz;
@property (nonatomic , copy) NSString              * standardId;
@property (nonatomic , copy) NSArray<List *>              * list;
@property (nonatomic , copy) NSString              * queryCondition;
@property (nonatomic , copy) NSString              * imgM;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              classLayer;
@end

@interface List :NSObject
@property (nonatomic , copy) NSString              * List_id;
@property (nonatomic , assign) BOOL              isShow;
@property (nonatomic , copy) NSString              * parentId;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * classList;
@property (nonatomic , assign) BOOL              hasBurst;
@property (nonatomic , assign) NSInteger              subType;
@property (nonatomic , copy) NSString              * pyIndex;
@property (nonatomic , copy) NSString              * itemCategorys;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , assign) NSInteger              sortId;
@property (nonatomic , copy) NSString              * cz;
@property (nonatomic , copy) NSString              * standardId;
@property (nonatomic , copy) NSArray<SmallList *>              * list;
@property (nonatomic , copy) NSString              * queryCondition;
@property (nonatomic , copy) NSString              * imgM;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              classLayer;

@end
NS_ASSUME_NONNULL_END
