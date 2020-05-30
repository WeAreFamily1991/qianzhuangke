//
//  CRProductCell.h
//  CRShopDetailDemo
//
//  Created by roger wu on 20/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CRProductModel;

static NSString * const DRNullGoodLikesCellID = @"DRNullGoodLikesCellID";

@interface CRProductCell : UICollectionViewCell

@property (strong, nonatomic) CRProductModel *model;

@end
