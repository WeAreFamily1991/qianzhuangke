//
//  CRSegmentCell.h
//  CRShopDetailDemo
//
//  Created by roger wu on 19/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRTableViewCell.h"
@class CRDetailModel;
@class DRNullGoodModel;

@interface CRSegmentCell : CRTableViewCell
@property (strong, nonatomic) CRDetailModel *model;
@property (strong, nonatomic) DRNullGoodModel *nullGoodModel;
@property (nonatomic,strong)NSString *sellerId;
@end
