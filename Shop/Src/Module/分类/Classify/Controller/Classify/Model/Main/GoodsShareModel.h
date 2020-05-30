//
//  GoodsShareModel.h
//  Shop
//
//  Created by BWJ on 2019/4/3.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsShareModel : DRBaseModel
#pragma mark - 单例
+(instancetype)sharedManager;
@property (nonatomic , copy) NSString              *queryType;//类型
@property (nonatomic , copy) NSString              *type;
@property (nonatomic , copy) NSString              * level1Id;
@property (nonatomic , copy) NSString              * level2Id;
@property (nonatomic , copy) NSString              * cz;//材质
@property (nonatomic , copy) NSString              * categoryId;//标准
@property (nonatomic , copy) NSString              * subType;
@property (nonatomic , copy) NSString              * jb;//级别
@property (nonatomic , copy) NSString              *bmcl;//表面处理
@property (nonatomic , copy) NSString              * cd;//长度
@property (nonatomic , copy) NSString              * cl;//材料
@property (nonatomic , copy) NSString              * yj;//牙距
@property (nonatomic , copy) NSString              * yx;//牙型
@property (nonatomic , copy) NSString              * pp;//品牌
@property (nonatomic , copy) NSString              * zj;//直径
@property (nonatomic , copy) NSString              *sellerId;
@property (nonatomic , copy) NSString              *levelId;
@property (nonatomic , copy) NSString              *surfaceId;
@property (nonatomic , copy) NSString              *materialId;
@property (nonatomic , copy) NSString              *standardId;
@property (nonatomic , copy) NSString              *keyword;
@property (nonatomic , copy) NSString              *countNumStr;
@property (nonatomic , copy) NSString              *selectcode;
@property (nonatomic , copy) NSString              *qty;


@end

NS_ASSUME_NONNULL_END
