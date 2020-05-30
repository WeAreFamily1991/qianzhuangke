//
//  CatoryTabCell.h
//  Shop
//
//  Created by BWJ on 2019/4/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRBaseCell.h"
@class CRDetailModel;
@class DRNullGoodModel;
@interface CatoryTabCell : DRBaseCell

@property (strong, nonatomic) CRDetailModel *model;
@property (strong, nonatomic) DRNullGoodModel *nullGoodModel;
@property (nonatomic,strong)NSString *sellerId;
@end

