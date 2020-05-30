//
//  DCClassGoodsItem.h
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChildListCatory2;
@class DCClassMianItem;
@class ChildList;
@interface DCClassGoodsItem : DRBaseModel

/** 文标题  */
@property (nonatomic, copy ,readonly) NSString *title;
/** plist  */
@property (nonatomic , copy) NSArray<ChildListCatory2 *>  * childList2;
@property (nonatomic , copy) NSString              * title_id;
@property (nonatomic , copy) NSString              * isShow;
@property (nonatomic , copy) NSString              * classList;
@property (nonatomic , copy) NSString              * parentId;
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
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * classLayer;

@end

@interface ChildCategory2 : DRBaseModel
@property (nonatomic , copy) NSString              * isShow;

@property (nonatomic , copy) NSString              * child2_id;
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
@property (nonatomic , copy) NSArray<ChildList *> * childList;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * classLayer;
@property (nonatomic,assign) BOOL                    hasBurst;
@property (nonatomic,assign) BOOL                    isSelected;

@end




@interface ChildList : DRBaseModel
@property (nonatomic , copy) NSString              * isShow;
@property (nonatomic , copy) NSString              * child_id;
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
@property (nonatomic , copy) NSArray<DCClassMianItem *> * childList;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * classLayer;
@property (nonatomic,assign) BOOL                    hasBurst;

@end
