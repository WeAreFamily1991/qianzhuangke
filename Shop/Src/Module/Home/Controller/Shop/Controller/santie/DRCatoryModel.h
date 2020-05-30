//
//  DRCatoryModel.h
//  Shop
//
//  Created by rockding on 2020/1/10.
//  Copyright © 2020 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CatoryList;
@class SmallList;
@interface DRCatoryModel : NSObject
@property (nonatomic , assign) NSInteger              subType;
@property (nonatomic , assign) NSInteger              classLayer;
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , copy) NSString              * itemCategorys;
@property (nonatomic , copy) NSString              * cz;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , assign) BOOL              isShow;
@property (nonatomic , copy) NSString              * pyIndex;
@property (nonatomic , assign) NSInteger              sortId;
@property (nonatomic , copy) NSString              * relationId;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * title_id;
@property (nonatomic , copy) NSString              * classList;
@property (nonatomic , assign) BOOL              isShowHj;
@property (nonatomic , copy) NSArray<CatoryList *>              * list;
@property (nonatomic , copy) NSString              * parentId;
@property (nonatomic , copy) NSString              * queryCondition;
@property (nonatomic , copy) NSString              * standards;
@property (nonatomic , copy) NSString              * imgM;
@property (nonatomic , copy) NSString              * standardid;
@property (nonatomic , assign) NSInteger              isCy;
@property (nonatomic , assign) BOOL              hasBurst;
@end

@interface CatoryList :NSObject
@property (nonatomic , assign) NSInteger              subType;
@property (nonatomic , assign) NSInteger              classLayer;
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , copy) NSString              * itemCategorys;
@property (nonatomic , copy) NSString              * cz;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , assign) BOOL              isShow;
@property (nonatomic , copy) NSString              * pyIndex;
@property (nonatomic , assign) NSInteger              sortId;
@property (nonatomic , copy) NSString              * relationId;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * CatoryList_id;
@property (nonatomic , copy) NSString              * classList;
@property (nonatomic , assign) BOOL              isShowHj;
@property (nonatomic , copy) NSArray<SmallList *>              * list;
@property (nonatomic , copy) NSString              * parentId;
@property (nonatomic , copy) NSString              * queryCondition;
@property (nonatomic , copy) NSString              * standards;
@property (nonatomic , copy) NSString              * imgM;
@property (nonatomic , copy) NSString              * standardid;
@property (nonatomic , assign) NSInteger              isCy;
@property (nonatomic , assign) BOOL              hasBurst;
@property (nonatomic , assign) BOOL              isSelected;

@end


@interface SmallList :NSObject
@property (nonatomic , assign) NSInteger              subType;
@property (nonatomic , assign) NSInteger              classLayer;
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , copy) NSString              * itemCategorys;
@property (nonatomic , copy) NSString              * cz;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , assign) BOOL              isShow;
@property (nonatomic , copy) NSString              * pyIndex;
@property (nonatomic , assign) NSInteger              sortId;
@property (nonatomic , copy) NSString              * relationId;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * SmallList_id;
@property (nonatomic , copy) NSString              * classList;
@property (nonatomic , assign) BOOL              isShowHj;
@property (nonatomic , copy) NSArray              * list;
@property (nonatomic , copy) NSString              * parentId;
@property (nonatomic , copy) NSString              * queryCondition;
@property (nonatomic , copy) NSString              * standards;
@property (nonatomic , copy) NSString              * imgM;
@property (nonatomic , copy) NSString              * standardid;
@property (nonatomic , assign) NSInteger              isCy;
@property (nonatomic , assign) BOOL              hasBurst;

@end
