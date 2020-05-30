//
//  DCClassMianItem.h
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DCCalssSubItem;
@interface DCClassMianItem : DRBaseModel
@property (nonatomic , copy) NSString              * isShow;
@property (nonatomic , copy) NSString              * st_id;
@property (nonatomic , copy) NSString              * parentId;
@property (nonatomic , copy) NSString              * classList;
@property (nonatomic , copy) NSString              * subType;
@property (nonatomic , copy) NSString              * itemCategorys;
@property (nonatomic , copy) NSString              * pyIndex;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * standards;
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , copy) NSString              * sortId;
@property (nonatomic , copy) NSString              * standardId;
@property (nonatomic , copy) NSString              * queryCondition;
@property (nonatomic , copy) NSString              * imgM;
//@property (nonatomic , copy) NSArray<StCategoryVOList *>              * stCategoryVOList;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * classLayer;
@property (nonatomic , copy) NSString              *cz;
@property (nonatomic , copy) NSString              *hasBurst;

@property (nonatomic , copy) NSString              *sellerId;


@end
